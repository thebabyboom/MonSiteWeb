<div class="page_header">
  <h1>Editer un article</h1>
</div>

<form action="<?php echo Router::url('../edit/'); ?>" method="post">
  <?php echo $this->Form->input('name', 'Titre', array('class'=>'form-control')); ?>
  <?php echo $this->Form->input('slug', 'Url', array('class'=>'form-control')); ?>
  <?php echo $this->Form->input('id', 'hidden', array('class'=>'form-control')); ?>
  <?php echo $this->Form->input('content', 'Contenu',array('type'=>'textarea','class'=>'form-control','rows'=>'5')); ?>
  <?php echo $this->Form->input('online', 'En ligne',array('type'=>'checkbox','class'=>'form-check-input ')); ?>
  <div class="action">
    <input type="submit" class="btn btn-primary" value="Envoyer">
  </div>
</form>
