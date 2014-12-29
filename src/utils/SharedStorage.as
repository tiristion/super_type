package utils {

	import core.model.vo.UserDO;
	
	import flash.net.SharedObject;

	public class SharedStorage {

		private static var instance:SharedStorage;
		private var sharedObjectUser:SharedObject;
		
		static public function getInstance():SharedStorage {

			if (instance == null) {
				instance = new SharedStorage();
			}

			return instance;
		}
		
		public function createShared(sharedName:String):void {

			sharedObjectUser = SharedObject.getLocal(sharedName);
		}
		
		public function hasUserData():Boolean {

			return (sharedObjectUser.data.userData != null);
		}
		
		public function checkPassword(password:String):Boolean {

            return (sharedObjectUser.data.userData.password == password);
		}
		
		public function getUserData():UserDO {

			var userDO:UserDO = new UserDO();
			userDO.name = sharedObjectUser.data.userData.name;
			userDO.password = sharedObjectUser.data.userData.password;
			userDO.score = sharedObjectUser.data.userData.score;
			return userDO;
		}
		
		public function createUser(sharedName:String, userPassword:String):void {

            sharedObjectUser.data.userData = {name:sharedName, password:userPassword, score:0};
			sharedObjectUser.flush();
		}
		
		public function saveUserData(userData:UserDO):void {

            sharedObjectUser.data.userData = userData;
			sharedObjectUser.flush();
		}
	}
}