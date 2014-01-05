package core.model.dataobject
{
	public class FlashVarsDO
	{
		public var _parameters:Object;
		public function FlashVarsDO(parameters:Object)
		{
			this._parameters = parameters;
		}
		public function get mainConfigPath():String
		{
			return String(_parameters['mainConfigPath']);
		}
	}
}