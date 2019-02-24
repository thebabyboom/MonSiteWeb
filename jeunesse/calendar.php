<?php
include_once('fonctions.php');
     echo('<h2>Calendrier des activités.</h2>');
	 if(isset($_GET['menu']))
	 {
	 	switch($_GET['menu'])
		{
			case 1 : 	echo ('<h3>Nos evenements</h3>');
						echo ('
						<p>Cette page servira a afficher les evenements que nous organiserons</p>
						');
						affiche_news($_GET['menu'],'evenement');
						break;
			case 3 : 	echo ('<h3>Nos participations</h3>');
						echo ('
						<p>Cette page servira a afficher les evenements auquel nous participerons</p>');
						affiche_news($_GET['menu'],'participation');
						break;
			default : echo('Erreur');
		}
	 }
	 else 
	 {
	 	echo('Cherche pas tu n\'y arrivera pas');
	 }
?>