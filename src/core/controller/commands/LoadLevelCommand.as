package core.controller.commands {

	import configs.GeneralNotifications;
	
	import core.model.dataobject.LevelConfigDO;
	import core.model.proxy.GameProxy;
	import core.model.proxy.LevelsConfigProxy;
	import core.view.components.GameViewLogic;
	import core.view.mediators.GameMediator;
	import core.view.mediators.RootMediator;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.MultiLoader;
	import utils.WarehouseAssets;
	
	public class LoadLevelCommand extends SimpleCommand {

		private var levelConfig:LevelConfigDO;

		override public function execute(notification:INotification):void {

            var levelId:String = notification.getBody() as String;
            levelConfig = levelsConfigProxy.getLevelInfo(levelId);

            WarehouseAssets.getInstance().hasAsset(levelId) ? startLevel() : loadLevel();
		}
		
		private function loadLevel():void {

			var multiLoader:MultiLoader = new MultiLoader();
			multiLoader.addTask(levelConfig.url, levelConfig.id, MultiLoader.MOVIE);
			multiLoader.addEventListener(Event.COMPLETE, onLevelAssetsLoadComplete);
			multiLoader.start();
		}
		
		private function onLevelAssetsLoadComplete(event:Event):void {

			var multiLoader:MultiLoader = MultiLoader(event.target);
			WarehouseAssets.getInstance().setAssets([{filename: levelConfig.id, content:Loader(multiLoader.getContentByRegistrationName(levelConfig.id)).content as MovieClip}]);
			startLevel();
		}
		
		private function startLevel():void {

			levelConfig.letters = createLevelString();
			var gameViewLogic:GameViewLogic = new GameViewLogic(levelConfig.id, levelConfig.letters);

			facade.registerProxy(new GameProxy(levelConfig));
			facade.registerMediator(new GameMediator(gameViewLogic));

			sendNotification(GeneralNotifications.UPDATE_LEVEL_SCORE, {levelScore:0, mistakes:levelConfig.mistakes});
			(facade.retrieveMediator(RootMediator.NAME) as RootMediator).content.stage.focus = gameViewLogic.content;
		}
		
		private function createLevelString():String {

			var levelString:String = '';

			for(var i:int = 0; i < 20; i++){

				var nom:int = Math.round(Math.random()*levelConfig.letters.length);

				if(nom != levelConfig.letters.length) {
					levelString = levelString + levelConfig.letters.charAt(nom);
				} else {
					i--;
				}
			}

			return levelString;
		}

        private function get levelsConfigProxy():LevelsConfigProxy {

            return facade.retrieveProxy(LevelsConfigProxy.NAME) as LevelsConfigProxy;
        }
	}
}