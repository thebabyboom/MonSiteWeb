<?php
include '../lib/includes.php';
include '../partials/header_admin.php';

/**
* SUPPRESSION
**/
if(isset($_GET['delete'])){
	checkCsrf();
	$id = $db->quote($_GET['delete']);
	$db->query("DELETE FROM categories WHERE id=$id");
	setFlash ('La catégorie a bien été supprimée');
	header('Location:category.php');
	die();
}
/**
* Catégories
**/

$select = $db->query('SELECT id, name, slug FROM categories');
$categories = $select->fetchAll();

?>

<h1> Les catégories </h1>

<p><a href="category_edit.php" class="btn btn-success">Ajouter une nouvelle catégorie</a></p>

<table class="table table-striped">
	<thead>
		<tr>
			<th>ID</th>
			<th>Nom</th>
			<th>Action</th>
		</tr>
	</thead>
	<tbody>
		<?php foreach($categories as $category): ?>

		<tr>
			<td><?= $category['id']; ?></td>
			<td><?= $category['name']; ?></td>
			<td>
				<a href="category_edit.php?id=<?= $category['id']; ?>" class="btn btn-default">Edit</a>
				<a href="?delete=<?= $category['id']; ?>&<?= csrf(); ?>" class="btn btn-error" onclick="return confirm('Sur de sur?');">Supprimer</a>
			</td>
		</tr>

		<?php endforeach; ?>
	</tbody>
</table>

<?php include '../partials/footer.php'; ?>
