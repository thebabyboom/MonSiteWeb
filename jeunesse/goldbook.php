<?php 
include_once('fonctions.php');
if($_POST['insert'])
{
	$ip = $_SERVER['REMOTE_ADDR'];
	echo('<h2>Inserer un message dans le livre d\'or</h2>
<form action="'. $_SERVER['PHP_SELF'].'" method="post">
Pseudo : <input type="text" name="nom" /> 
Votre IP est : '.$ip.'<br />
E-mail : <input type="text" name="email" /><br />
Votre Message : <br />
<textarea cols="55" rows="4" name="message"></textarea><br />
<input type="submit" value="Envoyer" />
<input type="hidden" value="1" name="insert" />
</form>');
}
else
{
	goldbook();
}

$continue = 1;
if($_POST['nom']=="")
{
	echo('Le champ nom doit etre rempli!!!<br />');
	$continue = 0;
}
if($_POST['email']=="")
{
	echo('Le champ email doit etre rempli!!!<br />');
	$continue = 0;
}
if($_POST['message']=="")
{
	echo('Le champ message doit etre rempli!!!<br />');
	$continue = 0;
}

if($continue==1)
{
	$sqlsel = 'SELECT ip_add FROM goldbook';
	$ressel = mysql_query($sqlsel);
	$tabsel = mysql_fetch_array($ressel);
	if ($tabsel['ip_add']!=$_SERVER['REMOTE_ADDR'])
	{
		$message = $_POST['message'];
		$email = str_replace('@', '&#64;', $_POST['email']);
		$name = $_POST['nom'];
		$ip_add = $_SERVER['REMOTE_ADDR'];
		$date_msg = date("Y-m-j H:i:s");
	 
		$strsql = "INSERT INTO `goldbook` ( `id` , `Nom` , `Message` , `email` , `ip_add` , `msg_date` ) VALUES (NULL , '".$name."', '".$message."', '".$email."', '".$ip_add."', '".$date_msg."');";
		$res = mysql_query($strsql);
		if(mysql_affected_rows() == 1)
		{
			echo ("Message inséré dans la base de données");
			echo('<a href="goldbook.php">Voir les message</a>');
		}
		else
		{
			echo("Une erreur est survenue lors de l'envoi de votre message");
		}
	}
	else
	{
		echo('Le Flood est interdit revenez demain');
	}
}
else
{
	echo('<a href="goldbook.php"> Retour </a>');
}

?>
