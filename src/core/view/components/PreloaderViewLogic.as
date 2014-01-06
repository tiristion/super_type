package core.view.components {

	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	
	public class PreloaderViewLogic extends EventDispatcher {

		public static const NAME:String="PreloaderViewLogic";
		private var _preloader:Shape = new Shape();

        public function PreloaderViewLogic() {

			_preloader.graphics.clear();
			_preloader.graphics.lineStyle(1);
			_preloader.graphics.drawRect(200, 100, 110, 20);
			_preloader.graphics.beginFill(0);
			_preloader.graphics.drawRect(200, 100, 50, 20);
			_preloader.graphics.endFill();
			super(_preloader);
		}

		public function get content():DisplayObject {

			return _preloader;
		}

		public function update(progress:int):void {

			_preloader.graphics.clear();
			_preloader.graphics.lineStyle(1);
			_preloader.graphics.drawRect(200, 100, 110, 20);
			_preloader.graphics.beginFill(0);
			_preloader.graphics.drawRect(200, 100, 10 + progress, 20);
			_preloader.graphics.endFill();
		}
	}
}