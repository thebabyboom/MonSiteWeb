<?php 

function Start()
{	
	$_SESSION['aff_form']=TRUE;
	$_SESSION['login']='';
	$_SESSION['pass']='';
	Affiche();
}

function Affiche()
{
echo('
	<form method="post">
		Login : <input type="text" name="TXT_login" />
		Password : <input type="password" name="TXT_pass" />
		<input type="button" onClick="'.Verification().'" name="bt_login" value="Login" />
		<input type="hidden" name="logout" value="0" />
	</form>
	');
}
function Stop_session()
{
	if(isset($_post['logout']))
	{
		session_unset();
		session_destroy();
		echo ("session détruite");
	}
}
function Verification()
{
	 if (isset($_POST['bt_login']))
	 {
	 	$link = mysql_connect("localhost","root","") or die ("Erreur de connexion au serveur");
		mysql_select_db("jeunesse",$link) or die ("Erreur de connexion à la DB");
		$query_user = 'SELECT * FROM membres WHERE login LIKE "'.$_POST['TXT_login'].'";';
		$query_pass = 'SELECT * FROM membres WHERE login LIKE "'.$_POST['TXT_login'].'" AND passwd LIKE "'.$_POST['TXT_pass'].'";';
		$result_user = mysql_query($query_user, $link) or die ($query_user." - ".mysql_error());
		$result_pass = mysql_query($query_pass, $link) or die ($query_pass." - ".mysql_error());
		$tab_user = mysql_fetch_array($result_user);
		$tab_pass = mysql_fetch_array($result_pass);
	  	if(mysql_num_rows($result_user))
		{
			if(mysql_num_rows($result_pass))
			{
				$_SESSION['login'] = $tab_user['login'];
				$_SESSION['pass'] = $tab_pass['passwd'];

				echo('Vous êtes connecté sous <b>'.$_SESSION['login'].'</b>');
				$_SESSION['aff_form']=FALSE;
			}
			else
			{
				echo('Password invalide');
			}
		}
		else
		{
			echo('Utilisateur inconnu');
		}
	 }
	 if($_SESSION['aff_form'])
	 {
	 	include ('form_auth.php');
	 }
	 else
	 {
	 	echo('
		<form action="index.php" method="post">
		 Login : '.$_SESSION['login'].'
		 Password : '.$_SESSION['pass'].'
	     <input type="submit" name="bt_logout" value="Se déconnecter" />
		 <input type="hidden" name="logout" value="1"/>
		</form>');
	 }	
}
?>