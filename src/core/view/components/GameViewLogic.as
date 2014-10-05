package core.view.components {

	import configs.CustomEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	
	import utils.WarehouseAssets;
	
	public class GameViewLogic extends ViewLogic {

		public static const NAME:String = "GameViewLogic";

		private var scene:DisplayObjectContainer;
		private var levelId:String;
		private var letters:Array = [];
		private var lettersIndex:Array = [];
		private var woolf:DisplayObjectContainer;
		private var position:int;
		private var levelScore:Number;
		private var mistakes:Number;
		
		public function GameViewLogic(levelId:String, levelString:String) {

			this.levelId = levelId;
			position = 0;
			levelScore = 0;
			scene = new (WarehouseAssets.getInstance().getAsset("Scene", levelId) as Class);
			woolf = new (WarehouseAssets.getInstance().getAsset("Wolf") as Class);

			super(scene);

			setLetters(levelString);
			scene.focusRect = false;
			scene.addEventListener(KeyboardEvent.KEY_DOWN, handlerOnKeyDown);
		}
		
		public function setLetters(levelString:String):void {

			for(var i:int = 0; i < levelString.length; i++) {
				letters[i] = levelString.charAt(i);
			}

			woolf.x = 14;
			woolf.y = 185;
			scene.addChild(woolf);

            var begin:int = 120;

            for(i = 0; i < letters.length; i++) {

                var letter:TextField = createLetter(i, begin);
                scene.addChild(letter);
				lettersIndex[i] = scene.getChildIndex(letter);
				begin = begin +15;
			}
		}

        private function createLetter(letterNumber:int, xPosition:int):TextField {

            var letter:TextField = new TextField();

            letter.text = letters[letterNumber];
            letter.x = xPosition + 15;
            letter.y = 250;
            letter.border = true;
            letter.width = 12;
            letter.height = 20;

            return letter;
        }
		
		public function handlerOnKeyDown(event:KeyboardEvent):void {

			var letterCode:Number = event.charCode;
			dispatchEvent(new CustomEvent(CustomEvent.KEY_PRESSED,{code:letterCode,position:position}));
		}
		
		public function letterTrue(mistakes:Number):void {

			this.mistakes = mistakes;
			levelScore += 3;
			scene.getChildAt(lettersIndex[position]).visible = false;
			position++;
			woolf.x = woolf.x + 15;
			dispatchEvent(new CustomEvent(CustomEvent.UPDATE_LEVEL_SCORE,{levelScore:levelScore,mistakes:mistakes}));

            if (position == letters.length) {
				dispatchEvent(new CustomEvent(CustomEvent.LEVEL_CLEAR,{levelScore:levelScore,mistakes:mistakes,levelId:levelId}));
				levelScore = 0;
			}
		}

        public function letterFalse(mistakes:Number):void {

			this.mistakes = mistakes;
			levelScore -= 5;

            if(levelScore < 0) {
                levelScore = 0;
            }

			dispatchEvent(new CustomEvent(CustomEvent.UPDATE_LEVEL_SCORE, {levelScore:levelScore, mistakes:mistakes}));
		}

		public function restartLevel(levelString:String):void {

			removeCurrentLetters();
            setLetters(levelString);
			content.stage.focus = content;
		}

        private function removeCurrentLetters():void {

            for (var i:int = 0; i < lettersIndex.length; i++) {
                scene.removeChildAt(lettersIndex[0]);
            }

            position = 0;
        }
	}
}