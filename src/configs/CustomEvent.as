package configs {

	import flash.events.Event;

	public class CustomEvent extends Event {

		public var data:*;

		public static const MENU_BUTTON_CLICK:String = "menuButtonClick";
		public static const GAME_ICON_CLICKED:String = "levelClicked";
		public static const KEY_PRESSED:String = "keyPressed";
		public static const LEVEL_CLEAR:String = "levelEnd";
		public static const UPDATE_LEVEL_SCORE:String = "updateLevelScore";
		public static const RESTART_BUTTON_CLICK:String = "restartButtonClick";
		
		public function CustomEvent(eventName:String, data:* = null) {

			super(eventName,data);
			this.data = data;
		}
	}
}