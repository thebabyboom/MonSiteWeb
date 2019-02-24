<?php include_once './Script/galerie_fonction.php'; ?>

<div id="galerie">
<?php
//echo($_ENV['id_galerie']);
//echo('ifgalerie='.$_ENV['galerie']);
if($_ENV['galerie'])
{
	affiche_tn($_ENV['id_galerie']);
}
?>
</div>
<div id="photo">
<?php
if ($_ENV['galerie'])
{
	if(isset($_GET['id_img']))
	affiche_img($_GET['id_img']);
	else
		affiche_img($_ENV['debut']);
}
?>
</div>