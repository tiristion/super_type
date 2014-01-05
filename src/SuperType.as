package {

	import core.ApplicationFacade;
	import core.controller.commands.StartupCommand;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SuperType extends Sprite	{

		public function SuperType() {

			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {

			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			ApplicationFacade.getInstance().startup(StartupCommand, this);
		}
	}
}