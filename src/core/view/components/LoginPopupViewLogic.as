package core.view.components {

	import flash.text.TextField;

	public class LoginPopupViewLogic extends PopupViewLogic {

		private var userName:TextField = new TextField();
		private var userPassword:TextField = new TextField();
				
		public function LoginPopupViewLogic() {

			super('PopupUserLogin');

			userName = content["InputUserName"] as TextField;
			(content["InputUserPassword"] as TextField).displayAsPassword = true;

			userPassword = content["InputUserPassword"] as TextField;
			(content["ErrorMessage"] as TextField).visible = false;
		}
	}
}