<!DOCTYPE html>
<html lang="en">
 <head>
	<meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="Site personnel de babyboom" />
	<meta name="keywords" content="babyboom, informatique, programmation, hesit" />
  <title>Mon site personnel</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
 </head>

 <body>
	 <nav class="navbar navbar-expand-lg navbar-light bg-light" role="navigation">
		<a class="navbar-brand" href="index.php">Mon Portfolio en PHP</a>
		 <ul class="navbar-nav">
			 <?php
			 	if(!isset($_SESSION['Auth']['id'])){
					echo("<li class='nav-item'><a href='login.php'>Se logger</a></li>");
				}
				else{
					echo("<li class='nav-item'><a href='" . WEBROOT . "admin/index.php'>Administration</a></li>");
					echo("<li class='nav-item'><a href='logout.php'>Se delogger</a></li>");
				}
			  ?>
		 </ul>
   </nav>
  <div class="container">

    <?= flash(); ?>
