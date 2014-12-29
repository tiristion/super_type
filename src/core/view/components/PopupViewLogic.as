package core.view.components {

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	import utils.WarehouseAssets;

	public class PopupViewLogic extends ViewLogic {
		
		public var dialogName:String = null;
		
		private var popupMC:MovieClip;
		
		public function PopupViewLogic(popupName:String) {

			dialogName = popupName;
			popupMC =  new (WarehouseAssets.getInstance().getAsset(popupName) as Class);

			super(popupMC);

			initCloseButtons();
			initDoButtons();
		}

		private function initCloseButtons():void {

			checkCloseButton("closeButton");
			checkCloseButton("x_btn");
			checkCloseButton("x_button");
			checkCloseButton("close_btn");
			checkCloseButton("close_button");
		}

		private function checkCloseButton(buttonName:String):void {

			if(popupMC.hasOwnProperty(buttonName)) {
				popupMC[buttonName].addEventListener(MouseEvent.CLICK, onCloseButtonClick, false, 0, true);
			}
		}

		private function onCloseButtonClick(event:MouseEvent):void {

		}

		private function initDoButtons():void {

		}
	}	
}