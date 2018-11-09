<?php
  include 'lib/db.php';
  $select = $db->query('SELECT News_ID, News_Year, News_Month, News_Day, News_Title, News_Link FROM news');
  $news = $select->fetchAll();
?>
<html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name="description" content="Site personnel de babyboom" />
	<meta name="keywords" content="babyboom, informatique, programmation, hesit" />
	<link title="test" type="text/css" rel="stylesheet" href="Style/blog.css" media="screen" />
	<title>Mon site personnel</title>
 </head>

<body>
 <div id="page">
  <!--******************************************************************************-->
  <!--En tete de la page-->
   <div id="header">
    <img src="Images/Notepad.png" border=0 /><h1>Titre du blog</h1>
   </div>
  <!-- **Fin d'en-tete**-->
  <!--******************************************************************************-->

  <!--******************************************************************************-->
  <!-- ****Menu**** -->
   <div id="blocmenu">
    <h1>menu du blog</h1>

    <ul class="menu">
   <li class="titre">Home</li>
    <li><a href="home.html">Page d'accueil</a></li>
    <li><a href="map.html">Plan du site</a></li>
    <li><a href="index.html">News</a></li>
   <li class="titre">Documentation</li>
    <li><a href="programmation.html">Programmation</a></li>
    <li><a href="peripherique.html">Peripherique</a></li>
    <li><a href="os.html">Systeme d'exploitation</a></li>
    <li><a href="divers.html">Divers</a></li>
   <li class="titre">Liens</li>
    <li><a href="link.html">Friends</a></li>
   <li class="titre">Perso</li>
    <li><a href="contact.html">Contact</a></li>
    <li><a href="cv.html">Curriculum Vit&aelig;</a></li>
  </ul>
  <ul class="menu">
    <li><a href="admin/article_edit.php">Ajouter ou modifier un article</a></li>
    <?php foreach($news as $el_news): ?>
      <li><?= $el_news['News_Title']; ?></li>
    <?php endforeach; ?>
  </ul>

   </div>
  <!--** Fin du menu **-->
  <!--******************************************************************************-->

  <!--******************************************************************************-->
  <!-- ** Contenu de la page **-->
  <div id="content">
    <h1>contenu du blog</h1>
    <?php foreach($news as $el_news): ?>
      <div class="article">
  		<fieldset class="news">
        <legend><?= $el_news['News_Day'].'/'.$el_news['News_Month'].'/'.$el_news['News_Year']; ?></legend>
        <p><u><?= $el_news['News_Title']; ?></u></p>
        <?= include 'articles/'.$el_news['News_Link'].'.php' ?>
        <a href="admin/article_edit.php?id=<?= $el_news['News_ID']; ?>" >Update</a>
		  </fieldset>

		  <br/>
      </div>
    <?php endforeach; ?>



  </div>
 </div>
</body>
</html>
