package core.controller.commands
{
	import configs.GeneralNotifications;
	
	import core.model.proxy.GameProxy;
	import core.model.proxy.UserProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class KeyPressedCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void{
			var userProxy:UserProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			var gameProxy:GameProxy = facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			var currentLetterCode:Number = notification.getBody().code as Number;
			var currentLetterPosition:Number = notification.getBody().position as Number;
			var letters:String = gameProxy.getData().letters;
			var mistakes:Number = gameProxy.getData().mistakes;
			if(currentLetterCode==letters.charCodeAt(currentLetterPosition)||currentLetterCode==letters.charCodeAt(currentLetterPosition)-32){
				sendNotification(GeneralNotifications.LETTER_TRUE,mistakes);
			}	
			else{
				mistakes--;
				if(mistakes<0){
					sendNotification(GeneralNotifications.LEVEL_LOST, gameProxy.levelConfig.id);
					mistakes = 1000;
				}
				else{
					gameProxy.setMistakes(mistakes);
					sendNotification(GeneralNotifications.LETTER_FALSE,mistakes);			
				}
			}
		}
	}
}