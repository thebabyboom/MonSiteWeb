<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
 <HEAD>
  <TITLE>Galerie</TITLE>
  <link href="../styles.css" type="text/css" rel="stylesheet"/>
  <?php include "scan_folder.php"; ?>
 </HEAD>
 <BODY>
  <div id="header">
    <h1>Jeunesse de Saint-Sauveur.</h1>
  </div>
   <div id="menu">
	  <span class="titre">Répertoires :</span>
     <ul>
	  <li><a href="../index.php">Accueil</a></li>
  	  <li><?php $rep->LienParent();?></li>
	  <li><?php $rep->AfficheArborescence();?></li>
	 </ul>
	<br>
	  
	<br>
   </div>
   <div id="content">
     <span class="titre">Gallerie</span>
	 <div class="liste">
	  <?php 
	  $rep->ListeFichiers();?>
	 </div>
   </div>
 </BODY>
</HTML>