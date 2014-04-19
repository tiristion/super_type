package core.controller.commands {

	import configs.GeneralNotifications;
	
	import core.model.dataobject.PopupDoActionDO;
	import core.view.components.LobbyViewLogic;
	import core.view.components.LoginPopupViewLogic;
	import core.view.components.TopPanelViewLogic;
	import core.view.mediators.LobbyMediator;
	import core.view.mediators.LoginPopupMediator;
	import core.view.mediators.TopPanelMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LobbyStartCommand extends SimpleCommand {

		override public function execute(notification:INotification):void {

			facade.registerMediator(new LobbyMediator(new LobbyViewLogic()));
			facade.registerMediator(new TopPanelMediator(new TopPanelViewLogic()));
			sendNotification(GeneralNotifications.SHOW_USER_LOGIN);
			var loginPopupDADO:PopupDoActionDO = new PopupDoActionDO(GeneralNotifications.REGISTER_USER_INFO);
			facade.registerMediator(new LoginPopupMediator(new LoginPopupViewLogic(),loginPopupDADO));
		}
	}
}