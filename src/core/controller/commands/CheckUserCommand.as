package core.controller.commands {

	import configs.GeneralNotifications;
	
	import core.model.dataobject.PopupDoActionDO;
	import core.model.proxy.UserProxy;
	import core.view.components.PopupViewLogic;
	import core.view.mediators.PopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.SharedStorage;
	
	public class CheckUserCommand extends SimpleCommand {
		
		override public function execute(notification:INotification):void {

			var userName:String = (notification.getBody() as Object).name as String;
			var userPassword:String = (notification.getBody() as Object).password as String;
			
			SharedStorage.getInstance().createShared(userName);
			var welcomeDADO:PopupDoActionDO = new PopupDoActionDO(GeneralNotifications.CLEAR_USER, {levelScore:0});

            if(!SharedStorage.getInstance().hasUserData()) {

				SharedStorage.getInstance().createUser(userName,userPassword);
				facade.registerProxy(new UserProxy(SharedStorage.getInstance().getUserData()));
				sendNotification(GeneralNotifications.PASSWORD_ACCEPTED);
				facade.registerMediator(new PopupMediator(new PopupViewLogic('PopupWelcome'), welcomeDADO));
			} else {
				if(SharedStorage.getInstance().checkPassword(userPassword)) {
					facade.registerProxy(new UserProxy(SharedStorage.getInstance().getUserData()));
					sendNotification(GeneralNotifications.PASSWORD_ACCEPTED);
					facade.registerMediator(new PopupMediator(new PopupViewLogic('PopupWelcome'), welcomeDADO));
				} else {
                    sendNotification(GeneralNotifications.PASSWORD_DENIED);
                }
			}
		}
	}
}