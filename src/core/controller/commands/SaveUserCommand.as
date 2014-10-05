package core.controller.commands {

	import configs.GeneralNotifications;
	
	import core.model.proxy.UserProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.SharedStorage;
	
	public class SaveUserCommand extends SimpleCommand {

		override public function execute(notification:INotification):void {

			userProxy.updateUserData((notification.getBody() as Object).levelScore);
			SharedStorage.getInstance().saveUserData(userProxy.userData);
			sendNotification(GeneralNotifications.SHOW_LOBBY);
		}

        public function get userProxy():UserProxy {

            return facade.retrieveProxy(UserProxy.NAME) as UserProxy;
        }
	}
}