<?php
$folder = ".";
$dossier = opendir($folder);
$tbExtANePasLister = array('db'); //Liste des extensions de fichiers à ne pas lister
//$Fichier = readdir($dossier)
while ($Fichier=readdir($dossier))
{
  if ($Fichier != '.' && $Fichier != '..') 
  {
  	if(!is_dir($Fichier))
	{
		$extension=explode('.',$Fichier);
		if (!in_array($extension[count($extension) - 1], $tbExtANePasLister))
		{
			echo ($extension[count($extension)-2]);
			echo ('&nbsp;');
    		$nomFichier = $folder.'/'.$Fichier;
			$path = str_replace(' ', '%20',$nomFichier);
    		echo ($path.'<BR>');
		}
  	}
  }	
}
closedir($dossier);
?>
