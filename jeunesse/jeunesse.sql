-- phpMyAdmin SQL Dump
-- version 2.9.2
-- http://www.phpmyadmin.net
-- 
-- Serveur: localhost
-- Généré le : Jeudi 12 Avril 2007 à 14:21
-- Version du serveur: 5.0.27
-- Version de PHP: 5.2.1
-- 
-- Base de données: `jeunesse`
-- 

-- --------------------------------------------------------

-- 
-- Structure de la table `commentaires`
-- 

CREATE TABLE `commentaires` (
  `id` int(11) NOT NULL auto_increment,
  `image_id` mediumint(8) NOT NULL,
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `author` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Contenu de la table `commentaires`
-- 


-- --------------------------------------------------------

-- 
-- Structure de la table `eve_coms`
-- 

CREATE TABLE `eve_coms` (
  `id` int(11) NOT NULL auto_increment,
  `image_id` mediumint(8) NOT NULL,
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `author` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `foreign` (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Contenu de la table `eve_coms`
-- 


-- --------------------------------------------------------

-- 
-- Structure de la table `eve_images`
-- 

CREATE TABLE `eve_images` (
  `id` mediumint(8) NOT NULL auto_increment,
  `img_file` varchar(255) NOT NULL,
  `img_path` varchar(255) NOT NULL,
  `cat_id` smallint(5) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `foreign` (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Contenu de la table `eve_images`
-- 
INSERT INTO `eve_images` (`id`, `img_file`, `img_path`, `cat_id`) VALUES 
(1, 'photo01', './galeries/13_04_07/', 3),
(2, 'photo02', './galeries/13_04_07/', 3),
(3, 'photo03', './galeries/13_04_07/', 3),
(4, 'photo04', './galeries/13_04_07/', 3),
(5, 'photo05', './galeries/13_04_07/', 3),
(6, 'photo06', './galeries/13_04_07/', 3),
(7, 'photo07', './galeries/13_04_07/', 3),
(8, 'photo08', './galeries/13_04_07/', 3),
(9, 'photo09', './galeries/13_04_07/', 3),
(10, 'photo10', './galeries/13_04_07/', 3),
(11, 'photo11', './galeries/13_04_07/', 3),
(12, 'photo12', './galeries/13_04_07/', 3),
(13, 'photo13', './galeries/13_04_07/', 3),
(14, 'photo14', './galeries/13_04_07/', 3),
(15, 'photo15', './galeries/13_04_07/', 3),
(16, 'photo16', './galeries/13_04_07/', 3),
(17, 'photo17', './galeries/13_04_07/', 3),
(18, 'photo18', './galeries/13_04_07/', 3),
(19, 'photo19', './galeries/13_04_07/', 3),
(20, 'photo20', './galeries/13_04_07/', 3),
(21, 'photo21', './galeries/13_04_07/', 3),
(22, 'photo22', './galeries/13_04_07/', 3),
(23, 'photo23', './galeries/13_04_07/', 3),
(24, 'photo24', './galeries/13_04_07/', 3),
(25, 'photo25', './galeries/13_04_07/', 3),
(26, 'photo26', './galeries/13_04_07/', 3),
(27, 'photo27', './galeries/13_04_07/', 3),
(28, 'photo28', './galeries/13_04_07/', 3),
(29, 'photo29', './galeries/13_04_07/', 3),
(30, 'photo30', './galeries/13_04_07/', 3),
(31, 'photo31', './galeries/13_04_07/', 3),
(32, 'photo32', './galeries/13_04_07/', 3),
(33, 'photo33', './galeries/13_04_07/', 3),
(34, 'photo34', './galeries/13_04_07/', 5),
(35, 'photo35', './galeries/13_04_07/', 3),
(36, 'photo36', './galeries/13_04_07/', 3),
(37, 'photo37', './galeries/13_04_07/', 3),
(38, 'photo38', './galeries/13_04_07/', 3),
(39, 'photo39', './galeries/13_04_07/', 3),
(40, 'photo40', './galeries/13_04_07/', 3),
(41, 'photo41', './galeries/13_04_07/', 3),
(42, 'photo42', './galeries/13_04_07/', 3),
(43, 'photo43', './galeries/13_04_07/', 3),
(44, 'photo44', './galeries/13_04_07/', 3),
(45, 'photo01', './galeries/Christian/', 4),
(46, 'photo02', './galeries/Christian/', 4),
(47, 'photo03', './galeries/Christian/', 4),
(48, 'photo04', './galeries/Christian/', 4),
(49, 'photo05', './galeries/Christian/', 4),
(50, 'photo06', './galeries/Christian/', 4),
(51, 'photo07', './galeries/Christian/', 4),
(52, 'photo08', './galeries/Christian/', 4),
(53, 'photo09', './galeries/Christian/', 4),
(54, 'photo10', './galeries/Christian/', 4),
(55, 'photo11', './galeries/Christian/', 4),
(56, 'photo12', './galeries/Christian/', 4),
(57, 'photo13', './galeries/Christian/', 4),
(58, 'photo14', './galeries/Christian/', 4),
(59, 'photo15', './galeries/Christian/', 4),
(60, 'photo16', './galeries/Christian/', 4),
(61, 'photo17', './galeries/Christian/', 4),
(62, 'photo18', './galeries/Christian/', 4),
(63, 'photo19', './galeries/Christian/', 4),
(64, 'photo20', './galeries/Christian/', 4),
(65, 'photo21', './galeries/Christian/', 4),
(66, 'photo22', './galeries/Christian/', 4),
(67, 'photo23', './galeries/Christian/', 4),
(68, 'photo24', './galeries/Christian/', 4),
(69, 'photo25', './galeries/Christian/', 4),
(70, 'photo26', './galeries/Christian/', 4),
(71, 'photo27', './galeries/Christian/', 4),
(72, 'photo28', './galeries/Christian/', 4),
(73, 'photo29', './galeries/Christian/', 4),
(74, 'photo30', './galeries/Christian/', 4),
(75, 'photo31', './galeries/Christian/', 4),
(76, 'photo32', './galeries/Christian/', 4),
(77, 'photo33', './galeries/Christian/', 4),
(78, 'photo34', './galeries/Christian/', 4),
(79, 'photo35', './galeries/Christian/', 4),
(80, 'photo36', './galeries/Christian/', 4),
(81, 'photo37', './galeries/Christian/', 4),
(82, 'photo38', './galeries/Christian/', 4),
(83, 'photo39', './galeries/Christian/', 4),
(84, 'photo40', './galeries/Christian/', 4),
(85, 'photo41', './galeries/Christian/', 4),
(86, 'photo42', './galeries/Christian/', 4),
(87, 'photo43', './galeries/Christian/', 4),
(88, 'photo44', './galeries/Christian/', 4),
(89, 'photo45', './galeries/Christian/', 4),
(90, 'photo46', './galeries/Christian/', 4),
(91, 'photo47', './galeries/Christian/', 4),
(92, 'photo48', './galeries/Christian/', 4),
(93, 'photo49', './galeries/Christian/', 4),
(94, 'photo50', './galeries/Christian/', 4),
(95, 'photo51', './galeries/Christian/', 4),
(96, 'photo52', './galeries/Christian/', 4),
(97, 'photo53', './galeries/Christian/', 4),
(98, 'photo54', './galeries/Christian/', 4),
(99, 'photo55', './galeries/Christian/', 4);

-- --------------------------------------------------------

-- 
-- Structure de la table `evenement`
-- 

CREATE TABLE `evenement` (
  `id` smallint(5) NOT NULL auto_increment,
  `nb_image` mediumint(8) NOT NULL,
  `name` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `photo` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- 
-- Contenu de la table `evenement`
-- 

INSERT INTO `evenement` (`id`, `nb_image`, `name`, `date`, `description`, `photo`) VALUES 
(1, 0, 'Souper', '', '', '#'),
(2, 0, 'Souper', '', '', '#'),
(3, 0, 'Soirée Aquarium', 'Le 13 Avril 2007', 'Venez tenter votre chance!!\r\n\r\nNotre première soirée à l''aquarium.', './galeries/13_04_07/afficheaqua.jpg'),
(4, 0, 'Soirée Christian', 'Le 28 Avril 2007', 'Soirée en l honneur de Christian Sieuw, le patron des Genets à St-Sauveur, pour son départ en Auvergne.','./galeries/Christian/photo00.jpg');

-- --------------------------------------------------------

-- 
-- Structure de la table `goldbook`
-- 

CREATE TABLE `goldbook` (
  `id` smallint(6) NOT NULL auto_increment,
  `Nom` varchar(50) NOT NULL,
  `Message` text NOT NULL,
  `email` varchar(255) NOT NULL,
  `ip_add` varchar(20) NOT NULL,
  `msg_date` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Contenu de la table `goldbook`
-- 


-- --------------------------------------------------------

-- 
-- Structure de la table `goodies`
-- 

CREATE TABLE `goodies` (
  `id` smallint(6) NOT NULL auto_increment,
  `img_file` varchar(255) NOT NULL,
  `img_path` varchar(255) NOT NULL,
  `cat_id` smallint(6) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- 
-- Contenu de la table `goodies`
-- 

INSERT INTO `goodies` (`id`, `img_file`, `img_path`, `cat_id`) VALUES 
(1, 'logowallpaper', './galeries/goodies/', 0),
(2, 'logoblended', './galeries/goodies/', 0),
(3, 'logochrome', './galeries/goodies/', 0),
(4, 'logofluo', './galeries/goodies/', 0),
(5, 'logogradient', './galeries/goodies/', 0),
(6, 'logolueur', './galeries/goodies/', 0),
(7, 'LogoNoir', './galeries/goodies/', 0),
(8, 'logorelief', './galeries/goodies/', 0),
(9, 'logotexture', './galeries/goodies/', 0);

-- --------------------------------------------------------

-- 
-- Structure de la table `membres`
-- 

CREATE TABLE `membres` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(20) NOT NULL,
  `passwd` varchar(12) NOT NULL,
  `role` varchar(10) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- 
-- Contenu de la table `membres`
-- 

INSERT INTO `membres` (`id`, `login`, `passwd`, `role`) VALUES 
(1, 'nounours', 'schuldig', 'admin'),
(2, 'test', 'pass', 'user');

-- --------------------------------------------------------

-- 
-- Structure de la table `part_coms`
-- 

CREATE TABLE `part_coms` (
  `id` int(11) NOT NULL auto_increment,
  `image_id` mediumint(8) NOT NULL,
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `author` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Contenu de la table `part_coms`
-- 


-- --------------------------------------------------------

-- 
-- Structure de la table `part_images`
-- 

CREATE TABLE `part_images` (
  `id` mediumint(8) NOT NULL auto_increment,
  `img_file` varchar(255) NOT NULL,
  `img_path` varchar(255) NOT NULL,
  `cat_id` smallint(5) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=50 ;

-- 
-- Contenu de la table `part_images`
-- 

INSERT INTO `part_images` (`id`, `img_file`, `img_path`, `cat_id`) VALUES 
(1, 'photo01', './galeries/reves_enfant/', 5),
(2, 'photo02', './galeries/reves_enfant/', 5),
(3, 'photo03', './galeries/reves_enfant/', 5),
(4, 'photo04', './galeries/reves_enfant/', 5),
(5, 'photo05', './galeries/reves_enfant/', 5),
(6, 'photo06', './galeries/reves_enfant/', 5),
(7, 'photo07', './galeries/reves_enfant/', 5),
(8, 'photo08', './galeries/reves_enfant/', 5),
(9, 'photo09', './galeries/reves_enfant/', 5),
(10, 'photo10', './galeries/reves_enfant/', 5),
(11, 'photo11', './galeries/reves_enfant/', 5),
(12, 'photo12', './galeries/reves_enfant/', 5),
(13, 'photo13', './galeries/reves_enfant/', 5),
(14, 'photo14', './galeries/reves_enfant/', 5),
(15, 'photo15', './galeries/reves_enfant/', 5),
(16, 'photo16', './galeries/reves_enfant/', 5),
(17, 'photo17', './galeries/reves_enfant/', 5),
(18, 'photo18', './galeries/reves_enfant/', 5),
(19, 'photo19', './galeries/reves_enfant/', 5),
(20, 'photo20', './galeries/reves_enfant/', 5),
(21, 'photo21', './galeries/reves_enfant/', 5),
(22, 'photo22', './galeries/reves_enfant/', 5),
(23, 'photo23', './galeries/reves_enfant/', 5),
(24, 'photo24', './galeries/reves_enfant/', 5),
(25, 'photo25', './galeries/reves_enfant/', 5),
(26, 'photo26', './galeries/reves_enfant/', 5),
(27, 'photo27', './galeries/reves_enfant/', 5),
(28, 'photo28', './galeries/reves_enfant/', 5),
(29, 'photo29', './galeries/reves_enfant/', 5),
(30, 'photo30', './galeries/reves_enfant/', 5),
(31, 'photo31', './galeries/reves_enfant/', 5),
(32, 'photo32', './galeries/reves_enfant/', 5),
(33, 'photo33', './galeries/reves_enfant/', 5),
(34, 'photo34', './galeries/reves_enfant/', 5),
(35, 'photo35', './galeries/reves_enfant/', 5),
(36, 'photo36', './galeries/reves_enfant/', 5),
(37, 'photo37', './galeries/reves_enfant/', 5),
(38, 'photo38', './galeries/reves_enfant/', 5),
(39, 'photo39', './galeries/reves_enfant/', 5),
(40, 'photo40', './galeries/reves_enfant/', 5),
(41, 'photo41', './galeries/reves_enfant/', 5),
(42, 'photo42', './galeries/reves_enfant/', 5),
(43, 'photo43', './galeries/reves_enfant/', 5),
(44, 'photo44', './galeries/reves_enfant/', 5),
(45, 'photo45', './galeries/reves_enfant/', 5),
(46, 'photo46', './galeries/reves_enfant/', 5),
(47, 'photo47', './galeries/reves_enfant/', 5),
(48, 'photo48', './galeries/reves_enfant/', 5),
(49, 'photo49', './galeries/reves_enfant/', 5);

-- --------------------------------------------------------

-- 
-- Structure de la table `participation`
-- 

CREATE TABLE `participation` (
  `id` smallint(5) NOT NULL auto_increment,
  `nb_image` mediumint(8) NOT NULL,
  `name` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `photo` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- 
-- Contenu de la table `participation`
-- 

INSERT INTO `participation` (`id`, `nb_image`, `name`, `date`, `description`, `photo`) VALUES 
(1, 0, 'Cuistax 2005', 'Aout 2005', '6 heures de cuistax.<br/>\r\nOrganisé par le racing team sur la place de Saint-Sauveur.', '#'),
(2, 0, 'Halloween 2005', 'Octobre 2005', 'Le comité d''Halloween, nous a demander si nous voulions bien participer en tant que figurants pour la ballade terrifiante.\r\n<br/>\r\nNous avons un petit bosquet au milieu des champs que nous pouvions décorer a notre façon.', '#'),
(3, 0, 'Cuistax 2006', 'Aout 2006', '6 heures de cuistax.<br/> Organisé par le racing team sur la place de Saint-Sauveur.', '#'),
(4, 0, 'Halloween 2006', '21 Octobre 2006', 'Vu le succès de l''année passée on remet ça cette année.<br/>\r\nOn n''a plus le droit au bosquet, cette fois ci nous sommes dans le champs le long du site.', '#'),
(5, 49, 'Rêves d''enfants', '11 Novembre 2006', 'Olivier et sa femme veulent organisés un souper pour récolter des fonds pour l''association "rêves d''enfants".\r\n<br/>\r\nPour ce faire, ils ont besoin de notre aide.', './galeries/reves_enfant/Page0.jpg');

-- 
-- Contraintes pour les tables exportées
-- 

-- 
-- Contraintes pour la table `eve_coms`
-- 
ALTER TABLE `eve_coms`
  ADD CONSTRAINT `eve_coms_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `eve_images` (`id`);

-- 
-- Contraintes pour la table `eve_images`
-- 
ALTER TABLE `eve_images`
  ADD CONSTRAINT `eve_images_ibfk_3` FOREIGN KEY (`id`) REFERENCES `eve_coms` (`image_id`);
