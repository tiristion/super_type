package core.model.proxy {

	import configs.GeneralNotifications;
	
	import core.model.dataobject.LevelConfigDO;
	
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
			levelsxmlLoaded();
		}

		private function levelsxmlLoaded():void {

			var levelslistXML:XMLList = xml.children();

            for(var i:int = 0; i < levelslistXML.length(); i++) {

                var level:LevelConfigDO = new LevelConfigDO();
				level.id = levelslistXML[i].attribute("id");
				level.url = levelslistXML[i].attribute("url");
				level.unlockValue = levelslistXML[i].attribute("unlock");
				level.letters = levelslistXML[i].attribute("letters");
				level.mistakes = levelslistXML[i].attribute("mistakes");
				levelsInfoDO.push(level);
			}

			sendNotification(GeneralNotifications.LEVELS_CONFIGS_LOADED, levelsInfoDO);
		}

		public function get levelInfo():Array {

			return levelsInfoDO;
		}

		public function getLevelInfoById(id:String):LevelConfigDO {

			for(var i:int = 0;  i < levelsInfoDO.length; i++) {

				if (levelsInfoDO[i].id == id) {
					return levelsInfoDO[i];
				} 
			}

			return null;
		}
	}
}