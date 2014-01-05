package configs {
	import flash.events.Event;

	public class CustomEvent extends Event {
		public var data:*;
		public static const DO_BTN_CLICK:String = "doButtonClick";           
		public static const CLOSE_BTN_CLICK:String = "closeButtonClick";                 
		public static const MENU_BUTTON_CLICK:String = "menuButtonClick";
		public static const LEVEL_CLICKED:String = "levelClicked";
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