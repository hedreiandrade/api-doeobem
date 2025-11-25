-- --------------------------------------------------------
-- Servidor:                     localhost
-- Versão do servidor:           5.7.22 - MySQL Community Server (GPL)
-- OS do Servidor:               Linux
-- HeidiSQL Versão:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para api-doeobem
CREATE DATABASE IF NOT EXISTS `api-doeobem` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `api-doeobem`;

-- Copiando estrutura para tabela api-doeobem.comments
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `post_id` (`post_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela api-doeobem.comments: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` (`id`, `post_id`, `user_id`, `comment`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 5, 'Demais! ❤', '2025-11-24 23:09:58', '2025-11-24 23:09:58', NULL),
	(2, 4, 5, 'Top !', '2025-11-24 23:10:06', '2025-11-24 23:10:06', NULL),
	(3, 1, 6, 'Lindo!', '2025-11-24 23:10:31', '2025-11-24 23:10:31', NULL),
	(4, 8, 233, 'Olha eu aí!', '2025-11-24 23:10:56', '2025-11-24 23:10:56', NULL),
	(5, 5, 233, 'Qaul é ?', '2025-11-24 23:11:21', '2025-11-25 02:11:23', '2025-11-25 02:11:23'),
	(6, 5, 233, 'Qual é ?', '2025-11-24 23:11:27', '2025-11-24 23:11:27', NULL),
	(7, 4, 3, 'Amei!', '2025-11-24 23:12:30', '2025-11-24 23:12:30', NULL),
	(8, 1, 3, 'Show!', '2025-11-24 23:12:40', '2025-11-24 23:12:40', NULL);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;

-- Copiando estrutura para tabela api-doeobem.followers
CREATE TABLE IF NOT EXISTS `followers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `follower_id` int(11) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_follower_id` (`follower_id`),
  CONSTRAINT `fk_followers_follower` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_followers_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela api-doeobem.followers: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` (`id`, `user_id`, `follower_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 233, 2, '2025-11-25 01:49:39', '2025-11-25 01:49:39', NULL),
	(2, 233, 3, '2025-11-25 01:49:59', '2025-11-25 01:49:59', NULL),
	(3, 2, 3, '2025-11-25 01:50:07', '2025-11-25 01:50:07', NULL),
	(4, 4, 3, '2025-11-25 01:50:40', '2025-11-25 01:50:40', NULL),
	(5, 233, 4, '2025-11-25 01:51:15', '2025-11-25 01:51:15', NULL),
	(6, 2, 4, '2025-11-25 01:51:23', '2025-11-25 01:51:23', NULL),
	(7, 3, 4, '2025-11-25 01:51:29', '2025-11-25 01:51:29', NULL),
	(8, 2, 5, '2025-11-25 01:51:55', '2025-11-25 01:51:55', NULL),
	(9, 233, 5, '2025-11-25 01:52:02', '2025-11-25 01:52:02', NULL),
	(10, 3, 5, '2025-11-25 01:52:08', '2025-11-25 01:52:08', NULL),
	(11, 233, 6, '2025-11-25 01:52:27', '2025-11-25 01:52:27', NULL),
	(12, 2, 233, '2025-11-25 01:52:51', '2025-11-25 01:52:51', NULL),
	(13, 3, 233, '2025-11-25 01:52:55', '2025-11-25 01:52:55', NULL),
	(14, 6, 233, '2025-11-25 01:53:02', '2025-11-25 01:53:02', NULL),
	(15, 5, 233, '2025-11-25 01:53:09', '2025-11-25 01:53:09', NULL),
	(16, 3, 2, '2025-11-25 02:08:51', '2025-11-25 02:08:51', NULL);
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;

