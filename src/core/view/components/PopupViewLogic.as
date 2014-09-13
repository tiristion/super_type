package core.view.components {

	import flash.display.MovieClip;
	
	import utils.WarehouseAssets;

	public class PopupViewLogic extends ViewLogic {
		
		public var dialogName:String = null;
		
		private var popupMC:MovieClip;
		
		public function PopupViewLogic(popupName:String) {

			dialogName = popupName;
			popupMC =  new (WarehouseAssets.getInstance().getAsset(popupName) as Class);

			super(popupMC);
		}
	}	
}