<?php
abstract class Controller_publication extends Controller_base {

    public static function start($method, $id, $type) {
        if(Model_user::getCurrentUser()){
            if (!$method) {
            self::view('addHeader');
            self::showPubs($id, $type);
            self::view('addFooter');
            }
            else {
                self::$method($id, $type);
            }
        }
        else{
            header('Location: /portal/user');
        }
	}

    public static function add() {
            if (empty($_POST)) {
                self::view('addHeader');
                self::view('addAd');
                self::view('addArticle');
                self::view('addNews');
                self::view('addFooter');
            }
            else {
                if (Model_publication::getNewPublication($_POST)) {
                    header('Location: /' . BASE . 'publication');
                }
                else {
                    echo 'Возникла проблема при создании записи!';
                }
            }
        }

    public static function showPubs($id, $type) {
        $publications = Model_publication::getList($type);
        self::view('addHeader');
        self::view('publicationsList', array('publications' => $publications));
        self::view('addFooter');
    }

    public static function mark($article_id, $uid){
        if (!empty($_POST)) {
            $user_id = Model_user::getCurrentUser();
            $id = Model_publication::addMark($article_id, $user_id, $_POST);
                self::view('addHeader');
                self::show($id, 'articles');
                self::view('addFooter');
            }
        }

    public static function show($id, $type){
        // $class = Model_publication::setClass($type);
        if(isset($id) && isset($type)){
            $table = $type;
            $pub = Model_publication::getObj($id, $table);
            self::view('addHeader');
            self::view('publication', array('pub' => $pub));
            self::view('addFooter');
        }
        else{
            echo "Не удается получить данные публикации";
        }
    }       
}
?>