-- Copiando estrutura para tabela api-doeobem.likes
CREATE TABLE IF NOT EXISTS `likes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  KEY `id` (`id`),
  KEY `FK_likes_posts` (`post_id`),
  KEY `FK_likes_users` (`user_id`),
  CONSTRAINT `FK_likes_posts` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_likes_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela api-doeobem.likes: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` (`id`, `post_id`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 233, '2025-11-24 22:58:28', '2025-11-24 22:58:29', '2025-11-24 22:58:29'),
	(2, 9, 5, '2025-11-25 02:09:38', '2025-11-25 02:09:38', NULL),
	(3, 8, 5, '2025-11-25 02:09:40', '2025-11-25 02:09:40', NULL),
	(4, 6, 5, '2025-11-25 02:09:41', '2025-11-25 02:09:41', NULL),
	(5, 5, 5, '2025-11-25 02:09:42', '2025-11-25 02:09:42', NULL),
	(6, 4, 5, '2025-11-25 02:09:43', '2025-11-25 02:09:43', NULL),
	(7, 1, 5, '2025-11-25 02:09:44', '2025-11-25 02:09:44', NULL),
	(8, 1, 6, '2025-11-25 02:10:24', '2025-11-25 02:10:24', NULL),
	(9, 9, 233, '2025-11-25 02:10:45', '2025-11-25 02:10:45', NULL),
	(10, 8, 233, '2025-11-25 02:10:50', '2025-11-25 02:10:50', NULL),
	(11, 4, 233, '2025-11-25 02:11:04', '2025-11-25 02:11:04', NULL),
	(12, 1, 233, '2025-11-25 02:11:07', '2025-11-25 02:11:08', '2025-11-25 02:11:08'),
	(13, 5, 233, '2025-11-25 02:11:16', '2025-11-25 02:11:16', NULL),
	(14, 9, 3, '2025-11-25 02:12:21', '2025-11-25 02:12:21', NULL),
	(15, 8, 3, '2025-11-25 02:12:21', '2025-11-25 02:12:21', NULL),
	(16, 6, 3, '2025-11-25 02:12:22', '2025-11-25 02:12:22', NULL),
	(17, 5, 3, '2025-11-25 02:12:24', '2025-11-25 02:12:24', NULL),
	(18, 4, 3, '2025-11-25 02:12:25', '2025-11-25 02:12:25', NULL),
	(19, 1, 3, '2025-11-25 02:12:42', '2025-11-25 02:12:42', NULL);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;

-- Copiando estrutura para tabela api-doeobem.posts
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `description` text COLLATE utf8mb4_unicode_ci,
  `media_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela api-doeobem.posts: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` (`id`, `description`, `media_link`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Meu video psycho', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6924e2f1909f67.26412208.mp4', '2025-11-24 19:57:57', '2025-11-24 19:57:57', NULL),
	(2, 'teste', 'http://localhost:8015/public/imagesVideos/media/media_6924e85b1aaac5.47538364.mp4', '2025-11-24 20:20:59', '2025-11-24 23:21:17', '2025-11-24 23:21:17'),
	(3, 'teste ', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6924f6d590be04.81222102.mp4', '2025-11-24 21:22:59', '2025-11-25 00:23:13', '2025-11-25 00:23:13'),
	(4, 'Olha que video massa !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_69250c633ce117.48206824.mp4', '2025-11-24 22:54:59', '2025-11-24 22:54:59', NULL),
	(5, 'Ouvindo minha música favorita :)', '', '2025-11-24 22:55:32', '2025-11-24 22:55:32', NULL),
	(6, 'Assistindo Star Wars !! ❤', '', '2025-11-24 23:05:49', '2025-11-24 23:05:49', NULL),
	(7, 'Mais um video legal !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_69250f31aa9833.08086824.mp4', '2025-11-24 23:06:55', '2025-11-25 02:07:17', '2025-11-25 02:07:17'),
	(8, 'Mais um video legal !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_69250f6691ed56.10054038.mp4', '2025-11-24 23:07:45', '2025-11-24 23:07:45', NULL),
	(9, 'Bom dia pessoal !!', '', '2025-11-24 23:08:11', '2025-11-24 23:08:11', NULL),
	(10, 'Hoje tem jogo do Palmeiras ✔', '', '2025-11-24 23:13:37', '2025-11-24 23:13:37', NULL);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;

-- Copiando estrutura para tabela api-doeobem.posts_users
CREATE TABLE IF NOT EXISTS `posts_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `post_id` int(11) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `FK__posts` (`post_id`),
  CONSTRAINT `FK__posts` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK__users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela api-doeobem.posts_users: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `posts_users` DISABLE KEYS */;
INSERT INTO `posts_users` (`id`, `user_id`, `post_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 233, 1, '2025-11-24 19:57:57', '2025-11-24 19:57:57', NULL),
	(2, 233, 2, '2025-11-24 20:20:59', '2025-11-24 20:20:59', NULL),
	(3, 233, 3, '2025-11-24 21:22:59', '2025-11-24 21:22:59', NULL),
	(4, 2, 4, '2025-11-24 22:54:59', '2025-11-24 22:54:59', NULL),
	(5, 2, 5, '2025-11-24 22:55:32', '2025-11-24 22:55:32', NULL),
	(6, 2, 6, '2025-11-24 23:05:49', '2025-11-24 23:05:49', NULL),
	(7, 2, 7, '2025-11-24 23:06:55', '2025-11-24 23:06:55', NULL),
	(8, 2, 8, '2025-11-24 23:07:45', '2025-11-24 23:07:45', NULL),
	(9, 2, 9, '2025-11-24 23:08:11', '2025-11-24 23:08:11', NULL),
	(10, 233, 10, '2025-11-24 23:13:37', '2025-11-24 23:13:37', NULL);
/*!40000 ALTER TABLE `posts_users` ENABLE KEYS */;

