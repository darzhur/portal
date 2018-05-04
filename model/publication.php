<?php
    class Model_publication {
    public $id, $heading, $text, $user_id, $date, $type;
    
    public function __construct($info){
        foreach ($info as $key => $value) {
            $this->$key = $value;
        }
    }

    public static function getNewPublication($post = array()) {
        if (!empty($post)) {
            if(self::setTable($post)){
                $table = self::setTable($post);
                $user_id = Model_user::getCurrentUser();
                $post['user_id'] = $user_id;
                return Controller_DB::insertPublication($table, $post);
            }
            else{
                exit("Не удается проверить тип публикации");
            }
        }
        else {
            return true;
        }
    }

    static function setTable($post = array()){
        if(!empty($post['authors'])){
            return 'articles';
        }
        if(!empty($post['expirationdate'])){
            return 'ads';
        }
        if(!empty($post['source'])){
            return 'news';
        }
    }

    public static function getObj($id, $table){
            $info = Controller_DB::getPubInfo($id, $table);
            $class = $table;
            return new $class($info);
    }

    public static function getList($col) {
        $currentDate = date("Y-m-d H:i:s");
        return Controller_DB::getListItem($currentDate, $col);
    }

    public static function addMark($article_id, $user_id, $newmark = array()){
        if(Controller_DB::checkAccess($article_id, $user_id)){
            $info = Controller_DB::getPubInfo($article_id, 'articles');
            print_r($info);
            if($info['mark'] == 0){
                $mark = $newmark['mark'];
            }
            else{
                $mark = (($info['mark'])*($info['count']) + $mark)/($info['count']+1);
            }

            Controller_DB::updateMark($article_id, $mark, $info);
            Controller_DB::insertMark($article_id, $user_id, $info);
            return $info['id'];
        }   
        else{
            exit("Оценить публикацию можно только один раз");
        }
    }

    public function filter(){}
    
    private function delete(){}
    
}

class news extends Model_publication {
    public $source;
}

class ads extends Model_publication {
    public $expirationdate;
}

class articles extends Model_publication {
    public $authors, $mark, $count;
}        
?>
