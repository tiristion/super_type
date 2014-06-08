package core.controller.commands {

	import configs.GeneralNotifications;
	
	import core.model.proxy.LevelsConfigProxy;
	import core.view.components.LobbyViewLogic;
	import core.view.components.TopPanelViewLogic;
	import core.view.mediators.GameMediator;
	import core.view.mediators.LobbyMediator;
	import core.view.mediators.TopPanelMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ShowLobbyCommand extends SimpleCommand	{

		override public function execute(notification:INotification):void {

			facade.removeMediator(GameMediator.NAME);
			facade.registerMediator(new LobbyMediator(new LobbyViewLogic()));
			facade.registerMediator(new TopPanelMediator(new TopPanelViewLogic()));
			var levelsConfigsProxy:LevelsConfigProxy = facade.retrieveProxy(LevelsConfigProxy.NAME) as LevelsConfigProxy;
			sendNotification(GeneralNotifications.LEVELS_CONFIGS_LOADED,levelsConfigsProxy.levelInfo);
		}
	}
}