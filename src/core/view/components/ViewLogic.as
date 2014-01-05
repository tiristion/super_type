package core.view.components {
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	
	public class ViewLogic extends EventDispatcher {
		public static const NAME:String="ViewLogic";
		private var _graphics:DisplayObjectContainer;
		
		public function ViewLogic(graphics:DisplayObjectContainer) {
			_graphics=graphics;
		}	
		
		public function get content():DisplayObjectContainer {
			return _graphics as DisplayObjectContainer;  
		}
		
		public function onRemove():void {
			if(content && content.parent)
				content.parent.removeChild(content);
		}
	}
}