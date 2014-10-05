package core.controller.commands {

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class ClosePopupCommand extends SimpleCommand {

		override public function execute(notification:INotification):void {

            facade.removeMediator(notification.getBody().toString());
		}
	}
}