package core.view.mediators {

	import configs.GeneralNotifications;
	
	import core.view.components.ViewLogic;
	
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class UIMediator	extends Mediator {

		public static const NAME:String="UIMediator";

        public function UIMediator(name:String, viewElement:ViewLogic) {

			super(name, viewElement);
		}

		override public function onRegister():void {

			super.onRegister();
			sendNotification(GeneralNotifications.ADD_CHILD_TO_ROOT,viewLogic.content);
		}

		override public function onRemove():void {

			super.onRemove();
			sendNotification(GeneralNotifications.REMOVE_CHILD_FROM_ROOT,viewLogic.content);
		}

		protected function get viewLogic():ViewLogic {

			return viewComponent as ViewLogic;
		}		
	}
}