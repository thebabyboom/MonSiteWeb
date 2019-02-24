//ecriture du menu
echo ('<div id="menu">');
echo(' <dl>');
echo('  <dt class="titre1">MENU</dt>');
//Calcule le nombre d'éléments a afficher
$menu_count = mysql_query("SELECT count(id) FROM menu;");
$menu_res= mysql_fetch_array($menu_count);
//boucle d'extraction des données de la base de données.
for ($j=1;$j<=$menu_res[0];$j++)
{
$menu_query = mysql_query("SELECT titre, chemin FROM menu WHERE id=".$j.";");
$menu_donnees = mysql_fetch_array($menu_query);
		switch($j)
		{
			case 1 : 	echo('  <dt class="titreL"><a href="'.$menu_donnees[chemin].'">'.$menu_donnees[titre].'</a></dt>');
						break;
			case 2 : 	echo('  <dt class="titre">Les anciennes</dt>');
						$nichees_count = mysql_query("SELECT count(id) FROM nichees;");
						$nichees_res = mysql_fetch_array($nichees_count);
						for ($i=1;$i<=$nichees_res[0];$i++)
						{
							$nichees_query = mysql_query("SELECT date_nom, galerie_path, galerie_num FROM nichees WHERE id=".$i.";");
							$nichees_donnees = mysql_fetch_array($nichees_query);
							echo('  <dt class="soustitre"><a href="'.$nichees_donnees[galerie_path].'?galerie='.$nichees_donnees[galerie_num].'">'.$nichees_donnees[date_nom].'</a></dt>');
						}
						break;
			case 3 : 	echo('  <dt class="titreL"><a href="#">La nouvelle</a></dt>');
						break;
			case 4 : 	break;
			default : 	echo('  <dt class="titreL"><a href="'.$menu_donnees[chemin].'">'.$menu_donnees[titre].'</a></dt>');
						break;
		}
}
echo(' </dl>');
echo('</div>');