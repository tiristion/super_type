package core.controller.commands {

    import configs.GeneralNotifications;

    import core.model.dataobject.LevelConfigDO;
    import core.model.proxy.GameProxy;
    import core.model.proxy.LevelsConfigProxy;

    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.command.SimpleCommand;

    public class RestartLevelCommand extends SimpleCommand {

		private var _levelConfig:LevelConfigDO;
		
		override public function execute(notification:INotification):void {

			_levelConfig = (facade.retrieveProxy(LevelsConfigProxy.NAME) as LevelsConfigProxy).getLevelInfo(notification.getBody() as String);
			var levelConfig:LevelConfigDO = new LevelConfigDO;
			levelConfig.id = _levelConfig.id;
			levelConfig.unlockValue = _levelConfig.unlockValue;
			levelConfig.url = _levelConfig.url;
			levelConfig.letters = createLevelString();
			levelConfig.mistakes = _levelConfig.mistakes;
			facade.registerProxy(new GameProxy(levelConfig));
			sendNotification(GeneralNotifications.UPDATE_LEVEL_SCORE, {levelScore:0, mistakes:_levelConfig.mistakes});
			sendNotification(GeneralNotifications.NEW_LEVEL_LETTERS,levelConfig.letters);
		}

		private function createLevelString():String {

			var lettersArray:Array = [];
			var levelString:String = ""; 

            for(var i:int=0;i<20;i++) {

				var nom:int = Math.round(Math.random()*_levelConfig.letters.length) - 1;

				if(nom==-1) {
                    nom++;
                }

				levelString=levelString + _levelConfig.letters.charAt(nom);
				lettersArray[i] = _levelConfig.letters.charAt(nom);
			}

			return levelString;
		}
	}
}