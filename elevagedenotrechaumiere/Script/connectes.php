<?php
// Connexion � MySQL
$link=mysql_connect("10.0.5.160", "i3990682","d4yppdkjk8xrvmad");
mysql_select_db("i3990682");

// -------
// ETAPE 1 : on v�rifie si l'IP se trouve d�j� dans la table
// Pour faire �a, on n'a qu'� compter le nombre d'entr�es dont le champ "IP" est l'adresse IP du visiteur
$retour = mysql_query('SELECT COUNT(*) AS nbre_entrees FROM connectes WHERE IP=\'' . $_SERVER['REMOTE_ADDR'] . '\'');
$donnees = mysql_fetch_array($retour);

if ($donnees['nbre_entrees'] == 0) // L'IP ne se trouve pas dans la table, on va l'ajouter
{
	$nbre=1;
    mysql_query('INSERT INTO connectes VALUES(\'' . $_SERVER['REMOTE_ADDR'] . '\', ' . time() . ','. $nbre .')');
}
else // L'IP se trouve d�j� dans la table, on met juste � jour le timestamp
{
	$res=mysql_query('SELECT nbre FROM connectes WHERE IP=\'' . $_SERVER['REMOTE_ADDR'] . '\'');
	$nbre=mysql_fetch_array($res,MYSQL_NUM);
	$nbre[0]=$nbre[0]+1;
    mysql_query('UPDATE connectes SET timestamp=' . time() . ' WHERE IP=\'' . $_SERVER['REMOTE_ADDR'] . '\'');
    mysql_query('UPDATE connectes SET nbre=' . $nbre[0] . ' WHERE IP=\'' . $_SERVER['REMOTE_ADDR'] . '\'');
}

// -------
// ETAPE 2 : on supprime toutes les entr�es dont le timestamp est plus vieux que 5 minutes
// On stocke dans une variable le timestamp qu'il �tait il y a 5 minutes :
//$timestamp_5min = time() - (60 * 5); // 60 * 5 = nombre de secondes �coul�es en 5 minutes
//mysql_query('DELETE FROM connectes WHERE timestamp < ' . $timestamp_5min);

// -------
// ETAPE 3 : on compte le nombre d'IP stock�es dans la table. C'est le nombre de visiteurs connect�s
$retour = mysql_query('SELECT COUNT(*) AS nbre_entrees FROM connectes');
$result = mysql_query('SELECT SUM(nbre) FROM connectes ');
$res = mysql_fetch_array($result,MYSQL_NUM);
$donnees = mysql_fetch_array($retour,MYSQL_ASSOC);

// Ouf ! On n'a plus qu'� afficher le nombre de connect�s !
if($donnees['nbre_entrees']<=1)
{
echo '<p>Il y a actuellement ' . $donnees['nbre_entrees'] . ' visiteur connect� !</p>';
echo 'Le site compte d�j� ' .$res[0]. ' visiteurs.';
}
else
{
echo '<p>Il y a actuellement ' . $donnees['nbre_entrees'] . ' visiteurs connect�s !</p>';
echo 'Le site compte d�j� ' .$res[0]. ' visiteurs.';
}
?>