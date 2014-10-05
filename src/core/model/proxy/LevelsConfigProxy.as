package core.model.proxy {

	import configs.GeneralNotifications;
	
	import core.model.dataobject.LevelConfigDO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LevelsConfigProxy extends Proxy {

		public static const NAME:String = "LevelsConfigProxy";
		private var _listGamesconfigXML:XMLList;
		private var _levelsInfoDO:Array = [];
		private var _urlPath:String;
		private var _xml:XML;
		
		public function LevelsConfigProxy(xml:XML) {

			_xml=xml;
			super(NAME,_xml);
		}

		override public function onRegister():void {

			super.onRegister();
			levelsxmlLoaded();
		}

		private function levelsxmlLoaded():void {

			var levelslistXML:XMLList = _xml.children();

            for(var i:int=0; i<levelslistXML.length(); i++) {
                var level:LevelConfigDO = new LevelConfigDO;
				level.id = levelslistXML[i].attribute("id");
				level.url = levelslistXML[i].attribute("url");
				level.unlockValue = levelslistXML[i].attribute("unlock");
				level.letters = levelslistXML[i].attribute("letters");
				level.mistakes = levelslistXML[i].attribute("mistakes");
				_levelsInfoDO[i]=level;
			}

			sendNotification(GeneralNotifications.LEVELS_CONFIGS_LOADED,_levelsInfoDO);
		}

		public function get levelInfo():Array {

			return _levelsInfoDO;
		}

		public function getLevelInfo(id:String):LevelConfigDO {

			for(var i:int = 0;  i < _levelsInfoDO.length; i++) {

				if (_levelsInfoDO[i].id == id) {
					return _levelsInfoDO[i];
				} 
			}
			return null;
		}
	}
}