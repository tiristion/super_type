package core.view.mediators {

	import configs.CustomEvent;
	import configs.GeneralNotifications;
	
	import core.view.components.LobbyViewLogic;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class LobbyMediator extends UIMediator {

		static public const NAME:String = "LobbyMediator";

        private var lobbyVLogic:LobbyViewLogic;

		private var gameInfoDO:Array;
		private var score:int;

		public function LobbyMediator(viewComponent:LobbyViewLogic) {

			super(NAME, viewComponent);
            lobbyVLogic = viewComponent;

            lobbyVLogic.addEventListener(CustomEvent.GAME_ICON_CLICKED, handlerOnGameIconClick);
		}
		
		public function handlerOnGameIconClick(event:CustomEvent):void {

            var gameName:String = event.data as String;
			sendNotification(GeneralNotifications.LOAD_LEVEL, gameName);
		}
		
		override public function listNotificationInterests():Array {

			return [
                GeneralNotifications.USER_DATA_UPDATED,
				GeneralNotifications.LEVELS_CONFIGS_LOADED,
				GeneralNotifications.CLEAR_USER
            ];
		}

		override public function handleNotification(notification:INotification):void {

			switch(notification.getName()) {
				case GeneralNotifications.USER_DATA_UPDATED:
					this.score = notification.getBody().score as Number;
                    lobbyVLogic.unlockLevels(score, gameInfoDO);
					break;
				case GeneralNotifications.LEVELS_CONFIGS_LOADED:
					this.gameInfoDO = notification.getBody() as Array;
					break;
				case GeneralNotifications.CLEAR_USER:
                    lobbyVLogic.unlockLevels(0, gameInfoDO);
					break;
			}	
		}	
	}
}