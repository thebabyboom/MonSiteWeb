<?php
//**********************************************************************************//
//**********************************************************************************//
//					Fonctions Globales de connexion DATABASE.						//
//**********************************************************************************//
//**********************************************************************************//

$host="localhost"; //Nom du serveur de base de donn�es
$user="root"; //login de connexion au serveur de base de donn�es
$passwd=""; //password de connexion au serveur de base de donn�es
$bdd="jeunesse"; //nom de la base de donn�es
//connexion au serveur de base de donn�es
mysql_connect($host,$user,$passwd) or die ("Erreur de connexion au serveur");
//selection de la base de donn�es
mysql_select_db($bdd) or die ("Erreur de connexion � la DB");

//$link = mysql_connect("10.0.5.160","i4275287","eoybzn0b909bswc8");
//mysql_select_db("i4275287");
?>