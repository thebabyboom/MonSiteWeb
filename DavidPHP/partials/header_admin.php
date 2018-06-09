<!DOCTYPE html>
<html lang="en">
 <head>
	<meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="Site personnel de babyboom" />
	<meta name="keywords" content="babyboom, informatique, programmation, hesit" />
  <title>Mon administration</title>
  <link href="<?= WEBROOT; ?>css/mycss.css" rel="stylesheet"  />
  <script type="text/javascript" src="<?= WEBROOT; ?>js/jquery.js"></script>
  <?php if(isset($script)); ?> <?= $script; ?> <?php endif; ?>
 </head>

 <body>
   <nav class="navbar navbar-expand-lg navbar-dark bg-dark" role="navigation">
     <div class="container">
       <div class="navbar-header">
         <a class="navbar-brand" href="index.php">Mon Portfolio en PHP</a>
       </div>
       <ul class="nav navbar-nav">
         <li>
          <a class='nav-link' href="category.php">Catégories</a>
         </li>
         <li>
          <a class='nav-link' href="work.php">Réalisations</a>
         </li>
       </ul>
     </div>
 </nav>
  <div class="container">

    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>

    <?= flash(); ?>
