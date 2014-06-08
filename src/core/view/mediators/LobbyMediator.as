package core.view.mediators {

	import configs.CustomEvent;
	import configs.GeneralNotifications;
	
	import core.view.components.LobbyViewLogic;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class LobbyMediator extends UIMediator {

		static public const NAME:String = "LobbyMediator";
		private var _gameInfoDO:Array;
		private var _score:int;
		
		public function LobbyMediator(viewComponent:LobbyViewLogic) {

			super(NAME,viewComponent);
			(viewComponent as LobbyViewLogic).addEventListener(CustomEvent.LEVEL_CLICKED, handlerOnLevelIconClick);
		}
		
		public function handlerOnLevelIconClick(event:CustomEvent):void {

			sendNotification(GeneralNotifications.LOAD_LEVEL,event.data);
		}
		
		override public function onRegister():void {

			super.onRegister();
		}
	
		override public function listNotificationInterests():Array {

			return [GeneralNotifications.USER_DATA_UPDATED,
				GeneralNotifications.LEVELS_CONFIGS_LOADED,
				GeneralNotifications.CLEAR_USER];
		}

		override public function handleNotification(notification:INotification):void {

			switch(notification.getName()) {
				case GeneralNotifications.USER_DATA_UPDATED:
					_score = notification.getBody().score as int;
					(viewComponent as LobbyViewLogic).unlockLevels(_score,_gameInfoDO);
					break;
				case GeneralNotifications.LEVELS_CONFIGS_LOADED:
					_gameInfoDO = notification.getBody() as Array;
					break;
				case GeneralNotifications.CLEAR_USER:
					(viewComponent as LobbyViewLogic).unlockLevels(0,_gameInfoDO);
					break;
			}	
		}	
	}
}