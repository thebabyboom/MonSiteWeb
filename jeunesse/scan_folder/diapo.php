<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Document sans titre</title>
<link href="../styles.css" type="text/css" rel="stylesheet"/>
<?php include "scan_folder.php"; ?>
</head>

<body>
  <div id="header">
    <h1>Jeunesse de Saint-Sauveur.</h1>
  </div>
   <div id="menu">
	  <span class="titre">Répertoires :</span>
     <ul>
	  <li><?php $rep->AfficheArborescence();?></li>
	  <li><?php $rep->LienParent();?></li>
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

</body>
</html>
