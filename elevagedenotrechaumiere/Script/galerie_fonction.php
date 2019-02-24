<?php
function galerie($idgalerie)
{
	$strSQL = 'SELECT MIN(id) AS debut, MAX(id) AS fin, count(id) AS nbre FROM galerie WHERE galerie_num ='.$idgalerie;
	$resultat = mysql_query($strSQL);
	$tab = mysql_fetch_array($resultat);
	$_ENV['debut'] = $tab['debut'];
	$_ENV['fin'] = $tab['fin'];
	$_ENV['nbre'] = $tab['nbre'];
//	$_ENV['id'] = $tab['id'];
//	$_ENV['galerie_num'] = $tab['galerie_num'];
//	$_ENV['img'] = $tab['img'];
//	$_ENV['path'] = $tab['path'];
//	$_ENV['TN_path'] = $tab['TN_path'];
//	$_ENV['nbre'] = mysql_num_rows($resultat);
//	echo $_ENV['id'].'<br>';
//	echo $_ENV['nbre'];
}
function affiche_tn($idgalerie)
{
//	echo('<div id="galerie">');
	galerie($idgalerie);
	$strSQL = 'SELECT * FROM galerie WHERE galerie_num = '.$idgalerie;
	$res = mysql_query($strSQL);
	$y=0;
	while($tab_res = mysql_fetch_array($res))
	{
		echo("&nbsp;");
		echo('<a href="index.php?id_img='.$tab_res['id'].'"><img src="'.$tab_res['TN_path'].$tab_res['img'].'.png" border=0></a>');
		//echo('<a href="galerie.php?id_img='.$tab_res['id'].'"><img src="'.$tab_res['TN_path'].$tab_res['img']'.png" border=0></a>');
		echo("&nbsp;");
		$y++;
		if (!($y%5))
			echo('<br>');
	}
//	echo('</div>');
	
//	affiche_img($tab_res['path'],$tab_res['img']);
}
function affiche_img($id)
{
	$strSQL = 'SELECT img_path, img FROM galerie WHERE id='.$id;
	$resultat = mysql_query($strSQL);
	$tab = mysql_fetch_array($resultat);
	echo('<img src="'.$tab['img_path'].$tab['img'].'.JPG" border=0>');
}
?>