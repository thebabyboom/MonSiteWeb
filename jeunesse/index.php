<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
 <HEAD>
  <!--Balise pour le référencement auprès des moteurs de recherche -->
  <meta name="description" content="Site de la Jeunesse de Saint-Sauveur (Hainaut - Belgique)">
  <meta name="keywords" content="Jeunesse de saint-sauveur; Saint-Sauveur; Hainaut; Wallonie; Frasnes-lez-Anvaing;Village;Mouvement de jeunesse;organisation;soiree;souper;evenements; ">
  <!--Titre de la page -->
  <TITLE>Jeunesse de Saint-Sauveur</TITLE>
  <!--lien vers la feuille de style-->
  <link href="styles.css" type="text/css" rel="stylesheet"/>
 </HEAD>
 <BODY>
 <!--En tête de la page-->
  <div id="header">
  </div>
 <!--Fin de l'En-tête de la page-->
 
 <!--Menu de la page-->
   <div id="menu">
<?php include('menu.php'); ?>
   </div>
  <!--Fin du Menu de la page-->
  
  <!--Contenu de la page-->
   <div id="content">
   <?php
    if(isset($_GET['menu']))
	{
		switch($_GET['menu'])
		{
			case 1 : 	include ('calendar.php');
						break;
						
			case 2 : 	include ('galeries.php');			
						break;
						
			case 3 : 	include ('calendar.php');
						break;
						
			case 4 : 	include ('galeries.php');
						break;
						
			case 5 : 	include ('membres.php');
						break;
						
			case 6 : 	include ('goodies.php');
						break;
			
			case 7 : 	include ('links.php');
						break;
						
			case 8 : 	include ('todo.php');
						break;
			case 9 : 	include ('goldbook.php');
						break;
			
			default : 	echo('<span class="error">N\'essayez pas de tricher avec l\'url.<br/>
			Passer par le menu c\'est mieux.</span>');
		}
	}
	else
	{
		echo ('
		<h2>News</h2>
		<p>Cette page affichera les news du comité et du site au fur et a mesure que quelque chose se passera.</p>
		<fieldset id="news">
			<legend>Naissance du site</legend>
			<p><u>Avril 2007</u><br/><br/>
			Et voila c\'est fait le site est enfin né. Il était temps! Hein?<br/>
			Il est encore en construction. Des Nouvelles fonctionnalités arriveront au fil du temps<br/>
			Pour visualiser les futures fonctionnalités aller dans le menu <a href="'.$_SERVER['PHP_SELF'].'?menu=8">"a faire"</a>.
			</p>
		</fieldset>
		');
	}

   ?>
   </div>
  <!--Fin du Contenu de la page-->
  <div id="footer">
   <?php include('footer.php');?>
  </div>
 </BODY>
</HTML>
