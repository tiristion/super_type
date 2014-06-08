package core.view.components {

	import flash.text.TextField;

	public class LoginPopupViewLogic extends PopupViewLogic {

		private var _userName:TextField = new TextField();
		private var _userPassword:TextField = new TextField();
				
		public function LoginPopupViewLogic() {

			super('PopupUserLogin');
			_userName = content["InputUserName"] as TextField;
			(content["InputUserPassword"] as TextField).displayAsPassword=true;
			_userPassword = content["InputUserPassword"] as TextField;
			(content["ErrorMessage"] as TextField).visible=false;
		}
	}
}