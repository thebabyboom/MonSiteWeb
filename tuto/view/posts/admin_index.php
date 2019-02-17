<div class="page_header">
  <h1><?php echo $total; ?> articles</h1>
</div>

<table>
  <thead>
    <tr>
      <th>ID</th>
      <th>Titre</th>
      <th>Actions</th>
    </tr>
  </thead>
  <tbody>
    <?php foreach($posts as $k => $v): ?>
      <tr>
        <td><?php echo $v->id; ?></td>
        <td><?php echo $v->name; ?></td>
        <td>
          <a href="<?php echo ROUTER::url('./edit/'.$v->id); ?>">Editer</a>
          <a onclick="return confirm('Voulez vous vraiment supprimer ce contenu');" href="<?php echo ROUTER::url('./delete/'.$v->id); ?>">Supprimer</a>

        </td>
      </tr>
    <?php endforeach ?>
  </tbody>
</table>
