<?php 
	if(isset($_GET['id_menu']))
	{
		$strSQL = 'SELECT * FROM nichees WHERE id='.$_GET['id_menu'];
		$resultat = mysql_query($strSQL);
		$tab= mysql_fetch_array($resultat);
		$_ENV['femelle'] = $tab['femelle'];
		$_ENV['male'] = $tab['male'];
		$_ENV['femelle_img'] = $tab['femelle_img'];
		$_ENV['male_img'] = $tab['male_img'];
		$_ENV['galerie']=$tab['galerie'];
		$_ENV['id_galerie']=$tab['id_galerie'];
		include('galerie.php');
	}
	else
	{
	echo('
		 <h2 align="center">Partie du site en construction</h2>
		 <p align="center">
		 Site en construction, cette page &eacute;voluera au cours du temps. En attendant, vous pouvez visualiser les quelques photos d&eacute;jà pr&eacute;sente sur le site.
		 <div align="center">
			 Vous trouverez dans le menu sur le cot&eacute; gauche de votre &eacute;cran, la nouvelle et les anciennes nich&eacute;es.
			 Les anciennes nich&eacute;es sont clas&eacute;es par date, et dans le menu de la nouvelle nich&eacute;e, 
			 vous trouverez les renseignements utiles de la nich&eacute;e la plus r&eacute;cente.
         </div>
		 <br>
		 <!--<div align="center">Les nouveaux jeunes viennent de na&icirc;tre, pour plus de renseignements aller voir la nouvelles nich&eacute;es en cliquant -->
		 ');
	}
?>