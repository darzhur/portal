<?php
	final class Controller_DB {
		public static $connect;
		
		public static function connect() {
			if (!self::$connect) {
				if(self::$connect = mysqli_connect(HOST, USER, PASS, DB)){
					mysqli_set_charset(self::$connect, 'utf8');
				} 
				else{
					exit("Ошибка соединения с БД"); 
				}  			
	        }
		}

		private function __construct() {}
		private function __clone(){}
		private function __sleep(){}
		private function __wakeup(){}
		

		public static function escape($val) {
			return mysqli_real_escape_string(self::$connect, $val);
		}
        
        public static function getHash() {
		$str  = 'abcdefghijklmnopqrstuvwxyz0123456789';
		$hash = '';
		
		for ($i = 0; $i < 32; $i++) {
			$hash.= $str[rand(0, 35)];
		}
		
		return $hash;
		}

		public static function createSession($id){
			$session = self::getHash();
			$token   = self::getHash();
            
            setcookie('s', $session, 0, '/portal/');
			setcookie('t', $token, 0, '/portal/');
            
            mysqli_query(self::$connect, "
				INSERT INTO `connect` SET
					`session` = '$session',
					`token`   = '$token',
					`user_id` = $id;
			");
		}
		
		public static function insertUser($values) {
			self::connect();

			$login = self::escape($values['login']);
			$pass = self::escape($values['pass']);
			$pass = md5($pass);
			$name = self::escape($values['name']);

			$query = mysqli_query(self::$connect, "SELECT `id` from `users` WHERE `login` = '$login';");

			if(mysqli_num_rows($query) > 0 ){
				echo "Такой логин уже занят!";
			}
			else{
				$query = "INSERT INTO `users` SET
				`login` = '$login',
				`pass` 	= '$pass',
				`name`  = '$name';
				";
				mysqli_query(self::$connect, $query);
	            
	            if (mysqli_errno(self::$connect) == 0){
	                $id = mysqli_insert_id(self::$connect);
	                self::createSession($id);
                	if (mysqli_affected_rows(self::$connect) > 0){
                	return $id;
                	}	                
	            }
	            else{
	            	echo mysqli_error(self::$connect);
	            	echo "Проблема с базой";
	            }
			}
		}

		public static function checkUser($userInfo){
			self::connect();
	
			$login = mysqli_real_escape_string(self::$connect, $userInfo['login']);
			$pass  = md5($userInfo['pass']);
			
			$query = "SELECT `id` FROM `users` WHERE `login` = '$login' AND `pass`  = '$pass';";
			$mysqli = mysqli_query(self::$connect, $query);

			if (mysqli_num_rows($mysqli) > 0) {
				$result = mysqli_fetch_assoc($mysqli);
				$id    = (int) $result['id'];
				self::createSession($id);
				return $id;
			}
			else {
				echo "Неверная связка Логин/Пароль!<br>";
				}
		}

		public static function getUserId(){
			self::connect();
			$session = $_COOKIE['s'];
			$token = $_COOKIE['t'];
			$query = "SELECT `user_id` FROM `connect` WHERE `session` = '$session' AND `token` = '$token'";

			$mysqli = mysqli_query(self::$connect, $query);
			if (mysqli_num_rows($mysqli) > 0) {
				$result = mysqli_fetch_assoc($mysqli);
				$id    = (int) $result['user_id'];
				return $id;
			}
			else{
	            echo mysqli_error(self::$connect);
	            }
		}

	    public static function deleteSession($user_id){
	    	self::connect();

	    	$query = "DELETE FROM `connect` WHERE `user_id` = '$user_id';";
	    	$mysqli = mysqli_query(self::$connect, $query);

	    	if (mysqli_errno(self::$connect) == 0) {
				setcookie('s', '', 0, '/portal/');
				setcookie('t', '', 0, '/portal/');
				return true;
			}
			else{
				echo mysqli_error(self::$connect);
			}
	    }

	    public static function insertPublication($table, $values) {
			self::connect();
			$cols = '';
			$vals = '';
			foreach ($values as $column => $value) {
				$cols.= "`" . self::escape($column) . "`,";
				$vals.= "'" . self::escape($value) . "',";
			}
			$cols  = trim($cols, ',');
			$vals  = trim($vals, ',');
			$query = "INSERT INTO `" . self::escape($table) . "` ($cols) VALUE($vals);";
			mysqli_query(self::$connect, $query);
			return mysqli_insert_id(self::$connect);
		}

		public static function getListItem($currentDate, $col){
			self::connect();

			if(empty($col)){
				$orderby = " ORDER BY `date` DESC";
			}
			else{
				if($col == 'date'){
					$orderby = " ORDER BY `date` ASC";
				}
				else{
					$orderby = " ORDER BY `" . self::escape($col) . "` DESC";
				}
			}
			
			$query = "
			SELECT `news`.`id`, `heading`, `date`, `type` 
			FROM `news` LEFT JOIN `types` ON( `news`.`type_id` = `types`.`id` ) UNION
			SELECT `ads`.`id`, `heading`, `date`, `type` 
			FROM `ads` LEFT JOIN `types` ON( `ads`.`type_id` = `types`.`id` ) 
			WHERE '$currentDate' < `expirationdate` UNION
			SELECT `articles`.`id`, `heading`, `date`, `type` 
			FROM `articles` LEFT JOIN `types` ON( `articles`.`type_id` = `types`.`id` )".$orderby." LIMIT 0, 10";

			$res = mysqli_query(self::$connect, $query);

			if (mysqli_num_rows($res) > 0) {
				$array = array();
				while($item = mysqli_fetch_assoc($res)) {
					$array[] = $item;
				}
				return $array;
			}
			else{
				//echo 'Не удалось получить список публикаций из базы';
				return true;
			}
		}

		public static function getPubInfo($id, $table){
			self::connect();
			$query = "SELECT * FROM `" . self::escape($table) . "` WHERE `id` = '$id';";
			$mysqli = mysqli_query(self::$connect, $query);
			if (mysqli_num_rows($mysqli) > 0) {
				return mysqli_fetch_assoc($mysqli);
			}
			else{
				//echo "Не удалось получить данные о публикации";
				return true;
			}
		}

		public static function checkAccess($article_id, $user_id){
			self::connect();
			$query = "SELECT * FROM `marks` WHERE `article_id` = '$article_id' AND `user_id` = '$user_id';";
			$mysqli = mysqli_query(self::$connect, $query);
			if (mysqli_num_rows($mysqli) > 0) {
				return false;
			}
			else{
				return true;
			}
		}

		public static function updateMark($article_id, $mark, $info = array()){
			self::connect();
			$count = $info['count'] + 1;
			$query = "UPDATE `articles` SET
				`mark` = '$mark', `count` = '$count'
				WHERE `id` = '$article_id'
				;";

			mysqli_query(self::$connect, $query);
            	return true;
            	// echo 'Не удалось обновить оценку';
		}

		public static function insertMark($article_id, $user_id, $info = array()){
			self::connect();
			$mark = $info['mark'];
			$query = "INSERT INTO `marks` (`article_id`, `user_id`) 
			VALUES ('$article_id', '$user_id');";
			mysqli_query(self::$connect, $query);
			// return true;
			// if (mysqli_errno(self::$connect) == 0){
			// 	return true;
	  //       }
   //          else{
   //          	//echo 'Не удалось записать оценку';
   //          }
		}
	}