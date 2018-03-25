<?php $titre = 'Mon Blog ? MVC simple' ?>

<?php ob_start() ?>
<?php foreach ($billets as $billet): 
  ?>
		<fieldset id="news">
			<legend><?= $billet['News_DT'] ?></legend>
			<p><u><?= $billet['News_Titre'] ?></u><br/><br/>
			<?= $billet['News_Contenu'] ?></p>
		</fieldset>
		<br/>	
  <hr />
<?php endforeach; ?>
<?php $contenu = ob_get_clean() ?>

<?php require 'news.php' ?>
