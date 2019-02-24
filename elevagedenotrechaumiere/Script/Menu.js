// JavaScript Document
function ouvrirLien(url,ouverture,cible){
	//Cette fonction permet d'ouvrir trois type de lien
	//1 : Dans la fenetre courante
	//2 : Dans une nouvelle fenetre
	//3 : Dans une frame dont la cible doit etre précisée
	
	switch(ouverture)
	{
		case "1" : 
				//ouverture dans la fenetre courante
				document.location.href=url;
				break;
		case "2" :
				//ouverture d'une nouvelle fenetre
				window.open(url)
				break;
		case "3" : 
				//ouverture dans une frame
				window.top.parent.frames[cible].location.href=url
				break;
		default : 
				//normalement, on arrive jamais ici
				alert('erreur : Cette valeur est hors limite');
				break;
	}
}
function changeCouleur(cellule,couleurFond,couleurPolice){
	//Cette fonction modifie la couleur de fond
	//et de police d'une cellule de tableau
	cellule.style.backgroundColor = couleurFond;
	cellule.style.color = couleurPolice;
}