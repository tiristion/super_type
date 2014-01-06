package core.view.mediators
{
	import configs.GeneralNotifications;
	
	import core.model.dataobject.PopupDoActionDO;
	import core.view.components.PopupViewLogic;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class PopupMediator extends UIMediator {
		
		protected var doActionDo:PopupDoActionDO;
		private var dialogName:String;
		
		public function PopupMediator(popupViewLogic:PopupViewLogic, doActionDO:PopupDoActionDO=null) {

			super(popupViewLogic.dialogName, popupViewLogic);
			this.doActionDo = doActionDO;
			dialogName = popupViewLogic.dialogName;
			popupViewLogic.content['closeButton'].addEventListener(MouseEvent.CLICK, closePopup);
			popupViewLogic.content['doButton'].addEventListener(MouseEvent.CLICK, doButtonHandler);
		}

		public function doButtonHandler( event:Event ):void {

			sendNotification(doActionDo.notificationName,doActionDo.notificationBody);
			sendNotification(GeneralNotifications.CLOSE_POPUP, dialogName);
		}

		public function closePopup( event:Event = null ):void {

			sendNotification(GeneralNotifications.CLOSE_POPUP, dialogName);

            if(doActionDo.doNotificationAfterClose!=null) {
                sendNotification(doActionDo.doNotificationAfterClose,doActionDo.doNotificationAfterCloseBody);
            }
		}
	}	
}