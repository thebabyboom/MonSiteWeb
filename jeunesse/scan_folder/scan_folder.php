<?PHP
/*
	Date : 30/03/2006
	Auteur : The_Legacy
	Description : 
		Mise en place d'une méthode de parcours de répertoire par appels récursif
		permettant la mise en ligne d'une gallerie d'images situées dans un répertoire et ses sous-répertoires.
		Pour le moment, il n'est implémenté que pour les photos et images. Il est destiné à s'enrichir
		avec la gestion de différents types de fichiers.
*/
//include_once "defineRoots.inc.php";
//define('ROOT', $tbRoots[strtoupper($_SERVER['PHP_AUTH_USER'])]); //Définition du répertoire à partir duquel on désire travail et corrspond également à la limite haute de l'arborescence
define ('ROOT','galleries');

//Connection a la base de données.
$link=mysql_connect("localhost", "root","");
mysql_select_db("jeunesse");

function TableauTrie($tab)
{
	//Méthode simple du tri par permutation
	$nbElements = count($tab);
	do 
	{
		$objTemp = null;
		$idx = 0;
		$permutation = false;
		while ($idx < $nbElements - 1)
		{
			if (strtoupper($tab[$idx]->nom) > strtoupper($tab[$idx + 1]->nom))
			{
				if (!$permutation)
				{
					$permutation = true;
				}
				$objTemp = $tab[$idx];
				$tab[$idx] = $tab[$idx + 1];
				 $tab[$idx + 1] = $objTemp;
			}
			$idx++;
		}
	}while ($permutation);
	return $tab;
}

class Fichier
{
	//Définition d'un objet fichier contenant simplement son nom et son chemin 
	public $nom = '';
	public $chemin = '';
	
	function Fichier($chemin)
	{
		$this->chemin = $chemin;
		
		$tbChemin = explode("/", $chemin);
		$this->nom = $tbChemin[count($tbChemin) - 1];
	}
}

class repertoire
{
	
	/*
		L'objet réperoire contient un tableau d'objets REPERTOIRE correspondants aux sous-répertoire de celui désiré
		et un autre tableau d'objets FICHIER correspondants aux fichiers contenus dans le répertoire désiré
	*/
	
	public $nom = '';
	public $chemin = '';
	
	public $tbSRep = array();
	public $tbFiles = array();
	
	function repertoire($chemin, $descendre = true)
	{
		/*
			Le deuxième paramètre du constructeur donne la limite de l'appel récursif
			s'il est mis à true, cela signifie que l'appel récursif déscendra d'un niveau dans l'arborescence et listera
			les sous-répertoires de l'élément analysé
		*/
		
		if (is_dir($chemin)) //Vérifier si le chemin existe et est bien un répertoire
		{
			//Remplissage des propriétés de l'objet
			$this->chemin = $chemin;
			
			$tbChemin = explode("/", $chemin);
			$this->nom = $tbChemin[count($tbChemin) - 1];

			//Récupération des sous-répertoires
			$lptRep = opendir($this->chemin); //Ouverture du répertoire désiré
			$tbRepANePasLister = array('.', '..'); //Liste des sous-répertoires à ne pas lister
			$tbExtANePasLister = array('db','php','html'); //Liste des extensions de fichiers à ne pas lister
			while (false !== ($obj = readdir($lptRep))) //Parcours des objets contenus dans le répertoire désiré
			{
				if (!in_array($obj, $tbRepANePasLister)) //Vérification de la non présence de l'élément dans les éléments à ne pas lister
				{
					$cheminObj = $this->chemin.'/'.$obj;
					if (is_dir($cheminObj)) //Si l'élément est un répertoire, le mettre dans le tableau des sous répertoires
					{
						if ($descendre)
						{
							//Appel récursif sur le sous-répertoire en cours
							//Ici, je ne désire pas rentrer dans les sous-répertoires
							$this->tbSRep[] = new repertoire($cheminObj, false); 
						}
					}
					
					if (is_file($cheminObj)) //Si l'élément est un fichier, je le mets dans le tableau des fichiers
					{
						/*
							Je construit un tableau contenant les éléments consituant le nom de l'objet en cours
							en général, 2 case : le nom sans l'extension puis l'extension.
						*/
						$tbInfosFichiers = explode('.', $obj); 
						if (!in_array($tbInfosFichiers[count($tbInfosFichiers) - 1], $tbExtANePasLister))
						{
							//Ajout de l'objet fichier correspondant
							$this->tbFiles[] = new Fichier($cheminObj);
						}
					}
				}
			}
			closedir($lptRep); //Fermeture du répertoire désiré
		}
		else 
		{
			die("Le chemin spécifié n'est pas un répertoire !");
		}
	}
	
