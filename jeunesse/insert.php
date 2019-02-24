<?php
$link=mysql_connect("localhost", "root","schuldig");
mysql_select_db("jeunesse");

for($i=1;$i<=49;$i++)
{
    mysql_query("INSERT INTO `goodies` ( `id` , `file` , `img_path` )
VALUES (NULL , 'photo".$i."', './galeries/reves_enfant/' );");

}
echo("Donn�es inseree");


//Requete de modification du nombre de photo pour les evenements.
//UPDATE `evenement` SET `nb_image` = '0' WHERE `evenement`.`id` =1 LIMIT 1 ;

//UPDATE `eve_images` SET `cat_id` = '3' WHERE `eve_images`.`id` =".$i." LIMIT 1 ;
//INSERT INTO `eve_images` ( `id` , `file` , `ext` , `path` , `cat_id` , `hit` , `com_id` )
//VALUES (NULL , 'HPIM0".$i."', '.JPG', './galeries/reves_enfant/', '1', '0', '');
?>
