package core.controller.commands {

	import configs.GeneralNotifications;
	
	import core.model.vo.PopupDoActionDO;
	import core.view.mediators.LobbyMediator;
	import core.view.mediators.LoginPopupMediator;
	import core.view.mediators.TopPanelMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LobbyStartCommand extends SimpleCommand {

		override public function execute(notification:INotification):void {

			facade.registerMediator(new LobbyMediator());
			facade.registerMediator(new TopPanelMediator());

			sendNotification(GeneralNotifications.SHOW_USER_LOGIN);

			var loginPopupDoActionDO:PopupDoActionDO;
			loginPopupDoActionDO = new PopupDoActionDO(GeneralNotifications.REGISTER_USER_INFO);
			facade.registerMediator(new LoginPopupMediator(loginPopupDoActionDO));
		}
	}
}