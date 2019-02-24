<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="description" content="Elevage de cockers Anglais situ&eacute; dans le Hainaut en Belgique">
<meta name="keywords" content="Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere; ">
<link rel="stylesheet" type="text/css" href="Style/MyCss.css" media="screen" title="default"/>
<title>18 f&eacute;vrier</title>
</head>

<body>
<!--Debut de la page-->
<div id="page">
<!--///////////////////////////////////////////////////////////////////////////////////////-->
	<!--****En tete de page****-->
		<div id="header">
			<h1>&Eacute;levage de notre Chaumi&egrave;re</h1>
			<p>Le 18 F&eacute;vrier 2006</p>
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
		<?php
		// Connexion à MySQL
		$link=mysql_connect("localhost", "root","");
		mysql_select_db("elevage");
		$parent = mysql_query("SELECT male, femelle, femelle_img, male_img FROM nichees WHERE gallerie_num=".$_GET[gallerie].";");
		$parent_res= mysql_fetch_array($parent);
		echo('<p align="center">');
		echo($parent_res[male]." et ".$parent_res[femelle]);
		echo('se sont unis le 22 Avril 2006.<br>
		Les b&eacute;b&eacute;s sont n&eacute;s le Dimanche 25 Juin 2006. <br>
</p>
<table>
 <tr>
  <td><H3>M&egrave;re : </H3></td>
  <td><h4>'.$parent_res[femelle].'</h4></td>
  <td width="250" align="center"></td>
  <td width="250" align="center"></td>
 </tr>
 <tr>
  <td width="150"><br></td>
  <td><img src="'.$parent_res[femelle_img].'" height="125"></td>
  <td width="250" align="center"></td>
  <td width="250" align="center"></td>
 </tr>
 <tr>
  <td colspan="3" align="right"><h4>Les chiots</h4><ul style="list-style-type:none; ">
		  <li>Epsyyellow de Notre chaumiere</li><li>Emi de notre chaumiere</li>
		  <li>Elvis de notre chaumiere</li><li>Elliot de notre chaumiere</li></ul>
  </td>
  <td align="right" width="200"><a href="gallerie.php?gallerie='.$_GET[gallerie].'"><img alt="Lien vers gallerie" border="0" src="Images/gallerie.png"></a></td>
 </tr>
 <tr>
  <td><H3>P&egrave;re : </H3></td>
  <td><h4>'.$parent_res[male].'</h4></td>
  <td width="250" align="center"></td>
  <td width="250" align="center"></td>
 </tr>
 <tr>
  <td width="150"><br></td>
  <td><img src="'.$parent_res[male_img].'" height="125"></td>
  <td width="250"></td>
  <td width="250" align="center"></td>
 </tr>
</table>');
 		?>	
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