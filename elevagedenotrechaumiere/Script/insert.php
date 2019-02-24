<?php
// Connexion à MySQL
$link=mysql_connect("localhost", "root","");
mysql_select_db("elevage");
//mysql_query("INSERT INTO nichees ( id , date_nom, femelle, femelle_img, male, male_img, galerie, id_galerie )
//VALUES (NULL, '27 Janvier 2007', 'Epsy Yellow de notre Chaumière','./Images/Janvier07/epsy2.jpg', //'BeachyBoy','./Images/Janvier07/beachboy2.jpg',1,5)");
for($i=2;$i<=23;$i++)
{
    mysql_query("INSERT INTO `galerie` ( `galerie_num` , `img` , `img_path` , `TN_path` )
	VALUES ('5', 'Photo".$i."', './Images/Janvier07/', './Images/Janvier07/Mini/');");
}
echo("Données inseree");
?>
