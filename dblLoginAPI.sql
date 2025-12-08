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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela api-doeobem.comments: ~17 rows (aproximadamente)
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` (`id`, `post_id`, `user_id`, `comment`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 5, 'Demais! ❤', '2025-11-24 23:09:58', '2025-11-24 23:09:58', NULL),
	(2, 4, 5, 'Top !', '2025-11-24 23:10:06', '2025-11-24 23:10:06', NULL),
	(3, 1, 6, 'Lindo!', '2025-11-24 23:10:31', '2025-11-24 23:10:31', NULL),
	(4, 8, 233, 'Olha eu aí!', '2025-11-24 23:10:56', '2025-11-24 23:10:56', NULL),
	(5, 5, 233, 'Qaul é ?', '2025-11-24 23:11:21', '2025-11-25 02:11:23', '2025-11-25 02:11:23'),
	(6, 5, 233, 'Qual é ?', '2025-11-24 23:11:27', '2025-11-24 23:11:27', NULL),
	(7, 4, 3, 'Amei!', '2025-11-24 23:12:30', '2025-11-24 23:12:30', NULL),
	(8, 1, 3, 'Show!', '2025-11-24 23:12:40', '2025-11-24 23:12:40', NULL),
	(9, 6, 233, 'teste', '2025-12-01 01:05:51', '2025-12-01 04:06:15', '2025-12-01 04:06:15'),
	(10, 6, 233, '2', '2025-12-01 01:05:54', '2025-12-01 04:06:15', '2025-12-01 04:06:15'),
	(11, 6, 233, '3', '2025-12-01 01:05:57', '2025-12-01 04:06:14', '2025-12-01 04:06:14'),
	(12, 6, 233, '4', '2025-12-01 01:06:00', '2025-12-01 04:06:13', '2025-12-01 04:06:13'),
	(13, 6, 233, '5', '2025-12-01 01:06:05', '2025-12-01 04:06:16', '2025-12-01 04:06:16'),
	(14, 6, 233, '6', '2025-12-01 01:06:08', '2025-12-01 04:06:17', '2025-12-01 04:06:17'),
	(21, 5, 233, 'teste', '2025-12-01 23:06:04', '2025-12-02 02:06:06', '2025-12-02 02:06:06'),
	(22, 57, 6, 'Linda mandala :) 🖤', '2025-12-02 20:27:40', '2025-12-02 20:27:40', NULL),
	(23, 57, 233, ':)', '2025-12-02 20:29:01', '2025-12-02 20:29:01', NULL),
	(24, 6, 233, 'Massa !', '2025-12-02 20:35:16', '2025-12-02 20:35:16', NULL),
	(26, 12, 233, 'oi', '2025-12-07 13:22:40', '2025-12-07 13:22:40', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela api-doeobem.followers: ~17 rows (aproximadamente)
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
	(12, 2, 233, '2025-11-25 01:52:51', '2025-12-02 23:36:08', '2025-12-02 23:36:08'),
	(13, 3, 233, '2025-11-25 01:52:55', '2025-12-02 23:29:55', '2025-12-02 23:29:55'),
	(14, 6, 233, '2025-11-25 01:53:02', '2025-11-25 01:53:02', NULL),
	(15, 5, 233, '2025-11-25 01:53:09', '2025-11-25 01:53:09', NULL),
	(16, 3, 2, '2025-11-25 02:08:51', '2025-11-25 02:08:51', NULL),
	(17, 233, 7, '2025-11-25 02:30:18', '2025-11-25 02:30:18', NULL),
	(18, 3, 233, '2025-12-02 23:29:57', '2025-12-02 23:29:57', NULL),
	(19, 2, 233, '2025-12-02 23:36:10', '2025-12-02 23:36:10', NULL),
	(20, 7, 233, '2025-12-07 15:20:09', '2025-12-07 15:20:09', NULL),
	(21, 6, 7, '2025-12-07 20:22:32', '2025-12-07 20:22:32', NULL),
	(22, 2, 7, '2025-12-07 20:22:54', '2025-12-07 20:22:54', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela api-doeobem.likes: ~26 rows (aproximadamente)
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
	(9, 9, 233, '2025-11-25 02:10:45', '2025-12-07 20:23:59', '2025-12-07 20:23:59'),
	(10, 8, 233, '2025-11-25 02:10:50', '2025-11-25 02:10:50', NULL),
	(11, 4, 233, '2025-11-25 02:11:04', '2025-11-29 00:11:03', '2025-11-29 00:11:03'),
	(12, 1, 233, '2025-11-25 02:11:07', '2025-11-25 02:11:08', '2025-11-25 02:11:08'),
	(13, 5, 233, '2025-11-25 02:11:16', '2025-12-02 23:35:07', '2025-12-02 23:35:07'),
	(14, 9, 3, '2025-11-25 02:12:21', '2025-11-25 02:12:21', NULL),
	(15, 8, 3, '2025-11-25 02:12:21', '2025-11-25 02:12:21', NULL),
	(16, 6, 3, '2025-11-25 02:12:22', '2025-11-25 02:12:22', NULL),
	(17, 5, 3, '2025-11-25 02:12:24', '2025-11-25 02:12:24', NULL),
	(18, 4, 3, '2025-11-25 02:12:25', '2025-11-25 02:12:25', NULL),
	(19, 1, 3, '2025-11-25 02:12:42', '2025-11-25 02:12:42', NULL),
	(21, 12, 233, '2025-11-25 02:40:18', '2025-12-02 01:12:24', '2025-12-02 01:12:24'),
	(22, 4, 233, '2025-11-29 00:12:00', '2025-11-29 00:12:00', NULL),
	(23, 6, 233, '2025-12-01 04:05:46', '2025-12-01 04:05:48', '2025-12-01 04:05:48'),
	(25, 12, 233, '2025-12-02 02:06:24', '2025-12-02 02:06:24', NULL),
	(26, 57, 6, '2025-12-02 23:27:23', '2025-12-02 23:27:23', NULL),
	(27, 6, 233, '2025-12-02 23:29:16', '2025-12-02 23:29:16', NULL),
	(28, 5, 233, '2025-12-02 23:35:09', '2025-12-02 23:35:09', NULL),
	(30, 9, 233, '2025-12-07 20:24:00', '2025-12-07 20:24:00', NULL);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;

-- Copiando estrutura para tabela api-doeobem.posts
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `description` text COLLATE utf8mb4_unicode_ci,
  `media_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `is_repost` tinyint(1) DEFAULT '0',
  `original_post_id` int(10) unsigned DEFAULT NULL,
  `original_user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_posts_original_post` (`original_post_id`),
  KEY `fk_posts_original_user` (`original_user_id`),
  CONSTRAINT `fk_posts_original_post` FOREIGN KEY (`original_post_id`) REFERENCES `posts` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_posts_original_user` FOREIGN KEY (`original_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela api-doeobem.posts: ~53 rows (aproximadamente)
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` (`id`, `description`, `media_link`, `created_at`, `updated_at`, `deleted_at`, `is_repost`, `original_post_id`, `original_user_id`) VALUES
	(1, 'Meu video psycho', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6924e2f1909f67.26412208.mp4', '2025-11-24 19:57:57', '2025-12-02 23:33:44', '2025-12-02 23:33:44', 0, NULL, NULL),
	(2, 'teste', 'http://localhost:8015/public/imagesVideos/media/media_6924e85b1aaac5.47538364.mp4', '2025-11-24 20:20:59', '2025-11-24 23:21:17', '2025-11-24 23:21:17', 0, NULL, NULL),
	(3, 'teste ', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6924f6d590be04.81222102.mp4', '2025-11-24 21:22:59', '2025-11-25 00:23:13', '2025-11-25 00:23:13', 0, NULL, NULL),
	(4, 'Olha que video massa !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_69250c633ce117.48206824.mp4', '2025-11-24 22:54:59', '2025-11-24 22:54:59', NULL, 0, NULL, NULL),
	(5, 'Ouvindo minha música favorita :)', '', '2025-11-24 22:55:32', '2025-11-24 22:55:32', NULL, 0, NULL, NULL),
	(6, 'Assistindo Star Wars !! ❤', '', '2025-11-24 23:05:49', '2025-11-24 23:05:49', NULL, 0, NULL, NULL),
	(7, 'Mais um video legal !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_69250f31aa9833.08086824.mp4', '2025-11-24 23:06:55', '2025-11-25 02:07:17', '2025-11-25 02:07:17', 0, NULL, NULL),
	(8, 'Mais um video legal !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_69250f6691ed56.10054038.mp4', '2025-11-24 23:07:45', '2025-11-24 23:07:45', NULL, 0, NULL, NULL),
	(9, 'Bom dia pessoal !!', '', '2025-11-24 23:08:11', '2025-11-24 23:08:11', NULL, 0, NULL, NULL),
	(10, 'Hoje tem jogo do Palmeiras ✔', '', '2025-11-24 23:13:37', '2025-11-24 23:13:37', NULL, 0, NULL, NULL),
	(11, 'teste', '', '2025-11-24 23:21:44', '2025-11-25 02:21:53', '2025-11-25 02:21:53', 0, NULL, NULL),
	(12, 'Qual a boa pro final de semana ? 👏🎶✌❤', '', '2025-11-24 23:36:10', '2025-11-24 23:36:10', NULL, 0, NULL, NULL),
	(14, 'teste', '', '2025-11-25 00:41:30', '2025-11-25 03:41:45', '2025-11-25 03:41:45', 0, NULL, NULL),
	(15, 'teste', '', '2025-11-25 00:44:46', '2025-11-25 03:44:52', '2025-11-25 03:44:52', 0, NULL, NULL),
	(16, 'teste', '', '2025-11-25 00:44:57', '2025-11-25 03:45:20', '2025-11-25 03:45:20', 0, NULL, NULL),
	(17, 'teste', '', '2025-11-25 00:45:22', '2025-11-25 03:45:28', '2025-11-25 03:45:28', 0, NULL, NULL),
	(18, 'teste', '', '2025-11-25 01:00:12', '2025-11-25 04:01:12', '2025-11-25 04:01:12', 0, NULL, NULL),
	(19, 'teste', '', '2025-11-25 01:01:19', '2025-11-25 04:01:26', '2025-11-25 04:01:26', 0, NULL, NULL),
	(20, 'teste', '', '2025-11-25 01:02:14', '2025-11-25 04:11:04', '2025-11-25 04:11:04', 0, NULL, NULL),
	(21, 'teste', '', '2025-11-25 01:06:58', '2025-11-25 04:07:04', '2025-11-25 04:07:04', 0, NULL, NULL),
	(22, 'teste', '', '2025-11-25 01:11:07', '2025-11-25 04:11:39', '2025-11-25 04:11:39', 0, NULL, NULL),
	(23, 'aaa', '', '2025-11-25 01:11:43', '2025-11-25 04:16:07', '2025-11-25 04:16:07', 0, NULL, NULL),
	(24, 'teste', '', '2025-11-25 01:16:09', '2025-11-25 04:18:11', '2025-11-25 04:18:11', 0, NULL, NULL),
	(25, 'aaa', '', '2025-11-25 01:18:14', '2025-11-25 04:18:52', '2025-11-25 04:18:52', 0, NULL, NULL),
	(26, 'teste', '', '2025-11-25 01:18:55', '2025-11-25 04:19:02', '2025-11-25 04:19:02', 0, NULL, NULL),
	(27, 'teste', '', '2025-11-25 01:20:55', '2025-11-25 04:20:58', '2025-11-25 04:20:58', 0, NULL, NULL),
	(28, 'teste ', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69252eb6d7b414.11339649.mp4', '2025-11-25 01:21:14', '2025-11-25 04:21:31', '2025-11-25 04:21:31', 0, NULL, NULL),
	(29, 'teste', '', '2025-11-25 01:24:03', '2025-11-25 04:24:06', '2025-11-25 04:24:06', 0, NULL, NULL),
	(30, 'teste ', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69252f706a3021.10222359.mp4', '2025-11-25 01:24:28', '2025-11-25 04:24:39', '2025-11-25 04:24:39', 0, NULL, NULL),
	(31, 'teste', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69252fa8542701.14095859.mp4', '2025-11-25 01:25:16', '2025-11-25 04:25:30', '2025-11-25 04:25:30', 0, NULL, NULL),
	(32, 'teste', '', '2025-11-25 01:30:41', '2025-11-25 04:31:09', '2025-11-25 04:31:09', 0, NULL, NULL),
	(33, 'teste', '', '2025-11-25 01:31:29', '2025-11-25 04:31:32', '2025-11-25 04:31:32', 0, NULL, NULL),
	(34, 'teste', '', '2025-11-25 01:31:39', '2025-11-25 04:31:46', '2025-11-25 04:31:46', 0, NULL, NULL),
	(35, 'teste ', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_692531389f7621.01495490.mp4', '2025-11-25 01:31:56', '2025-11-25 04:32:02', '2025-11-25 04:32:02', 0, NULL, NULL),
	(36, 'teste', '', '2025-11-25 01:47:50', '2025-11-25 04:47:52', '2025-11-25 04:47:52', 0, NULL, NULL),
	(37, 'teste', '', '2025-11-25 01:47:54', '2025-11-25 04:47:56', '2025-11-25 04:47:56', 0, NULL, NULL),
	(38, 'teste ', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69253502b8fd29.90024801.mp4', '2025-11-25 01:48:16', '2025-11-25 04:55:17', '2025-11-25 04:55:17', 0, NULL, NULL),
	(39, 'teste', '', '2025-11-25 01:54:35', '2025-11-25 04:54:37', '2025-11-25 04:54:37', 0, NULL, NULL),
	(40, 'teste', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_69253693bdbc86.44137645.mp4', '2025-11-25 01:54:55', '2025-11-25 04:55:12', '2025-11-25 04:55:12', 0, NULL, NULL),
	(41, 'teste', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_692536c790c6a6.02644872.mp4', '2025-11-25 01:55:39', '2025-11-25 04:55:48', '2025-11-25 04:55:48', 0, NULL, NULL),
	(42, 'teste', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_692536de515491.04265316.jpg', '2025-11-25 01:55:59', '2025-11-25 04:56:22', '2025-11-25 04:56:22', 0, NULL, NULL),
	(43, 'teste', '', '2025-11-25 01:56:28', '2025-11-25 04:56:38', '2025-11-25 04:56:38', 0, NULL, NULL),
	(44, 'teste', '', '2025-11-25 01:56:42', '2025-11-25 04:56:44', '2025-11-25 04:56:44', 0, NULL, NULL),
	(45, 'teste', '', '2025-11-25 01:56:52', '2025-11-25 04:56:56', '2025-11-25 04:56:56', 0, NULL, NULL),
	(46, 'teste', '', '2025-11-25 01:57:18', '2025-11-25 04:58:02', '2025-11-25 04:58:02', 0, NULL, NULL),
	(47, 'teste', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6925378cdb7e85.21176941.mp4', '2025-11-25 01:58:56', '2025-11-25 04:59:04', '2025-11-25 04:59:04', 0, NULL, NULL),
	(48, 'teste', '', '2025-12-01 01:06:38', '2025-12-01 04:06:41', '2025-12-01 04:06:41', 0, NULL, NULL),
	(49, 'teste ', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_692d14574ac688.04973445.jpg', '2025-12-01 01:06:50', '2025-12-01 04:06:57', '2025-12-01 04:06:57', 0, NULL, NULL),
	(50, 'teste', '', '2025-12-01 01:21:32', '2025-12-01 04:21:35', '2025-12-01 04:21:35', 0, NULL, NULL),
	(51, 'teste ', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_692d17d4ac03d2.29491514.jpg', '2025-12-01 01:21:42', '2025-12-01 04:21:47', '2025-12-01 04:21:47', 0, NULL, NULL),
	(54, 'Qual a boa pro final de semana ? 👏🎶✌❤', '', '2025-12-02 01:33:41', '2025-12-02 02:06:52', '2025-12-02 02:06:52', 1, 12, 6),
	(55, 'Qual a boa pro final de semana ? 👏🎶✌❤', '', '2025-12-02 02:06:54', '2025-12-02 02:06:59', '2025-12-02 02:06:59', 1, 12, 6),
	(56, 'Meu video psycho', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_6924e2f1909f67.26412208.mp4', '2025-12-02 02:07:04', '2025-12-02 02:07:22', '2025-12-02 02:07:22', 1, 1, 233),
	(57, 'Olha minha mandala by Mara Dias 🎶', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_692f75882dacd8.84178374.jpg', '2025-12-02 20:26:03', '2025-12-02 20:26:03', NULL, 0, NULL, NULL),
	(58, 'Assistindo Star Wars !! ❤', '', '2025-12-02 23:29:26', '2025-12-02 23:30:24', '2025-12-02 23:30:24', 1, 6, 2),
	(59, 'My psycho video', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_692f776c58de40.26114566.mp4', '2025-12-02 20:34:16', '2025-12-07 15:39:27', '2025-12-07 15:39:27', 0, NULL, NULL),
	(60, 'teste', '', '2025-12-02 20:35:29', '2025-12-02 23:35:31', '2025-12-02 23:35:31', 0, NULL, NULL),
	(61, 'My psycho video', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_692f776c58de40.26114566.mp4', '2025-12-02 23:36:37', '2025-12-02 23:36:37', NULL, 1, 59, 233),
	(62, 'My psycho video', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/media_692f776c58de40.26114566.mp4', '2025-12-05 17:10:39', '2025-12-05 17:10:39', NULL, 1, 61, 233),
	(63, 'Ouvindo minha música favorita :)', '', '2025-11-24 22:55:32', '2025-11-24 22:55:32', NULL, 1, 5, 2),
	(84, 'Olha que video massa !', 'https://hmediaha.s3.us-west-2.amazonaws.com/imagesVideos/posts/d41d8cd98f00b204e9800998ecf8427e_calebe/media_69250c633ce117.48206824.mp4', '2025-12-08 03:46:47', '2025-12-08 03:46:47', NULL, 1, 4, 2);
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
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela api-doeobem.posts_users: ~52 rows (aproximadamente)
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
	(10, 233, 10, '2025-11-24 23:13:37', '2025-11-24 23:13:37', NULL),
	(11, 233, 11, '2025-11-24 23:21:44', '2025-11-24 23:21:44', NULL),
	(12, 6, 12, '2025-11-24 23:36:10', '2025-11-24 23:36:10', NULL),
	(14, 233, 14, '2025-11-25 00:41:30', '2025-11-25 00:41:30', NULL),
	(15, 233, 15, '2025-11-25 00:44:46', '2025-11-25 00:44:46', NULL),
	(16, 233, 16, '2025-11-25 00:44:57', '2025-11-25 00:44:57', NULL),
	(17, 233, 17, '2025-11-25 00:45:22', '2025-11-25 00:45:22', NULL),
	(18, 233, 18, '2025-11-25 01:00:12', '2025-11-25 01:00:12', NULL),
	(19, 233, 19, '2025-11-25 01:01:19', '2025-11-25 01:01:19', NULL),
	(20, 233, 20, '2025-11-25 01:02:14', '2025-11-25 01:02:14', NULL),
	(21, 233, 21, '2025-11-25 01:06:58', '2025-11-25 01:06:58', NULL),
	(22, 233, 22, '2025-11-25 01:11:07', '2025-11-25 01:11:07', NULL),
	(23, 233, 23, '2025-11-25 01:11:43', '2025-11-25 01:11:43', NULL),
	(24, 233, 24, '2025-11-25 01:16:09', '2025-11-25 01:16:09', NULL),
	(25, 233, 25, '2025-11-25 01:18:14', '2025-11-25 01:18:14', NULL),
	(26, 233, 26, '2025-11-25 01:18:55', '2025-11-25 01:18:55', NULL),
	(27, 233, 27, '2025-11-25 01:20:55', '2025-11-25 01:20:55', NULL),
	(28, 233, 28, '2025-11-25 01:21:14', '2025-11-25 01:21:14', NULL),
	(29, 233, 29, '2025-11-25 01:24:03', '2025-11-25 01:24:03', NULL),
	(30, 233, 30, '2025-11-25 01:24:28', '2025-11-25 01:24:28', NULL),
	(31, 233, 31, '2025-11-25 01:25:16', '2025-11-25 01:25:16', NULL),
	(32, 233, 32, '2025-11-25 01:30:41', '2025-11-25 01:30:41', NULL),
	(33, 233, 33, '2025-11-25 01:31:29', '2025-11-25 01:31:29', NULL),
	(34, 233, 34, '2025-11-25 01:31:39', '2025-11-25 01:31:39', NULL),
	(35, 233, 35, '2025-11-25 01:31:56', '2025-11-25 01:31:56', NULL),
	(36, 233, 36, '2025-11-25 01:47:50', '2025-11-25 01:47:50', NULL),
	(37, 233, 37, '2025-11-25 01:47:54', '2025-11-25 01:47:54', NULL),
	(38, 233, 38, '2025-11-25 01:48:16', '2025-11-25 01:48:16', NULL),
	(39, 233, 39, '2025-11-25 01:54:35', '2025-11-25 01:54:35', NULL),
	(40, 233, 40, '2025-11-25 01:54:55', '2025-11-25 01:54:55', NULL),
	(41, 233, 41, '2025-11-25 01:55:39', '2025-11-25 01:55:39', NULL),
	(42, 233, 42, '2025-11-25 01:55:59', '2025-11-25 01:55:59', NULL),
	(43, 233, 43, '2025-11-25 01:56:28', '2025-11-25 01:56:28', NULL),
	(44, 233, 44, '2025-11-25 01:56:42', '2025-11-25 01:56:42', NULL),
	(45, 233, 45, '2025-11-25 01:56:52', '2025-11-25 01:56:52', NULL),
	(46, 233, 46, '2025-11-25 01:57:18', '2025-11-25 01:57:18', NULL),
	(47, 233, 47, '2025-11-25 01:58:56', '2025-11-25 01:58:56', NULL),
	(48, 233, 48, '2025-12-01 01:06:38', '2025-12-01 01:06:38', NULL),
	(49, 233, 49, '2025-12-01 01:06:50', '2025-12-01 01:06:50', NULL),
	(50, 233, 50, '2025-12-01 01:21:32', '2025-12-01 01:21:32', NULL),
	(51, 233, 51, '2025-12-01 01:21:42', '2025-12-01 01:21:42', NULL),
	(54, 233, 54, '2025-12-02 01:33:41', '2025-12-02 01:33:41', NULL),
	(55, 233, 55, '2025-12-02 02:06:54', '2025-12-02 02:06:54', NULL),
	(56, 233, 56, '2025-12-02 02:07:04', '2025-12-02 02:07:04', NULL),
	(57, 233, 57, '2025-12-02 20:26:03', '2025-12-02 20:26:03', NULL),
	(58, 233, 58, '2025-12-02 23:29:27', '2025-12-02 23:29:27', NULL),
	(59, 233, 59, '2025-12-02 20:34:16', '2025-12-02 20:34:16', NULL),
	(60, 233, 60, '2025-12-02 20:35:29', '2025-12-02 20:35:29', NULL),
	(84, 233, 84, '2025-12-08 03:46:47', '2025-12-08 03:46:47', NULL);
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

-- Copiando dados para a tabela api-doeobem.users: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `nickname`, `phone1`, `has_whatsapp`, `phone2`, `email`, `password`, `postal_code`, `street`, `number`, `complement`, `neighborhood`, `city`, `state`, `country`, `recovery_key`, `first_access`, `last_access`, `access_count`, `receive_newsletter`, `active`, `created_at`, `updated_at`, `deleted_at`, `userscol`, `photo`, `cover_photo`, `google_id`, `facebook_id`, `auth_provider`, `email_verified`, `verified_profile`) VALUES
	(2, 'Calebe', NULL, NULL, 0, NULL, 'calebe@gmail.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', 2, 0, 1, '2025-11-24 13:26:09', '2025-11-25 01:54:12', NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/1be21001e4647d409c73c9e2bb350bf1_calebe/1993258390eu4bm.jpg', 'https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_calebe/1607179466capasound.jpg', NULL, NULL, 'local', 1, 0),
	(3, 'Iasmin Cora', NULL, NULL, 0, NULL, 'iasmin@gmail.com', '$2y$10$RLe8jkyB73i5KNYnFRiR5efclCwowVvD1KaQwCDTJqYfRrsayIVx6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', 2, 0, 1, '2025-11-24 13:26:09', '2025-11-25 02:34:36', NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/0a0c603e8b59008a552c108a80dffd53_iasmincora/1251455249clouds.jpg', '', NULL, NULL, 'local', 1, 0),
	(4, 'Marcos Bastista', NULL, NULL, 0, NULL, 'marcos@gmail.com', '$2y$10$RLe8jkyB73i5KNYnFRiR5efclCwowVvD1KaQwCDTJqYfRrsayIVx6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', 2, 0, 1, '2025-11-24 13:26:09', '2025-11-25 01:51:07', NULL, NULL, '', '', NULL, NULL, 'local', 1, 0),
	(5, 'Andre ', NULL, NULL, 0, NULL, 'andre@gmail.com', '$2y$10$RLe8jkyB73i5KNYnFRiR5efclCwowVvD1KaQwCDTJqYfRrsayIVx6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', 2, 0, 1, '2025-11-24 13:26:09', '2025-11-25 02:09:32', NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/df8bcc50f015de8677e4025ecb1a369a_andre/1087917545eu3.jpg', '', NULL, NULL, 'local', 1, 0),
	(6, 'Jeniffer Cora', NULL, NULL, 0, NULL, 'admin2@user.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', 2, 0, 1, '2025-11-24 13:26:09', '2025-11-25 02:35:00', NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/f73599fffd54f314ee59a4379278c366_jeniffercora/374066667dubai.jpg', '', NULL, NULL, 'local', 1, 0),
	(7, 'Mora Dias', NULL, NULL, 0, NULL, 'mora@gmail.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-11-24 22:57:27', 2, 0, 1, '2025-11-24 13:26:09', '2025-11-25 01:52:16', NULL, NULL, '', '', NULL, NULL, 'local', 1, 0),
	(233, 'Hedrei Andrade', NULL, NULL, 0, NULL, 'hedreiandrade@gmail.com', '$2y$10$wzXeGinsU4P8sFxlkCsTquuJECsznHia6cD6Q4//fDktLhvTqXD1m', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-11-24 13:26:09', '2025-12-08 03:46:05', 10, 0, 1, '2025-11-24 13:26:09', '2025-12-08 03:46:05', NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_hedreiandrade/2048186498ha.jpg', 'https://hmediaha.s3.us-west-2.amazonaws.com/images/cover/d41d8cd98f00b204e9800998ecf8427e_hedreiandrade/2075300663capayoutube.jpg', NULL, NULL, 'facebook', 1, 0),
	(234, 'Star Projectt', NULL, NULL, 0, NULL, 'admin@user.com', '$2y$10$7QwVqU/1j0HMB9woNqk8MOVHBmeYY3smcOvAq166I6x0m1jVOxIuK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-03 18:47:55', '2025-12-08 03:45:20', 1, 0, 1, '2025-12-03 18:47:56', '2025-12-08 03:45:20', NULL, NULL, 'https://hmediaha.s3.us-west-2.amazonaws.com/images/profile/45ffe4526a174467d18531ced45e90df_starprojectt/facebook_25385239877749037_1764787672.jpg', NULL, NULL, NULL, 'facebook', 0, 0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
