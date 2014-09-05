package core.controller.commands {

    import configs.GeneralNotifications;

    import core.model.dataobject.LevelConfigDO;
    import core.model.proxy.GameProxy;
    import core.model.proxy.LevelsConfigProxy;

    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    public class RestartLevelCommand extends SimpleCommand {

		private var levelConfig:LevelConfigDO;
		
		override public function execute(notification:INotification):void {

			levelConfig = (facade.retrieveProxy(LevelsConfigProxy.NAME) as LevelsConfigProxy).getLevelInfo(notification.getBody() as String);

			var currentLevelConfig:LevelConfigDO = new LevelConfigDO;

			currentLevelConfig.id = levelConfig.id;
			currentLevelConfig.unlockValue = levelConfig.unlockValue;
			currentLevelConfig.url = levelConfig.url;
			currentLevelConfig.letters = createLevelString();
			currentLevelConfig.mistakes = levelConfig.mistakes;

			facade.registerProxy(new GameProxy(currentLevelConfig));

			sendNotification(GeneralNotifications.UPDATE_LEVEL_SCORE, {levelScore:0, mistakes:levelConfig.mistakes});
			sendNotification(GeneralNotifications.NEW_LEVEL_LETTERS,currentLevelConfig.letters);
		}

		private function createLevelString():String {

			var lettersArray:Array = [];
			var levelString:String = ""; 

            for(var i:int=0;i<20;i++) {

				var nom:int = Math.round(Math.random() * levelConfig.letters.length) - 1;

				if(nom == -1) {
                    nom++;
                }

				levelString = levelString + levelConfig.letters.charAt(nom);
				lettersArray[i] = levelConfig.letters.charAt(nom);
			}

			return levelString;
		}
	}
}