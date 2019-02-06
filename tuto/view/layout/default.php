<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
 <head>
   <meta http-equiv="content-type" content="text/html; charset=utf-8" />
   <title><?php echo isset($title_for_layout)?$title_for_layout:'Mon site'; ?> </title>
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
 </head>

 <body>

   <nav class="navbar navbar-expand-lg navbar-light bg-light">
     <a class="navbar-brand" href="<?php echo BASE_URL;?>">Mon Site</a>
     <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
       <span class="navbar-toggler-icon"></span>
     </button>

     <div class="collapse navbar-collapse" id="navbarSupportedContent">
       <ul class="navbar-nav mr-auto">
         <?php $pagesMenu = $this->request('Pages','getMenu'); ?>
         <?php foreach($pagesMenu as $p): ?>
          <li class="nav-item active"><a class="nav-link" href="<?php echo '/pages/view/'.$p->id; ?>" title="<?php echo $p->name; ?>"><?php  echo $p->name; ?> </a></li>
         <?php endforeach; ?>
         <li class="nav-item">
           <a class="nav-link" href="<?php echo '/posts' ?>">Blog</a>
         </li>
       </ul>
     </div>
   </nav>

   <div class="container">
     <?php echo $content_for_layout; ?>
   </div>

 </body>
 <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
 <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
</html>
