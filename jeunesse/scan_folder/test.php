<?php
//Include

include "scan_folder.php";

//defines

define ('ROOT','./galeries');

//Connection a la base de donn�es.
//$link=mysql_connect("localhost", "root","");
//mysql_select_db("jeunesse");
//R�cup�ration des param�tres
$path = ROOT;

$rep = new repertoire($path);
$rep->AfficheArborescence();//Tri des tableaux
//$rep->tbSRep = TableauTrie($rep->tbSRep);
//$rep->tbFiles = TableauTrie($rep->tbFiles);

$dimensionOrigine = '';
if (isset($_GET['file']) AND is_file($_GET['file']))
{
	//Pour redimensionner l'image pour un affichage plus "visible"
	//De mani�re � en garder le rapport hauteur * largeur
	//J'utilise cette m�thode pour ne pas d�former les photos prises en hauteur en attendant de savoir retourner dynamiquement une photo
	$image = $_GET['file'];
	$tbInfos = getimagesize($image);
	if($tbInfos[0] > 640)
	{
		$largeurDesiree = 640;
	}
	else
	{
		$largeurDesiree=$tbInfos[0];
	}
	$hauteurDesiree = ($largeurDesiree * $tbInfos[1]) / $tbInfos[0];
	$hauteur = $tbInfos[1] * ((($hauteurDesiree * 100) / $tbInfos[1]) / 100);
	$largeur = $tbInfos[0] * ((($largeurDesiree * 100) / $tbInfos[0]) / 100);

	//Pour afficher les dimensions originales de l'image
	$dimensionOrigine = 'Hauteur r�elle : '.$tbInfos[1].' pixels&nbsp;&nbsp;&nbsp;&nbsp;Largeur r�elle : '.$tbInfos[0].' pixels';
}

?>
