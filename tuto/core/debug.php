 <div class="row">

   <div class="col-4 order-1">
     <h2> server </h2>
     <?php  var_dump($_SERVER); ?>
   </div>

   <div class="col-4 order-2">
     <h2> constante </h2>
     <?php
     echo " WEBROOT : "; var_dump(WEBROOT);
     echo "<br />";
     echo " ROOT : ";var_dump(ROOT);
     echo "<br />";
     echo " DS : ";var_dump(DS);
     echo "<br />";
     echo " CORE : ";var_dump(CORE);
     echo "<br />";
     echo " BASE_URL : ";var_dump(BASE_URL);
     echo "<br />";
     var_dump($_SERVER['SCRIPT_NAME']);
     ?>
   </div>

   <div class="col-4 order-3">
     <h2> session </h2>
     <?php  //var_dump($_SESSION); ?>
   </div>
</div>
