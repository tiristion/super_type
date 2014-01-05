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

		private var _levelConfig:LevelConfigDO;
		private var _gameViewLogic:GameViewLogic;
				
		override public function execute(notification:INotification):void {

            _levelConfig = (facade.retrieveProxy(LevelsConfigProxy.NAME) as LevelsConfigProxy).getLevelInfo(notification.getBody() as String);

			if(WarehouseAssets.getInstance().hasAsset(notification.getBody() as String)) {
				startLevel();
			} else {
				loadLevel();
			}
		}
		
		private function loadLevel():void {

			var multiLoader:MultiLoader=new MultiLoader;
			multiLoader.addTask(_levelConfig.url, _levelConfig.id, MultiLoader.MOVIE);
			multiLoader.addEventListener(Event.COMPLETE, onComplete);
			multiLoader.start();
		}
		
		private function onComplete(event:Event):void {

			var multiLoader:MultiLoader = MultiLoader(event.target);
			WarehouseAssets.getInstance().setAssets([{filename: _levelConfig.id, content:Loader(multiLoader.getContentByRegistrationName(_levelConfig.id)).content as MovieClip}]);
			startLevel();
		}
		
		private function startLevel():void {

			var levelConfig:LevelConfigDO = new LevelConfigDO;
			levelConfig.id = _levelConfig.id;
			levelConfig.unlockValue = _levelConfig.unlockValue;
			levelConfig.url = _levelConfig.url;
			levelConfig.letters = createLevelString();
			levelConfig.mistakes = _levelConfig.mistakes;
			_gameViewLogic = new GameViewLogic(levelConfig.id, levelConfig.letters);
			facade.registerProxy(new GameProxy(levelConfig));
			facade.registerMediator(new GameMediator(_gameViewLogic));
			sendNotification(GeneralNotifications.UPDATE_LEVEL_SCORE, {levelScore:0, mistakes:_levelConfig.mistakes});
			(facade.retrieveMediator(RootMediator.NAME) as RootMediator).content.stage.focus = _gameViewLogic.content;
		}
		
		private function createLevelString():String {

			var levelString:String = "";

			for(var i:int=0;i<20;i++){
				var nom:int = Math.round(Math.random()*_levelConfig.letters.length);
				if(nom!=_levelConfig.letters.length) {
					levelString=levelString + _levelConfig.letters.charAt(nom);
				} else {
					i--;
				}
			}

			return levelString;
		}
	}
}