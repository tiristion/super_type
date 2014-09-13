package core.view.mediators {

	import configs.CustomEvent;
	import configs.GeneralNotifications;
	
	import core.view.components.GameViewLogic;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class GameMediator extends UIMediator {

		static public const NAME:String = "GameMediator";

		private var viewElement:GameViewLogic;

        public function GameMediator(viewElement:GameViewLogic) {

			this.viewElement = viewElement;

			super(NAME, viewElement);

			addListeners();
		}

        private function addListeners():void {

            viewElement.addEventListener(CustomEvent.KEY_PRESSED, handlerOnKeyPressed);
            viewElement.addEventListener(CustomEvent.LEVEL_CLEAR, handlerOnLevelClear);
            viewElement.addEventListener(CustomEvent.UPDATE_LEVEL_SCORE, handlerUpdateLevelScore);
        }

		public function handlerOnKeyPressed(event:CustomEvent):void {

			sendNotification(GeneralNotifications.KEY_PRESSED, event.data);
		}
		
		public function handlerOnLevelClear(event:CustomEvent):void {

			sendNotification(GeneralNotifications.LEVEL_CLEAR,event.data);
		}
		
		public function handlerUpdateLevelScore(event:CustomEvent):void {

			sendNotification(GeneralNotifications.UPDATE_LEVEL_SCORE,event.data);
		}
		
		override public function listNotificationInterests():Array {

			return  [GeneralNotifications.LETTER_TRUE,
				    GeneralNotifications.LETTER_FALSE,
				    GeneralNotifications.NEW_LEVEL_LETTERS];
		}
		
		override public function handleNotification(notification:INotification):void {

			switch(notification.getName()){
				case GeneralNotifications.LETTER_TRUE:
					viewElement.letterTrue(notification.getBody() as Number);
					break;
				case GeneralNotifications.LETTER_FALSE:
					viewElement.letterFalse(notification.getBody() as Number);
					break;
				case GeneralNotifications.NEW_LEVEL_LETTERS:
					viewElement.restartLevel(notification.getBody() as String);
					break;
			}
		}
	}
}