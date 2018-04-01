<?php include 'partials/header.php'; ?>
<?php include 'lib/db.php'; ?>
  <!--******************************************************************************-->
  <!-- ** Contenu de la page **-->
  <div id="content">
		<div class="bloctitre">News.</div>

    <?php
    $select=$db-> query('SELECT * FROM users');
    var_dump($select->fetch());
    ?>
  </div>
  <!--******************************************************************************-->
  <!-- ** Fin Contenu de la page **-->

<?php include 'partials/footer.php'; ?>
