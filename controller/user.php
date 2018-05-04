<?php
	class Controller_user extends Controller_base {
		public static function start($method, $id, $type) {
			if (Model_user::getCurrentUser()) {
				if($method == 'logout'){
					self::logout();
				}
				else{
					header('Location: /' . BASE . 'publication');
				}
			}
			else {
				if (!$method) {
					self::showUserMenu();
				}
				else {
					self::$method();
				}
			}
		}
        
        public static function showUserMenu() {
				self::view('addHeader');
				self::view('usermenu');
				self::view('addFooter');
		}
        
        public static function reg() {
            if (empty($_POST)) {
            	self::view('addHeader');          	
				self::view('reg');
				self::view('addFooter');
			}
			else {
                if (Model_user::addNewUser($_POST)) {
         			header('Location: /' . BASE . 'publication');
				}
				else {
					self::view('addHeader');
					echo 'Ой, это не вы, это мы: не удалось вас зарегистрировать!';
					self::view('addFooter');
				}
			}
		}

		public static function auth(){
			if (empty($_POST)) {
            	self::view('addHeader');
				self::view('auth');
				self::view('addFooter');
			}
			else {
				if (Model_user::getNewUser($_POST)) {
         			header('Location: /' . BASE . 'publication');
				}
				else {
					echo 'Ой, это не вы, это мы: не удалось вас опознать!';
				}
			}
		}

		public static function logout(){
			$user_id = Model_user::getCurrentUser();
			if(Model_user::logOutUser($user_id)){
				self::view('addHeader');
				echo "Вы успешно разлогинились";
				self::view('addFooter');

			}
			else{
				self::view('addHeader');
				exit("Проблема с удалением сессии");
				self::view('addFooter');	
			}
		}
    }
?>