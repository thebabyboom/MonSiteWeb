<?php
function connexion_DB ($name_DB)
{
	//introduire ici les infos de connexion de la base de donnees
	$host="localhost";
	$user="root";
	$bdd=$name_DB;
	$passwd="";
	
	mysql_connect($host,$user,$passwd) or die ("Erreur de connexion au serveur");
	mysql_select_db($bdd) or die ("Erreur de connexion à la DB");
}

function deconnexion_DB()
{
	mysql_close();
}

function requete_SQL($strSQL)
{
	$result=mysql_query($strSQL);
	if(!$result)
	{
		$message =  'Erreur SQL : '.mysql_error()."<br>\n";
		$message .= 'SQL String : '.$strSQL."<br>\n";
		$message .= "Merci d'envoyer ce message au webmaster";
		die ($message);
	}
	return $result;
}

function extraction_infos_DB()
{
	$strSQL ='SELECT * FROM menu WHERE id='.$_ENV['id_page'];
	$resultat = requete_SQL($strSQL);
	$tabl_result = mysql_fetch_array($resultat);
	$_ENV['mots_cles'] = $tabl_result['Mots_cles'];
	$_ENV['description'] = $tabl_result['Description'];
	$_ENV['titre'] = $tabl_result['titre'];
	$_ENV['contenu'] = $tabl_result['chemin'];
	$_ENV['galerie'] = $tabl_result['galerie'];
	$_ENV['id_galerie'] = $tabl_result['id_galerie'];
}

function affiche_menu($idpage)
{
echo(' <dl>');
echo('  <dt class="titreM">MENU</dt>');
if($idpage==5)
{
	$retour = mysql_query ('SELECT * FROM menu WHERE id < 2 OR id >4');
	while($donnees = mysql_fetch_array($retour))
	{
		echo('<dt class="titreL"><a href="index.php?id_page='.$donnees['id'].'">'.$donnees['titre'].'</a></dt>');
		if($donnees['id']=='5')
		{
			menu_nichees();
		}
	}
}
else
{	
	$retour = mysql_query("SELECT * FROM menu ");
	while($donnees = mysql_fetch_array($retour))
	{
		if($donnees['chemin']=='NULL')
		{
			echo('  <dt class="titre">'.$donnees['titre'].'</dt>');
		}
		else
		{	
			if($donnees['sousmenu'])
			{
				echo('  <dt class="soustitre"><a href="index.php?id_page='.$donnees['id'].'">'.$donnees['titre'].'</a></dt>');	
			}
			else
			{
				echo('  <dt class="titreL"><a href="index.php?id_page='.$donnees['id'].'">'.$donnees['titre'].'</a></dt>');
			}
		}
	}			
}
echo(' </dl>');

}

function menu_nichees()
{
echo('  <dt class="titre">Les anciennes</dt>');
$retour = mysql_query("SELECT id,date_nom FROM nichees ");

while($donnees = mysql_fetch_array($retour))
{
	echo('<dt class="soustitre"><a href="index.php?id_page=5&id_menu='.$donnees['id'].'">'.$donnees['date_nom'].'</a></dt>');	
}
}
?>