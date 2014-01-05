package core.model.dataobject
{
	import org.puremvc.as3.patterns.observer.Notification;

	public class PopupDoActionDO	{
		
		public var notificationName:String;
		public var notificationBody:Object;
		public var shouldCloseAfterDo:Boolean;
		public var doNotificationAfterClose:String;
		public var doNotificationAfterCloseBody:Object;
 		 
		public function PopupDoActionDO(notificationName:String, notificationBody:Object=null, doNotificationAfterClose:String=null, doNotificationAfterCloseBody:Object=null, shouldCloseAfterDo:Boolean=true ) {
			this.notificationName = notificationName;
			this.notificationBody = notificationBody;
			this.shouldCloseAfterDo = shouldCloseAfterDo;
			this.doNotificationAfterClose = doNotificationAfterClose;
			this.doNotificationAfterCloseBody = doNotificationAfterCloseBody;
		}
	}
}