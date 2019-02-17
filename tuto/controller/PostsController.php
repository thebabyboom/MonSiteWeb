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

   /**
   * ADMIN
   **/
   function admin_index(){
     $perPage = 10;
     $this->loadModel('Post');
     $conditions = array('type'=>'post');
     $d['posts'] = $this->Post->find(array(
       'fields' => 'id,name,online',
       'conditions' => $conditions,
       'limit' => ($perPage*($this->request->page-1)).','.$perPage
     ));
     $d['total'] = $this->Post->findCount($conditions);
     $d['page'] = $d['total'] ;
     //debug($d);
     $this->set($d);
   }

   /**
   * Permet d'éditer un fichier
   **/
   function admin_edit($id=null){
     if($this->request->data){
       debug($this->request->data);
     }
     $this->loadModel('Post');
     $this->request->data = $this->Post->findFirst(array(
       'conditions' => array('id'=>$id)
     ));
   }

   /**
   * Permet de supprimer un article
   **/
   function admin_delete($id){
     $this->loadModel('Post');
     //$this->Post->delete($id);
     $this->Session->setFlash('Le contenu a bien ete supprimé');
     $this->redirect('../index');
   }

 }
?>
