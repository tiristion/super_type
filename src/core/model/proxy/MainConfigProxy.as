package core.model.proxy {

	import configs.GeneralNotifications;
	
	import core.model.dataobject.XMLElementDO;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class MainConfigProxy extends Proxy {

		public static const NAME:String = "MainConfigProxy";
		private var _urlPath:String;

		public function MainConfigProxy(urlPath:String) {

			super(NAME,new XML());
			this._urlPath = urlPath + "mainconfig.xml";
		}

		override public function onRegister():void {

			super.onRegister();
			var xmlUrl:URLRequest = new URLRequest(_urlPath); 
			var loader:URLLoader = new URLLoader(xmlUrl);
			loader.addEventListener(Event.COMPLETE, xmlLoaded); 
		}

		private function xmlLoaded(event:Event):void {

			(event.target).removeEventListener(Event.COMPLETE, xmlLoaded);
			this.data = XML(event.target.data);
			var listXML:XMLList = data.children();
			var elementsFromXML:Array = [];

            for(var i:int = 0; i < listXML.length(); i++) {

				var xmlElement:XMLElementDO = new XMLElementDO;
				xmlElement.name = listXML[i].attribute("name");
				xmlElement.type = listXML[i].attribute("type");
				xmlElement.value = listXML[i].attribute("value");
				elementsFromXML[i] = xmlElement;
			}

			sendNotification(GeneralNotifications.LOAD_ASSETS,elementsFromXML);
		}
	}
}