package core.controller.commands {

	import configs.GeneralNotifications;
	
	import core.model.dataobject.PopupDoActionDO;
	import core.view.components.ClearLevelPopupViewLogic;
	import core.view.mediators.PopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ClearLevelCommand extends SimpleCommand {

		override public function execute(notification:INotification):void {

			var clearLevelDADO:PopupDoActionDO = new PopupDoActionDO(GeneralNotifications.RESTART_LEVEL, (notification.getBody()as Object).levelId, GeneralNotifications.LEVEL_END, notification.getBody());
			facade.registerMediator(new PopupMediator(new ClearLevelPopupViewLogic('PopupClearLevel', (notification.getBody() as Object).levelScore), clearLevelDADO));
		}
	}
}