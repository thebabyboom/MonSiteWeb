-- phpMyAdmin SQL Dump
-- version 2.9.2
-- http://www.phpmyadmin.net
-- 
-- Serveur: localhost
-- Généré le : Mardi 10 Avril 2007 à 15:47
-- Version du serveur: 5.0.27
-- Version de PHP: 5.2.1
-- 
-- Base de données: `elevage`
-- 

-- --------------------------------------------------------

-- 
-- Structure de la table `galerie`
-- 

CREATE TABLE `galerie` (
  `id` smallint(5) NOT NULL auto_increment,
  `galerie_num` mediumint(8) NOT NULL,
  `img` varchar(255) NOT NULL,
  `img_path` varchar(255) NOT NULL,
  `TN_path` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=104 ;

-- 
-- Contenu de la table `galerie`
-- 

INSERT INTO `galerie` (`id`, `galerie_num`, `img`, `img_path`, `TN_path`) VALUES 
(1, 1, 'groupe', './Images/Photos/', './Images/Photos/Mini/'),
(2, 1, 'cockerdessin', './Images/Photos/', './Images/Photos/Mini/'),
(3, 1, 'Pupies', './Images/Photos/', './Images/Photos/Mini/'),
(4, 1, 'CastaneaKings', './Images/Photos/', './Images/Photos/Mini/'),
(5, 1, 'TipolZima', './Images/Photos/', './Images/Photos/Mini/'),
(6, 1, 'Disquysdalimittripols1b', './Images/Photos/', './Images/Photos/Mini/'),
(7, 1, 'Disquysdalimittripols2b', './Images/Photos/', './Images/Photos/Mini/'),
(8, 2, 'Ciara1', './Images/Ciara/', './Images/Ciara/Mini/'),
(9, 2, 'Ciara2', './Images/Ciara/', './Images/Ciara/Mini/'),
(10, 2, 'Ciara3', './Images/Ciara/', './Images/Ciara/Mini/'),
(11, 2, 'Ciara4', './Images/Ciara/', './Images/Ciara/Mini/'),
(12, 2, 'Ciara5', './Images/Ciara/', './Images/Ciara/Mini/'),
(13, 2, 'Ciara6', './Images/Ciara/', './Images/Ciara/Mini/'),
(14, 2, 'Ciara7', './Images/Ciara/', './Images/Ciara/Mini/'),
(15, 2, 'Ciara8', './Images/Ciara/', './Images/Ciara/Mini/'),
(16, 2, 'Ciara9', './Images/Ciara/', './Images/Ciara/Mini/'),
(17, 2, 'Ciara10', './Images/Ciara/', './Images/Ciara/Mini/'),
(18, 2, 'Ciara11', './Images/Ciara/', './Images/Ciara/Mini/'),
(19, 2, 'Ciara12', './Images/Ciara/', './Images/Ciara/Mini/'),
(20, 2, 'Ciara13', './Images/Ciara/', './Images/Ciara/Mini/'),
(21, 2, 'Ciara14', './Images/Ciara/', './Images/Ciara/Mini/'),
(22, 2, 'Ciara15', './Images/Ciara/', './Images/Ciara/Mini/'),
(23, 2, 'Ciara16', './Images/Ciara/', './Images/Ciara/Mini/'),
(24, 2, 'Ciara17', './Images/Ciara/', './Images/Ciara/Mini/'),
(25, 2, 'Ciara18', './Images/Ciara/', './Images/Ciara/Mini/'),
(26, 2, 'Ciara19', './Images/Ciara/', './Images/Ciara/Mini/'),
(27, 3, 'Photo1', './Images/chiots/', './Images/chiots/Mini/'),
(28, 3, 'Photo2', './Images/chiots/', './Images/chiots/Mini/'),
(29, 3, 'Photo3', './Images/chiots/', './Images/chiots/Mini/'),
(30, 3, 'Photo4', './Images/chiots/', './Images/chiots/Mini/'),
(31, 3, 'Photo5', './Images/chiots/', './Images/chiots/Mini/'),
(32, 3, 'Photo6', './Images/chiots/', './Images/chiots/Mini/'),
(33, 3, 'Photo7', './Images/chiots/', './Images/chiots/Mini/'),
(34, 3, 'Photo8', './Images/chiots/', './Images/chiots/Mini/'),
(35, 3, 'Photo9', './Images/chiots/', './Images/chiots/Mini/'),
(36, 3, 'Photo10', './Images/chiots/', './Images/chiots/Mini/'),
(37, 3, 'Photo11', './Images/chiots/', './Images/chiots/Mini/'),
(38, 3, 'Photo12', './Images/chiots/', './Images/chiots/Mini/'),
(39, 3, 'Photo13', './Images/chiots/', './Images/chiots/Mini/'),
(40, 3, 'Photo14', './Images/chiots/', './Images/chiots/Mini/'),
(41, 3, 'Photo15', './Images/chiots/', './Images/chiots/Mini/'),
(42, 3, 'Photo16', './Images/chiots/', './Images/chiots/Mini/'),
(43, 3, 'Photo17', './Images/chiots/', './Images/chiots/Mini/'),
(44, 3, 'Photo18', './Images/chiots/', './Images/chiots/Mini/'),
(45, 3, 'Photo19', './Images/chiots/', './Images/chiots/Mini/'),
(46, 3, 'Photo20', './Images/chiots/', './Images/chiots/Mini/'),
(47, 3, 'Photo21', './Images/chiots/', './Images/chiots/Mini/'),
(48, 3, 'Photo22', './Images/chiots/', './Images/chiots/Mini/'),
(49, 3, 'Photo23', './Images/chiots/', './Images/chiots/Mini/'),
(50, 3, 'Photo24', './Images/chiots/', './Images/chiots/Mini/'),
(51, 3, 'Photo25', './Images/chiots/', './Images/chiots/Mini/'),
(52, 3, 'Photo26', './Images/chiots/', './Images/chiots/Mini/'),
(53, 3, 'Photo27', './Images/chiots/', './Images/chiots/Mini/'),
(54, 3, 'Photo28', './Images/chiots/', './Images/chiots/Mini/'),
(55, 3, 'Photo29', './Images/chiots/', './Images/chiots/Mini/'),
(56, 3, 'Photo30', './Images/chiots/', './Images/chiots/Mini/'),
(57, 3, 'Photo31', './Images/chiots/', './Images/chiots/Mini/'),
(58, 3, 'Photo32', './Images/chiots/', './Images/chiots/Mini/'),
(59, 3, 'Photo33', './Images/chiots/', './Images/chiots/Mini/'),
(60, 3, 'Photo34', './Images/chiots/', './Images/chiots/Mini/'),
(61, 4, 'Photo1', './Images/Juin/', './Images/Juin/Mini/'),
(62, 4, 'Photo2', './Images/Juin/', './Images/Juin/Mini/'),
(63, 4, 'Photo3', './Images/Juin/', './Images/Juin/Mini/'),
(64, 4, 'Photo4', './Images/Juin/', './Images/Juin/Mini/'),
(65, 4, 'Photo5', './Images/Juin/', './Images/Juin/Mini/'),
(66, 4, 'Photo6', './Images/Juin/', './Images/Juin/Mini/'),
(67, 4, 'Photo7', './Images/Juin/', './Images/Juin/Mini/'),
(68, 4, 'Photo8', './Images/Juin/', './Images/Juin/Mini/'),
(69, 4, 'Photo9', './Images/Juin/', './Images/Juin/Mini/'),
(70, 4, 'Photo10', './Images/Juin/', './Images/Juin/Mini/'),
(71, 4, 'Photo11', './Images/Juin/', './Images/Juin/Mini/'),
(72, 4, 'Photo12', './Images/Juin/', './Images/Juin/Mini/'),
(73, 4, 'Photo13', './Images/Juin/', './Images/Juin/Mini/'),
(74, 4, 'Photo14', './Images/Juin/', './Images/Juin/Mini/'),
(75, 4, 'Photo15', './Images/Juin/', './Images/Juin/Mini/'),
(76, 4, 'Photo16', './Images/Juin/', './Images/Juin/Mini/'),
(77, 4, 'Photo17', './Images/Juin/', './Images/Juin/Mini/'),
(78, 4, 'Photo18', './Images/Juin/', './Images/Juin/Mini/'),
(79, 4, 'Photo19', './Images/Juin/', './Images/Juin/Mini/'),
(80, 4, 'Photo20', './Images/Juin/', './Images/Juin/Mini/'),
(81, 5, 'Photo1', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(82, 5, 'Photo2', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(83, 5, 'Photo3', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(84, 5, 'Photo4', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(85, 5, 'Photo5', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(86, 5, 'Photo6', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(87, 5, 'Photo7', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(88, 5, 'Photo8', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(89, 5, 'Photo9', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(90, 5, 'Photo10', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(91, 5, 'Photo11', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(92, 5, 'Photo12', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(93, 5, 'Photo13', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(94, 5, 'Photo14', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(95, 5, 'Photo15', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(96, 5, 'Photo16', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(97, 5, 'Photo17', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(98, 5, 'Photo18', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(99, 5, 'Photo19', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(100, 5, 'Photo20', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(101, 5, 'Photo21', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(102, 5, 'Photo22', './Images/Janvier07/', './Images/Janvier07/Mini/'),
(103, 5, 'Photo23', './Images/Janvier07/', './Images/Janvier07/Mini/');

-- --------------------------------------------------------

-- 
-- Structure de la table `menu`
-- 

CREATE TABLE `menu` (
  `id` tinyint(4) NOT NULL auto_increment,
  `titre` varchar(255) NOT NULL,
  `chemin` varchar(255) NOT NULL,
  `Mots_cles` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `sousmenu` tinyint(1) NOT NULL,
  `galerie` tinyint(1) NOT NULL,
  `id_galerie` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

-- 
-- Contenu de la table `menu`
-- 

INSERT INTO `menu` (`id`, `titre`, `chemin`, `Mots_cles`, `Description`, `sousmenu`, `galerie`, `id_galerie`) VALUES 
(1, 'Accueil', './pages/Home.php', 'Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', 0, 0, 0),
(2, 'Mes chiens', 'NULL', '', '', 0, 0, 0),
(3, 'Mes femelles', './pages/Femelles.php', 'Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere;femelles;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', 1, 0, 0),
(4, 'Mes mâles', './pages/Males.php', 'Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere;males;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', 1, 0, 0),
(5, 'Mes Nichées', './pages/Nichees.php', 'Elevage;cockers Anglais;Belgique;Hainaut;nichees;chiens;chiots;chaumiere;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', 0, 0, 0),
(6, 'Photos Diverses', './pages/galerie.php', 'Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere;photos;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', 0, 1, 1),
(7, 'Me contacter', './pages/Contact.php', 'Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere;contact', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', 0, 0, 0),
(8, 'Liens', './pages/Liens.php', 'Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', 0, 0, 0);

-- --------------------------------------------------------

-- 
-- Structure de la table `nichees`
-- 

CREATE TABLE `nichees` (
  `id` tinyint(5) NOT NULL auto_increment,
  `date_nom` varchar(255) NOT NULL,
  `femelle` varchar(255) NOT NULL,
  `femelle_img` varchar(255) NOT NULL,
  `male` varchar(255) NOT NULL,
  `male_img` varchar(255) NOT NULL,
  `galerie` tinyint(1) NOT NULL,
  `id_galerie` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- 
-- Contenu de la table `nichees`
-- 

INSERT INTO `nichees` (`id`, `date_nom`, `femelle`, `femelle_img`, `male`, `male_img`, `galerie`, `id_galerie`) VALUES 
(1, 'Ciara', '', '', '', '', 1, 2),
(2, '18 février 2005', 'Tipsy Lady de la coquinière', 'Images/Photos/Tipsydelacoquiniere.JPG', 'Tripol''s Disquys Dalimit', 'Images/Photos/Disquysdalimittripols2b.jpg', 1, 3),
(3, '25 juin 2006', 'Bugsy de notre Chaumière', 'Images/Photos/bugsy.jpg', 'Tripol''s Disquys Dalimit', 'Images/Photos/Disquysdalimittripols2b.jpg', 1, 4),
(4, '27 Janvier 2007', 'Epsy Yellow de notre Chaumière', './Images/Janvier07/epsy2.jpg', 'BeachyBoy', './Images/Janvier07/beachboy2.jpg', 1, 5);

-- --------------------------------------------------------

-- 
-- Structure de la table `pages`
-- 

CREATE TABLE `pages` (
  `Id_page` int(11) NOT NULL auto_increment,
  `Titre` varchar(255) NOT NULL,
  `Mots_cles` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `Contenu` varchar(255) NOT NULL,
  `Id_parent` int(11) NOT NULL default '1',
  `galerie` tinyint(1) NOT NULL,
  `Id_galerie` int(11) NOT NULL default '0',
  PRIMARY KEY  (`Id_page`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

-- 
-- Contenu de la table `pages`
-- 

INSERT INTO `pages` (`Id_page`, `Titre`, `Mots_cles`, `Description`, `Contenu`, `Id_parent`, `galerie`, `Id_galerie`) VALUES 
(1, 'Accueil', 'Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', './home.php', 0, 0, 0),
(2, 'Mes chiens', 'Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', 'NULL', 1, 0, 0),
(3, 'Mes Nichées', 'Elevage;cockers Anglais;Belgique;Hainaut;nichees;chiens;chiots;chaumiere;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', './nichees.php', 1, 0, 0),
(4, 'Photos Diverses', 'Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere;photos;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', './photos.php', 1, 0, 0),
(5, 'Me contacter', 'Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere;contact', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', './contact.php', 1, 0, 0),
(6, 'Liens', 'Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', './liens.php', 1, 0, 0),
(7, 'Mes femelles', 'Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere;femelles;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', './femelles.php', 2, 0, 0),
(8, 'Mes mâles', 'Elevage;cockers Anglais;Belgique;Hainaut;chiens;chiots;chaumiere;males;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', './males.php', 2, 0, 0),
(9, 'Dona Ciara', 'Elevage;cockers Anglais;Belgique;Hainaut;nichees;chiens;chiots;chaumiere;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', './galerie.php', 3, 1, 1),
(10, '18 février 2005', 'Elevage;cockers Anglais;Belgique;Hainaut;nichees;chiens;chiots;chaumiere;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', './galerie.php', 3, 1, 2),
(11, '25 juin 2006', 'Elevage;cockers Anglais;Belgique;Hainaut;nichees;chiens;chiots;chaumiere;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', './galerie.php', 3, 1, 3),
(12, 'La nouvelle', 'Elevage;cockers Anglais;Belgique;Hainaut;nichees;chiens;chiots;chaumiere;', 'Elevage de cockers Anglais situé dans le Hainaut en Belgique', './nouvelle.php', 3, 1, 4);