-- Copiando estrutura para tabela api-doeobem.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `nickname` varchar(40) COLLATE utf8_bin DEFAULT NULL,
  `phone1` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `has_whatsapp` tinyint(1) DEFAULT '0',
  `phone2` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(200) COLLATE utf8_bin NOT NULL,
  `postal_code` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `street` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `number` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `complement` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `neighborhood` varchar(90) COLLATE utf8_bin DEFAULT NULL,
  `city` varchar(90) COLLATE utf8_bin DEFAULT NULL,
  `state` char(3) COLLATE utf8_bin DEFAULT NULL,
  `country` char(2) COLLATE utf8_bin DEFAULT NULL,
  `recovery_key` char(32) COLLATE utf8_bin DEFAULT NULL,
  `first_access` datetime DEFAULT NULL,
  `last_access` datetime DEFAULT NULL,
  `access_count` int(4) unsigned DEFAULT NULL,
  `receive_newsletter` tinyint(1) DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `userscol` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `photo` varchar(800) COLLATE utf8_bin DEFAULT NULL,
  `cover_photo` varchar(800) COLLATE utf8_bin DEFAULT NULL,
  `google_id` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `facebook_id` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `auth_provider` enum('local','google','facebook') COLLATE utf8_bin DEFAULT 'local',
  `email_verified` tinyint(1) DEFAULT '0',
  `verified_profile` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `google_id_UNIQUE` (`google_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `facebook_id` (`facebook_id`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela api-doeobem.users: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `nickname`, `phone1`, `has_whatsapp`, `phone2`, `email`, `password`, `postal_code`, `street`, `number`, `complement`, `neighborhood`, `city`, `state`, `country`, `recovery_key`, `first_access`, `last_access`, `access_count`, `receive_newsletter`, `active`, `created_at`, `updated_at`, `deleted_at`, `userscol`, `photo`, `cover_photo`, `google_id`, `facebook_id`, `auth_provider`, `email_verified`, `verified_profile`) VALUES
	(2, 'Calebe', NULL, NULL, 0, NULL, 'calebe@gmail.com', '$2y$10$RLe8jkyB73i5KNYnFRiR5efclCwowVvD1KaQwCDTJqYfRrsayIVx6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', 2, 0, 1, '2025-11-24 13:26:09', '2025-11-25 01:54:12', NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/1be21001e4647d409c73c9e2bb350bf1_calebe/1993258390eu4bm.jpg', 'https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_calebe/1607179466capasound.jpg', NULL, NULL, 'local', 1, 0),
	(3, 'Iasmin Cora', NULL, NULL, 0, NULL, 'iasmin@gmail.com', '$2y$10$RLe8jkyB73i5KNYnFRiR5efclCwowVvD1KaQwCDTJqYfRrsayIVx6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', 2, 0, 1, '2025-11-24 13:26:09', '2025-11-25 01:49:51', NULL, NULL, '', '', NULL, NULL, 'local', 1, 0),
	(4, 'Marcos Bastista', NULL, NULL, 0, NULL, 'marcos@gmail.com', '$2y$10$RLe8jkyB73i5KNYnFRiR5efclCwowVvD1KaQwCDTJqYfRrsayIVx6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', 2, 0, 1, '2025-11-24 13:26:09', '2025-11-25 01:51:07', NULL, NULL, '', '', NULL, NULL, 'local', 1, 0),
	(5, 'Andre ', NULL, NULL, 0, NULL, 'andre@gmail.com', '$2y$10$RLe8jkyB73i5KNYnFRiR5efclCwowVvD1KaQwCDTJqYfRrsayIVx6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', 2, 0, 1, '2025-11-24 13:26:09', '2025-11-25 02:09:32', NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/df8bcc50f015de8677e4025ecb1a369a_andre/1087917545eu3.jpg', '', NULL, NULL, 'local', 1, 0),
	(6, 'Jeniffer Cora', NULL, NULL, 0, NULL, 'jeniffer@gmail.com', '$2y$10$RLe8jkyB73i5KNYnFRiR5efclCwowVvD1KaQwCDTJqYfRrsayIVx6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', 2, 0, 1, '2025-11-24 13:26:09', '2025-11-25 01:52:16', NULL, NULL, '', '', NULL, NULL, 'local', 1, 0),
	(233, 'Hedrei Andrade', NULL, NULL, 0, NULL, 'hedreiandrade@gmail.com', '$2y$10$RLe8jkyB73i5KNYnFRiR5efclCwowVvD1KaQwCDTJqYfRrsayIVx6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', 2, 0, 1, '2025-11-24 13:26:09', '2025-11-25 01:52:46', NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_hedreiandrade/2048186498ha.jpg', 'https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/2075300663capayoutube.jpg', NULL, NULL, 'local', 1, 0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
