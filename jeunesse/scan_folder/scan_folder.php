<?PHP
/*
	Date : 30/03/2006
	Auteur : The_Legacy
	Description : 
		Mise en place d'une m�thode de parcours de r�pertoire par appels r�cursif
		permettant la mise en ligne d'une gallerie d'images situ�es dans un r�pertoire et ses sous-r�pertoires.
		Pour le moment, il n'est impl�ment� que pour les photos et images. Il est destin� � s'enrichir
		avec la gestion de diff�rents types de fichiers.
*/
//include_once "defineRoots.inc.php";
//define('ROOT', $tbRoots[strtoupper($_SERVER['PHP_AUTH_USER'])]); //D�finition du r�pertoire � partir duquel on d�sire travail et corrspond �galement � la limite haute de l'arborescence
define ('ROOT','galleries');

//Connection a la base de donn�es.
$link=mysql_connect("localhost", "root","");
mysql_select_db("jeunesse");

function TableauTrie($tab)
{
	//M�thode simple du tri par permutation
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
	//D�finition d'un objet fichier contenant simplement son nom et son chemin 
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
		L'objet r�peroire contient un tableau d'objets REPERTOIRE correspondants aux sous-r�pertoire de celui d�sir�
		et un autre tableau d'objets FICHIER correspondants aux fichiers contenus dans le r�pertoire d�sir�
	*/
	
	public $nom = '';
	public $chemin = '';
	
	public $tbSRep = array();
	public $tbFiles = array();
	
	function repertoire($chemin, $descendre = true)
	{
		/*
			Le deuxi�me param�tre du constructeur donne la limite de l'appel r�cursif
			s'il est mis � true, cela signifie que l'appel r�cursif d�scendra d'un niveau dans l'arborescence et listera
			les sous-r�pertoires de l'�l�ment analys�
		*/
		
		if (is_dir($chemin)) //V�rifier si le chemin existe et est bien un r�pertoire
		{
			//Remplissage des propri�t�s de l'objet
			$this->chemin = $chemin;
			
			$tbChemin = explode("/", $chemin);
			$this->nom = $tbChemin[count($tbChemin) - 1];

			//R�cup�ration des sous-r�pertoires
			$lptRep = opendir($this->chemin); //Ouverture du r�pertoire d�sir�
			$tbRepANePasLister = array('.', '..'); //Liste des sous-r�pertoires � ne pas lister
			$tbExtANePasLister = array('db','php','html'); //Liste des extensions de fichiers � ne pas lister
			while (false !== ($obj = readdir($lptRep))) //Parcours des objets contenus dans le r�pertoire d�sir�
			{
				if (!in_array($obj, $tbRepANePasLister)) //V�rification de la non pr�sence de l'�l�ment dans les �l�ments � ne pas lister
				{
					$cheminObj = $this->chemin.'/'.$obj;
					if (is_dir($cheminObj)) //Si l'�l�ment est un r�pertoire, le mettre dans le tableau des sous r�pertoires
					{
						if ($descendre)
						{
							//Appel r�cursif sur le sous-r�pertoire en cours
							//Ici, je ne d�sire pas rentrer dans les sous-r�pertoires
							$this->tbSRep[] = new repertoire($cheminObj, false); 
						}
					}
					
					if (is_file($cheminObj)) //Si l'�l�ment est un fichier, je le mets dans le tableau des fichiers
					{
						/*
							Je construit un tableau contenant les �l�ments consituant le nom de l'objet en cours
							en g�n�ral, 2 case : le nom sans l'extension puis l'extension.
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
			closedir($lptRep); //Fermeture du r�pertoire d�sir�
		}
		else 
		{
			die("Le chemin sp�cifi� n'est pas un r�pertoire !");
		}
	}
	
	function AfficheArborescence($niveau = 1)
	{
		//Parcours tous les sous-r�pertoires du r�pertoire en cours
		//Le param�tre donn� peut permettre d'effectuer un affichage d�cal� des sous-r�pertoire en fonction du niveau
		//Par exemple en ajoutant (niveau) fois un espace devant le lien
		//Le premier test permet de ne pas afficher le nom du r�pertoire en cours
		if ($niveau > 1)
		{
			//Construction du lien pour le r�pertoire concern� par l'appel r�cursif
			print '<A href="?REP='.$this->chemin.'">'.$this->nom.'</A><BR>';
		}
		
		//Affichage des sous-r�pertoires
		for ($i = 0; $i < count($this->tbSRep); $i++)
		{
			//Appel r�cursif pour l'affichage
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
		//permet d'afficher le lien pour remonter au r�pertoire parent de celui consult�
		//Le premier test permet de ne pas donner la possibilit� de remonter au dessus d'un certain r�pertoire
		//Dans mon cas le r�pertoire parent de ROOT est ma racine du serveur Web, je ne d�sire pas que mes
		//visiteurs puissent y acc�der
		//Je suis en train de travailler sur la cr�ation dynamique du ROOT en fonction du visiteur
		//Pour �viter par exemple que mes amis n'acc�dent � mes photos de famille et inversement
		if ($this->chemin != ROOT)
		{
			//Les 3 lignes qui suivent enl�vent le r�pertoire en cours du chemin de retour, pour remonter d'un seul niveau
			$tbPath = explode('/', $this->chemin); 
			array_splice($tbPath, count($tbPath) - 1);
			$pathOrigine = implode('/', $tbPath);
			
			print '<A href="?REP='.$pathOrigine.'">Retour</A><BR>';
		}
		else 
		{
			//Blanc pour remplir la case du tableau affich� en cas d'inexistence (ou d'inaccessibilit�) du r�pertoire parent
			print "&nbsp;";
		}
	}
	function NombreElement()
	{
		$nbre=count($this->tbFiles);
		return $nbre;
	}
}

//R�cup�ration des param�tres
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
	//De mani�re � en garder le rapport hauteur * largeur
	//J'utilise cette m�thode pour ne pas d�former les photos prises en hauteur en attendant de savoir retourner dynamiquement une photo
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
	$dimensionOrigine = 'Hauteur r�elle : '.$tbInfos[1].' pixels&nbsp;&nbsp;&nbsp;&nbsp;Largeur r�elle : '.$tbInfos[0].' pixels';
}
?>
