<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="description" content="Elevage de cockers Anglais situé dans le Hainaut en Belgique">
<meta name="keywords" content="Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere; ">
<!--<link rel="stylesheet" href="Style/gallerie.css" type="text/css" media="screen" title="Gallerie">-->
<link rel="stylesheet" href="Style/MyCss.css" type="text/css" media="screen" title="Default">
<title>Gallerie</title>
</head>
 
<body>
<!--Debut de la page-->
<div id="page">
<!--///////////////////////////////////////////////////////////////////////////////////////-->
	<!--****En tete de page****-->
		<div id="header">
			<h1>&Eacute;levage de notre Chaumi&egrave;re</h1>
			<p>Gallerie</p>
		</div>
	<!--****Fin de l'entete****-->
<!--///////////////////////////////////////////////////////////////////////////////////////-->

<!--///////////////////////////////////////////////////////////////////////////////////////-->
	<!--****Menu vertical****-->
<?php include("menunichees.php"); ?>
	<!--****Fin du menu****-->
<!--///////////////////////////////////////////////////////////////////////////////////////-->	

<!--///////////////////////////////////////////////////////////////////////////////////////-->
	<!--****Contenu de la page****-->
		<div id="content">
<div id="galerie">
<?php 
// Connexion à MySQL
$link=mysql_connect("localhost", "root","");
mysql_select_db("elevage");
//Calcule le nombre d'éléments a afficher
$img_debut = mysql_query("SELECT count(id) FROM gallerie WHERE galerie_num!=".$_GET[gallerie].";");
$res_debut = mysql_fetch_array($img_debut);
$img_count = mysql_query("SELECT count(id) FROM gallerie WHERE galerie_num=".$_GET[gallerie].";");
$img_res= mysql_fetch_array($img_count);
$y=0;
for ($x=$res_debut[0]+1;$x<=$img_res[0]+$res_debut[0];$x++)
{
 $img_src = mysql_query("SELECT path, img, TN_path FROM galerie WHERE id=".$x.";");
 $img_aff = mysql_fetch_array($img_src);
 $myurl=explode("&",$_SERVER['REQUEST_URI']);
 echo('<a href="'.$myurl[0].'&img='.$img_aff[path].$img_aff[img].'.JPG" title="'.$img_aff[img].'"><img src="'.$img_aff[TN_path].$img_aff[img].'.png" alt="'.$img_aff[img].' mini" border=0 /></a>');
 echo('&nbsp;');
 $y++;
 if (!($y%5))
 	echo('<br>');
}
?>
</div>
<div id="photo">
<?php echo('<img src="'.$_GET['img'].'">'); ?>
</div>
		</div>
	<!--****Fin du contenu****-->
<!--///////////////////////////////////////////////////////////////////////////////////////-->

<!--///////////////////////////////////////////////////////////////////////////////////////-->
	<!--****Pied de page****-->
		<div id="footer">
			<p>Site &agrave; usage personnel, effectu&eacute; par mon fils &agrave; l'aide de certains sites et de copains.</p>
		</div>
	<!--****fin du pied de page****-->
<!--///////////////////////////////////////////////////////////////////////////////////////-->
</div>
<!--Fin de la page-->

</body>
</html>