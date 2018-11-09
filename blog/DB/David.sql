-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Client :  localhost:3306
-- Généré le :  Sam 09 Juin 2018 à 18:58
-- Version du serveur :  5.7.22-0ubuntu18.04.1
-- Version de PHP :  7.2.3-1ubuntu1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `David`
--
CREATE DATABASE IF NOT EXISTS `David` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `David`;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`) VALUES
(1, 'Test1', 'test1'),
(2, 'Test2', 'test2');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997');

-- --------------------------------------------------------

--
-- Structure de la table `works`
--

CREATE TABLE `works` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `works`
--

INSERT INTO `works` (`id`, `name`, `slug`, `content`, `category_id`) VALUES
(1, 'Portfolio', 'portfolio', '<h1>I\'m real proud of you for coming, bro. I know you hate funerals.</h1>\r\n<p>Keep your mind limber. Makes me a â€¦ scientist. I\'m going to tell you something that I\'ve never told anyone before. Pretend. You pretend the feelings are there, for the world, for the people around you. Who knows? Maybe one day they will be.</p>\r\n<p>This man is a knight in shining armor. Only you could make those words cute. I am not a killer. <strong> God created pudding, and then he rested.</strong> <em> Like a sloth.</em> I can do that.</p>\r\n<h2>Hello, Dexter Morgan.</h2>\r\n<p>Finding a needle in a haystack isn\'t hard when every straw is computerized. I have a dark side, too. I think he\'s got a crush on you, Dex! Cops, another community I\'m not part of.</p>\r\n<ol>\r\n\r\n    <li>Keep your mind limber.</li><li>Oh I beg to differ, I think we have a lot to discuss. After all, you are a client.</li><li>This man is a knight in shining armor.</li>\r\n\r\n</ol>', 1),
(2, 'portfolio2', 'portfolio2', '<h3>I\'m Dexter, and I\'m not sure what I am.</h3>\r\n<p>I\'m really more an apartment person. He taught me a code. To survive. Makes me a â€¦ scientist. God created pudding, and then he rested. I\'m really more an apartment person.</p>\r\n<ul>\r\n\r\n    <li>I like seafood.</li><li>I\'m really more an apartment person.</li><li>You\'re a killer. I catch killers.</li>\r\n\r\n</ul>', 2);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `works`
--
ALTER TABLE `works`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `works`
--
ALTER TABLE `works`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
