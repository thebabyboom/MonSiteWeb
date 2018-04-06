<!DOCTYPE html>
<html lang="en">
 <head>
	<meta charst="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="Site personnel de babyboom" />
	<meta name="keywords" content="babyboom, informatique, programmation, hesit" />
  <title>Mon site personnel</title>
 <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">-->
 <link rel="stylesheet" href="css/mycss.css" />
 </head>

 <body>
	 <nav class="navbar navbar-expand-lg navbar-dark bg-dark" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="index.php">Mon Portfolio en PHP</a>
			</div>
			<ul class="navbar-nav">
				<?php
					if(!isset($_SESSION['Auth']['id'])){
						echo("<li class='nav-item'><a class='nav-link' href='login.php'>Se logger</a></li>");
					}else{
						echo("<li class='nav-item'><a class='nav-link' href='" . WEBROOT . "admin/index.php'>Administration</a></li>");
						echo("<li class='nav-item'><a class='nav-link' href='logout.php'>Se delogger</a></li>");
					}
				?>
			</ul>
		</div>
	</nav>

  <div class="container">

    <?= flash(); ?>
