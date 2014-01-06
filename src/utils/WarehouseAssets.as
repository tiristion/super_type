package utils {

	import flash.display.MovieClip;
	
	public class WarehouseAssets {

		private static var _instance:WarehouseAssets;
		private var _assetsArray:Array = [];
		
		static public function getInstance():WarehouseAssets {

			if (_instance == null) {
				_instance = new WarehouseAssets();
			}

			return _instance;
		}
		
		public function setAssets(assetsArray:Array):void {

			for(var i:int=0; i<assetsArray.length; i++) {
				_assetsArray.push(assetsArray[i]);
			}
		}
		
		public function getAsset(assetName:String,assetSpace:String=null):Class {

			if(assetSpace!=null) {
				for(var i:int=0; i<_assetsArray.length; i++) {
					if(_assetsArray[i].filename == assetSpace) {
                        return (_assetsArray[i].content as MovieClip).loaderInfo.applicationDomain.getDefinition(assetName) as Class;
                    }
				}
            } else {
				for(var j:int=0; j<_assetsArray.length; j++) {
					if((_assetsArray[j].content as MovieClip).loaderInfo.applicationDomain.hasDefinition(assetName)) {
						return (_assetsArray[j].content as MovieClip).loaderInfo.applicationDomain.getDefinition(assetName) as Class;
					}
				}
            }

			return null;
		}
		
		public function hasAsset(assetName:String,assetSpace:String=null):Boolean {

			if(assetSpace!=null) {
                for(var i:int=0; i<_assetsArray.length; i++) {
                    if(_assetsArray[i].filename==assetSpace) {
                        return true;
                    }
                }
            } else {
				for(var j:int=0; j<_assetsArray.length; j++) {
					if((_assetsArray[j].content as MovieClip).loaderInfo.applicationDomain.hasDefinition(assetName)){
						return true;
					}
				}
            }

			return false;
		}
	}
}