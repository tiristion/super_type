package core.view.mediators {

	import configs.GeneralNotifications;

	import core.model.vo.PopupDoActionDO;
	import core.model.vo.UserDO;

	import core.view.components.LoginPopupViewLogic;
	
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.INotification;

	public class LoginPopupMediator extends UIMediator {
		
		private static const NAME:String = "PopupUserLogin";

		protected var doActionDO:PopupDoActionDO;

		public function LoginPopupMediator(doActionDO:PopupDoActionDO) {

			super(NAME, new LoginPopupViewLogic(NAME));

			this.doActionDO = doActionDO;

			viewLogic.content['doButton'].addEventListener(MouseEvent.CLICK, doButtonHandler);
		}

		override public function listNotificationInterests():Array {

			return[
                GeneralNotifications.PASSWORD_ACCEPTED,
                GeneralNotifications.PASSWORD_DENIED
            ];
		}

		override public function handleNotification(notification:INotification):void {

			switch(notification.getName()) {
				case GeneralNotifications.PASSWORD_ACCEPTED:
					onRemove();
					break;
				case GeneralNotifications.PASSWORD_DENIED:
					showErrorMessage();
					break;
			}
		}

		private function showErrorMessage():void {

			viewLogic.content["ErrorMessage"].visible = true;
		}

		public function doButtonHandler(event:MouseEvent):void {

			var userData:UserDO = new UserDO();
			userData.name = viewLogic.content["InputUserName"].text;
			userData.password = viewLogic.content["InputUserPassword"].text;

            if(userData.name != "") {
				 sendNotification(doActionDO.notificationName, userData);
			}
		}
	}
}