<?php
include '../lib/includes.php';

if(isset($_POST['name'])&& isset($_POST['slug'])){
	checkCsrf();
	$slug = $_POST['slug'];
	if(preg_match('/^[a-z\-0-9]+$/', $slug)){
		$name = $db->quote($_POST['name']);
		$slug = $db->quote($_POST['slug']);
		$db->query("INSERT INTO categories SET name=$name, slug=$slug");
		setFlash('La catégorie a bien été ajoutée');
		header('Location:category.php');
		die();
	}else{
		setFlash('le slug n\'est pas valide','danger');
	}
}


include '../partials/header_admin.php';


?>

<h1> Editer une catégorie </h1>

<form action="#" method="post">
	<div class="form-group">
		<label for="name">Nom de la catégories</label>
		<?= input('name'); ?>
	</div>
  <div class="form-group">
		<label for="slug">Url de la catégories</label>
		<?= input('slug'); ?>
	</div>
	<?= csrfInput(); ?>
  <button type="submit" class="btn btn-default">Enregistrer</button>
</form>
<?php include '../partials/footer.php'; ?>