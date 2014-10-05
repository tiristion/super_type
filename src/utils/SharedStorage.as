package utils {

	import core.model.dataobject.UserDO;
	
	import flash.net.SharedObject;

	public class SharedStorage {

		private static var _instance:SharedStorage;
		private var _sharedObjectUser:SharedObject;
		
		static public function getInstance():SharedStorage {

			if (_instance == null) {
				_instance = new SharedStorage();
			}

			return _instance;
		}
		
		public function createShared(sharedName:String):void {

			_sharedObjectUser = SharedObject.getLocal(sharedName);
		}
		
		public function hasUserData():Boolean{

			return (_sharedObjectUser.data.userData != null);
		}
		
		public function checkPassword(password:String):Boolean {

            return (_sharedObjectUser.data.userData.password == password);
		}
		
		public function getUserData():UserDO {

			var userDO:UserDO = new UserDO;
			userDO.name = _sharedObjectUser.data.userData.name;
			userDO.password = _sharedObjectUser.data.userData.password;
			userDO.score = _sharedObjectUser.data.userData.score;
			return userDO;
		}
		
		public function createUser(sharedName:String,userPassword:String):void {

            _sharedObjectUser.data.userData = {name:sharedName,password:userPassword,score:0};
			_sharedObjectUser.flush();
		}
		
		public function saveUserData(userData:UserDO):void {

            _sharedObjectUser.data.userData = userData;
			_sharedObjectUser.flush();
		}
	}
}