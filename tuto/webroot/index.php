<?php
 error_reporting(E_ALL);

 define('WEBROOT',dirname(__FILE__));
 define('ROOT',dirname(WEBROOT));
 define('DS',DIRECTORY_SEPARATOR);
 define('CORE',ROOT.DS.'core');
 define('BASE_URL',dirname(dirname($_SERVER['REQUEST_URI'])));

//phpinfo();
//print_r($_SERVER);
//print_r(BASE_URL);
//print_r($_SERVER['SCRIPT_NAME']);
//require CORE.DS.'debug.php';
 require CORE.DS.'includes.php';
 new Dispatcher();


?>
