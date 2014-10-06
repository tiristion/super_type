package core.view.components {

	import configs.CustomEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import utils.WarehouseAssets;
	
	public class LobbyViewLogic extends ViewLogic {

		public static const NAME:String = "LobbyViewLogic";

		private var lobbyContainer:DisplayObjectContainer;
		private var gameInfoDO:Array;
		private var message:DisplayObjectContainer;
		
		public function LobbyViewLogic() {

			lobbyContainer= new (WarehouseAssets.getInstance().getAsset("Lobby") as Class);
			super(lobbyContainer);
		}
				
		public function unlockLevels(score:int, gameInfoDO:Array):void {

			this.gameInfoDO = gameInfoDO;

            for(var i:int = 0; i < gameInfoDO.length; i++) {

                if(score >= gameInfoDO[i].unlockValue) {
					if(i!=0) {
                        lobbyContainer['Lock'+(i+1)].visible = false;
                    }
					lobbyContainer['Level'+(i+1)+'Button'].addEventListener(MouseEvent.CLICK, handlerOnLevelIconClick);
				} else {
					lobbyContainer['Lock'+(i+1)].visible = true;
					lobbyContainer['Lock'+(i+1)].addEventListener(MouseEvent.MOUSE_OVER, showUnlockValue);
					lobbyContainer['Lock'+(i+1)].addEventListener(MouseEvent.MOUSE_OUT, hideUnlockValue)
				}
			}
		}
		
		private function handlerOnLevelIconClick(event:Event):void {

			var levelName:String = event.target.name.replace("Button", "");
			dispatchEvent(new CustomEvent(CustomEvent.GAME_ICON_CLICKED, levelName));
		}
		
		public function showUnlockValue(event:MouseEvent):void {

			var sprite:DisplayObjectContainer = lobbyContainer as MovieClip;
			message = new (WarehouseAssets.getInstance().getAsset("UnlockValue") as Class);

            for(var i:int = 1; i < gameInfoDO.length; i++) {

				if(event.target.name == "Lock" +(i+1)) {
					(message.getChildByName("UnlockValueText") as TextField).text = "You need " + gameInfoDO[i].unlockValue + " points!";
				}
			}

            message.x=(event.target as MovieClip).x + 9 ;
			message.y=(event.target as MovieClip).y + 71;
			sprite.addChild(message);
		}
		
		public function hideUnlockValue(event:MouseEvent):void {

			var sprite:DisplayObjectContainer = lobbyContainer as MovieClip;
			sprite.removeChild(message);
		}
	}
}