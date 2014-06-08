package core.controller.commands {

	import core.model.proxy.UserProxy;
	
	import flash.net.SharedObject;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.SharedStorage;
	
	public class ClearUserCommand extends SimpleCommand	{

		override public function execute(notification:INotification):void {

			var userProxy:UserProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			userProxy.clearUserData();
			SharedStorage.getInstance().saveUserData(userProxy.userData);
		}
	}
}