<?php

// partie Modèle du blog

// Renvoie la liste de tous les billets, triés par identifiant décroissant
function getBillets() {
    $bdd = getBdd();
    $requeteBillets = "select * from News order by News_ID desc";
    $stmtBillets = $bdd->query($requeteBillets);
    return $stmtBillets;
}

// Renvoie les informations sur un billet
function getBillet($idBillet)
{
    $bdd = getBdd();
    $stmtBillet = $bdd->query('select * from News where News_ID=' . $idBillet);
    $billet = $stmtBillet->fetch(); // Accès au premier élément résultat
    return $billet;
}

// Renvoie la liste des commentaires associés à un billet
function getCommentaires($idBillet)
{
    $bdd = getBdd();
    $stmtCommentaires = $bdd->query('select * from T_COMMENTAIRE where BIL_ID=' . $idBillet);
    return $stmtCommentaires;
}

// Effectue la connexion à la BDD
// Instancie et renvoie l'objet PDO associé
function getBdd() {
    $bdd = new PDO('mysql:host=localhost;dbname=David;charset=utf8',
                    'root', '81schuldig', array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
    return $bdd;
}