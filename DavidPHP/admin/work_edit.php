<?php
include '../lib/includes.php';

if(isset($_POST['name']) && isset($_POST['slug'])){
	
	checkCsrf();
	$slug = $_POST['slug'];
	if(preg_match('/^[a-z\-0-9]+$/', $slug)){
		$name = $db->quote($_POST['name']);
		$slug = $db->quote($_POST['slug']);
		$content = $db->quote($_POST['content']);
		$category_id = $db->quote($_POST['category_id']);

		/**
		* SAUVEGARDE DE LA REALISATION
		**/

		if(isset($_GET['id'])){
			$id = $db->quote($_GET['id']);
			$db->query("UPDATE works SET name=$name, slug=$slug, content=$content, category_id=$category_id where id=$id");
		}else {
			$db->query("INSERT INTO works SET name=$name, slug=$slug, content=$content, category_id=$category_id");
			$_GET['id'] = $db->lastInsertId();
		}
		setFlash('La réalisation a bien été ajoutée');

		/**
		* ENVOIS DES IMAGES
		**/
		$work_id = $db->quote($_GET['id']);
		$image = $_FILES['image'];
		$extension = pathinfo($image['name'], PATHINFO_EXTENSION);
		if(in_array($extension, array('jpg', 'png'))){
			$db->query("INSERT INTO images SET work_id=$work_id, name=''");
			$image_id = $db->lastInsertId();
			$image_name = $image_id . '.' . $extension;
			move_uploaded_file($image['tmp_name'], IMAGES . '/works/' . $image_name);
			$image_name = $db->quote($image_name);
			$db->query("UPDATE images SET name=$image_name WHERE id=$image_id");
		}
		var_dump($image_name);
		//header('Location:work.php');
		die();
	}else{
		setFlash('le slug n\'est pas valide','danger');
	}
}

if(isset($_GET['id'])){
	$id = $db->quote($_GET['id']);
	$select = $db->query("SELECT * FROM works WHERE id=$id");
	if($select->rowcount() == 0){
		setFlash('Il n\'y a pas de réalisation avec cet id','danger');
		header('Location:work.php');
		die();
	}
	$_POST = $select->fetch();
}

$select = $db->query('SELECT id, name FROM categories ORDER BY name ASC');
$categories = $select->fetchAll();
$categories_list = array();
foreach ($categories as $category) {
	$categories_list[$category['id']] = $category['name'];
}

include '../partials/header_admin.php';


?>

<h1> Editer une réalisation </h1>

<form action="#" method="post" enctype="multipart/form-data">
	<div class="form-group">
		<label for="name">Nom de la réalisations</label>
		<?= input('name'); ?>
	</div>
  	<div class="form-group">
		<label for="slug">Url de la réalisations</label>
		<?= input('slug'); ?>
	</div>
 	<div class="form-group">
		<label for="content">Contenu de la réalisations</label>
		<?= textarea('content'); ?>
	</div>
	<div class="form-group">
		<label for="category_id">Catégorie</label>
		<?= select('category_id', $categories_list); ?>
	</div>	
	<?= csrfInput(); ?>
	<div class="form-group">
		<input type="file" name="image">
	</div> 
  <button type="submit" class="btn btn-default">Enregistrer</button>
</form>



<?php include '../partials/footer.php'; ?>
