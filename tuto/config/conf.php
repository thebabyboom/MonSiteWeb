<?php
class Conf{

  static $debug = 1;

  static $databases = array (
            'default' => array(
                'host' => 'localhost',
                'database' => 'tuto',
                'login' => 'root',
                'password' => 'schuldig'
            )
  );
}

Router::connect('/','posts/index');
Router::connect('posts/:slug-:id','posts/view/id:([0-9]+)/slug:([a-z0-9\-]+)');
Router::connect('blog/:action','posts/:action');

?>
