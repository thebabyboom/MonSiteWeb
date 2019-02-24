<?php echo('
	  <h2>Menu :</h2>
     <dl>
	  <dt><a href="index.php">Accueil</a></dt>
	  <dt>Nos événements</dt>
	  	<dt class="sousmenu"><a href="'.$_SERVER['PHP_SELF'].'?menu=1">Calendrier</a></dt>
	  	<dt class="sousmenu"><a href="'.$_SERVER['PHP_SELF'].'?menu=2">Galeries</a></dt>
	  <dt>Nos participations</dt>
	  	<dt class="sousmenu"><a href="'.$_SERVER['PHP_SELF'].'?menu=3">Calendrier</a></dt>
	  	<dt class="sousmenu"><a href="'.$_SERVER['PHP_SELF'].'?menu=4">Galeries</a></dt>
	  <dt><a href="'.$_SERVER['php_self'].'?menu=5">Nos membres</a></dt>
	  <!--<dt><a href="'.$_SERVER['php_self'].'?menu=9">Livre d\'or</a></dt>-->
	 </dl>
	<h2>Sous-menu : </h2>
	<dl>
	 <dt><a href="'.$_SERVER['PHP_SELF'].'?menu=6">Goodies</a></dt>
	 <dt><a href="'.$_SERVER['PHP_SELF'].'?menu=7">liens</a></dt>
	 <dt><a href="'.$_SERVER['PHP_SELF'].'?menu=8">A faire</a></dt>
	</dl>
	');
?>