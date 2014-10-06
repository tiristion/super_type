package core.view.components {

	import flash.text.TextField;

	public class LoginPopupViewLogic extends PopupViewLogic {

		public function LoginPopupViewLogic() {

			super('PopupUserLogin');

            var userName:TextField = content["InputUserName"] as TextField;
			userName.displayAsPassword = true;

            var userPassword:TextField = content["InputUserPassword"] as TextField;
			(content["ErrorMessage"] as TextField).visible = false;
		}
	}
}