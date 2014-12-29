package core.model.proxy {

	import configs.GeneralNotifications;
	
	import core.model.vo.LevelConfigDO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LevelsConfigProxy extends Proxy {

		public static const NAME:String = "LevelsConfigProxy";

		private var levelsInfoDO:Array = [];
		private var xml:XML;

		public function LevelsConfigProxy(xml:XML) {

			this.xml = xml;
			super(NAME, xml);
		}

		override public function onRegister():void {

			super.onRegister();
			getLevelsConfigsFromXML();
		}

		private function getLevelsConfigsFromXML():void {

			var levelsListXML:XMLList = xml.children();

            for(var i:int = 0; i < levelsListXML.length(); i++) {

                var level:LevelConfigDO = new LevelConfigDO();
				level.id = levelsListXML[i].attribute("id");
				level.url = levelsListXML[i].attribute("url");
				level.unlockValue = levelsListXML[i].attribute("unlock");
				level.letters = levelsListXML[i].attribute("letters");
				level.mistakes = levelsListXML[i].attribute("mistakes");
				levelsInfoDO.push(level);
			}

			sendNotification(GeneralNotifications.LEVELS_CONFIGS_LOADED, levelsInfoDO);
		}

		public function get levelInfo():Array {

			return levelsInfoDO;
		}

		public function getLevelInfoById(id:String):LevelConfigDO {

			for(var i:int = 0; i < levelsInfoDO.length; i++) {

				if(levelsInfoDO[i].id == id) {
					return levelsInfoDO[i];
				} 
			}

			return null;
		}
	}
}