	function AfficheArborescence($niveau = 1)
	{
		//Parcours tous les sous-répertoires du répertoire en cours
		//Le paramètre donné peut permettre d'effectuer un affichage décalé des sous-répertoire en fonction du niveau
		//Par exemple en ajoutant (niveau) fois un espace devant le lien
		//Le premier test permet de ne pas afficher le nom du répertoire en cours
		if ($niveau > 1)
		{
			//Construction du lien pour le répertoire concerné par l'appel récursif
			print '<A href="?REP='.$this->chemin.'">'.$this->nom.'</A><BR>';
		}
		
		//Affichage des sous-répertoires
		for ($i = 0; $i < count($this->tbSRep); $i++)
		{
			//Appel récursif pour l'affichage
			$srep = $this->tbSRep[$i];
			$srep->AfficheArborescence($niveau + 1);
		}
	}
	
	function ListeFichiers()
	{
		//Construction du lien pour les fichiers
		if (count($this->tbFiles) > 0)
		{
			foreach ($this->tbFiles as $fichier)
			{
				print '<A href="?file='.$fichier->chemin.'">
				<IMG id="img" src="'.$fichier->chemin.'" border="0" width="128" height="96"></A>';
			}
		}
	}
	
	function LienParent()
	{
		//permet d'afficher le lien pour remonter au répertoire parent de celui consulté
		//Le premier test permet de ne pas donner la possibilité de remonter au dessus d'un certain répertoire
		//Dans mon cas le répertoire parent de ROOT est ma racine du serveur Web, je ne désire pas que mes
		//visiteurs puissent y accéder
		//Je suis en train de travailler sur la création dynamique du ROOT en fonction du visiteur
		//Pour éviter par exemple que mes amis n'accèdent à mes photos de famille et inversement
		if ($this->chemin != ROOT)
		{
			//Les 3 lignes qui suivent enlèvent le répertoire en cours du chemin de retour, pour remonter d'un seul niveau
			$tbPath = explode('/', $this->chemin); 
			array_splice($tbPath, count($tbPath) - 1);
			$pathOrigine = implode('/', $tbPath);
			
			print '<A href="?REP='.$pathOrigine.'">Retour</A><BR>';
		}
		else 
		{
			//Blanc pour remplir la case du tableau affiché en cas d'inexistence (ou d'inaccessibilité) du répertoire parent
			print "&nbsp;";
		}
	}
	function NombreElement()
	{
		$nbre=count($this->tbFiles);
		return $nbre;
	}
}

//Récupération des paramètres
if (isset($_GET['REP']))
{
	$path = $_GET['REP'];
}
else 
{
	$path = ROOT;
}
			
$rep = new repertoire($path);

//Tri des tableaux
//$rep->tbSRep = TableauTrie($rep->tbSRep);
//$rep->tbFiles = TableauTrie($rep->tbFiles);

$dimensionOrigine = '';
if (isset($_GET['file']) AND is_file($_GET['file']))
{
	//Pour redimensionner l'image pour un affichage plus "visible"
	//De manière à en garder le rapport hauteur * largeur
	//J'utilise cette méthode pour ne pas déformer les photos prises en hauteur en attendant de savoir retourner dynamiquement une photo
	$image = $_GET['file'];
	$tbInfos = getimagesize($image);
	if($tbInfos[0] > 640)
	{
		$largeurDesiree = 640;
	}
	else
	{
		$largeurDesiree=$tbInfos[0];
	}
	$hauteurDesiree = ($largeurDesiree * $tbInfos[1]) / $tbInfos[0];
	$hauteur = $tbInfos[1] * ((($hauteurDesiree * 100) / $tbInfos[1]) / 100);
	$largeur = $tbInfos[0] * ((($largeurDesiree * 100) / $tbInfos[0]) / 100);

	//Pour afficher les dimensions originales de l'image
	$dimensionOrigine = 'Hauteur réelle : '.$tbInfos[1].' pixels&nbsp;&nbsp;&nbsp;&nbsp;Largeur réelle : '.$tbInfos[0].' pixels';
}
?>
