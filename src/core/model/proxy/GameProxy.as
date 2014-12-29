package core.model.proxy {

	import core.model.vo.LevelConfigDO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class GameProxy extends Proxy {

		static public const NAME:String = "GameProxy";
		
		public function GameProxy(levelConfig:LevelConfigDO) {

			super(NAME,levelConfig);
		}

		public function get levelConfig():LevelConfigDO	{

			return getData() as LevelConfigDO;
		}

		public function setMistakes(mistakes:Number):void {

			data.mistakes = mistakes;
		}
	}
}