package core.view.components {

	import flash.text.TextField;

	public class LoginPopupViewLogic extends PopupViewLogic {

		public function LoginPopupViewLogic(name:String) {

			super(name);

			(content["InputUserPassword"] as TextField).displayAsPassword = true;
			(content["ErrorMessage"] as TextField).visible = false;
		}
	}
}