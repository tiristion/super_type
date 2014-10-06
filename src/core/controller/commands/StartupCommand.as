package core.controller.commands {

	import configs.GeneralNotifications;
	
	import core.model.dataobject.FlashVarsDO;
	import core.model.proxy.FlashVarsProxy;
	import core.model.proxy.MainConfigProxy;
	import core.view.components.PreloaderViewLogic;
	import core.view.mediators.PreloaderMediator;
	import core.view.mediators.RootMediator;
	
	import flash.display.Sprite;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartupCommand extends SimpleCommand {

		override public function execute(notification:INotification):void {

			//application initialization
			var root:Sprite = notification.getBody() as Sprite;
		
			//register Commands
			facade.registerCommand(GeneralNotifications.ASSETS_LOADED, LobbyStartCommand);
			facade.registerCommand(GeneralNotifications.LOAD_ASSETS, AssetsLoadingCommand);
			facade.registerCommand(GeneralNotifications.CLOSE_POPUP, ClosePopupCommand);
			facade.registerCommand(GeneralNotifications.REGISTER_USER_INFO, CheckUserCommand);
			facade.registerCommand(GeneralNotifications.LOAD_LEVEL, LoadLevelCommand);
			facade.registerCommand(GeneralNotifications.RESTART_LEVEL, RestartLevelCommand);
			facade.registerCommand(GeneralNotifications.SHOW_LOBBY, ShowLobbyCommand);
			facade.registerCommand(GeneralNotifications.KEY_PRESSED, KeyPressedCommand);
			facade.registerCommand(GeneralNotifications.LEVEL_END, SaveUserCommand);
			facade.registerCommand(GeneralNotifications.CLEAR_USER, ClearUserCommand);
			facade.registerCommand(GeneralNotifications.LEVEL_LOST, LostLevelCommand);
			facade.registerCommand(GeneralNotifications.LEVEL_CLEAR, ClearLevelCommand);
			
			//register Mediators
			facade.registerMediator(new RootMediator(root));
			facade.registerMediator(new PreloaderMediator(new PreloaderViewLogic()));
				
			//register Proxies
			facade.registerProxy(new FlashVarsProxy(new FlashVarsDO(root.loaderInfo.parameters)));

			var mainConfigPath:String = flashVarsProxy.flashVars.mainConfigPath;
			facade.registerProxy(new MainConfigProxy(mainConfigPath));
		}

        public function get flashVarsProxy():FlashVarsProxy {

            return facade.retrieveProxy(FlashVarsProxy.NAME) as FlashVarsProxy;
        }
	}
}