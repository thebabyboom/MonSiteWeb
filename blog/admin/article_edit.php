<?php
include '../lib/includes.php';

if(isset($_POST['name']) && isset($_POST['slug'])){

	//checkCsrf();
	$News_Link = $_POST['slug'];
	if(preg_match('/^[a-z\-0-9]+$/', $News_Link)){
		$News_Title = $db->quote($_POST['name']);
		$News_Link = $db->quote($_POST['slug']);
		if(isset($_POST['content'])){
			$content = $db->quote($_POST['content']);
			$fname = date('Ymd');
			//$fname = "../articles/20181108.php";
			$fichier = fopen("../articles/".$fname.".php",'a+');
			$texte = "<P>".$content."</p>";
			fwrite($fichier, $texte);
			fclose($fichier);
		}
		var_dump($fname);
		/**
		* SAUVEGARDE DE LA REALISATION
		**/

		if(isset($_GET['id'])){
			$id = $db->quote($_GET['id']);
			$db->query("UPDATE news SET News_Title=$News_Title, News_Link=$News_Link where News_ID=$id");
		}else {
			$db->query("INSERT INTO news SET News_Title=$News_Title, News_Link=$News_Link, News_Day='08', News_Month='11', News_Year='2018'");
			$_GET['id'] = $db->lastInsertId();
		}
		setFlash('La réalisation a bien été ajoutée');

		die();
		//header('Location:work.php');
	}else{
		setFlash('le News_Link n\'est pas valide','danger');
	}
}

if(isset($_GET['id'])){
	$id = $db->quote($_GET['id']);
	$select = $db->query("SELECT * FROM news WHERE News_ID=$id");
	if($select->rowcount() == 0){
		setFlash('Il n\'y a pas de réalisation avec cet id','danger');
		header('Location:work.php');
		die();
	}
	$_POST = $select->fetch();
}

$select = $db->query('SELECT News_ID, News_Title FROM news ORDER BY News_Title ASC');
$News = $select->fetchAll();
$News_list = array();
foreach ($News as $el_News) {
	$News_list[$el_News['News_ID']] = $el_News['News_Title'];
}
?>


<html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name="description" content="Site personnel de babyboom" />
	<meta name="keywords" content="babyboom, informatique, programmation, hesit" />
	<link title="test" type="text/css" rel="stylesheet" href="../Style/blog.css" media="screen" />
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
</div>
<!--** Fin du menu **-->
<!--******************************************************************************-->

<!--******************************************************************************-->
<!-- ** Contenu de la page **-->
<div id="content">
  <h1>contenu du blog</h1>
  <h3>Ajout d'un article</h3>
  <form action="#" method="post" enctype="multipart/form-data">
  	<div class="form-group">
  		<label for="name">Titre de l'article</label>
  		<?= input('name'); ?>
  	</div>
    	<div class="form-group">
  		<label for="slug">Url de l'article'</label>
  		<?= input('slug'); ?>
  	</div>
   	<div class="form-group">
  		<label for="content">Contenu de l'article'</label>
  		<?= textarea('content'); ?>
  	</div>
    <button type="submit" class="btn btn-default">Enregistrer</button>
  </form>

</div>
</div>
</body>
</html>
