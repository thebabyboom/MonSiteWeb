<?php
 class Request{

   public $url; //URL appellé par l'utilisateur
   public $page = 1;
   public $prefix = false;
   public $data = false;

   function __construct(){
     $this->url = isset($_SERVER['REDIRECT_URL'])?$_SERVER['REDIRECT_URL']:'/';
     //debug($_SERVER);
     if (isset($_GET['page'])){
       if(is_numeric($_GET['page'])){
         if($_GET['page'] > 0){
           $this->page = round($_GET['page']);
         }
       }
     }
     if(!empty($_POST)){
       $this->data = new stdClass();
       foreach($POST as $k=>$v){
         $this->data->$k=$v;
       }
     }
   }
 }
?>
