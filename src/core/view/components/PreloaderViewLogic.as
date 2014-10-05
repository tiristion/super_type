package core.view.components {

	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	
	public class PreloaderViewLogic extends EventDispatcher {

		public static const NAME:String = "PreloaderViewLogic";

		private var preloader:Shape = new Shape();

        public function PreloaderViewLogic() {

            initializePreloader();

			super(preloader);
		}

        private function initializePreloader():void {

            preloader.graphics.clear();
            preloader.graphics.lineStyle(1);
            preloader.graphics.drawRect(200, 100, 110, 20);
            preloader.graphics.beginFill(0);
            preloader.graphics.drawRect(200, 100, 50, 20);
            preloader.graphics.endFill();
        }

		public function get content():DisplayObject {

			return preloader;
		}

		public function update(progress:int):void {

			preloader.graphics.clear();
			preloader.graphics.lineStyle(1);
			preloader.graphics.drawRect(200, 100, 110, 20);
			preloader.graphics.beginFill(0);
			preloader.graphics.drawRect(200, 100, 10 + progress, 20);
			preloader.graphics.endFill();
		}
	}
}