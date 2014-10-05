package core.view.mediators {

	import configs.GeneralNotifications;
	
	import core.model.dataobject.PopupDoActionDO;
	import core.model.dataobject.UserDO;
	import core.view.components.LoginPopupViewLogic;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.INotification;

	public class LoginPopupMediator extends UIMediator {
		
		protected var doActionDo:PopupDoActionDO;
		private var dialogName:String;
		
		public function LoginPopupMediator(popupViewLogic:LoginPopupViewLogic, doActionDO:PopupDoActionDO=null) {

			super(popupViewLogic.dialogName, popupViewLogic);

			this.doActionDo = doActionDO;
			dialogName = popupViewLogic.dialogName;

			popupViewLogic.content['doButton'].addEventListener( MouseEvent.CLICK, doButtonHandler);
		}

		public function closePopup( event:Event = null ):void {

			sendNotification(GeneralNotifications.CLOSE_POPUP, dialogName);
		}
		
		override public function listNotificationInterests():Array {

			return[GeneralNotifications.PASSWORD_ACCEPTED,GeneralNotifications.PASSWORD_DENIED];
		}

		override public function handleNotification(notification:INotification):void {
			switch(notification.getName()) {
				case GeneralNotifications.PASSWORD_ACCEPTED:
					closePopup();
					break;
				case GeneralNotifications.PASSWORD_DENIED:
					viewLogic.content["ErrorMessage"].visible=true;
					break;
			}
		}

		public function doButtonHandler(event:MouseEvent):void {

			var user:UserDO = new UserDO;
			user.name = viewLogic.content["InputUserName"].text;
			user.password = viewLogic.content["InputUserPassword"].text;

            if(user.name != "") {
				 sendNotification(doActionDo.notificationName,user);
			 }
		}
	}
}