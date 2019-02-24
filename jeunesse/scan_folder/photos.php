<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Document sans titre</title>
  <link href="../styles.css" type="text/css" rel="stylesheet"/>
  <?php include "scan_folder.php" ?>
</head>

<body>
  <div id="header">
    <h1>Jeunesse de Saint-Sauveur.</h1>
  </div>
   <div id="menu">
	  <span class="titre">Répertoires :</span>
     <ul>
	  <li><a href="../evenements.php?REP=galleries/reves_enfant">Retour</a></li>
	 </ul>
	<br>
	  
	<br>
   </div>
   <div id="content">
     <span class="titre">Gallerie</span>
	 <div class="previous">
	 </div>
	 <div class="image">
	<?PHP	
	 if (isset($_GET['file']) AND is_file($_GET['file']))
	 {
	 	print $dimensionOrigine.'<BR>';
		echo ('<IMG id="img" src="'.$image.'" border="0" width="'.$largeur.'" height="'.$hauteur.'">');
	 }
	?>
	<div class="next">
	</div>
   </div>
   </div>
</body>
</html>
