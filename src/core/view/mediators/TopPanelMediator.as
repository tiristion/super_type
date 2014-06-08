package core.view.mediators {

	import configs.CustomEvent;
	import configs.GeneralNotifications;
	
	import core.view.components.TopPanelViewLogic;
	import core.view.components.ViewLogic;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.INotification;

	public class TopPanelMediator extends UIMediator {

		private static const NAME:String="TopPanelMediator";
		private var _levelId:String;

        public function TopPanelMediator(viewLogic:ViewLogic):void{

			super(NAME, viewLogic);
		}

		override public function listNotificationInterests():Array {

			return[ GeneralNotifications.USER_DATA_UPDATED,
				GeneralNotifications.LOAD_LEVEL,
				GeneralNotifications.LEVEL_END,
				GeneralNotifications.UPDATE_LEVEL_SCORE];
		}

		override public function handleNotification(notification:INotification):void {

			switch(notification.getName()) {
				case GeneralNotifications.USER_DATA_UPDATED:
					(viewLogic as TopPanelViewLogic).userDataUpdate((notification.getBody() as Object).name as String, (notification.getBody() as Object).score as Number);
					break;
				case GeneralNotifications.LOAD_LEVEL:
					_levelId = notification.getBody() as String;
					(viewLogic as TopPanelViewLogic).visibleLevelComponents(true);
					(viewLogic as TopPanelViewLogic).addEventListener(CustomEvent.MENU_BUTTON_CLICK,handlerLobbyButtonClick);
					(viewLogic as TopPanelViewLogic).addEventListener(CustomEvent.RESTART_BUTTON_CLICK,handlerRestartButtonClick);
					break;
				case GeneralNotifications.UPDATE_LEVEL_SCORE:
					(viewLogic as TopPanelViewLogic).updateLevelScore((notification.getBody() as Object).levelScore as Number, (notification.getBody() as Object).mistakes as Number);
					break;
				case GeneralNotifications.LEVEL_END:
					(viewLogic as TopPanelViewLogic).visibleLevelComponents(false);
					break;
			}	
		}	

        private function handlerLobbyButtonClick(event:Event):void {

			(viewLogic as TopPanelViewLogic).visibleLevelComponents(false);
			sendNotification(GeneralNotifications.SHOW_LOBBY);
		}

        private function handlerRestartButtonClick(event:Event):void {

			sendNotification(GeneralNotifications.RESTART_LEVEL,_levelId);
		}
	}
}