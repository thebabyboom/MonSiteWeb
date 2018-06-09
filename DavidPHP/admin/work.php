<?php
include '../lib/includes.php';
include '../partials/header_admin.php';

/**
* SUPPRESSION
**/
if(isset($_GET['delete'])){
	checkCsrf();
	$id = $db->quote($_GET['delete']);
	$db->query("DELETE FROM works WHERE id=$id");
	setFlash ('La réalisation a bien été supprimée');
	header('Location:work.php');
	die();
}
/**
* Catégories
**/

$select = $db->query('SELECT id, name, slug FROM works');
$works = $select->fetchAll();
?>

<h1> Mes Réalisations</h1>

<p><a href="work_edit.php" class="btn btn-success">Ajouter une nouvelle réalisation</a></p>

<table class="table table-striped">
	<thead>
		<tr>
			<th>ID</th>
			<th>Nom</th>
			<th>Action</th>
		</tr>
	</thead>
	<tbody>
		<?php foreach($works as $work): ?>

		<tr>
			<td><?= $work['id']; ?></td>
			<td><?= $work['name']; ?></td>
			<td>
				<a href="work_edit.php?id=<?= $work['id']; ?>" class="btn btn-default">Editer</a>
				<a href="?delete=<?= $work['id']; ?>&<?= csrf(); ?>" class="btn btn-error" onclick="return confirm('Sur de sur?');">Supprimer</a>
			</td>
		</tr>

		<?php endforeach; ?>
	</tbody>
</table>

<?php include '../partials/footer.php'; ?>
