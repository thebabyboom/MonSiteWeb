<?php
	error_reporting(E_ALL);
	include_once './Script/fonctions.php';
	connexion_DB('elevage');
	$id_page_accueil =1;
	if(isset($_GET['id_page']))
	{
		$_ENV['id_page']=intval($_GET['id_page']);
	}
	else
	{
		$_ENV['id_page'] = $id_page_accueil;
	}
	extraction_infos_DB();
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="description" content="<?php echo $_ENV['description']; ?>">
<meta name="keywords" content="<?php echo $_ENV['mots_cles']; ?> ">
<link rel="stylesheet" type="text/css" href="Style/MyCss.css" media="screen" title="Default">
<title><?php echo $_ENV['titre']; ?></title>
</head>

<body>
<!--Debut de la page-->
<div id="page">
<!--///////////////////////////////////////////////////////////////////////////////////////-->
	<!--****En tete de page****-->
		<div id="header">
			<h1>&Eacute;levage de notre Chaumi&egrave;re</h1>
			<p><?php echo($_ENV['titre']); ?></p>
		</div>
	<!--****Fin de l'entete****-->
<!--///////////////////////////////////////////////////////////////////////////////////////-->

<!--///////////////////////////////////////////////////////////////////////////////////////-->
	<!--****Menu vertical****-->
			<?php
			echo('<div id="menu">');
		  		affiche_menu($_ENV['id_page']); 
			echo('</div>');
			?>
	<!--****Fin du menu****-->
<!--///////////////////////////////////////////////////////////////////////////////////////-->	

<!--///////////////////////////////////////////////////////////////////////////////////////-->
	<!--****Contenu de la page****-->
		<div id="content">
			<div id="contenu">
				<?php include ($_ENV['contenu']); ?>
			</div>
		</div>
	<!--****Fin du contenu****-->
<!--///////////////////////////////////////////////////////////////////////////////////////-->

<!--///////////////////////////////////////////////////////////////////////////////////////-->
	<!--****Pied de page****-->
		<div id="footer">
			<p>Site r&eacute;alis&eacute; par Babyboom (thebabyboom@gmail.com)</p>
		</div>
	<!--****fin du pied de page****-->
<!--///////////////////////////////////////////////////////////////////////////////////////-->
</div>
<!--Fin de la page-->
</body>
</html>