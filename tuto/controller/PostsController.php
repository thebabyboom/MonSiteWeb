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


   function view($id,$slug){
     $this->loadModel('Post');

     $d['post'] = $this->Post->findFirst(array(
                'fields'     => 'id,slug,content,name',
                'conditions' => array('online' => 1,'id' => $id, 'type'=>'post')
              ));
     if(empty($d['post'])){
       $this->e404('Page introuvable');
     }
     if($slug != $d['post']->slug){
       $this->redirect("posts/view/id:$id/slug:".$d['post']->slug,301);
     }
     $this->set($d);
   }

 }
?>
