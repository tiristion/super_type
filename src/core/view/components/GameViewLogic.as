package core.view.components {
	import configs.CustomEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	
	import utils.WarehouseAssets;
	
	public class GameViewLogic extends ViewLogic {
		public static const NAME:String="GameViewLogic";
		private var _sprite:DisplayObjectContainer;
		private var _levelId:String;
		private var _letters:Array = [];
		private var _lettersIndex:Array = [];
		private var _woolf:DisplayObjectContainer;
		private var _position:int;
		private var _levelScore:Number;
		private var _mistakes:Number;
		
		public function GameViewLogic(levelId:String,levelString:String) {
			_levelId = levelId;
			_position = 0;
			_levelScore = 0;
			_sprite = new (WarehouseAssets.getInstance().getAsset("Scene",levelId) as Class);
			_woolf = new (WarehouseAssets.getInstance().getAsset("Wolf") as Class);
			super(_sprite);
			setLetters(levelString);
			_sprite.focusRect = false;
			_sprite.addEventListener(KeyboardEvent.KEY_DOWN, handlerOnKeyDown);
		}
		
		public function setLetters(levelString:String):void {
			for(var i:int = 0; i<levelString.length; i++) {
				_letters[i] = levelString.charAt(i);
			}
			_woolf.x = 14;
			_woolf.y = 185;
			_sprite.addChild(_woolf);
			var begin:int = 120;
			for(i = 0; i<_letters.length; i++) {
				var letter:TextField = new TextField();
				letter.text = _letters[i]; 
				letter.x = begin+15;
				letter.y = 250;
				letter.border = true;
				letter.width = 12;
				letter.height = 20;
				_sprite.addChild(letter);
				_lettersIndex[i] = _sprite.getChildIndex(letter);
				begin = begin +15;
			}
		}
		
		public function handlerOnKeyDown(event:KeyboardEvent):void {
			var letterCode:Number = event.charCode;
			dispatchEvent(new CustomEvent(CustomEvent.KEY_PRESSED,{code:letterCode,position:_position}));
		}
		
		public function letterTrue(mistakes:Number):void {
			_mistakes=mistakes;
			_levelScore+=3;
			_sprite.getChildAt(_lettersIndex[_position]).visible = false;
			_position++;
			_woolf.x = _woolf.x + 15;
			dispatchEvent(new CustomEvent(CustomEvent.UPDATE_LEVEL_SCORE,{levelScore:_levelScore,mistakes:_mistakes}));
			if (_position == _letters.length) {
				dispatchEvent(new CustomEvent(CustomEvent.LEVEL_CLEAR,{levelScore:_levelScore,mistakes:_mistakes,levelId:_levelId}));
				_levelScore = 0;
			}
		}
		public function letterFalse(mistakes:Number):void {
			_mistakes=mistakes;
			_levelScore-=5;
			if(_levelScore < 0)
				_levelScore = 0;
			dispatchEvent(new CustomEvent(CustomEvent.UPDATE_LEVEL_SCORE,{levelScore:_levelScore,mistakes:_mistakes}));
		}
		public function restartLevel(levelString:String):void {
			for(var i:int = 0;i<_lettersIndex.length;i++)
				_sprite.removeChildAt(_lettersIndex[0]);
			setLetters(levelString);
			_position = 0;
			content.stage.focus = content; 
		}
	}
}