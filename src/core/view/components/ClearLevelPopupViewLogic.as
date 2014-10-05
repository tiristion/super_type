package core.view.components {

	public class ClearLevelPopupViewLogic extends PopupViewLogic {

		public function ClearLevelPopupViewLogic(popupName:String, levelScore:Number) {

			super(popupName);
			content['result'].text = levelScore.toString();
		}
	}
}