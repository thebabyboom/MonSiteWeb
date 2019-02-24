<?php
include_once('connection.php');
//**********************************************************************************//
//**********************************************************************************//
//					Fonctions d'affichage de galerie photos.						//
//**********************************************************************************//
//**********************************************************************************//
function affiche_galerie($table)
{
	//requete de selection dans la tabe dont le nom est passé en parametre
	$strsql = 'SELECT id, photo FROM '.$table;
	$res = mysql_query($strsql);
	$nbresult = mysql_num_rows($res); // nombre d'enregistrement retourné par la requete
	$x=0;//valeur de controle pour l'affichage

	if($nbresult >0)
	{
		//Bloc d'affichage des informations retirée de la base de données.
		while ($tab=mysql_fetch_array($res))
		{
			if($tab['photo']=='#')//si il n'y a pas de chamin dans la base de données
			{
				echo('<a href="index.php?menu='.$_GET['menu'].'&galerie='.$tab['id'].'"><img src="./images/Galerie.png" border=0></a>');//affiche une image générique/
			}
			else
			{
				//sinon affiche la photo correspondant a la galerie
				echo('<a href="index.php?menu='.$_GET['menu'].'&galerie='.$tab['id'].'"><img src="'.$tab['photo'].'" border=0></a>');
			}
			$x++;//incrementation du controle d'affichage
			if(!($x%5))//si il y a 5 image en ligne 
			{
				echo('<br/>');//alors affiche un retour a la ligne
			}		
		}
	}
	else
	{
		echo('Pas encore de galerie photo dans ce cas ci');
	}
}

function affiche_photo($table,$catid)
{
	//requete d'extraction des photos correspondantes a la galerie selectionnée.
	$strsql='SELECT * FROM '.$table.' WHERE cat_id='.$catid;
	$res = mysql_query($strsql);
	$nbresult = mysql_num_rows($res);
	$galerie = $_GET['galerie'];
	$x=0; //valeur de controle pour l'affichage des photos
	if(	$nbresult > 0)//si il y a des photos
	{
		//Affiche les photos tant qu'il y en a 
		while($tab = mysql_fetch_array($res))
		{
			$fichier=$tab['img_path'].$tab['img_file'].'.JPG';
			echo('<a href="index.php?menu='.$_GET['menu'].'&diapo='.$galerie.'+'.$tab['id'].'"><img src="'.$fichier.'" width="100px" height="75px" border=0></a>&nbsp;&nbsp;');
			$x++; //incremente la valeur de controle
			if(!($x%8)) //si il y a 5 photo sur une ligne
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
		$fichier_img = $tab_photo['img_path'].$tab_photo['img_file'].'.jpg';
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
	$fichier_img = $tab_photo['img_path'].$tab_photo['img_file'].'.jpg';
	$size = getimagesize($fichier_img);

	echo('&nbsp;<a href="index.php?menu='.$_GET['menu'].'&diapo='.$galerie.'+'.$image.'"><img src="'.$fichier_img.'" WIDTH="'.($size[0]/6).'" height="'.($size[1]/6).'" border=0></a>&nbsp;');

//	echo "<a href='article.php3?id_article=$id_article";
//    echo "&debut_image=$image' title='" . htmlentities($titre, ENT_QUOTES) . "'>$texte</a>";
}    




//**********************************************************************************//
//**********************************************************************************//
//				Fonctions d'affichage du calendrier des activités.					//
//**********************************************************************************//
//**********************************************************************************//
function affiche_news($menu,$table)
{
	//requete d'extraction du calendrier des evenements
	$strsql='SELECT id, name, date, description FROM '.$table.' ORDER BY id DESC';
	$res = mysql_query($strsql);
	$nbresult = mysql_num_rows($res);//Nombre d'enregistrement retourné par la requete
	$menu+=1;
	if ( $nbresult >0) // si il y a des enregistrements
	{
		//affiche les enregistrements tant qu'il y en a
		while($tab = mysql_fetch_array($res))
		{
			$description = htmlspecialchars($tab['description']);
			$description = nl2br($description);
			echo('
			<fieldset id="news">
				<legend><a href="index.php?menu='.$menu.'&galerie='.$tab['id'].'">'.$tab['name'].'</a></legend>
				<p><u>'.$tab['date'].'</u><br/><br/>
				'.$description.'</p>
			</fieldset>
			');
		}
	}
	else //si pas d'enregistrements
	{
		echo('PAS ENCORE D\'EVENEMENTS DANS CETTE PARTIE');
	}
}
function goldbook()
{
	echo("<h2>Livre d'or</h2>");
	$datetoday = date("j/m/Y"); 
	echo ("Nous sommes le ".$datetoday."<br />"); 
	echo('<form action="'.$_SERVER['PHP_SELF'].' method="post"><input type="hidden" value="0" name="insert" /></form>
 Inserer un message');

	$strsql = 'SELECT * FROM goldbook;';
	$res = mysql_query($strsql);
	
	while ( $tab = mysql_fetch_array($res))
	{
		echo("Pseudo : ".$tab['Nom']);
		echo(" a ecrit le ".$tab['msg_date']);
		echo("<br />");
		echo("E-mail : ".$tab['email']);
		echo("<br />");
		echo(" Message : <br /> ".$tab['Message']);
		echo("<br />");
	}
}
?>

