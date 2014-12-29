package core.controller.commands {

	import configs.GeneralNotifications;
	
	import core.model.vo.PopupDoActionDO;
	import core.view.components.PopupViewLogic;
	import core.view.mediators.PopupMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class LostLevelCommand extends SimpleCommand {

		override public function execute(notification:INotification):void {

            var levelId:String = notification.getBody() as String;
			var lostLevelDADO:PopupDoActionDO = new PopupDoActionDO(GeneralNotifications.RESTART_LEVEL, levelId, GeneralNotifications.LEVEL_END, {levelScore:0});
			facade.registerMediator(new PopupMediator(new PopupViewLogic('PopupLostLevel'), lostLevelDADO));
		}
	}
}