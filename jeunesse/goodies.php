<h2>Goodies</h2>
<h3>Fonds d'écran</h3>
<?php 
include_once('connection.php');
if(isset($_GET['diapo']))
{	
	affiche_diapo('goodies',$_GET['diapo']);
}
else
{
	//requete d'extraction des photos correspondantes a la galerie selectionnée.
	$strsql='SELECT * FROM goodies';
	$res = mysql_query($strsql);
	$nbresult = mysql_num_rows($res);
	$x=0; //valeur de controle pour l'affichage des photos
	if(	$nbresult > 0)//si il y a des photos
	{
		//Affiche les photos tant qu'il y en a 
		while($tab = mysql_fetch_array($res))
		{
			$fichier=$tab['img_path'].$tab['img_file'].'.png';
			echo('<a href="index.php?menu='.$_GET['menu'].'&diapo=0+'.$tab['id'].'"><img src="'.$fichier.'" width="100px" height="75px" border=0></a>&nbsp;&nbsp;');
			$x++; //incremente la valeur de controle
			if(!($x%5)) //si il y a 5 photo sur une ligne
			{
				echo('<br/>');	//affiche un retour a la ligne.
			}
		}
	}
	else //si pas de photos
	{
		echo('PAS ENCORE DE PHOTOS POUR CETTE GALERIE');
	}
}
function affiche_diapo($table,$diapo)
{
	$catid=explode(" ",$diapo);
	$strsql='SELECT MIN(id) AS debut, MAX(id) AS fin, count(id) AS nbre FROM '.$table.' WHERE cat_id='.$catid[0];
	$res = mysql_query($strsql);
	$tab = mysql_fetch_array($res);
//	echo('min = '.$tab['debut'].'<br>');
//	echo('max = '.$tab['fin'].'<br>');
//	echo('total = '.$tab['nbre'].'<br>');
	if($tab['nbre']>1)
	{
		if($catid[1] > 1)
		{
			lienPage ($table, $catid[0],($catid[1]-1),"image précedente","precedente"); 
		}
	
		$strsql2 = 'SELECT * FROM '.$table.' WHERE id='.$catid[1].' AND cat_id='.$catid[0];
		$res2 = mysql_query($strsql2);
		$tab_photo = mysql_fetch_array($res2);
		$fichier_img = $tab_photo['img_path'].$tab_photo['img_file'].'.png';
		$size = getimagesize($fichier_img);
		echo('<img src="'.$fichier_img.'" WIDTH="'.($size[0]/2).'" height="'.($size[1]/2).'">');		
		
		if($catid[1] < $tab['nbre']-1)
		{
        	lienPage($table, $catid[0], ($catid[1]+1), "image suivante", "suivante");
		}
	}
}
function lienPage($table, $galerie, $image, $titre, $texte) 
{
    // affiche un lien avec les paramètres en argument
	$strsql2 = 'SELECT * FROM '.$table.' WHERE id='.$image.' AND cat_id='.$galerie;
	$res2 = mysql_query($strsql2);
	$tab_photo = mysql_fetch_array($res2);
	$fichier_img = $tab_photo['img_path'].$tab_photo['img_file'].'.png';
	$size = getimagesize($fichier_img);

	echo('&nbsp;<a href="index.php?menu='.$_GET['menu'].'&diapo='.$galerie.'+'.$image.'"><img src="'.$fichier_img.'" WIDTH="'.($size[0]/6).'" height="'.($size[1]/6).'" border=0></a>&nbsp;');

//	echo "<a href='article.php3?id_article=$id_article";
//    echo "&debut_image=$image' title='" . htmlentities($titre, ENT_QUOTES) . "'>$texte</a>";
}    

?>