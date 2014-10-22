package core.controller.commands {

	import configs.GeneralNotifications;

    import core.model.dataobject.KeyPressedInfo;

    import core.model.proxy.GameProxy;

	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class KeyPressedCommand extends SimpleCommand {

		override public function execute(notification:INotification):void {

			var keyPressedInfo:KeyPressedInfo = notification.getBody() as KeyPressedInfo;
            var currentLetterCode:Number = keyPressedInfo.letterCharCode;
			var currentLetterPosition:Number = keyPressedInfo.currentLetterposition;
			var letters:String = (gameProxy.getData() as Object).letters;
			var mistakes:Number = (gameProxy.getData() as Object).mistakes;

            if(currentLetterCode == letters.charCodeAt(currentLetterPosition) || currentLetterCode == letters.charCodeAt(currentLetterPosition) - 32) {
				sendNotification(GeneralNotifications.LETTER_TRUE, mistakes);
                return;
			}

            mistakes--;

            if(mistakes < 0) {
                sendNotification(GeneralNotifications.LEVEL_LOST, gameProxy.levelConfig.id);
                return;
            }

            gameProxy.setMistakes(mistakes);
            sendNotification(GeneralNotifications.LETTER_FALSE, mistakes);
		}

        private function get gameProxy():GameProxy {

            return facade.retrieveProxy(GameProxy.NAME) as GameProxy;
        }
	}
}