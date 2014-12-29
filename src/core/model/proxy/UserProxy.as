package core.model.proxy {

	import configs.GeneralNotifications;
	
	import core.model.vo.UserDO;
	
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class UserProxy extends Proxy {

		public static const NAME:String = "UserProxy";
		private var userDO:UserDO;

        public function UserProxy(userDO:UserDO) {

            super(NAME, userDO);
			this.userDO = userDO;
			sendNotification(GeneralNotifications.USER_DATA_UPDATED,userDO);
		}

		override public function onRegister():void {

			super.onRegister();
		}

		public function get userData():UserDO {

			return getData() as UserDO;
		}

		public function setUserData(userDO:UserDO):void {

			this.userDO = userDO;
			sendNotification(GeneralNotifications.USER_DATA_UPDATED, userDO);
		}

		public function updateUserData(levelScore:Number):void {

			userDO.score += levelScore;
			sendNotification(GeneralNotifications.USER_DATA_UPDATED, userDO);
		}

		public function clearUserData():void{

			userDO.score = 0;
			sendNotification(GeneralNotifications.USER_DATA_UPDATED, userDO);
		}	
	}
}