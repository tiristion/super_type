package
{
	import core.ApplicationFacade;
	import core.controller.commands.StartupCommand;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class KB_training extends Sprite
	{
		public function KB_training()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			ApplicationFacade.getInstance().startup(StartupCommand, this);
		}
	}
}