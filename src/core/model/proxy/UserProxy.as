package core.model.proxy {

	import configs.GeneralNotifications;
	
	import core.model.dataobject.UserDO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class UserProxy extends Proxy {

		public static const NAME:String = "UserProxy";
		private var _userDO:UserDO;

        public function UserProxy(userDO:UserDO) {

            super(NAME,userDO);
			_userDO = userDO;
			sendNotification(GeneralNotifications.USER_DATA_UPDATED,_userDO);
		}

		override public function onRegister():void {

			super.onRegister();
		}

		public function get userData():UserDO {

			return getData() as UserDO;
		}

		public function setUserData(userDO:UserDO):void {

			_userDO = userDO;
			sendNotification(GeneralNotifications.USER_DATA_UPDATED,_userDO);
		}

		public function updateUserData(levelScore:Number):void{
			_userDO.score += levelScore;
			sendNotification(GeneralNotifications.USER_DATA_UPDATED,_userDO);
		}

		public function clearUserData():void{
			_userDO.score = 0;
			sendNotification(GeneralNotifications.USER_DATA_UPDATED,_userDO);
		}	
	}
}