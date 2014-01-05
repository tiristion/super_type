package core.view.components {
	import configs.CustomEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import utils.WarehouseAssets;
	
	public class LobbyViewLogic extends ViewLogic {
		public static const NAME:String="LobbyViewLogic";
		private var _sprite:DisplayObjectContainer;
		private var _gameInfoDO:Array;
		private var _message:DisplayObjectContainer;
		
		public function LobbyViewLogic(){
			_sprite= new (WarehouseAssets.getInstance().getAsset("Lobby") as Class);
			super(_sprite);
		}
				
		public function unlockLevels(score:int,gameInfoDO:Array):void {
			_gameInfoDO=gameInfoDO;
			for(var i:int=0;i<_gameInfoDO.length;i++) {
				var name:String = _gameInfoDO[i].id;
				var number:int = int(_gameInfoDO[i].id.replace("level",""));
				if(score>=gameInfoDO[i].unlockValue) {
					if(i!=0)
						_sprite['Lock'+(i+1)].visible = false;
					_sprite['Level'+(i+1)+'Button'].addEventListener(MouseEvent.CLICK, handlerOnLevelIconClick);
				}
				else {
					_sprite['Lock'+(i+1)].visible = true;
					_sprite['Lock'+(i+1)].addEventListener(MouseEvent.MOUSE_OVER, showUnlockValue);
					_sprite['Lock'+(i+1)].addEventListener(MouseEvent.MOUSE_OUT, hideUnlockValue)
				}
			}
		}
		
		private function handlerOnLevelIconClick(event:Event):void {
			var levelName:String = event.target.name.replace("Button", "");
			dispatchEvent(new CustomEvent(CustomEvent.LEVEL_CLICKED,levelName));
		}
		
		public function showUnlockValue(event:MouseEvent):void {
			var sprite:DisplayObjectContainer = _sprite as MovieClip;
			_message = new (WarehouseAssets.getInstance().getAsset("UnlockValue") as Class);
			for(var i:int=1;i<_gameInfoDO.length;i++) {
				if(event.target.name=="Lock"+(i+1)) {
					(_message.getChildByName("UnlockValueText") as TextField).text = "Нужно набрать "+_gameInfoDO[i].unlockValue+" очков!";
				}
			}
			_message.x=(event.target as MovieClip).x + 9 ;
			_message.y=(event.target as MovieClip).y + 71;
			sprite.addChild(_message);
		}
		
		public function hideUnlockValue(event:MouseEvent):void {
			var sprite:DisplayObjectContainer = _sprite as MovieClip;
			sprite.removeChild(_message);
		}
	}
}