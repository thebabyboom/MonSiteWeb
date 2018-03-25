<html>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name="description" content="Site personnel de babyboom" />
	<meta name="keywords" content="babyboom, informatique, programmation, hesit" />
	<link title="test" type="text/css" rel="stylesheet" href="Style/teststyle.css" media="screen" />
	<title>Mon site personnel</title>
 </head>

 <body>
  <div id="page">
  <!--******************************************************************************-->
  <!--En tete de la page-->
   <div id="header">
    <img src="Images/Notepad.png" border=0 /><img src="Images/titre_transp.png" border=0 />
   </div>
  <!-- **Fin d'en-tete**-->
  <!--******************************************************************************-->

  <!--******************************************************************************-->
  <!-- ****Menu**** -->
   <div id="blocmenu">
    <div class="bloctitre">
	 **** Menu ****
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
	  <li></li><a href="link.html">Friends</a></li>
	 <li class="titre">Perso</li>
	  <li><a href="contact.html">Contact</a></li>
	  <li><a href="cv.html">Curriculum Vit&aelig;</a></li>
	  <li><a href="motivation.html">Motivation</a></li>
	</ul>
   </div>
  <!--** Fin du menu **-->
  <!--******************************************************************************-->

  <!--******************************************************************************-->
  <!-- ** Contenu de la page **-->
  	<div id="content"> 
		<div class="bloctitre">Listefilms</div>
		
		<div class="texte">
<?php
// Connexion à MySQL
$link=mysql_connect("imysql04", "i3989895","asvqwu08gb01n4gf");
mysql_select_db("i3989895");

$retour = mysql_query('SELECT count(*) AS total FROM divx');
$res = mysql_fetch_array($retour);

echo("<table>
<THEAD>
<tr>
<th bgcolor='#CCCCCC' >Titre</th>
<th bgcolor='#CCCCCC' >Nbre_cd</th>
<th bgcolor='#CCCCCC' >description</th>
<th bgcolor='#CCCCCC' >status</th>
</tr>
</THEAD>");
for ($i=0;$i<$res['total'];$i++)
{
$query = mysql_query('SELECT titre, Nbre_cd, description, status FROM divx WHERE Id='.$i);
$donnees = mysql_fetch_array($query);

echo("

<tbody>
<tr>
 <td>".$donnees['titre']."</td>
 <td>".$donnees['Nbre_cd']."</td>
 <td>".$donnees['description']."</td>
 <td>".$donnees['status']."</td>
</tr>
</tbody>
</tables>
");
}
?>
	
</div>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-1824598-1";
urchinTracker();
</script>
 </body>
</html>