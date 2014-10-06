package core.model.dataobject {

	public class FlashVarsDO {

		public var parameters:Object;

		public function FlashVarsDO(parameters:Object) {

			this.parameters = parameters;
		}

		public function get mainConfigPath():String {

			return String(parameters['mainConfigPath']);
		}
	}
}