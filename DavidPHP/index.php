<?php
$auth = 0;
include 'lib/includes.php';
include 'partials/header.php';

$select = $db->query('SELECT * FROM works');
$works = $select->fetchAll();
?>

<h1>Portfolio Tutorial</h1>

<div class="row">
	
</div>


<div id=content>
	<H1>Ma page de test</H1>
	<h2>commandes unix</h2>

	<p>Listing de fichiers</p>
	<code>ls -l </code>

	<p>Liens symboliques</p>
	<code>ln -s "source" "target" </code>
</div>
<?php
include 'partials/footer.php';
?>
