package core.view.components {

	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	
	public class ViewLogic extends EventDispatcher {

		private var graphics:DisplayObjectContainer;
		
		public function ViewLogic(graphics:DisplayObjectContainer) {

			this.graphics = graphics;
		}	
		
		public function get content():DisplayObjectContainer {

            return graphics as DisplayObjectContainer;
		}
	}
}