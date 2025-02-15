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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela api-doeobem.users: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `nickname`, `phone1`, `has_whatsapp`, `phone2`, `email`, `password`, `postal_code`, `street`, `number`, `complement`, `neighborhood`, `city`, `state`, `country`, `recovery_key`, `first_access`, `last_access`, `access_count`, `receive_newsletter`, `active`, `created_at`, `updated_at`, `deleted_at`, `userscol`, `photo`) VALUES
  (43, 'Admin', NULL, NULL, 0, NULL, 'admin@user.com', '$2y$10$pq4AKQq3ERUX7M9zfVM/z.Z2iFXwg2h0wdGuKdbbgHHV0YQ.yAsHq', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2025-02-15 19:24:22', '2025-02-15 19:24:22', NULL, NULL, 'http://localhost:8009/public/images/profile/2016949700eu.jpg');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
