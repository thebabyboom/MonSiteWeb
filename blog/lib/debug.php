<div class="row">
  <div class="col-4 order-1">
    <h2> server </h2>
    <?php  var_dump($_SERVER); ?>
  </div>
  <div class="col-4 order-2">
    <h2> constante </h2>
    <?php  var_dump(get_defined_constants()); ?>
</div>
  <div class="col-4 order-3">
    <h2> session </h2>
    <?php  var_dump($_SESSION); ?>
  </div>
