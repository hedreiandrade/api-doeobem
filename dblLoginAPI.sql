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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela api-doeobem.followers: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` (`id`, `user_id`, `follower_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 85, 84, '2025-03-30 03:12:43', NULL, NULL),
	(2, 84, 85, '2025-03-30 03:22:14', NULL, NULL),
	(3, 86, 85, '2025-03-30 03:22:15', NULL, NULL),
	(4, 85, 86, '2025-03-30 03:22:15', NULL, NULL),
	(5, 60, 85, '2025-03-30 03:22:13', NULL, NULL),
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
	(25, 85, 108, NULL, NULL, NULL),
	(26, 85, 109, NULL, NULL, NULL),
	(27, 85, 110, NULL, NULL, NULL),
	(28, 85, 111, NULL, NULL, NULL),
	(29, 85, 112, NULL, NULL, NULL),
	(30, 85, 113, NULL, NULL, NULL);
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;

-- Copiando estrutura para tabela api-doeobem.posts
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `description` text,
  `media_link` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela api-doeobem.posts: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` (`id`, `description`, `media_link`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Desse FDS', 'http://localhost:8009/public/images/profile/286959604euuu.jpg', '2025-03-30 03:10:07', NULL, NULL),
	(6, 'teste ', 'http://localhost:8015/public/imagesVideos/media/media_68570f661010d0.88172603.mp4', '2025-06-21 20:00:38', '2025-06-21 20:00:38', NULL),
	(7, 'teste ', '', '2025-06-21 20:02:33', '2025-06-21 20:02:33', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela api-doeobem.posts_users: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `posts_users` DISABLE KEYS */;
INSERT INTO `posts_users` (`id`, `user_id`, `post_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 85, 1, '2025-03-30 03:10:36', NULL, NULL),
	(6, 85, 6, '2025-06-21 20:00:39', '2025-06-21 20:00:39', NULL),
	(7, 85, 7, '2025-06-21 20:02:33', '2025-06-21 20:02:33', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela api-doeobem.users: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `nickname`, `phone1`, `has_whatsapp`, `phone2`, `email`, `password`, `postal_code`, `street`, `number`, `complement`, `neighborhood`, `city`, `state`, `country`, `recovery_key`, `first_access`, `last_access`, `access_count`, `receive_newsletter`, `active`, `created_at`, `updated_at`, `deleted_at`, `userscol`, `photo`) VALUES
	(60, 'Admin', NULL, NULL, 0, NULL, 'admin@user.com', '$2y$10$DBRiDXdHGicq9HJYnKxODOXsQvWDLc0rU4rUuqfOr/SRNukwS06NC', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-03-08 19:02:15', '2025-03-08 19:02:15', NULL, NULL, 'http://localhost:8009/public/images/profile/978727390euuu.jpg'),
	(84, 'Calebe', NULL, NULL, 0, NULL, 'hedreiandrade2@gmail.com', '$2y$10$Fc4qOO4ysAD4v./zgtygZeg0HMMZ0e8FHZTPtP8W1XLUbhxXa2ety', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-03-15 18:03:10', '2025-04-13 11:35:58', NULL, NULL, 'http://localhost:8009/public/images/profile/1351828300eu3.jpg'),
	(85, 'Hedrei Andrade', NULL, NULL, 0, NULL, 'hedreiandrade@gmail.com', '$2y$10$TXF/mHoFWzYe5zCaxwycuOD3ZPL6oUTzx/a/ybC3FQjvLm4umTDQm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-03-16 11:34:17', '2025-04-20 01:39:50', NULL, NULL, 'http://localhost:8009/public/images/profile/424481954euuu.jpg'),
	(86, 'Andre José', NULL, NULL, 0, NULL, 'teste@teste9.com', '$2y$10$vSN6QyANoNy7SfKVUuLsO.ZZ9fLqKq.lYGvo4bBSvPUxWkZCbABbi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-03-29 02:09:26', '2025-03-29 02:09:26', NULL, NULL, 'http://localhost:8009/public/images/profile/51820549eu4bm.jpg'),
	(87, 'Fernando Torres', NULL, NULL, 0, NULL, 'teste@teste88.com', '$2y$10$jVHG894ZoIxWKZVXHnafOO5GRIURpcpmoJ81isqQMKizt4ONTJ0nW', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-05 14:19:34', '2025-04-05 14:19:34', NULL, NULL, 'http://localhost:8009/public/images/profile/320161411euuu.jpg'),
	(88, 'Marcos Rocha', NULL, NULL, 0, NULL, 'teste@testebb.com', '$2y$10$OdAPkZUPWMxZ1tANd/9Z4utEof0pv4WXmwVB3vBOaouSH848oaM2i', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-05 14:54:51', '2025-04-05 14:55:03', NULL, NULL, 'http://localhost:8009/public/images/profile/1633946152euuu.jpg'),
	(89, 'João Batista', NULL, NULL, 0, NULL, 'joao@gmail.com', '$2y$10$y4mq77azp9witq.rA8LBLODys8YNNjiJCqnOAUrlBzKV0enFa32vG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-12 09:44:40', '2025-04-12 09:44:47', NULL, NULL, 'http://localhost:8009/public/images/profile/240809439euuu.jpg'),
	(93, 'Pedro Castro', NULL, NULL, 0, NULL, 'alok@gmail.com', '$2y$10$xEJHEv799IOsLM2n3ZUgweLl8XjrKraC8FhSXhdZyYttJ/3Pj1oJi', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-13 20:30:14', '2025-04-13 20:30:14', NULL, NULL, 'http://localhost:8009/public/images/profile/1030854678euuu.jpg'),
	(94, 'João Batista', NULL, NULL, 0, NULL, 'castro4@gmail.com', '$2y$10$2KgLceKyXwVS.kQG7CfP7eqpKb.ZX03QVMkvS7iT9vGl39oERkZK.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-17 21:39:54', '2025-04-17 22:34:03', '2025-04-17 22:34:03', NULL, 'http://localhost:8009/public/images/profile/1928325339eu3.jpg'),
	(95, 'Maria Soares', NULL, NULL, 0, NULL, 'maria@gmail.com', '$2y$10$diyMnueQ6or27JfeLkgid.k/6QmkN26nKTNHeoTrhwnE23PMeGdS2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:09', '2025-04-20 12:16:09', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(96, 'Joana Dias', NULL, NULL, 0, NULL, 'joana@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(97, 'Tesla', NULL, NULL, 0, NULL, 'joana@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(98, 'Fernanda', NULL, NULL, 0, NULL, 'joana@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(99, 'Julio', NULL, NULL, 0, NULL, 'joana@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(100, 'Carlos Maia', NULL, NULL, 0, NULL, 'joana@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(101, 'Samuel', NULL, NULL, 0, NULL, 'joana@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(102, 'Natalia', NULL, NULL, 0, NULL, 'joana@gmail.com', '$2y$10$L/IlppHIYuhdtxF3HxeTIukEwwc0UgzVTKD0jyBVSz53aSr8L..lK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-20 12:16:53', '2025-04-20 12:16:53', NULL, NULL, 'http://localhost:8009/public/images/profile/643849404Amanita.jpg'),
	(103, 'Eder Jota', NULL, NULL, 0, NULL, 'eder@gmail.com', '$2y$10$OGoaveycp6/iJIb9f46rROtlay.7JeoCJnJmTwdcHBAAd9HjIPeoS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 12:33:12', '2025-04-26 12:55:25', NULL, NULL, 'http://localhost:8009/public/images/profile/758210200euuu.jpg'),
	(104, 'Teste Agora', NULL, NULL, 0, NULL, 'teste@testeagora.com', '$2y$10$fa5gmoCS9DoW4NpGyjd5i.xaXnrlRrKYJ6mRr4gFWW7MdGl3DzMGG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 12:55:51', '2025-04-26 12:55:51', NULL, NULL, 'null'),
	(105, 'Mesmo', NULL, NULL, 0, NULL, 'mesmo@gmail.com', '$2y$10$GvFZMByIjUqTvZHCPkYgZucTYlcOc816dIbw8ZNzUSpkR7SZp4xze', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 12:57:13', '2025-04-26 13:21:37', NULL, NULL, 'http://localhost:8009/public/images/profile/2004235341euuu.jpg'),
	(106, 'Iasmin Cora', NULL, NULL, 0, NULL, 'iasmin@gmail.com', '$2y$10$zEgQ3Z8ikziLYdEY2L9wfeewd2RH72XGVVqphmJZ16QZyZxpYt7s2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 13:22:35', '2025-04-26 13:22:35', NULL, NULL, 'null'),
	(107, 'Lara Lisa', NULL, NULL, 0, NULL, 'lara@gmail.com', '$2y$10$1MlGcD2zrETpT1VDvhOxFOVpGf70VEkg.vUS8pl38DCVUFF263vvy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 13:24:58', '2025-04-26 13:24:58', NULL, NULL, 'null'),
	(108, 'Hedrei Andrade', NULL, NULL, 0, NULL, 'hedreiandrade66@gmail.com', '$2y$10$fG5plTMXx2aIW8Ip6/QWMOfpJpyuFF8SWV3dpbHjjZP4nZUrjlRha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 13:36:18', '2025-04-26 13:36:18', NULL, NULL, 'null'),
	(109, 'Iago Lucas', NULL, NULL, 0, NULL, 'lucas888@gmail.com', '$2y$10$ZlCAk53uVMnUAvjEy2F8HO1MG54.8fWjsKXmTwWeAa9PAv7pSiPjm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 13:38:04', '2025-04-26 13:38:04', NULL, NULL, 'null'),
	(110, 'Lucia Amorin', NULL, NULL, 0, NULL, 'lucia@gmail.com', '$2y$10$XHGq7LhyudahkZ/.Ql1KmuFhyoIiHmGS23MhPPHh2szvm0i503FFK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 14:09:22', '2025-04-26 14:10:02', NULL, NULL, 'http://localhost:8009/public/images/profile/1355349776Bonito04.jpg'),
	(111, 'Ana Julia', NULL, NULL, 0, NULL, 'ana@gmail.com', '$2y$10$VDaYiWueNMqiBOnriIPuYeBE.oUB6DIPS13AXsGULN2.cIz2NqMDe', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 15:44:34', '2025-04-26 15:46:44', NULL, NULL, 'http://localhost:8009/public/images/profile/1397644539Code.png'),
	(112, 'Marcia Amaral', NULL, NULL, 0, NULL, 'marcia@gmail.com', '$2y$10$IWQ3UcNI7cjuIG6gn/Yue.EIDdj/HsN7rh2qfJ4cAgnOdlUFiEnv.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 15:47:08', '2025-04-26 15:47:08', NULL, NULL, 'http://localhost:8009/public/images/profile/1888685797CapaSoundCloud.jpg'),
	(113, 'Maria Luca', NULL, NULL, 0, NULL, 'maria6@gmail.com', '$2y$10$faVJHP2ztA9zbM7Ro5HhtuOPG3INVH3bk8OE9VeTVxMrHDBBQgQeG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-04-26 15:47:37', '2025-04-26 15:47:37', NULL, NULL, 'null');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
