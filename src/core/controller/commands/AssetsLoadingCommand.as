package core.controller.commands {

	import configs.GeneralNotifications;
	
	import core.model.proxy.LevelsConfigProxy;
	import core.view.mediators.PreloaderMediator;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.MultiLoader;
	import utils.WarehouseAssets;
	
	public class AssetsLoadingCommand extends SimpleCommand {

		override public function execute(notification:INotification):void {

			var mainConfigXmlList:Array = notification.getBody() as Array;
			var multiLoader:MultiLoader = new MultiLoader();
            var levelsConfigPath:String = '';

            for(var i:int = 0; i < mainConfigXmlList.length; i++) {

				switch(mainConfigXmlList[i].type) {
					case "movie": {
						multiLoader.addTask(mainConfigXmlList[i].value, mainConfigXmlList[i].name, MultiLoader.MOVIE);
						break;
                    }
					case "xml": {
						multiLoader.addTask(mainConfigXmlList[i].value, mainConfigXmlList[i].name, MultiLoader.TEXT);
						levelsConfigPath = mainConfigXmlList[i].value as String;
						break;
                    }
				}
			}
			
			multiLoader.addEventListener(Event.COMPLETE, onComplete);
			multiLoader.addEventListener(MultiLoader.ITEM_COMPLETE, onItemComplete);
			multiLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			multiLoader.start();
		}
		
		private function onProgress(event:ProgressEvent):void {

			var multiLoader:MultiLoader = MultiLoader(event.target);
			var progress:int = Math.floor(multiLoader.progress*100);

			sendNotification(GeneralNotifications.PRELOADER_UPDATE, progress)
		}
	
		private function onItemComplete(event:Event):void {

		}
	
		private function onComplete(event:Event):void {

			facade.removeMediator(PreloaderMediator.NAME);
			var multiLoader:MultiLoader = event.target as MultiLoader;

            for(var i:int = 0; i < multiLoader.length; i++) {

				var registrationNameOfTask:String=multiLoader.getItemRegistrationName(i);

				if(multiLoader.getItemType(i) == MultiLoader.MOVIE) {
					WarehouseAssets.getInstance().setAssets([{filename:registrationNameOfTask, content:Loader(multiLoader.getContentByRegistrationName(registrationNameOfTask)).content as MovieClip}]);
				}
				if(multiLoader.getItemType(i) == MultiLoader.TEXT) {
					var xml:XML = XML(multiLoader.getContentByRegistrationName(registrationNameOfTask));
				}
			}

			sendNotification(GeneralNotifications.ASSETS_LOADED);
			facade.registerProxy(new LevelsConfigProxy(xml));
		}
	}
}