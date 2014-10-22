package core.view.mediators {

	import configs.CustomEvent;
	import configs.GeneralNotifications;
	
	import core.view.components.GameViewLogic;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class GameMediator extends UIMediator {

		static public const NAME:String = "GameMediator";

		private var gameVLogic:GameViewLogic;

        public function GameMediator(vLogic:GameViewLogic) {

			this.gameVLogic = vLogic;

			super(NAME, vLogic);

			addListeners();
		}

        private function addListeners():void {

            gameVLogic.addEventListener(CustomEvent.KEY_PRESSED, handlerOnKeyPressed);
            gameVLogic.addEventListener(CustomEvent.LEVEL_CLEAR, handlerOnLevelClear);
            gameVLogic.addEventListener(CustomEvent.UPDATE_LEVEL_SCORE, handlerUpdateLevelScore);
        }

		public function handlerOnKeyPressed(event:CustomEvent):void {

			sendNotification(GeneralNotifications.KEY_PRESSED, event.data);
		}
		
		public function handlerOnLevelClear(event:CustomEvent):void {

			sendNotification(GeneralNotifications.LEVEL_CLEAR, event.data);
		}
		
		public function handlerUpdateLevelScore(event:CustomEvent):void {

			sendNotification(GeneralNotifications.UPDATE_LEVEL_SCORE, event.data);
		}
		
		override public function listNotificationInterests():Array {

			return  [
                GeneralNotifications.LETTER_TRUE,
				GeneralNotifications.LETTER_FALSE,
				GeneralNotifications.NEW_LEVEL_LETTERS
            ];
		}
		
		override public function handleNotification(notification:INotification):void {

			switch(notification.getName()){
				case GeneralNotifications.LETTER_TRUE:
					gameVLogic.correctSymbolEntered(notification.getBody() as Number);
					break;
				case GeneralNotifications.LETTER_FALSE:
					gameVLogic.incorrectSymbolEntered(notification.getBody() as Number);
					break;
				case GeneralNotifications.NEW_LEVEL_LETTERS:
					gameVLogic.restartLevel(notification.getBody() as String);
					break;
			}
		}
	}
}