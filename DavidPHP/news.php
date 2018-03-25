<html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="description" content="Site personnel de babyboom" />
	<meta name="keywords" content="babyboom, informatique, programmation, hesit" />
	<link title="test" type="text/css" rel="stylesheet" href="Style/teststyle.css" media="screen" />
	<title>Mon site personnel</title>
 </head>

 <body>
  <div id="page">
  <!--******************************************************************************-->
  <!--En tete de la page-->
   <header>
    <img src="Images/Notepad.png" border=0 /><img src="Images/titre_transp.png" border=0 />
   </header>
  <!-- **Fin d'en-tete**-->
  <!--******************************************************************************-->

  <!--******************************************************************************-->
  <!-- ****Menu**** -->
  <nav>
   <div id="blocmenu">
    <div class="bloctitre">
	  Menu 
	</div>
	<ul class="menu">
	 <li class="titre">Home</li>
	  <li><a href="home.html">Page d'accueil</a></li>
	  <li><a href="map.html">Plan du site</a></li>
	  <li><a href="index.html">News</a></li>
	 <li class="titre">Documentation</li>
	  <li><a href="programmation.html">Programmation</a></li>
	  <li><a href="peripherique.html">Peripherique</a></li>
	  <li><a href="os.html">Systeme d'exploitation</a></li>
	  <li><a href="divers.html">Divers</a></li>
	 <li class="titre">Forum</li>
	  <li><a href="http://www.hesit.be/~forum" target="_blank">Forum</a></li>
	 <li class="titre">Liens</li>
	  <li><a href="ecole.html">Ecole</a></li>
	  <li></li><a href="link.html">Friends</a>
	 <li class="titre">Perso</li>
	  <li><a href="contact.html">Contact</a></li>
	  <li><a href="cv.html">Curriculum Vit&aelig;</a></li>
	  <li><a href="motivation.html">Motivation</a></li>
	</ul>
   </div>
  </nav>
   <!--** Fin du menu **-->
  <!--******************************************************************************-->

  <!--******************************************************************************-->
  <!-- ** Contenu de la page **-->
  	<div id="content">
		<div class="bloctitre">News.</div>
		
		<div class="texte">
		 <?= $contenu ?>  <!-- Élément spécifique -->
		</div>
	</div> <!-- #contenu -->
      <footer id="piedBlog">
        Blog réalisé avec PHP, HTML5 et CSS.
      </footer>
    </div> <!-- #global -->
  </body>
</html>
