<?php
try{
    $db= new PDO('mysql:host=localhost;dbname=David','root','schuldig');
    $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_OBJ);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
}catch (Exception $e){
  echo 'Impossible de se connecter à la base de données';
  echo $e->getMessage();
  die();
}



 ?>