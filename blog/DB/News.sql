-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le : Mar 23 Avril 2013 à 22:28
-- Version du serveur: 5.5.29
-- Version de PHP: 5.3.10-1ubuntu3.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `David`
--

-- --------------------------------------------------------

--
-- Structure de la table `News`
--

CREATE TABLE IF NOT EXISTS `News` (
  `News_ID` int(11) NOT NULL AUTO_INCREMENT,
  `News_DT` date NOT NULL,
  `News_Titre` varchar(100) NOT NULL,
  `News_Contenu` varchar(400) NOT NULL,
  PRIMARY KEY (`News_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Contenu de la table `News`
--

INSERT INTO `News` (`News_ID`, `News_DT`, `News_Titre`, `News_Contenu`) VALUES
(1, '2004-01-01', 'Naissance de ce site.', 'Sa version de base était vraiment "de base" mais remplissait totalement le rôle qui lui était attribué à l''époque. C''est-à-dire le partage temporaire de documents scolaires et autres.'),
(2, '2004-06-01', 'Upload de plusieurs documents.', 'Dans la section documentation, plusieurs documents relatifs aux cours de l''école où j''ai réalisé mes études sont en téléchargements au format " *.doc " et au format " *.pdf ".\nLe format " *.doc " est présent pour ceux et celles qui veulent une version facilement modifiable.\nLe format " *.pdf " est présent pour tout ceux qui ne travaille pas sous windows. '),
(3, '2005-06-01', 'Refonte totale du site.', 'Après avoir pris le temps, pendant mon stage, d''apprendre de nouvelles choses sur les standards du web et les feuilles de styles en cascade, j''ai décidé de refaire totalement mon site perso.'),
(4, '2005-09-01', 'Ajout de mon Curriculum Vitæ.', 'Je viens de terminer mes études, alors j''ajoute une page contenant mon Curriculum vitæ ainsi qu''une lettre de motivation qui explique ce que j''aimerais faire comme travail.'),
(5, '2006-03-01', 'Changement d''hébergeur', 'Suite à une envie d''apprendre le langage PHP, il me fallait un hébergeur qui accepte ce langage. Grâce à une connaissance, j''ai découvert "ibelgique".'),
(6, '2006-04-01', 'Mise à jour.', 'Suite à un entretien obligatoire avec le forem, pour l''accompagnement aux chômeurs, modification de mon curriculum vitæ.'),
(7, '2006-09-01', 'Changement de design.', 'Apprentissage du logiciels de retouche d''image "TheGimp" et découverte d''un "tutoriel" sur le design web.'),
(8, '2013-04-01', 'Changement d''hébergeur', 'Plus d''accès à iBelgique, donc changement d’hébergement, direction freeheberg ; hébergeur mutualisé gratuit ou pas cher');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
