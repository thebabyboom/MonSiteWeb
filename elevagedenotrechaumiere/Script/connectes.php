<?php
// Connexion à MySQL
$link=mysql_connect("10.0.5.160", "i3990682","d4yppdkjk8xrvmad");
mysql_select_db("i3990682");

// -------
// ETAPE 1 : on vérifie si l'IP se trouve déjà dans la table
// Pour faire ça, on n'a qu'à compter le nombre d'entrées dont le champ "IP" est l'adresse IP du visiteur
$retour = mysql_query('SELECT COUNT(*) AS nbre_entrees FROM connectes WHERE IP=\'' . $_SERVER['REMOTE_ADDR'] . '\'');
$donnees = mysql_fetch_array($retour);

if ($donnees['nbre_entrees'] == 0) // L'IP ne se trouve pas dans la table, on va l'ajouter
{
	$nbre=1;
    mysql_query('INSERT INTO connectes VALUES(\'' . $_SERVER['REMOTE_ADDR'] . '\', ' . time() . ','. $nbre .')');
}
else // L'IP se trouve déjà dans la table, on met juste à jour le timestamp
{
	$res=mysql_query('SELECT nbre FROM connectes WHERE IP=\'' . $_SERVER['REMOTE_ADDR'] . '\'');
	$nbre=mysql_fetch_array($res,MYSQL_NUM);
	$nbre[0]=$nbre[0]+1;
    mysql_query('UPDATE connectes SET timestamp=' . time() . ' WHERE IP=\'' . $_SERVER['REMOTE_ADDR'] . '\'');
    mysql_query('UPDATE connectes SET nbre=' . $nbre[0] . ' WHERE IP=\'' . $_SERVER['REMOTE_ADDR'] . '\'');
}

// -------
// ETAPE 2 : on supprime toutes les entrées dont le timestamp est plus vieux que 5 minutes
// On stocke dans une variable le timestamp qu'il était il y a 5 minutes :
//$timestamp_5min = time() - (60 * 5); // 60 * 5 = nombre de secondes écoulées en 5 minutes
//mysql_query('DELETE FROM connectes WHERE timestamp < ' . $timestamp_5min);

// -------
// ETAPE 3 : on compte le nombre d'IP stockées dans la table. C'est le nombre de visiteurs connectés
$retour = mysql_query('SELECT COUNT(*) AS nbre_entrees FROM connectes');
$result = mysql_query('SELECT SUM(nbre) FROM connectes ');
$res = mysql_fetch_array($result,MYSQL_NUM);
$donnees = mysql_fetch_array($retour,MYSQL_ASSOC);

// Ouf ! On n'a plus qu'à afficher le nombre de connectés !
if($donnees['nbre_entrees']<=1)
{
echo '<p>Il y a actuellement ' . $donnees['nbre_entrees'] . ' visiteur connecté !</p>';
echo 'Le site compte déjà ' .$res[0]. ' visiteurs.';
}
else
{
echo '<p>Il y a actuellement ' . $donnees['nbre_entrees'] . ' visiteurs connectés !</p>';
echo 'Le site compte déjà ' .$res[0]. ' visiteurs.';
}
?>