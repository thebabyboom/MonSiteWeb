<?php
 class PostsController extends Controller {

   function index(){
     $perPage = 1;
     $this->loadModel('Post');
     $conditions = array('online' => 1, 'type'=>'post');
     $d['posts'] = $this->Post->find(array(
       'conditions' => $conditions,
       'limit' => ($perPage*($this->request->page-1)).','.$perPage
     ));
     $d['total'] = $this->Post->findCount($conditions);
     $d['page'] = $d['total'] ;
     //debug($d);
     $this->set($d);
   }


   function view($id){
     $this->loadModel('Post');

     $d['page'] = $this->Post->findFirst(array(
                'conditions' => array('online' => 1,'id' => $id, 'type'=>'post')
              ));
     if(empty($d['page'])){
       $this->e404('Page introuvable');
     }
     $this->set($d);
   }

 }
?>
