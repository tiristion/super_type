package core.view.components {

	import configs.CustomEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import utils.WarehouseAssets;

	public class TopPanelViewLogic extends ViewLogic {

		public static const NAME:String = "TopPanelViewLogic";

		private var topPanelContainer:DisplayObjectContainer;
		private var userScoreNumber:Number;

		public function TopPanelViewLogic():void {

			topPanelContainer = new (WarehouseAssets.getInstance().getAsset("TopPanel") as Class);

			super(topPanelContainer);

			visibleLevelComponents(false);

			addListeners();
		}

        private function addListeners():void {

            content["BackButton"].addEventListener(MouseEvent.CLICK, handlerLobbyButtonClick);
            content["RestartButton"].addEventListener(MouseEvent.CLICK, handlerRestartButtonClick);
            content["ExitButton"].addEventListener(MouseEvent.CLICK, handlerExitButtonClick);
        }

		public function userDataUpdate(userName:String,userScore:Number):void {

			userScoreNumber = userScore;

			content["UserName"].text = userName;
			content["Score"].text = userScore.toString();
		}

		private function handlerExitButtonClick(event:MouseEvent):void {

			var req:URLRequest = new URLRequest("javascript:window.close();");
			navigateToURL(req, "_self");
		}

		private function handlerLobbyButtonClick(event:MouseEvent):void {

			dispatchEvent(new CustomEvent(CustomEvent.MENU_BUTTON_CLICK));
		}

		private function handlerRestartButtonClick(event:MouseEvent):void {

			dispatchEvent(new CustomEvent(CustomEvent.RESTART_BUTTON_CLICK));
		}

		public function updateLevelScore(levelScore:Number,mistakes:Number):void {

			content["LevelScore"].text = levelScore.toString();
			showLives(mistakes);
		}

		public function visibleLevelComponents(visible:Boolean):void {

			content["BackButton"].visible = visible;
			content["RestartButton"].visible = visible;
			content["LevelScoreLebel"].visible = visible;
			content["LevelScore"].visible = visible;
			content["title"].visible = ! visible;

            for(var i:int = 1; i <= 7; i++) {
				content["Live"+i].visible = visible;
			}
		}

		public function showLives(lives:Number):void {

			for(var i:int = 1; i <= 7; i++) {
                content["Live" + i].visible = (i <= lives);
			}
		}
	}
}