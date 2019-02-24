<?php
include_once('fonctions.php');
    echo('<h2>Galeries photos.</h2>');
	if(isset($_GET['menu']))
	{
		switch($_GET['menu'])
		{
			case 2 : 	if(isset($_GET['galerie']))
						{
							include_once('fonctions.php');
							echo('<h3>Photos</h3>');
							affiche_photo('eve_images', $_GET['galerie']);
						}
						else
						{
							if(isset($_GET['diapo']))
							{
								echo('<H3>Diaporama</H3>');
								affiche_diapo('eve_images',$_GET['diapo']);
							}
							else
							{							
								echo('<h3>galerie de nos evenements</h3>');
								affiche_galerie('evenement');
							}
						}
						break;
						
			case 4 : 	if(isset($_GET['galerie']))
						{	
							include_once('fonctions.php');
							echo('<h3>Photos</h3>');
							affiche_photo('part_images',$_GET['galerie']);

						}
						else
						{
							if (isset($_GET['diapo']))
							{
								echo('<h3>Diaporama</h3>');
								affiche_diapo('part_images',$_GET['diapo']);
							}
							else
							{
								echo('<h3>galerie de nos participations</h3>');
								affiche_galerie('participation');
							}
						}
							
						break;
		}
	}
	else
	{
		echo('N\essaye meme pas de tricher');
	}
?>

