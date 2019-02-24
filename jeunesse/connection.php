<?php
//**********************************************************************************//
//**********************************************************************************//
//					Fonctions Globales de connexion DATABASE.						//
//**********************************************************************************//
//**********************************************************************************//

$host="localhost"; //Nom du serveur de base de données
$user="root"; //login de connexion au serveur de base de données
$passwd=""; //password de connexion au serveur de base de données
$bdd="jeunesse"; //nom de la base de données
//connexion au serveur de base de données
mysql_connect($host,$user,$passwd) or die ("Erreur de connexion au serveur");
//selection de la base de données
mysql_select_db($bdd) or die ("Erreur de connexion à la DB");

//$link = mysql_connect("10.0.5.160","i4275287","eoybzn0b909bswc8");
//mysql_select_db("i4275287");
?>