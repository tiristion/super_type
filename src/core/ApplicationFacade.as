package core {

	import configs.GeneralNotifications;
	
	import flash.display.Sprite;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade {

		public static function getInstance():ApplicationFacade {

			return instance ? instance as ApplicationFacade : new ApplicationFacade();
		}

		public function startup(command:Class,root:Sprite):void {

			registerCommand(GeneralNotifications.STARTUP, command);
			sendNotification(GeneralNotifications.STARTUP, root);
		}
	}
}