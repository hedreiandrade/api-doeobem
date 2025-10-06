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
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela api-doeobem.comments: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` (`id`, `post_id`, `user_id`, `comment`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(55, 1, 85, '1', '2025-09-30 20:10:07', '2025-09-30 20:25:20', '2025-09-30 20:25:20'),
	(64, 1, 84, 'Foi massa a viagem ?', '2025-09-30 20:28:55', '2025-10-03 20:28:24', '2025-10-03 20:28:24'),
	(65, 6, 84, 'Gostei desse assunto, me conta mais ?', '2025-09-30 20:29:38', '2025-09-30 20:29:38', NULL),
	(66, 6, 85, 'Depois te mando outro video. 😎', '2025-09-30 20:30:24', '2025-10-03 20:50:58', '2025-10-03 20:50:58'),
	(67, 1, 85, 'Foi legal!', '2025-09-30 21:05:33', '2025-10-03 21:24:51', '2025-10-03 21:24:51'),
	(68, 1, 85, 'tet', '2025-10-03 20:24:21', '2025-10-03 20:29:13', '2025-10-03 20:29:13'),
	(69, 1, 84, 'Foi massa a viagem', '2025-10-03 20:29:01', '2025-10-03 20:29:01', NULL),
	(70, 13, 85, 'kkkk', '2025-10-03 20:30:25', '2025-10-03 20:52:02', '2025-10-03 20:52:02'),
	(71, 11, 86, 'Boa noite', '2025-10-03 20:31:44', '2025-10-03 20:31:44', NULL),
	(72, 6, 86, 'Boa noite', '2025-10-03 20:31:49', '2025-10-05 00:10:40', '2025-10-05 00:10:40'),
	(73, 1, 86, 'kkkk', '2025-10-03 20:32:58', '2025-10-04 00:11:33', '2025-10-04 00:11:33'),
	(74, 1, 85, 'obabaa', '2025-10-03 20:34:53', '2025-10-03 21:24:50', '2025-10-03 21:24:50'),
	(75, 6, 85, 'Boa noite', '2025-10-03 20:51:11', '2025-10-05 00:10:26', '2025-10-05 00:10:26'),
	(76, 13, 85, 'OI :)', '2025-10-03 20:52:07', '2025-10-03 21:06:00', '2025-10-03 21:06:00'),
	(77, 11, 85, 'Está funcionando', '2025-10-03 20:52:21', '2025-10-03 20:54:03', '2025-10-03 20:54:03'),
	(78, 11, 84, 'Está funcionando', '2025-10-03 20:52:55', '2025-10-03 20:52:55', NULL),
	(79, 13, 85, 'OI', '2025-10-03 21:05:58', '2025-10-04 00:08:51', '2025-10-04 00:08:51'),
	(80, 19, 85, 'Massa', '2025-10-03 21:07:52', '2025-10-04 00:08:55', '2025-10-04 00:08:55'),
	(81, 13, 85, 'dsadada', '2025-10-03 21:21:24', '2025-10-03 21:25:36', '2025-10-03 21:25:36'),
	(82, 13, 85, '3', '2025-10-03 21:25:08', '2025-10-03 21:25:35', '2025-10-03 21:25:35'),
	(83, 13, 85, '4', '2025-10-03 21:25:10', '2025-10-03 21:25:34', '2025-10-03 21:25:34'),
	(84, 13, 85, '5', '2025-10-03 21:25:12', '2025-10-03 21:25:33', '2025-10-03 21:25:33'),
	(85, 13, 85, '6', '2025-10-03 21:25:14', '2025-10-03 21:25:23', '2025-10-03 21:25:23'),
	(86, 13, 85, '7', '2025-10-03 21:25:19', '2025-10-03 21:25:22', '2025-10-03 21:25:22'),
	(87, 13, 85, '8', '2025-10-03 21:25:30', '2025-10-03 21:25:32', '2025-10-03 21:25:32'),
	(88, 1, 85, 'teste', '2025-10-04 00:01:01', '2025-10-04 00:01:02', '2025-10-04 00:01:02'),
	(89, 19, 85, 'dsadsada', '2025-10-04 00:08:44', '2025-10-04 00:09:15', '2025-10-04 00:09:15'),
	(90, 13, 85, 'dsada', '2025-10-04 00:08:47', '2025-10-04 00:11:53', '2025-10-04 00:11:53'),
	(91, 19, 85, 'Boa noite!', '2025-10-04 00:11:59', '2025-10-05 00:14:11', '2025-10-05 00:14:11'),
	(92, 19, 86, 'Parabéns ! ✔', '2025-10-05 00:12:01', '2025-10-05 00:12:01', NULL),
	(93, 6, 86, 'Nossa adorei o designer! ❤', '2025-10-05 00:12:30', '2025-10-05 00:12:30', NULL),
	(94, 1, 86, 'Foi para onde ?', '2025-10-05 00:12:50', '2025-10-05 00:12:50', NULL),
	(95, 13, 85, 'OI', '2025-10-05 00:14:20', '2025-10-05 08:15:01', '2025-10-05 08:15:01'),
	(96, 13, 85, 'oi', '2025-10-05 08:15:08', '2025-10-06 08:27:33', '2025-10-06 08:27:33'),
	(97, 22, 85, 'hahaha', '2025-10-05 17:27:22', '2025-10-05 17:27:22', NULL),
	(98, 19, 85, 'oioio', '2025-10-06 08:23:06', '2025-10-06 08:23:08', '2025-10-06 08:23:08'),
	(99, 1, 85, '3', '2025-10-06 08:23:34', '2025-10-06 08:23:49', '2025-10-06 08:23:49'),
	(100, 1, 85, '4', '2025-10-06 08:23:36', '2025-10-06 08:23:47', '2025-10-06 08:23:47'),
	(101, 1, 85, '5', '2025-10-06 08:23:41', '2025-10-06 08:23:51', '2025-10-06 08:23:51'),
	(102, 1, 85, '6', '2025-10-06 08:23:43', '2025-10-06 08:23:46', '2025-10-06 08:23:46'),
	(103, 19, 85, 'OI', '2025-10-06 08:27:58', '2025-10-06 08:28:15', '2025-10-06 08:28:15'),
	(104, 24, 85, 'Me conta mais ? 💕', '2025-10-06 12:55:11', '2025-10-06 12:55:11', NULL),
	(105, 24, 86, 'TOP !', '2025-10-06 12:56:17', '2025-10-06 12:56:17', NULL),
	(106, 23, 86, 'Dia de primaveira !', '2025-10-06 12:56:36', '2025-10-06 12:56:44', '2025-10-06 12:56:44'),
	(107, 23, 86, 'Vamos pescar ?', '2025-10-06 12:56:52', '2025-10-06 12:56:52', NULL),
	(108, 19, 85, 'Parabéns ! 😎', '2025-10-06 12:57:41', '2025-10-06 12:57:41', NULL),
	(109, 1, 85, 'Foi massa!', '2025-10-06 12:57:58', '2025-10-06 12:57:58', NULL),
	(110, 24, 89, 'Que designer lindo !!', '2025-10-06 12:59:43', '2025-10-06 12:59:43', NULL),
	(111, 6, 89, 'Parabéns !', '2025-10-06 13:00:09', '2025-10-06 13:00:09', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela api-doeobem.followers: ~49 rows (aproximadamente)
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` (`id`, `user_id`, `follower_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 85, 84, '2025-03-30 03:12:43', NULL, NULL),
	(2, 84, 85, '2025-03-30 03:22:14', '2025-09-21 23:03:17', '2025-09-21 23:03:17'),
	(3, 86, 85, '2025-03-30 03:22:15', NULL, NULL),
	(4, 85, 86, '2025-03-30 03:22:15', NULL, NULL),
	(5, 60, 85, '2025-03-30 03:22:13', '2025-09-21 23:17:16', '2025-09-21 23:17:16'),
	(6, 85, 88, NULL, NULL, NULL),
	(9, 85, 93, NULL, NULL, NULL),
	(10, 85, 96, NULL, NULL, NULL),
	(11, 85, 95, NULL, NULL, NULL),
	(12, 85, 94, NULL, NULL, NULL),
	(13, 85, 60, NULL, NULL, NULL),
	(14, 85, 97, NULL, NULL, NULL),
	(15, 85, 98, NULL, NULL, NULL),
	(16, 85, 99, NULL, NULL, NULL),
	(17, 85, 100, NULL, NULL, NULL),
	(18, 85, 102, NULL, NULL, NULL),
	(19, 85, 101, NULL, NULL, NULL),
	(20, 85, 103, NULL, NULL, NULL),
	(21, 85, 104, NULL, NULL, NULL),
	(22, 85, 105, NULL, NULL, NULL),
	(23, 85, 106, NULL, NULL, NULL),
	(24, 85, 107, NULL, NULL, NULL),
	(25, 85, 108, NULL, '2025-09-25 13:04:24', '2025-09-25 13:04:24'),
	(27, 85, 110, NULL, NULL, NULL),
	(28, 85, 111, NULL, NULL, NULL),
	(29, 85, 112, NULL, NULL, NULL),
	(30, 85, 113, NULL, NULL, NULL),
	(31, 93, 85, '2025-03-30 03:22:13', '2025-09-21 23:03:53', '2025-09-21 23:03:53'),
	(32, 99, 85, '2025-03-30 03:22:13', NULL, NULL),
	(33, 106, 85, '2025-03-30 03:22:13', '2025-09-24 00:23:32', '2025-09-24 00:23:32'),
	(35, 84, 85, '2025-09-21 23:03:41', '2025-09-21 23:09:46', '2025-09-21 23:09:46'),
	(36, 93, 85, '2025-09-21 23:03:56', '2025-09-21 23:03:57', '2025-09-21 23:03:57'),
	(37, 84, 85, '2025-09-21 23:09:47', '2025-09-21 23:10:27', '2025-09-21 23:10:27'),
	(38, 84, 85, '2025-09-21 23:10:28', '2025-09-21 23:17:56', '2025-09-21 23:17:56'),
	(39, 60, 85, '2025-09-21 23:17:23', '2025-09-21 23:17:26', '2025-09-21 23:17:26'),
	(40, 60, 85, '2025-09-21 23:17:27', '2025-09-21 23:17:28', '2025-09-21 23:17:28'),
	(41, 60, 85, '2025-09-21 23:17:29', '2025-09-21 23:17:33', '2025-09-21 23:17:33'),
	(42, 60, 85, '2025-09-21 23:17:36', '2025-09-21 23:20:39', '2025-09-21 23:20:39'),
	(43, 84, 85, '2025-09-21 23:17:57', '2025-09-21 23:22:34', '2025-09-21 23:22:34'),
	(44, 60, 85, '2025-09-21 23:20:40', '2025-09-21 23:22:42', '2025-09-21 23:22:42'),
	(45, 84, 85, '2025-09-21 23:22:37', '2025-09-21 23:22:49', '2025-09-21 23:22:49'),
	(46, 84, 85, '2025-09-21 23:22:50', '2025-09-25 13:31:54', '2025-09-25 13:31:54'),
	(47, 97, 85, '2025-09-22 02:47:12', '2025-09-22 02:47:20', '2025-09-22 02:47:20'),
	(48, 96, 85, '2025-09-24 00:22:46', '2025-09-24 00:22:52', '2025-09-24 00:22:52'),
	(49, 106, 85, '2025-09-24 00:27:42', '2025-09-24 00:27:42', NULL),
	(50, 100, 85, '2025-09-24 00:29:28', '2025-09-24 00:29:32', '2025-09-24 00:29:32'),
	(51, 97, 85, '2025-09-24 03:09:29', '2025-09-25 16:48:27', '2025-09-25 16:48:27'),
	(52, 85, 108, '2025-09-25 13:04:49', '2025-09-25 13:04:49', NULL),
	(53, 84, 85, '2025-09-25 13:31:55', '2025-09-25 15:17:47', '2025-09-25 15:17:47'),
	(54, 84, 85, '2025-09-25 15:18:04', '2025-09-25 15:32:53', '2025-09-25 15:32:53'),
	(55, 84, 85, '2025-09-25 15:33:02', '2025-10-03 20:51:41', '2025-10-03 20:51:41'),
	(56, 84, 85, '2025-10-03 20:51:52', '2025-10-03 21:02:45', '2025-10-03 21:02:45'),
	(57, 84, 85, '2025-10-03 21:02:56', '2025-10-03 21:02:56', NULL),
	(58, 84, 86, '2025-10-05 00:11:28', '2025-10-05 00:11:28', NULL),
	(59, 85, 115, '2025-10-05 17:25:59', '2025-10-05 17:25:59', NULL),
	(60, 115, 85, '2025-10-05 17:27:16', '2025-10-06 08:05:25', '2025-10-06 08:05:25'),
	(61, 85, 89, '2025-10-06 12:59:14', '2025-10-06 12:59:14', NULL),
	(62, 84, 89, '2025-10-06 12:59:21', '2025-10-06 12:59:21', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela api-doeobem.likes: ~13 rows (aproximadamente)
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` (`id`, `post_id`, `user_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(53, 17, 85, '2025-09-25 16:34:27', '2025-09-25 17:51:47', '2025-09-25 17:51:47'),
	(54, 14, 85, '2025-09-25 16:34:41', '2025-09-25 16:34:41', NULL),
	(56, 17, 85, '2025-09-25 17:51:53', '2025-09-25 17:52:02', '2025-09-25 17:52:01'),
	(57, 17, 85, '2025-09-25 17:52:06', '2025-09-27 19:18:16', '2025-09-27 19:18:16'),
	(58, 17, 85, '2025-09-27 19:18:18', '2025-09-27 19:18:18', NULL),
	(59, 18, 85, '2025-09-27 20:06:26', '2025-09-27 20:06:27', '2025-09-27 20:06:27'),
	(60, 18, 85, '2025-09-27 20:10:07', '2025-09-27 20:10:29', '2025-09-27 20:10:29'),
	(61, 16, 85, '2025-09-30 18:48:22', '2025-09-30 18:48:36', '2025-09-30 18:48:36'),
	(62, 1, 85, '2025-09-30 19:49:35', '2025-09-30 20:28:17', '2025-09-30 20:28:17'),
	(63, 13, 85, '2025-09-30 20:28:24', '2025-10-03 20:30:14', '2025-10-03 20:30:14'),
	(64, 1, 85, '2025-09-30 20:59:57', '2025-09-30 20:59:58', '2025-09-30 20:59:58'),
	(65, 1, 85, '2025-09-30 20:59:59', '2025-09-30 21:00:00', '2025-09-30 21:00:00'),
	(66, 1, 85, '2025-10-02 07:29:57', '2025-10-02 07:29:59', '2025-10-02 07:29:59'),
	(67, 13, 85, '2025-10-03 20:30:15', '2025-10-03 20:51:27', '2025-10-03 20:51:26'),
	(68, 11, 85, '2025-10-03 20:51:17', '2025-10-03 20:52:28', '2025-10-03 20:52:28'),
	(69, 13, 85, '2025-10-03 20:51:29', '2025-10-03 20:51:29', NULL),
	(70, 11, 84, '2025-10-03 20:52:45', '2025-10-03 20:52:45', NULL),
	(71, 11, 86, '2025-10-03 21:05:05', '2025-10-03 21:05:05', NULL),
	(72, 6, 86, '2025-10-03 21:05:06', '2025-10-03 21:05:06', NULL),
	(73, 1, 86, '2025-10-03 21:05:08', '2025-10-05 00:12:34', '2025-10-05 00:12:34'),
	(74, 19, 85, '2025-10-03 21:07:47', '2025-10-03 21:07:47', NULL),
	(75, 19, 86, '2025-10-05 00:12:08', '2025-10-05 00:12:08', NULL),
	(76, 22, 115, '2025-10-05 17:25:29', '2025-10-05 17:25:32', '2025-10-05 17:25:32'),
	(77, 6, 115, '2025-10-05 17:26:30', '2025-10-05 17:26:30', NULL),
	(78, 1, 115, '2025-10-05 17:26:32', '2025-10-05 17:26:32', NULL),
	(79, 22, 85, '2025-10-05 17:27:23', '2025-10-05 17:27:23', NULL),
	(80, 6, 85, '2025-10-06 08:24:04', '2025-10-06 08:24:16', '2025-10-06 08:24:16'),
	(81, 24, 85, '2025-10-06 12:54:59', '2025-10-06 12:54:59', NULL),
	(82, 24, 86, '2025-10-06 12:56:19', '2025-10-06 12:56:19', NULL),
	(83, 23, 86, '2025-10-06 12:56:22', '2025-10-06 12:56:22', '2025-10-06 12:56:22'),
	(84, 23, 86, '2025-10-06 12:56:24', '2025-10-06 12:56:24', NULL),
	(85, 13, 86, '2025-10-06 12:56:55', '2025-10-06 12:56:55', NULL),
	(86, 1, 86, '2025-10-06 12:56:57', '2025-10-06 12:56:57', NULL),
	(87, 24, 89, '2025-10-06 12:59:34', '2025-10-06 12:59:34', NULL),
	(88, 23, 89, '2025-10-06 12:59:46', '2025-10-06 12:59:46', NULL),
	(89, 19, 89, '2025-10-06 12:59:50', '2025-10-06 12:59:50', NULL),
	(90, 13, 89, '2025-10-06 12:59:50', '2025-10-06 12:59:50', NULL),
	(91, 6, 89, '2025-10-06 12:59:52', '2025-10-06 12:59:52', NULL),
	(92, 1, 89, '2025-10-06 12:59:53', '2025-10-06 12:59:53', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela api-doeobem.posts: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` (`id`, `description`, `media_link`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Desse FDS', 'http://localhost:8009/public/images/profile/286959604euuu.jpg', '2025-03-30 03:10:07', NULL, NULL),
	(6, 'Esse é meu projeto', 'http://localhost:8015/public/imagesVideos/media/media_68570f661010d0.88172603.mp4', '2025-06-21 20:00:38', '2025-06-21 20:00:38', NULL),
	(11, 'Vamos testar os emojis 🙌👍😍❤💕🎂', '', '2025-08-30 13:08:58', '2025-10-04 22:12:23', '2025-10-04 22:12:23'),
	(12, 'Olá eu sou o Calebe', '', '2025-09-08 14:08:11', '2025-09-08 14:08:11', NULL),
	(13, 'Bom dia, passando para dizer OI !', '', '2025-09-16 20:08:31', '2025-09-16 20:08:31', NULL),
	(14, 'Mais um vídeo ', 'http://localhost:8015/public/imagesVideos/media/media_68c9c3d330e431.72516281.mp4', '2025-09-16 20:08:51', '2025-09-16 20:08:51', NULL),
	(16, 'Qual a boa para esse FDS ?', '', '2025-09-16 20:09:21', '2025-09-16 20:09:21', NULL),
	(17, 'Vai chover !!!', '', '2025-09-16 20:09:31', '2025-09-16 20:09:31', NULL),
	(18, 'Olá', '', '2025-09-16 20:26:22', '2025-09-16 20:26:22', NULL),
	(19, 'Agora de carro novo :)', '', '2025-10-03 21:06:44', '2025-10-03 21:06:44', NULL),
	(20, 'teste', '', '2025-10-04 21:52:10', '2025-10-04 21:56:06', '2025-10-04 21:56:06'),
	(21, 'Olá pessoal :)', '', '2025-10-05 00:14:02', '2025-10-05 06:33:48', '2025-10-05 06:33:48'),
	(22, 'Hello Word', '', '2025-10-05 17:25:21', '2025-10-05 17:25:21', NULL),
	(23, 'Mais um lindo dia 😍', '', '2025-10-06 12:53:00', '2025-10-06 12:53:00', NULL),
	(24, 'Mais um video interessante ', 'http://localhost:8015/public/imagesVideos/media/media_68e3bc107a6e73.90856494.mp4', '2025-10-06 12:54:40', '2025-10-06 12:54:40', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela api-doeobem.posts_users: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `posts_users` DISABLE KEYS */;
INSERT INTO `posts_users` (`id`, `user_id`, `post_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 85, 1, '2025-03-30 03:10:36', NULL, NULL),
	(6, 85, 6, '2025-06-21 20:00:39', '2025-06-21 20:00:39', NULL),
	(11, 85, 11, '2025-08-30 13:08:58', '2025-08-30 13:08:58', NULL),
	(13, 84, 13, '2025-09-16 20:08:31', '2025-09-16 20:08:31', NULL),
	(14, 84, 19, '2025-10-03 21:06:44', '2025-10-03 21:06:44', NULL),
	(15, 85, 20, '2025-10-04 21:52:10', '2025-10-04 21:52:10', NULL),
	(16, 85, 21, '2025-10-05 00:14:02', '2025-10-05 00:14:02', NULL),
	(17, 115, 22, '2025-10-05 17:25:21', '2025-10-05 17:25:21', NULL),
	(18, 85, 23, '2025-10-06 12:53:00', '2025-10-06 12:53:00', NULL),
	(19, 84, 24, '2025-10-06 12:54:40', '2025-10-06 12:54:40', NULL);
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
  `photo` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela api-doeobem.users: ~28 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `nickname`, `phone1`, `has_whatsapp`, `phone2`, `email`, `password`, `postal_code`, `street`, `number`, `complement`, `neighborhood`, `city`, `state`, `country`, `recovery_key`, `first_access`, `last_access`, `access_count`, `receive_newsletter`, `active`, `created_at`, `updated_at`, `deleted_at`, `userscol`, `photo`) VALUES
	(60, 'Admin', NULL, NULL, 0, NULL, 'admin@user.com', '$2y$10$DBRiDXdHGicq9HJYnKxODOXsQvWDLc0rU4rUuqfOr/SRNukwS06NC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-03-08 19:02:15', '2025-03-08 19:02:15', NULL, NULL, 'http://localhost:8009/public/images/profile/978727390euuu.jpg'),
	(84, 'Calebe', NULL, NULL, 0, NULL, 'hedreiandrade2@gmail.com', '$2y$10$joAKBw9fgKYs5rngJD5nSOeBWnhTAkkM84eZAo9PabwEe1KJZFVOS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-03-15 18:03:10', '2025-04-13 11:35:58', NULL, NULL, 'http://localhost:8009/public/images/profile/1351828300eu3.jpg'),
	(85, 'Hedrei Andrade', NULL, NULL, 0, NULL, 'hedreiandrade@gmail.com', '$2y$10$1DDfzgb.SkZr3U7a748hPOsw9MnvtYiXdIX5RU5O7GONjE6Nt3xUW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-03-16 11:34:17', '2025-09-09 18:50:24', NULL, NULL, 'http://localhost:8009/public/images/profile/424481954euuu.jpg'),
	(86, 'Andre José', NULL, NULL, 0, NULL, 'teste@teste9.com', '$2y$10$vSN6QyANoNy7SfKVUuLsO.ZZ9fLqKq.lYGvo4bBSvPUxWkZCbABbi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-03-29 02:09:26', '2025-03-29 02:09:26', NULL, NULL, 'http://localhost:8009/public/images/profile/51820549eu4bm.jpg'),
	(87, 'Fernando Torres', NULL, NULL, 0, NULL, 'teste@teste88.com', '$2y$10$jVHG894ZoIxWKZVXHnafOO5GRIURpcpmoJ81isqQMKizt4ONTJ0nW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-05 14:19:34', '2025-04-05 14:19:34', NULL, NULL, 'http://localhost:8009/public/images/profile/320161411euuu.jpg'),
	(88, 'Marcos Rocha', NULL, NULL, 0, NULL, 'teste@testebb.com', '$2y$10$OdAPkZUPWMxZ1tANd/9Z4utEof0pv4WXmwVB3vBOaouSH848oaM2i', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-05 14:54:51', '2025-04-05 14:55:03', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(89, 'Marcos Batista', NULL, NULL, 0, NULL, 'joao@gmail.com', '$2y$10$y4mq77azp9witq.rA8LBLODys8YNNjiJCqnOAUrlBzKV0enFa32vG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-12 09:44:40', '2025-04-12 09:44:47', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(93, 'Pedro Castro', NULL, NULL, 0, NULL, 'alok@gmail.com', '$2y$10$xEJHEv799IOsLM2n3ZUgweLl8XjrKraC8FhSXhdZyYttJ/3Pj1oJi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-13 20:30:14', '2025-04-13 20:30:14', NULL, NULL, 'http://localhost:8009/public/images/profile/1030854678euuu.jpg'),
	(94, 'João Batista', NULL, NULL, 0, NULL, 'hedreiandrade909@gmail.com', '$2y$10$2KgLceKyXwVS.kQG7CfP7eqpKb.ZX03QVMkvS7iT9vGl39oERkZK.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-17 21:39:54', '2025-04-17 22:34:03', '2025-04-17 22:34:03', NULL, 'http://localhost:8009/public/images/profile/1928325339eu3.jpg'),
	(95, 'Maria Soares', NULL, NULL, 0, NULL, 'maria@gmail.com', '$2y$10$diyMnueQ6or27JfeLkgid.k/6QmkN26nKTNHeoTrhwnE23PMeGdS2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:09', '2025-04-20 12:16:09', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(96, 'Joana Lucas', NULL, NULL, 0, NULL, 'joana1@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(97, 'Tesla', NULL, NULL, 0, NULL, 'joana2@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(98, 'Fernanda', NULL, NULL, 0, NULL, 'joana3@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(99, 'Julio', NULL, NULL, 0, NULL, 'joana4@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(100, 'Carlos Castro', NULL, NULL, 0, NULL, 'joana5@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(101, 'Laura', NULL, NULL, 0, NULL, 'joana6@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(102, 'Laura Mara', NULL, NULL, 0, NULL, 'joana7@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(103, 'Julio K', NULL, NULL, 0, NULL, 'eder@gmail.com', '$2y$10$OGoaveycp6/iJIb9f46rROtlay.7JeoCJnJmTwdcHBAAd9HjIPeoS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 12:33:12', '2025-04-26 12:55:25', NULL, NULL, 'http://localhost:8009/public/images/profile/758210200euuu.jpg'),
	(104, 'Marcio Abrel', NULL, NULL, 0, NULL, 'teste@testeagora.com', '$2y$10$fa5gmoCS9DoW4NpGyjd5i.xaXnrlRrKYJ6mRr4gFWW7MdGl3DzMGG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 12:55:51', '2025-04-26 12:55:51', NULL, NULL, 'null'),
	(105, 'Iasmin Flora', NULL, NULL, 0, NULL, 'mesmo@gmail.com', '$2y$10$GvFZMByIjUqTvZHCPkYgZucTYlcOc816dIbw8ZNzUSpkR7SZp4xze', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 12:57:13', '2025-04-26 13:21:37', NULL, NULL, 'http://localhost:8009/public/images/profile/2004235341euuu.jpg'),
	(106, 'Iasmin Cora', NULL, NULL, 0, NULL, 'iasmin@gmail.com', '$2y$10$zEgQ3Z8ikziLYdEY2L9wfeewd2RH72XGVVqphmJZ16QZyZxpYt7s2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 13:22:35', '2025-04-26 13:22:35', NULL, NULL, 'http://localhost:8009/public/images/profile/2004235341euuu.jpg'),
	(107, 'Lara Lisa', NULL, NULL, 0, NULL, 'lara@gmail.com', '$2y$10$1MlGcD2zrETpT1VDvhOxFOVpGf70VEkg.vUS8pl38DCVUFF263vvy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 13:24:58', '2025-04-26 13:24:58', NULL, NULL, 'null'),
	(108, 'Veras', NULL, NULL, 0, NULL, 'hedreiandrade66@gmail.com', '$2y$10$fG5plTMXx2aIW8Ip6/QWMOfpJpyuFF8SWV3dpbHjjZP4nZUrjlRha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 13:36:18', '2025-04-26 13:36:18', NULL, NULL, 'null'),
	(109, 'Iago Lucas', NULL, NULL, 0, NULL, 'lucas888@gmail.com', '$2y$10$ZlCAk53uVMnUAvjEy2F8HO1MG54.8fWjsKXmTwWeAa9PAv7pSiPjm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 13:38:04', '2025-04-26 13:38:04', NULL, NULL, 'null'),
	(110, 'Lucia Amorin', NULL, NULL, 0, NULL, 'lucia@gmail.com', '$2y$10$XHGq7LhyudahkZ/.Ql1KmuFhyoIiHmGS23MhPPHh2szvm0i503FFK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 14:09:22', '2025-04-26 14:10:02', NULL, NULL, 'http://localhost:8009/public/images/profile/1355349776Bonito04.jpg'),
	(111, 'Ana Julia', NULL, NULL, 0, NULL, 'ana@gmail.com', '$2y$10$VDaYiWueNMqiBOnriIPuYeBE.oUB6DIPS13AXsGULN2.cIz2NqMDe', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 15:44:34', '2025-04-26 15:46:44', NULL, NULL, 'http://localhost:8009/public/images/profile/1397644539Code.png'),
	(112, 'Marcia Amaral', NULL, NULL, 0, NULL, 'marcia@gmail.com', '$2y$10$IWQ3UcNI7cjuIG6gn/Yue.EIDdj/HsN7rh2qfJ4cAgnOdlUFiEnv.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 15:47:08', '2025-04-26 15:47:08', NULL, NULL, 'http://localhost:8009/public/images/profile/1888685797CapaSoundCloud.jpg'),
	(113, 'Maria Luca', NULL, NULL, 0, NULL, 'maria6@gmail.com', '$2y$10$faVJHP2ztA9zbM7Ro5HhtuOPG3INVH3bk8OE9VeTVxMrHDBBQgQeG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 15:47:37', '2025-04-26 15:47:37', NULL, NULL, 'null'),
	(114, 'teste', NULL, NULL, 0, NULL, 'teste@teste333.com', '$2y$10$X.4/rFgYuru3BhkYwvXI5uK89HsAoGt7Y.HCMQSFa4uMDRUsn7ZyS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-09-10 06:16:03', '2025-09-10 06:16:03', NULL, NULL, 'null'),
	(115, 'calebi', NULL, NULL, 0, NULL, 'calebi.andrade@gmail.com', '$2y$10$D1q1lgiCt9fcjbuM/lBF9O/yw47C96R6uvpZqdDML0QEWRMWmOitW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-10-05 17:25:03', '2025-10-05 17:25:03', NULL, NULL, 'null'),
	(116, 'Teste', NULL, NULL, 0, NULL, 'heteste@gmail.com', '$2y$10$ulPz6bDvLxOs40EVgt8YYuZ8xJ3y1DeFZg.lmTpcXuQPexDWc1XLK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-10-06 08:43:34', '2025-10-06 08:43:34', NULL, NULL, 'null');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
