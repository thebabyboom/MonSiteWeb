-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Client :  localhost:3306
-- Généré le :  Mer 06 Février 2019 à 14:48
-- Version du serveur :  5.7.25-0ubuntu0.18.04.2
-- Version de PHP :  7.2.10-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `tuto`
--

-- --------------------------------------------------------

--
-- Structure de la table `configs`
--

CREATE TABLE `configs` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `medias`
--

CREATE TABLE `medias` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL COMMENT '		',
  `type` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `content` text,
  `create` datetime DEFAULT NULL,
  `online` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `slug` varchar(45) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `posts`
--

INSERT INTO `posts` (`id`, `name`, `content`, `create`, `online`, `type`, `slug`, `user_id`) VALUES
(1, 'Ma première page', '<div id=\"lipsum\">\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. In congue fermentum ornare. In rhoncus massa vitae ornare blandit. Sed ullamcorper lacus nec tristique imperdiet. Sed purus sem, eleifend non sagittis vitae, pharetra varius nibh. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris vitae tristique turpis, eu sodales sapien. Aliquam eu lectus ex. Mauris dapibus, augue et dapibus sodales, erat enim laoreet leo, sit amet sodales arcu tellus quis sem. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed non nulla ac tortor condimentum dapibus. Sed magna mi, porta ut lacinia varius, placerat vitae felis. Aenean nisl neque, pellentesque nec ex ac, laoreet porta massa. Curabitur et quam at mauris euismod tincidunt in et odio. Donec hendrerit volutpat mollis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.\r\n</p>\r\n<p>\r\nSuspendisse potenti. Nunc ac pulvinar lectus, non imperdiet sapien. Vivamus sit amet est enim. Curabitur ac turpis quam. Etiam volutpat mauris eget sapien egestas sollicitudin. Suspendisse non luctus ipsum. Nulla non varius elit.\r\n</p>\r\n<p>\r\nDonec accumsan lectus et tortor auctor dignissim. Aliquam viverra iaculis porta. Donec lacinia ultrices euismod. Curabitur sed nunc ut mi fringilla imperdiet nec id lectus. In iaculis, massa ullamcorper convallis consequat, elit sem viverra sapien, ac viverra magna nulla et quam. Vestibulum ultricies eu quam nec molestie. Curabitur commodo nibh sit amet laoreet posuere. Praesent neque elit, tristique vel lorem vitae, vestibulum mattis nisi. Suspendisse pellentesque sit amet metus eu condimentum.\r\n</p>\r\n<p>\r\nCras elit massa, commodo quis ex id, venenatis viverra erat. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Curabitur quis nibh velit. Morbi nec eros semper, efficitur turpis quis, tincidunt dui. Curabitur at accumsan turpis. In mattis urna ac felis aliquet feugiat a vel dolor. Nulla facilisi. Praesent auctor velit eu magna finibus ullamcorper. Cras nulla odio, faucibus ut vestibulum eleifend, scelerisque id urna. Pellentesque lobortis congue eleifend. Fusce suscipit bibendum ligula eu vestibulum. Proin efficitur turpis orci, pellentesque tempor magna eleifend ac. Duis sit amet arcu nec justo gravida efficitur eu lobortis felis. Phasellus nisl mi, cursus in neque sit amet, efficitur rutrum lectus.\r\n</p>\r\n<p>\r\nFusce malesuada commodo fringilla. Nullam suscipit vehicula dolor ultricies sagittis. Suspendisse ut tempus leo. Ut dapibus orci tortor, in condimentum diam interdum vitae. Vivamus a accumsan velit. Mauris varius lorem mauris, eget maximus mi commodo vitae. Donec in tellus rutrum, fringilla quam sit amet, consectetur sapien. Vivamus et magna tortor. Nulla laoreet elit eu lectus molestie tincidunt et a sem. Maecenas quis ullamcorper purus.\r\n</p></div>', '2018-12-31 00:00:00', 1, 'page', 'ma-premier-page', 0),
(2, 'Ma seconde page', 'Un second contenu bidon', '2018-12-31 17:30:00', 1, 'page', 'ma-seconde-page', 0),
(3, 'Mon premier article', '<div id=\"lipsum\">\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. In congue fermentum ornare. In rhoncus massa vitae ornare blandit. Sed ullamcorper lacus nec tristique imperdiet. Sed purus sem, eleifend non sagittis vitae, pharetra varius nibh. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris vitae tristique turpis, eu sodales sapien. Aliquam eu lectus ex. Mauris dapibus, augue et dapibus sodales, erat enim laoreet leo, sit amet sodales arcu tellus quis sem. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed non nulla ac tortor condimentum dapibus. Sed magna mi, porta ut lacinia varius, placerat vitae felis. Aenean nisl neque, pellentesque nec ex ac, laoreet porta massa. Curabitur et quam at mauris euismod tincidunt in et odio. Donec hendrerit volutpat mollis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.\r\n</p>\r\n<p>\r\nSuspendisse potenti. Nunc ac pulvinar lectus, non imperdiet sapien. Vivamus sit amet est enim. Curabitur ac turpis quam. Etiam volutpat mauris eget sapien egestas sollicitudin. Suspendisse non luctus ipsum. Nulla non varius elit.\r\n</p>\r\n<p>\r\nDonec accumsan lectus et tortor auctor dignissim. Aliquam viverra iaculis porta. Donec lacinia ultrices euismod. Curabitur sed nunc ut mi fringilla imperdiet nec id lectus. In iaculis, massa ullamcorper convallis consequat, elit sem viverra sapien, ac viverra magna nulla et quam. Vestibulum ultricies eu quam nec molestie. Curabitur commodo nibh sit amet laoreet posuere. Praesent neque elit, tristique vel lorem vitae, vestibulum mattis nisi. Suspendisse pellentesque sit amet metus eu condimentum.\r\n</p>\r\n<p>\r\nCras elit massa, commodo quis ex id, venenatis viverra erat. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Curabitur quis nibh velit. Morbi nec eros semper, efficitur turpis quis, tincidunt dui. Curabitur at accumsan turpis. In mattis urna ac felis aliquet feugiat a vel dolor. Nulla facilisi. Praesent auctor velit eu magna finibus ullamcorper. Cras nulla odio, faucibus ut vestibulum eleifend, scelerisque id urna. Pellentesque lobortis congue eleifend. Fusce suscipit bibendum ligula eu vestibulum. Proin efficitur turpis orci, pellentesque tempor magna eleifend ac. Duis sit amet arcu nec justo gravida efficitur eu lobortis felis. Phasellus nisl mi, cursus in neque sit amet, efficitur rutrum lectus.\r\n</p>\r\n<p>\r\nFusce malesuada commodo fringilla. Nullam suscipit vehicula dolor ultricies sagittis. Suspendisse ut tempus leo. Ut dapibus orci tortor, in condimentum diam interdum vitae. Vivamus a accumsan velit. Mauris varius lorem mauris, eget maximus mi commodo vitae. Donec in tellus rutrum, fringilla quam sit amet, consectetur sapien. Vivamus et magna tortor. Nulla laoreet elit eu lectus molestie tincidunt et a sem. Maecenas quis ullamcorper purus.\r\n</p></div>', '2018-12-31 00:00:00', 1, 'post', 'mon-premier-article', 0),
(4, 'Mon second article', 'Un second article bidon', '2018-12-31 17:30:00', 1, 'post', 'mon-seconde-article', 0);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `login` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `configs`
--
ALTER TABLE `configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- Index pour la table `medias`
--
ALTER TABLE `medias`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `configs`
--
ALTER TABLE `configs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `medias`
--
ALTER TABLE `medias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
