package core.view.mediators {

	import configs.GeneralNotifications;
	
	import core.view.components.PreloaderViewLogic;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class PreloaderMediator extends Mediator {

		static public const NAME:String = "PreloaderMediator";
		
		public function PreloaderMediator(viewComponent:PreloaderViewLogic) {

				super(NAME, viewComponent)
		}
		
		override public function onRegister():void {

            super.onRegister();
		}

		override public function listNotificationInterests():Array {

			return[GeneralNotifications.PRELOADER_UPDATE];
		}

		override public function handleNotification(notification:INotification):void {

			switch(notification.getName()) {
				case GeneralNotifications.PRELOADER_UPDATE:
                    (viewComponent as PreloaderViewLogic).update(notification.getBody() as int);
					sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT,viewComponent.content);
					break;
			}
		}
	}
}