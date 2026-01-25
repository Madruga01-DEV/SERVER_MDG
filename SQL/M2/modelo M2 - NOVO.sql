-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.28-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para modelo_m2
CREATE DATABASE IF NOT EXISTS `modelo_m2` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `modelo_m2`;

-- Copiando estrutura para procedure modelo_m2.AlterTableMail
DELIMITER //
CREATE PROCEDURE `AlterTableMail`()
BEGIN
    DECLARE table_exists INT DEFAULT 0;
    DECLARE adress_exists INT DEFAULT 0;
    DECLARE adressbook_exists INT DEFAULT 0;
    DECLARE identifier_exists INT DEFAULT 0;

    -- Check if the table exists
    SELECT COUNT(*) INTO table_exists
    FROM information_schema.TABLES
    WHERE TABLE_NAME = 'mail';
    
    -- If table exists, check if columns exist
    IF table_exists = 1 THEN
        SELECT COUNT(*) INTO adress_exists
        FROM information_schema.COLUMNS
        WHERE TABLE_NAME = 'mail' AND COLUMN_NAME = 'adress';

        SELECT COUNT(*) INTO adressbook_exists
        FROM information_schema.COLUMNS
        WHERE TABLE_NAME = 'mail' AND COLUMN_NAME = 'adressbook';

        SELECT COUNT(*) INTO identifier_exists
        FROM information_schema.COLUMNS
        WHERE TABLE_NAME = 'mail' AND COLUMN_NAME = 'identifier';

        -- Conditional altering
        IF adress_exists = 1 THEN
            SET @sql = 'ALTER TABLE mail CHANGE `adress` `address` int(11) NOT NULL AUTO_INCREMENT;';
            PREPARE stmt FROM @sql;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
        END IF;

        IF adressbook_exists = 1 THEN
            SET @sql = 'ALTER TABLE mail DROP COLUMN adressbook;';
            PREPARE stmt FROM @sql;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
        END IF;

        IF identifier_exists = 1 THEN
            SET @sql = 'ALTER TABLE mail DROP COLUMN identifier;';
            PREPARE stmt FROM @sql;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
        END IF;
    END IF;
END//
DELIMITER ;

-- Copiando estrutura para tabela modelo_m2.bank_users
CREATE TABLE IF NOT EXISTS `bank_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `money` double(22,2) DEFAULT 0.00,
  `gold` double(22,2) DEFAULT 0.00,
  `items` longtext DEFAULT '[]',
  `invspace` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `bankusers` (`identifier`) USING BTREE,
  CONSTRAINT `bankusers` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.bank_users: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.bills
CREATE TABLE IF NOT EXISTS `bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longtext DEFAULT NULL,
  `playername` longtext DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `issuer` longtext DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.bills: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.birds
CREATE TABLE IF NOT EXISTS `birds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `charid` int(5) NOT NULL,
  `model` int(25) NOT NULL,
  `name` varchar(50) NOT NULL,
  `preset` int(2) NOT NULL DEFAULT 0,
  `xp` int(6) NOT NULL DEFAULT 0,
  `price` int(8) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.birds: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `steamname` varchar(50) NOT NULL DEFAULT '',
  `charidentifier` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(10) DEFAULT 'user',
  `money` double(11,2) DEFAULT 0.00,
  `gold` double(11,2) DEFAULT 0.00,
  `rol` double(11,2) NOT NULL DEFAULT 0.00,
  `xp` int(11) DEFAULT 0,
  `healthouter` int(4) DEFAULT 500,
  `healthinner` int(4) DEFAULT 100,
  `staminaouter` int(4) DEFAULT 100,
  `staminainner` int(4) DEFAULT 100,
  `hours` float NOT NULL DEFAULT 0,
  `LastLogin` date DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `slots` decimal(20,1) NOT NULL DEFAULT 35.0,
  `job` varchar(50) DEFAULT 'unemployed',
  `joblabel` varchar(255) DEFAULT 'Unemployed',
  `meta` varchar(255) NOT NULL DEFAULT '{}',
  `firstname` varchar(50) DEFAULT ' ',
  `lastname` varchar(50) DEFAULT ' ',
  `character_desc` mediumtext NOT NULL DEFAULT ' ',
  `gender` varchar(50) NOT NULL DEFAULT ' ',
  `age` int(11) NOT NULL DEFAULT 0,
  `nickname` varchar(50) DEFAULT ' ',
  `skinPlayer` longtext DEFAULT NULL,
  `compPlayer` longtext DEFAULT NULL,
  `compTints` longtext DEFAULT NULL,
  `jobgrade` int(11) DEFAULT 0,
  `coords` longtext DEFAULT '{}',
  `status` varchar(140) DEFAULT '{}',
  `isdead` tinyint(1) DEFAULT 0,
  `skills` longtext DEFAULT NULL,
  `walk` varchar(50) DEFAULT 'noanim',
  `gunsmith` double(11,2) DEFAULT 0.00,
  `ammo` longtext DEFAULT '{}',
  `discordid` varchar(255) DEFAULT '0',
  `lastjoined` longtext DEFAULT '[]',
  `moonshineenty` longtext DEFAULT '{}',
  `motel` longtext DEFAULT '0',
  `info` longtext DEFAULT '{}',
  `multijobs` longtext DEFAULT '{}',
  UNIQUE KEY `identifier_charidentifier` (`identifier`,`charidentifier`) USING BTREE,
  KEY `charidentifier` (`charidentifier`) USING BTREE,
  KEY `identifier` (`identifier`),
  KEY `compPlayer` (`compPlayer`(768)),
  KEY `inventory` (`inventory`(768)),
  KEY `coords` (`coords`(768)),
  KEY `money` (`money`),
  KEY `meta` (`meta`),
  KEY `steamname` (`steamname`),
  KEY `info` (`info`(768)),
  CONSTRAINT `FK_characters_users` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela modelo_m2.characters: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.character_inventories
CREATE TABLE IF NOT EXISTS `character_inventories` (
  `character_id` int(11) DEFAULT NULL,
  `inventory_type` varchar(100) NOT NULL DEFAULT 'default',
  `item_crafted_id` int(11) NOT NULL,
  `item_name` varchar(50) DEFAULT 'item',
  `amount` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `degradation` int(11) DEFAULT NULL,
  `percentage` int(11) DEFAULT NULL,
  KEY `character_inventory_idx` (`character_id`,`inventory_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.character_inventories: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.clothes_bought
CREATE TABLE IF NOT EXISTS `clothes_bought` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL,
  `charid` int(11) NOT NULL,
  `hash` bigint(20) NOT NULL,
  `drawable` bigint(20) DEFAULT NULL,
  `albedo` bigint(20) DEFAULT NULL,
  `normal` bigint(20) DEFAULT NULL,
  `material` bigint(20) DEFAULT NULL,
  `palette` bigint(20) DEFAULT NULL,
  `tint0` smallint(6) DEFAULT NULL,
  `tint1` smallint(6) DEFAULT NULL,
  `tint2` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`,`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.clothes_bought: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.container
CREATE TABLE IF NOT EXISTS `container` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT NULL,
  `items` longtext NOT NULL DEFAULT '{}',
  `invslots` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.container: ~70 rows (aproximadamente)
INSERT IGNORE INTO `container` (`id`, `name`, `items`, `invslots`) VALUES
	(1, 'Marshal', '{}', 0),
	(2, 'Doutor', '{}', 0),
	(3, 'Lenhador', '{}', 0),
	(4, 'Fundicao_Valentine', '{}', 0),
	(5, 'Fundicao_Blackwater', '{}', 0),
	(6, 'Fundicao_Sd', '{}', 0),
	(7, 'Ferraria_Armadillo', '{}', 0),
	(8, 'Ferraria_Blackwater', '{}', 0),
	(9, 'Ferraria_Strawberry', '{}', 0),
	(10, 'Ferraria_Valentine', '{}', 0),
	(11, 'Ferraria_Rhodes', '{}', 0),
	(12, 'Ferraria_Saint_Denis', '{}', 0),
	(13, 'Treinador_Rhodes', '{}', 0),
	(14, 'Treinador_Armadillo', '{}', 0),
	(15, 'Treinador_SaitDenis', '{}', 0),
	(16, 'Treinador_Esmerald', '{}', 0),
	(17, 'Treinador_Valentine', '{}', 0),
	(18, 'Treinador_Strawberry', '{}', 0),
	(19, 'Treinador_Blackwater', '{}', 0),
	(20, 'Treinador_Mcf', '{}', 0),
	(21, 'Treinador_Tumbleweed', '{}', 0),
	(22, 'Veterinario_Esmerald', '{}', 0),
	(23, 'Armaria_Rhodes', '{}', 0),
	(24, 'Armaria_SaintDenis', '{}', 0),
	(25, 'Armaria_Annesburg', '{}', 0),
	(26, 'Armaria_Valentine', '{}', 0),
	(27, 'Armaria_Blackwater', '{}', 0),
	(28, 'Armaria_Strawberry', '{}', 0),
	(29, 'Armaria_Tumbleweed', '{}', 0),
	(30, 'Tabacaria_Valentine', '{}', 0),
	(31, 'Tabacaria_Blackwater', '{}', 0),
	(32, 'Padaria_Blackwater', '{}', 0),
	(33, 'Padaria_SaintDenis', '{}', 0),
	(34, 'Saloon_Valentine', '{}', 0),
	(35, 'Saloon_Rhodes', '{}', 0),
	(36, 'Saloon_Armadillo', '{}', 0),
	(37, 'Saloon_VanHorn', '{}', 0),
	(38, 'Saloon_SaintDenis', '{}', 0),
	(39, 'Saloon_Blackwater', '{}', 0),
	(40, 'Saloon_Strawberry', '{}', 0),
	(41, 'Saloon_Annesburg', '{}', 0),
	(42, 'Fazenda_01', '{}', 0),
	(43, 'Fazenda_02', '{}', 0),
	(44, 'Fazenda_03', '{}', 0),
	(45, 'Fazenda_04', '{}', 0),
	(46, 'Fazenda_05', '{}', 0),
	(47, 'Fazenda_06', '{}', 0),
	(48, 'Fazenda_07', '{}', 0),
	(49, 'Fazenda_08', '{}', 0),
	(50, 'Fazenda_09', '{}', 0),
	(51, 'Fazenda_10', '{}', 0),
	(52, 'Fazenda_11', '{}', 0),
	(53, 'Fazenda_12', '{}', 0),
	(54, 'Fazenda_13', '{}', 0),
	(55, 'Fazenda_14', '{}', 0),
	(56, 'Fazenda_15', '{}', 0),
	(57, 'Fazenda_16', '{}', 0),
	(58, 'Fazenda_17', '{}', 0),
	(59, 'Fazenda_18', '{}', 0),
	(60, 'Fazenda_19', '{}', 0),
	(61, 'Fazenda_20', '{}', 0),
	(62, 'Fazenda_21', '{}', 0),
	(63, 'Fazenda_22', '{}', 0),
	(64, 'Fazenda_23', '{}', 0),
	(65, 'Fazenda_24', '{}', 0),
	(66, 'Fazenda_25', '{}', 0),
	(67, 'Fazenda_26', '{}', 0),
	(68, 'Fazenda_27', '{}', 0),
	(69, 'Artesanato_Blackwater', '{}', 0),
	(70, 'Tribo_01', '{}', 0);

-- Copiando estrutura para tabela modelo_m2.doors
CREATE TABLE IF NOT EXISTS `doors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doorinfo` longtext NOT NULL DEFAULT '[]',
  `job` longtext NOT NULL DEFAULT '[]',
  `item` longtext NOT NULL,
  `breakin` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.doors: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.farming
CREATE TABLE IF NOT EXISTS `farming` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(500) NOT NULL,
  `charid` varchar(255) DEFAULT NULL,
  `plant_center` varchar(255) DEFAULT '{}',
  `herbs` longtext NOT NULL DEFAULT '{}',
  `protect` varchar(255) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.farming: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.herbalists
CREATE TABLE IF NOT EXISTS `herbalists` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`identifier`) USING BTREE,
  UNIQUE KEY `identifier_charidentifier` (`identifier`,`charidentifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela modelo_m2.herbalists: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.horse_complements
CREATE TABLE IF NOT EXISTS `horse_complements` (
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) NOT NULL,
  `complements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela modelo_m2.horse_complements: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.housing
CREATE TABLE IF NOT EXISTS `housing` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `charidentifier` int(11) NOT NULL,
  `key` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela modelo_m2.housing: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.items
CREATE TABLE IF NOT EXISTS `items` (
  `item` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT 1,
  `can_remove` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(50) DEFAULT NULL,
  `usable` tinyint(1) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(10) unsigned NOT NULL DEFAULT 1 COMMENT 'Item Group ID for Filtering',
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}',
  `desc` varchar(5550) NOT NULL DEFAULT 'nice item',
  `weight` decimal(20,2) NOT NULL DEFAULT 0.25,
  `degradation` int(11) NOT NULL DEFAULT 0 COMMENT 'if 0 Item do not degrade use a positive number (in minutes) to enable degradation min is 1',
  PRIMARY KEY (`item`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `FK_items_item_group` (`groupId`) USING BTREE,
  CONSTRAINT `FK_items_item_group` FOREIGN KEY (`groupId`) REFERENCES `item_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `metadata` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB AUTO_INCREMENT=1664 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela modelo_m2.items: ~1.046 rows (aproximadamente)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `id`, `groupId`, `metadata`, `desc`, `weight`, `degradation`) VALUES
	('abacaxi', 'Abacaxi', 100, 1, 'item_standard', 1, 638, 1, '{}', 'nice item', 0.50, 0),
	('abelhas', 'Abelhas', 100, 1, 'item_standard', 1, 1512, 1, '{}', 'nice item', 0.50, 0),
	('acessorios', 'Acessorio', 100, 1, 'item_standard', 1, 1379, 1, '{}', 'nice item', 0.50, 0),
	('acessorios_arm', 'Acessorios Arm', 100, 1, 'item_standard', 1, 1395, 1, '{}', 'nice item', 0.50, 0),
	('acessorios_cabelo', 'Acessorios Cabelos', 100, 1, 'item_standard', 1, 1396, 1, '{}', 'nice item', 0.50, 0),
	('acucar', 'Açúcar', 100, 1, 'item_standard', 1, 1141, 1, '{}', 'nice item', 0.50, 0),
	('adrenalina', 'Seringa de Adrenalina', 100, 1, 'item_standard', 1, 1206, 1, '{}', 'nice item', 0.50, 0),
	('agarita', 'Agarita', 100, 1, 'item_standard', 1, 579, 1, '{}', 'nice item', 0.50, 0),
	('agua', 'Agua', 100, 1, 'item_standard', 1, 720, 1, '{}', 'nice item', 0.50, 0),
	('agua_suja', 'Agua Suja', 100, 1, 'item_standard', 1, 721, 1, '{}', 'nice item', 0.50, 0),
	('alcachofra', 'Alcachofra', 100, 1, 'item_standard', 1, 602, 1, '{}', 'nice item', 0.50, 0),
	('alca_couro', 'Alça de Couro', 100, 1, 'item_standard', 1, 1115, 1, '{}', 'nice item', 0.50, 0),
	('alcohol', 'Álcool', 100, 1, 'item_standard', 1, 669, 1, '{}', 'nice item', 0.50, 0),
	('alcoolindustrial', 'Álcool industrial', 100, 1, 'item_standard', 1, 1077, 1, '{}', 'nice item', 0.50, 0),
	('alface', 'Alface', 100, 1, 'item_standard', 1, 606, 1, '{}', 'nice item', 0.50, 0),
	('algema', 'Algema', 100, 1, 'item_standard', 1, 1025, 1, '{}', 'nice item', 0.50, 0),
	('algodao', 'Algodão', 100, 1, 'item_standard', 1, 616, 1, '{}', 'nice item', 0.50, 0),
	('alho', 'Alho', 100, 1, 'item_standard', 1, 604, 1, '{}', 'nice item', 0.50, 0),
	('ameixa', 'Ameixa', 100, 1, 'item_standard', 1, 1662, 1, '{}', 'nice item', 0.25, 0),
	('amido_milho', 'Amido de Milho', 100, 1, 'item_standard', 1, 1149, 1, '{}', 'nice item', 0.50, 0),
	('amora', 'Amora', 100, 1, 'item_standard', 1, 571, 1, '{}', 'nice item', 0.50, 0),
	('anel_de_ouro', 'Anel de Ouro', 100, 1, 'item_standard', 1, 850, 1, '{}', 'nice item', 0.50, 0),
	('anfetamina', 'Anfetamina', 100, 1, 'item_standard', 1, 1080, 1, '{}', 'nice item', 0.50, 0),
	('antibiotic', 'Antibiotico', 100, 1, 'item_standard', 1, 1207, 1, '{}', 'nice item', 0.50, 0),
	('anticoral', 'Anti Coral', 100, 1, 'item_standard', 1, 843, 1, '{}', 'nice item', 0.50, 0),
	('apito', 'Apito de Passaros', 100, 1, 'item_standard', 1, 1427, 1, '{}', 'nice item', 0.50, 0),
	('apple_barrel', 'Barril de maçã', 5, 1, 'item_standard', 1, 897, 1, '{}', 'nice item', 4.00, 0),
	('apple_basket', 'Cesta de maçã', 5, 1, 'item_standard', 1, 898, 1, '{}', 'nice item', 2.00, 0),
	('armadilha', 'Armadilha de Caça', 100, 1, 'item_standard', 1, 1404, 1, '{}', 'nice item', 0.25, 0),
	('armadura', 'Armadura', 100, 1, 'item_standard', 1, 1367, 1, '{}', 'nice item', 0.50, 0),
	('armaria_annesburg', 'Livro Armaria Annesburg', 100, 1, 'item_standard', 1, 1131, 1, '{}', 'nice item', 0.50, 0),
	('armaria_blackwater', 'Livro Armaria Blackwater', 100, 1, 'item_standard', 1, 1133, 1, '{}', 'nice item', 0.50, 0),
	('armaria_rhodes', 'Livro Armaria Rhodes', 100, 1, 'item_standard', 1, 1101, 1, '{}', 'nice item', 0.50, 0),
	('armaria_saintdenis', 'Livro Armaria Saint Denis', 100, 1, 'item_standard', 1, 1130, 1, '{}', 'nice item', 0.50, 0),
	('armaria_strawberry', 'Livro Armaria Strawberry', 100, 1, 'item_standard', 1, 1134, 1, '{}', 'nice item', 0.50, 0),
	('armaria_tumbleweed', 'Livro Armaria Tumbleweed', 100, 1, 'item_standard', 1, 1135, 1, '{}', 'nice item', 0.50, 0),
	('armaria_valentine', 'Livro Armaria Valentine', 100, 1, 'item_standard', 1, 1132, 1, '{}', 'nice item', 0.50, 0),
	('armario_a_prop', 'Armario Medio', 3, 1, 'item_standard', 1, 754, 1, '{}', 'nice item', 8.00, 0),
	('armario_doutor_prop', 'Armario Doctor', 3, 1, 'item_standard', 1, 733, 1, '{}', 'nice item', 5.00, 0),
	('arroz', 'Arroz', 100, 1, 'item_standard', 1, 620, 1, '{}', 'nice item', 0.50, 0),
	('artefato_ritual', 'Artefato Ritualístico', 100, 1, 'item_standard', 1, 1248, 1, '{}', 'nice item', 0.50, 0),
	('artesanato_blackwater', 'Livro Artesanato Blackwater', 100, 1, 'item_standard', 1, 1190, 1, '{}', 'nice item', 0.50, 0),
	('arvore_natal_prop', 'Arvore de Natal', 3, 1, 'item_standard', 1, 738, 1, '{}', 'nice item', 6.00, 0),
	('asa_morcego', 'Asa de Morcego', 100, 1, 'item_standard', 1, 876, 1, '{}', 'nice item', 0.10, 0),
	('asclepias', 'Asclepias', 100, 1, 'item_standard', 1, 594, 1, '{}', 'nice item', 0.50, 0),
	('avental', 'Avental', 100, 1, 'item_standard', 1, 1383, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishbluegil_01_ms', 'Blue Gil (Médio)', 100, 1, 'item_standard', 1, 804, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishbluegil_01_sm', 'Blue Gil (Pequeno)', 100, 1, 'item_standard', 1, 805, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishbullheadcat_01_ms', 'Bagre Bullhead (Médio)', 100, 1, 'item_standard', 1, 806, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishbullheadcat_01_sm', 'Bagre Bullhead (Pequeno)', 100, 1, 'item_standard', 1, 807, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishchainpickerel_01_ms', 'Pickerel em Corrente (Médio)', 100, 1, 'item_standard', 1, 808, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishchainpickerel_01_sm', 'Pickerel em Corrente (Pequeno)', 100, 1, 'item_standard', 1, 809, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishchannelcatfish_01_lg', 'Bagre do Canal (Grande)', 100, 1, 'item_standard', 1, 810, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishchannelcatfish_01_xl', 'Bagre do Canal (Extra Grande)', 100, 1, 'item_standard', 1, 811, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishlakesturgeon_01_lg', 'Esturjão do Lago (Grande)', 100, 1, 'item_standard', 1, 812, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishlargemouthbass_01_lg', 'Black Bass de Boca Grande (Grande)', 100, 1, 'item_standard', 1, 813, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishlargemouthbass_01_ms', 'Black Bass de Boca Grande (Médio)', 100, 1, 'item_standard', 1, 814, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishlongnosegar_01_lg', 'Peixe-gar-de-focinho-longo (Grande)', 100, 1, 'item_standard', 1, 815, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishmuskie_01_lg', 'Muskellunge (Grande)', 100, 1, 'item_standard', 1, 816, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishnorthernpike_01_lg', 'Lucio-do-Norte (Grande)', 100, 1, 'item_standard', 1, 817, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishperch_01_ms', 'Perca (Médio)', 100, 1, 'item_standard', 1, 818, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishperch_01_sm', 'Perca (Pequeno)', 100, 1, 'item_standard', 1, 819, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishrainbowtrout_01_lg', 'Truta Arco-íris (Grande)', 100, 1, 'item_standard', 1, 820, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishrainbowtrout_01_ms', 'Truta Arco-íris (Médio)', 100, 1, 'item_standard', 1, 821, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishredfinpickerel_01_ms', 'Pickerel de Barbatana Vermelha (Médio)', 100, 1, 'item_standard', 1, 822, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishredfinpickerel_01_sm', 'Pickerel de Barbatana Vermelha (Pequeno)', 100, 1, 'item_standard', 1, 823, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishrockbass_01_ms', 'Rock Bass (Médio)', 100, 1, 'item_standard', 1, 824, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishrockbass_01_sm', 'Rock Bass (Pequeno)', 100, 1, 'item_standard', 1, 825, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishsalmonsockeye_01_lg', 'Salmão Sockeye (Grande)', 100, 1, 'item_standard', 1, 826, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishsalmonsockeye_01_ml', 'Salmão Sockeye (Médio-Grande)', 100, 1, 'item_standard', 1, 827, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishsalmonsockeye_01_ms', 'Salmão Sockeye (Médio)', 100, 1, 'item_standard', 1, 828, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishsmallmouthbass_01_lg', 'Black Bass de Boca Pequena (Grande)', 100, 1, 'item_standard', 1, 829, 1, '{}', 'nice item', 0.50, 0),
	('a_c_fishsmallmouthbass_01_ms', 'Black Bass de Boca Pequena (Médio)', 100, 1, 'item_standard', 1, 830, 1, '{}', 'nice item', 0.50, 0),
	('babosa', 'Babosa', 100, 1, 'item_standard', 1, 608, 1, '{}', 'nice item', 0.50, 0),
	('balde_agua_suja', 'Balde de agua suja', 100, 1, 'item_standard', 1, 1256, 1, '{}', 'nice item', 0.25, 0),
	('balde_cheio', 'Balde Cheio', 100, 1, 'item_standard', 1, 1255, 1, '{}', 'nice item', 0.25, 0),
	('balde_vazio', 'Balde Vazio', 100, 1, 'item_standard', 1, 1245, 1, '{}', 'nice item', 0.50, 0),
	('bambu', 'bambu', 100, 1, 'item_standard', 1, 648, 1, '{}', 'nice item', 0.50, 0),
	('banana', 'Banana', 100, 1, 'item_standard', 1, 624, 1, '{}', 'nice item', 0.50, 0),
	('bandage', 'Bandagem', 100, 1, 'item_standard', 1, 1022, 1, '{}', 'nice item', 0.50, 0),
	('bandana', 'Bandana', 100, 1, 'item_standard', 1, 717, 1, '{}', 'nice item', 0.50, 0),
	('bandeira_dominas', 'Bandeira de Dominação', 100, 1, 'item_standard', 1, 879, 1, '{}', 'nice item', 0.50, 0),
	('barbante', 'Barbante', 100, 1, 'item_standard', 1, 1198, 1, '{}', 'nice item', 0.50, 0),
	('baril_de_agua_prop', 'Baril De Agua', 5, 1, 'item_standard', 1, 766, 1, '{}', 'nice item', 8.00, 0),
	('barrel', 'Barril', 100, 1, 'item_standard', 1, 665, 1, '{}', 'nice item', 0.50, 0),
	('batata', 'Batata', 100, 1, 'item_standard', 1, 598, 1, '{}', 'nice item', 0.50, 0),
	('bateia', 'Bateia de Ouro', 100, 1, 'item_standard', 1, 1403, 1, '{}', 'nice item', 0.25, 0),
	('bau_a_prop', 'Baú 1', 2, 1, 'item_standard', 1, 758, 1, '{}', 'nice item', 18.00, 0),
	('bau_b_prop', 'Baú 2', 2, 1, 'item_standard', 1, 759, 1, '{}', 'nice item', 15.00, 0),
	('bau_c_prop', 'Baú 3', 2, 1, 'item_standard', 1, 760, 1, '{}', 'nice item', 20.00, 0),
	('bcandle', 'Vela de garrafa', 5, 1, 'item_standard', 1, 926, 1, '{}', 'nice item', 0.30, 0),
	('bear_bench', 'Banco de Urso', 30, 1, 'item_standard', 1, 908, 1, '{}', 'nice item', 4.00, 0),
	('beehive_box', 'Apiário', 100, 1, 'item_standard', 1, 1204, 1, '{}', 'nice item', 0.50, 0),
	('big_firecracker', 'grande foguete', 100, 1, 'item_standard', 1, 1400, 1, '{}', 'nice item', 0.25, 0),
	('big_fireworks', 'grandes fogos de artifício', 100, 1, 'item_standard', 1, 1398, 1, '{}', 'nice item', 0.25, 0),
	('birdcall', 'Apito para Pássaro Indígena', 100, 1, 'item_standard', 1, 1246, 1, '{}', 'nice item', 0.50, 0),
	('blanket_box', 'Caixa de cobertor', 5, 1, 'item_standard', 1, 895, 1, '{}', 'nice item', 3.00, 0),
	('blooditem', 'Feitiço quebra osso', 100, 1, 'item_standard', 1, 1468, 1, '{}', 'nice item', 0.25, 0),
	('bmdresser', 'Cômoda espelho marrom', 35, 1, 'item_standard', 1, 915, 1, '{}', 'nice item', 7.00, 0),
	('boat_ticket', 'Ticket Barco', 100, 1, 'item_standard', 1, 854, 1, '{}', 'nice item', 0.50, 0),
	('bolo_banana', 'Bolo de Banana', 100, 1, 'item_standard', 1, 1157, 1, '{}', 'nice item', 0.50, 0),
	('bolo_cenoura', 'Bolo de Cenoura', 100, 1, 'item_standard', 1, 1139, 1, '{}', 'nice item', 0.50, 0),
	('bolo_chocolate', 'Bolo de Chocolate', 100, 1, 'item_standard', 1, 1158, 1, '{}', 'nice item', 0.50, 0),
	('bolo_limao', 'Bolo de Limão', 100, 1, 'item_standard', 1, 1150, 1, '{}', 'nice item', 0.50, 0),
	('bolo_milho', 'Bolo de Milho', 100, 1, 'item_standard', 1, 1153, 1, '{}', 'nice item', 0.50, 0),
	('bolsa', 'Bolsa', 100, 1, 'item_standard', 1, 1381, 1, '{}', 'nice item', 0.50, 0),
	('bomba_de_agua_prop', 'Bomba de Aguá', 3, 1, 'item_standard', 1, 774, 1, '{}', 'nice item', 10.00, 0),
	('bonecovoodo', 'Boneco Voodo', 100, 1, 'item_standard', 1, 1523, 1, '{}', 'nice item', 0.50, 0),
	('bookcase', 'Estante', 10, 1, 'item_standard', 1, 958, 1, '{}', 'nice item', 15.00, 0),
	('boost_cavalo', 'Boost para cavalo', 100, 1, 'item_standard', 1, 1084, 1, '{}', 'nice item', 0.50, 0),
	('botas', 'Botas', 100, 1, 'item_standard', 1, 1390, 1, '{}', 'nice item', 0.50, 0),
	('brocolis', 'Brócolis', 100, 1, 'item_standard', 1, 614, 1, '{}', 'nice item', 0.50, 0),
	('brush', 'Escova de cavalo', 100, 1, 'item_standard', 1, 1089, 1, '{}', 'nice item', 0.50, 0),
	('bunkbed', 'Beliche', 20, 1, 'item_standard', 1, 928, 1, '{}', 'nice item', 15.00, 0),
	('bussola', 'Bussola', 100, 1, 'item_standard', 1, 786, 1, '{}', 'nice item', 0.50, 0),
	('bwdresser', 'Cômoda madeira marrom', 25, 1, 'item_standard', 1, 914, 1, '{}', 'nice item', 6.00, 0),
	('C1', 'Bengala 1', 100, 1, 'item_standard', 1, 1452, 1, '{}', 'nice item', 0.25, 0),
	('C2', 'Bengala 2', 100, 1, 'item_standard', 1, 1453, 1, '{}', 'nice item', 0.25, 0),
	('cabedero_prop', 'Cabedero', 5, 1, 'item_standard', 1, 732, 1, '{}', 'nice item', 2.00, 0),
	('cabo', 'Cabo de Madeira', 100, 1, 'item_standard', 1, 1054, 1, '{}', 'nice item', 0.50, 0),
	('cacau', 'Cacau', 100, 1, 'item_standard', 1, 630, 1, '{}', 'nice item', 0.50, 0),
	('cachaca', 'Cachaça', 100, 1, 'item_standard', 1, 1180, 1, '{}', 'nice item', 0.50, 0),
	('cachimbo', 'Cachimbo', 100, 1, 'item_standard', 1, 1288, 1, '{}', 'nice item', 0.25, 0),
	('cactos', 'Cactos', 100, 1, 'item_standard', 1, 650, 1, '{}', 'nice item', 0.50, 0),
	('cadeira_de_madeira_prop', 'Cadeira de Madeira', 10, 1, 'item_standard', 1, 768, 1, '{}', 'nice item', 3.00, 0),
	('cadeira_presidente_prop', 'Cadeira Presidente', 5, 1, 'item_standard', 1, 769, 1, '{}', 'nice item', 4.00, 0),
	('cafe', 'Café', 100, 1, 'item_standard', 1, 626, 1, '{}', 'nice item', 0.50, 0),
	('cafemoido', 'Café Moido', 100, 1, 'item_standard', 1, 1145, 1, '{}', 'nice item', 0.50, 0),
	('cafe_puro', 'Café Puro', 100, 1, 'item_standard', 1, 1155, 1, '{}', 'nice item', 0.50, 0),
	('cage', 'Jaula', 10, 1, 'item_standard', 1, 957, 1, '{}', 'nice item', 12.00, 0),
	('caixadonatespecia2', 'Caixa Especial #2', 100, 1, 'item_standard', 1, 1515, 1, '{}', 'nice item', 0.25, 0),
	('caixadonatespecial', 'Caixa Especial #1', 100, 1, 'item_standard', 1, 1514, 1, '{}', 'nice item', 0.25, 0),
	('caixao_a_prop', 'Caixão', 2, 1, 'item_standard', 1, 1309, 1, '{}', 'nice item', 15.00, 0),
	('caixao_b_prop', 'Caixão Aberto', 2, 1, 'item_standard', 1, 753, 1, '{}', 'nice item', 15.00, 0),
	('caixao_prop', 'Caixão Prop', 100, 1, 'item_standard', 1, 752, 1, '{}', 'nice item', 0.50, 0),
	('caixa_abelha_1', 'Caixa de Abelha 1', 100, 1, 'item_standard', 1, 1505, 1, '{}', 'nice item', 0.50, 0),
	('caixa_abelha_2', 'Caixa de Abelha 2', 100, 1, 'item_standard', 1, 1506, 1, '{}', 'nice item', 0.50, 0),
	('caixa_abelha_3', 'Caixa de Abelha 3', 100, 1, 'item_standard', 1, 1507, 1, '{}', 'nice item', 0.50, 0),
	('caixa_abelha_4', 'Caixa de Abelha 4', 100, 1, 'item_standard', 1, 1508, 1, '{}', 'nice item', 0.50, 0),
	('caixa_abelha_5', 'Caixa de Abelha 5', 100, 1, 'item_standard', 1, 1509, 1, '{}', 'nice item', 0.50, 0),
	('caixa_abelha_6', 'Caixa de Abelha 6', 100, 1, 'item_standard', 1, 1510, 1, '{}', 'nice item', 0.50, 0),
	('caixa_cerveja_prop', 'Caixa De Cerveja', 10, 1, 'item_standard', 1, 765, 1, '{}', 'nice item', 4.00, 0),
	('caixa_ferramenta', 'Caixa de Ferramentas', 100, 1, 'item_standard', 1, 1057, 1, '{}', 'nice item', 0.50, 0),
	('calderaosagrado', 'Calderão', 100, 1, 'item_standard', 1, 1528, 1, '{}', 'nice item', 0.50, 0),
	('calendula', 'Calêndula', 100, 1, 'item_standard', 1, 541, 1, '{}', 'nice item', 0.50, 0),
	('calsas', 'Calas', 100, 1, 'item_standard', 1, 1384, 1, '{}', 'nice item', 0.50, 0),
	('cama_nativa_a_prop', 'Cama Nativa', 2, 1, 'item_standard', 1, 734, 1, '{}', 'nice item', 8.00, 0),
	('camisas_fechada', 'Camisas Fechadas', 100, 1, 'item_standard', 1, 1366, 1, '{}', 'nice item', 0.50, 0),
	('camomila', 'Camomila', 100, 1, 'item_standard', 1, 708, 1, '{}', 'nice item', 0.50, 0),
	('campfire', 'Fogueira', 100, 1, 'item_standard', 1, 1033, 1, '{}', 'nice item', 0.50, 0),
	('canaacucar', 'Cana de Açúcar', 100, 1, 'item_standard', 1, 622, 1, '{}', 'nice item', 0.50, 0),
	('candlea', 'Vela', 5, 1, 'item_standard', 1, 924, 1, '{}', 'nice item', 0.20, 0),
	('cannabis', 'Folha de Cannabis', 100, 1, 'item_standard', 1, 1291, 1, '{}', 'nice item', 0.25, 0),
	('cantil', 'Cantil ', 100, 1, 'item_standard', 1, 1424, 1, '{}', 'nice item', 0.25, 0),
	('cantil_vazio', 'Cantil Vazio', 100, 1, 'item_standard', 1, 1423, 1, '{}', 'nice item', 0.25, 0),
	('capacete_minerador', 'Capacete Minerador', 100, 1, 'item_standard', 1, 835, 1, '{}', 'nice item', 0.50, 0),
	('cappuccino', 'Cappuccino', 100, 1, 'item_standard', 1, 1144, 1, '{}', 'nice item', 0.50, 0),
	('capsula_muni', 'Capsula de Munição', 100, 1, 'item_standard', 1, 1049, 1, '{}', 'nice item', 0.50, 0),
	('caranguejo', 'Caranguejo', 100, 1, 'item_standard', 1, 1397, 1, '{}', 'nice item', 0.25, 0),
	('carnepeixe', 'Carne de Peixe', 100, 1, 'item_standard', 1, 1169, 1, '{}', 'nice item', 0.50, 0),
	('carne_assada', 'Carne Assada', 100, 1, 'item_standard', 1, 1032, 1, '{}', 'nice item', 0.50, 0),
	('carne_ave', 'Carne de Ave', 100, 1, 'item_standard', 1, 859, 1, '{}', 'nice item', 0.30, 0),
	('carne_caca', 'Carne de Caça', 100, 1, 'item_standard', 1, 858, 1, '{}', 'nice item', 0.80, 0),
	('carne_morango', 'Carne com Molho de Morango', 100, 1, 'item_standard', 1, 1183, 1, '{}', 'nice item', 0.50, 0),
	('carregadores', 'Carregadores', 100, 1, 'item_standard', 1, 1380, 1, '{}', 'nice item', 0.50, 0),
	('cartaz', 'Cartaz', 100, 1, 'item_standard', 1, 718, 1, '{}', 'nice item', 0.50, 0),
	('carvao', 'Carvão', 100, 1, 'item_standard', 1, 1029, 1, '{}', 'nice item', 0.50, 0),
	('carvao_refinado', 'Carvão Refinado', 100, 1, 'item_standard', 1, 1046, 1, '{}', 'nice item', 0.50, 0),
	('casaco', 'Casaco', 100, 1, 'item_standard', 1, 1373, 1, '{}', 'nice item', 0.50, 0),
	('casaco_fechado', 'Casaco Fechado', 100, 1, 'item_standard', 1, 1374, 1, '{}', 'nice item', 0.50, 0),
	('cascalho', 'Cascalho', 100, 1, 'item_standard', 1, 1051, 1, '{}', 'nice item', 0.50, 0),
	('casca_caranguejo', 'Casca de Caranguejo', 100, 1, 'item_standard', 1, 878, 1, '{}', 'nice item', 0.30, 0),
	('casco_tartaruga', 'Casco de Tartaruga', 100, 1, 'item_standard', 1, 872, 1, '{}', 'nice item', 1.00, 0),
	('casco_tatu', 'Casco de Tatu', 100, 1, 'item_standard', 1, 875, 1, '{}', 'nice item', 0.60, 0),
	('cauda_castor', 'Cauda de Castor', 100, 1, 'item_standard', 1, 874, 1, '{}', 'nice item', 0.40, 0),
	('cela_prop', 'Cela', 2, 1, 'item_standard', 1, 737, 1, '{}', 'nice item', 10.00, 0),
	('celulose', 'Celulose', 100, 1, 'item_standard', 1, 1202, 1, '{}', 'nice item', 0.50, 0),
	('cenoura', 'Cenoura', 100, 1, 'item_standard', 1, 575, 1, '{}', 'nice item', 0.50, 0),
	('cenouraselvagem', 'Cenoura Silvestre', 100, 1, 'item_standard', 1, 711, 1, '{}', 'nice item', 0.50, 0),
	('cerca_madeira', 'Cerca de Madeira Prop', 100, 1, 'item_standard', 1, 744, 1, '{}', 'nice item', 0.50, 0),
	('cerca_madeira_prop', 'Cerca de Madeira', 20, 1, 'item_standard', 1, 1308, 1, '{}', 'nice item', 3.00, 0),
	('certificado', 'Certificado', 1, 1, 'item_standard', 1, 1655, 1, '{}', 'nice item', 0.25, 0),
	('certificado_armas', 'Certificado de Armas', 1, 1, 'item_standard', 1, 1657, 1, '{}', 'nice item', 0.25, 0),
	('certificado_cacador', 'Certificado de Caçador', 1, 1, 'item_standard', 1, 1656, 1, '{}', 'nice item', 0.25, 0),
	('certificado_medico', 'Certificado Médico', 1, 1, 'item_standard', 1, 1660, 1, '{}', 'nice item', 0.25, 0),
	('certificado_mineracao', 'Certificado de Mineração', 1, 1, 'item_standard', 1, 1659, 1, '{}', 'nice item', 0.25, 0),
	('certificado_pesca', 'Certificado de Pesca', 1, 1, 'item_standard', 1, 1658, 1, '{}', 'nice item', 0.25, 0),
	('cestadeflores', 'Cesta de Flores', 100, 1, 'item_standard', 1, 1524, 1, '{}', 'nice item', 0.50, 0),
	('cestaervas', 'Cesta de Flores', 100, 1, 'item_standard', 1, 1525, 1, '{}', 'nice item', 0.50, 0),
	('cesto_nativo_a_prop', 'Cesto Nativo 1', 10, 1, 'item_standard', 1, 746, 1, '{}', 'nice item', 1.00, 0),
	('cesto_nativo_b_prop', 'Cesto Nativo 2', 10, 1, 'item_standard', 1, 747, 1, '{}', 'nice item', 1.00, 0),
	('champanherose', 'Champanhe Rose', 100, 1, 'item_standard', 1, 1186, 1, '{}', 'nice item', 0.50, 0),
	('changer', 'Cabide', 10, 1, 'item_standard', 1, 959, 1, '{}', 'nice item', 4.00, 0),
	('chapeu', 'Chapeu', 100, 1, 'item_standard', 1, 1378, 1, '{}', 'nice item', 0.50, 0),
	('chaps', 'Chapes', 100, 1, 'item_standard', 1, 1393, 1, '{}', 'nice item', 0.50, 0),
	('charuto_aromatizado', 'Charuto Aromatizado', 100, 1, 'item_standard', 1, 1290, 1, '{}', 'nice item', 0.25, 0),
	('chave_algema', 'Chave De Algema', 100, 1, 'item_standard', 1, 1026, 1, '{}', 'nice item', 0.50, 0),
	('chave_trem', 'Chave Do Trem', 100, 1, 'item_standard', 1, 1028, 1, '{}', 'nice item', 0.50, 0),
	('cha_hortela', 'Chá de Hortelã', 100, 1, 'item_standard', 1, 1146, 1, '{}', 'nice item', 0.50, 0),
	('cha_limao', 'Chá de Limão e Mel', 100, 1, 'item_standard', 1, 1160, 1, '{}', 'nice item', 0.50, 0),
	('chesta', 'Baú 1', 50, 1, 'item_standard', 1, 920, 1, '{}', 'nice item', 8.00, 0),
	('chestb', 'Baú 2', 50, 1, 'item_standard', 1, 921, 1, '{}', 'nice item', 8.00, 0),
	('chestc', 'Peito C', 10, 1, 'item_standard', 1, 935, 1, '{}', 'nice item', 8.00, 0),
	('chewingtobacco', 'Tabaco De Mascar', 100, 1, 'item_standard', 1, 728, 1, '{}', 'nice item', 0.50, 0),
	('chifre', 'Chifre', 100, 1, 'item_standard', 1, 864, 1, '{}', 'nice item', 0.80, 0),
	('cigarro', 'Cigarro', 100, 1, 'item_standard', 1, 725, 1, '{}', 'nice item', 0.50, 0),
	('cintos', 'Cintos', 100, 1, 'item_standard', 1, 1386, 1, '{}', 'nice item', 0.50, 0),
	('cinto_muni', 'Cinto De Munição', 100, 1, 'item_standard', 1, 1388, 1, '{}', 'nice item', 0.50, 0),
	('clothepolice1', 'Uniforme 1', 100, 1, 'item_standard', 1, 778, 1, '{}', 'nice item', 0.50, 0),
	('clothepolice2', 'Uniforme 2', 100, 1, 'item_standard', 1, 779, 1, '{}', 'nice item', 0.50, 0),
	('clothepolice3', 'Uniforme 3', 100, 1, 'item_standard', 1, 780, 1, '{}', 'nice item', 0.50, 0),
	('clothepolice4', 'Uniforme 4', 100, 1, 'item_standard', 1, 781, 1, '{}', 'nice item', 0.50, 0),
	('clothepolice5', 'Uniforme 5', 100, 1, 'item_standard', 1, 782, 1, '{}', 'nice item', 0.50, 0),
	('clothepolice6', 'Uniforme 6', 100, 1, 'item_standard', 1, 783, 1, '{}', 'nice item', 0.50, 0),
	('clothepolice7', 'Uniforme 7', 100, 1, 'item_standard', 1, 784, 1, '{}', 'nice item', 0.50, 0),
	('clothes_line', 'Varal de roupas', 5, 1, 'item_standard', 1, 901, 1, '{}', 'nice item', 2.00, 0),
	('cloth_bench', 'Banco de pano', 15, 1, 'item_standard', 1, 911, 1, '{}', 'nice item', 2.50, 0),
	('cogumelo', 'Cogumelo Ostra', 100, 1, 'item_standard', 1, 712, 1, '{}', 'nice item', 0.50, 0),
	('cogumelobolete', 'Cogumelo Bolete', 100, 1, 'item_standard', 1, 545, 1, '{}', 'nice item', 0.50, 0),
	('cogumeloguardasol', 'Cogumelo guarda-sol', 100, 1, 'item_standard', 1, 533, 1, '{}', 'nice item', 0.50, 0),
	('cogumeloschanterelles', 'Cogumelos chanterelles', 100, 1, 'item_standard', 1, 581, 1, '{}', 'nice item', 0.50, 0),
	('cogumelo_venenoso', 'Cogumelo Venenoso', 100, 1, 'item_standard', 1, 856, 1, '{}', 'nice item', 0.50, 0),
	('cola', 'Cola', 100, 1, 'item_standard', 1, 1197, 1, '{}', 'nice item', 0.50, 0),
	('colar', 'Colar', 100, 1, 'item_standard', 1, 1382, 1, '{}', 'nice item', 0.50, 0),
	('coldres', 'Coldre', 100, 1, 'item_standard', 1, 1389, 1, '{}', 'nice item', 0.50, 0),
	('coletes', 'Coletes', 100, 1, 'item_standard', 1, 1372, 1, '{}', 'nice item', 0.50, 0),
	('condenser', 'Condensador', 100, 1, 'item_standard', 1, 660, 1, '{}', 'nice item', 0.50, 0),
	('coracao_animal', 'Coração de Animal', 100, 1, 'item_standard', 1, 868, 1, '{}', 'nice item', 0.30, 0),
	('corino', 'Corino', 100, 1, 'item_standard', 1, 1194, 1, '{}', 'nice item', 0.50, 0),
	('corpo_escopeta', 'Corpo de Escopeta', 100, 1, 'item_standard', 1, 1062, 1, '{}', 'nice item', 0.50, 0),
	('corpo_pistola', 'Corpo de Pistola', 100, 1, 'item_standard', 1, 1064, 1, '{}', 'nice item', 0.50, 0),
	('corpo_revolver', 'Corpo de Revolver', 100, 1, 'item_standard', 1, 1292, 1, '{}', 'nice item', 0.25, 0),
	('corpo_rifle', 'Corpo de Rifle', 100, 1, 'item_standard', 1, 1063, 1, '{}', 'nice item', 0.50, 0),
	('cougar_taxidermy', 'Taxidermia de puma', 30, 1, 'item_standard', 1, 906, 1, '{}', 'nice item', 3.50, 0),
	('coyote_taxidermy', 'Taxidermia de Coiote', 25, 1, 'item_standard', 1, 903, 1, '{}', 'nice item', 3.00, 0),
	('crafting_fire', 'Criando Fogo', 25, 1, 'item_standard', 1, 888, 1, '{}', 'nice item', 3.00, 0),
	('cranio', 'Cranio Humano', 100, 1, 'item_standard', 1, 1526, 1, '{}', 'nice item', 0.50, 0),
	('cranio_humano', 'Cranio Humano', 100, 1, 'item_standard', 1, 846, 1, '{}', 'nice item', 0.50, 0),
	('creme_capilar', 'Creme Capilar', 100, 1, 'item_standard', 1, 831, 1, '{}', 'nice item', 0.50, 0),
	('cruza', 'Remedio Para Cruzar', 100, 1, 'item_standard', 1, 1360, 1, '{}', 'nice item', 0.25, 0),
	('cruz_com_caveira_prop', 'Cruz Com Caveira', 5, 1, 'item_standard', 1, 749, 1, '{}', 'nice item', 2.50, 0),
	('cura_cavalo', 'Ramédio para Cavalo', 100, 1, 'item_standard', 1, 1087, 1, '{}', 'nice item', 0.50, 0),
	('cure', 'Cura', 100, 1, 'item_standard', 1, 1467, 1, '{}', 'nice item', 0.25, 0),
	('curtimento', 'Curtimento', 100, 1, 'item_standard', 1, 1195, 1, '{}', 'nice item', 0.50, 0),
	('cuscuz_com_ovo', 'Cuscuz com ovo', 100, 1, 'item_standard', 1, 1142, 1, '{}', 'nice item', 0.50, 0),
	('dbcandle', 'Vela Dbl', 5, 1, 'item_standard', 1, 923, 1, '{}', 'nice item', 0.30, 0),
	('decoracao_nativa_a_prop', 'Decoração Nativa 1', 10, 1, 'item_standard', 1, 748, 1, '{}', 'nice item', 1.50, 0),
	('deernativetent', 'Tenda Nativa de Pele de Veado', 10, 1, 'item_standard', 1, 966, 1, '{}', 'nice item', 13.00, 0),
	('deer_taxidermy', 'Taxidermia de Veados', 15, 1, 'item_standard', 1, 905, 1, '{}', 'nice item', 2.50, 0),
	('dente_de_ouro', 'Dente de Ouro', 100, 1, 'item_standard', 1, 849, 1, '{}', 'nice item', 0.50, 0),
	('desativado', 'Item Desativado', 100, 1, 'item_standard', 1, 731, 1, '{}', 'nice item', 0.50, 0),
	('detectiveverify', 'Teste Detetive', 100, 1, 'item_standard', 1, 1021, 1, '{}', 'nice item', 0.50, 0),
	('diario', 'Diario ', 100, 1, 'item_standard', 1, 1415, 1, '{}', 'nice item', 0.25, 0),
	('dinheiro_sujo', 'Dinheiro Sujo', 5000, 1, 'item_standard', 1, 880, 1, '{}', 'nice item', 0.50, 0),
	('distintivos', 'Distintivos', 100, 1, 'item_standard', 1, 1394, 1, '{}', 'nice item', 0.50, 0),
	('distintivo_delegado', 'Distintivo De Delegado', 100, 1, 'item_standard', 1, 1352, 1, '{}', 'nice item', 0.50, 0),
	('distintivo_delegado2', 'Distintivo De Delegado 2', 100, 1, 'item_standard', 1, 1353, 1, '{}', 'nice item', 0.50, 0),
	('distintivo_marshal', 'Distintivo De Marshal', 100, 1, 'item_standard', 1, 1358, 1, '{}', 'nice item', 0.50, 0),
	('distintivo_oficial', 'Distintivo De Oficial', 100, 1, 'item_standard', 1, 1354, 1, '{}', 'nice item', 0.50, 0),
	('distintivo_pinkerton', 'Distintivo De Pinkerton', 100, 1, 'item_standard', 1, 1359, 1, '{}', 'nice item', 0.50, 0),
	('distintivo_policia', 'Distintivo De Policia', 100, 1, 'item_standard', 1, 1356, 1, '{}', 'nice item', 0.50, 0),
	('distintivo_texas_ranger', 'Distintivo De Texas Ranger', 100, 1, 'item_standard', 1, 1357, 1, '{}', 'nice item', 0.50, 0),
	('distintivo_xeriff', 'Distintivo De Xeriff', 100, 1, 'item_standard', 1, 1355, 1, '{}', 'nice item', 0.50, 0),
	('dreamcatcher', 'Apanhador de Sonhos', 10, 1, 'item_standard', 1, 948, 1, '{}', 'nice item', 0.50, 0),
	('dynamite', 'dinamite', 100, 1, 'item_standard', 1, 684, 1, '{}', 'nice item', 0.50, 0),
	('embalagem', 'Embalagem', 100, 1, 'item_standard', 1, 1078, 1, '{}', 'nice item', 0.50, 0),
	('empanado_peixe', 'Empanado de Peixe com arroz', 100, 1, 'item_standard', 1, 1162, 1, '{}', 'nice item', 0.50, 0),
	('ervaamarga', 'Erva amarga', 100, 1, 'item_standard', 1, 537, 1, '{}', 'nice item', 0.50, 0),
	('espantalho_prop', 'Espantalho', 5, 1, 'item_standard', 1, 756, 1, '{}', 'nice item', 4.00, 0),
	('estacao_de_comida_prop', 'Estação de Comida', 3, 1, 'item_standard', 1, 773, 1, '{}', 'nice item', 8.00, 0),
	('estimulante_cavalo', 'Estimulante para cavalo', 100, 1, 'item_standard', 1, 1085, 1, '{}', 'nice item', 0.50, 0),
	('estimulante_cavalo_raro', 'Estimulante Raro para cavalo', 100, 1, 'item_standard', 1, 1483, 1, '{}', 'nice item', 0.25, 0),
	('exporas', 'Exporas', 100, 1, 'item_standard', 1, 1391, 1, '{}', 'nice item', 0.50, 0),
	('extrato_tomate', 'Extrato de Tomate', 100, 1, 'item_standard', 1, 1177, 1, '{}', 'nice item', 0.50, 0),
	('fancydouble', 'Cama casal chique', 50, 1, 'item_standard', 1, 930, 1, '{}', 'nice item', 18.00, 0),
	('farinha_trigo', 'Farinha de Trigo', 100, 1, 'item_standard', 1, 1140, 1, '{}', 'nice item', 0.50, 0),
	('favo_de_mel', 'Favo de Mel', 100, 1, 'item_standard', 1, 1511, 1, '{}', 'nice item', 0.50, 0),
	('favo_mel', 'Favo de Mel', 1, 1, 'item_standard', 1, 1349, 1, '{}', 'nice item', 0.50, 0),
	('fazenda_01', 'Livro Fazenda 01', 100, 1, 'item_standard', 1, 1188, 1, '{}', 'nice item', 0.50, 0),
	('fazenda_02', 'Livro Fazenda 02', 100, 1, 'item_standard', 1, 1050, 1, '{}', 'nice item', 0.50, 0),
	('Feather1', 'Penas 1', 100, 1, 'item_standard', 1, 1232, 1, '{}', 'nice item', 0.50, 0),
	('Feather2', 'Penas 2', 100, 1, 'item_standard', 1, 1233, 1, '{}', 'nice item', 0.50, 0),
	('Feather3', 'Penas 3', 100, 1, 'item_standard', 1, 1234, 1, '{}', 'nice item', 0.50, 0),
	('Feather4', 'Penas 4', 100, 1, 'item_standard', 1, 1235, 1, '{}', 'nice item', 0.50, 0),
	('Feather5', 'Penas 5', 100, 1, 'item_standard', 1, 1236, 1, '{}', 'nice item', 0.50, 0),
	('Feather6', 'Penas 6', 100, 1, 'item_standard', 1, 1237, 1, '{}', 'nice item', 0.50, 0),
	('Feather7', 'Penas 7', 100, 1, 'item_standard', 1, 1238, 1, '{}', 'nice item', 0.50, 0),
	('Feather8', 'Penas 8', 100, 1, 'item_standard', 1, 1239, 1, '{}', 'nice item', 0.50, 0),
	('feijao', 'Feijão', 100, 1, 'item_standard', 1, 610, 1, '{}', 'nice item', 0.50, 0),
	('fermento', 'Fermento', 100, 1, 'item_standard', 1, 678, 1, '{}', 'nice item', 0.50, 0),
	('ferraria_armadillo', 'Livro Ferraria Armadillo', 100, 1, 'item_standard', 1, 1053, 1, '{}', 'nice item', 0.50, 0),
	('ferraria_blackwater', 'Livro Ferraria BlackWater', 100, 1, 'item_standard', 1, 1069, 1, '{}', 'nice item', 0.50, 0),
	('ferraria_rhodes', 'Livro Ferraria Rhodes', 100, 1, 'item_standard', 1, 1072, 1, '{}', 'nice item', 0.50, 0),
	('ferraria_saint_denis', 'Livro Ferraria Saint Denis', 100, 1, 'item_standard', 1, 1073, 1, '{}', 'nice item', 0.50, 0),
	('ferraria_strawberry', 'Livro Ferraria Strawberry', 100, 1, 'item_standard', 1, 1070, 1, '{}', 'nice item', 0.50, 0),
	('ferraria_valentine', 'Livro Ferraria Valentine', 100, 1, 'item_standard', 1, 1071, 1, '{}', 'nice item', 0.50, 0),
	('fertilizer', 'Fertilizante ', 100, 1, 'item_standard', 1, 1504, 1, '{}', 'nice item', 0.25, 0),
	('fibra', 'Fibras', 100, 1, 'item_standard', 1, 1090, 1, '{}', 'nice item', 0.50, 0),
	('filtro_sonho_prop', 'Filtro dos Sonhos', 10, 1, 'item_standard', 1, 1307, 1, '{}', 'nice item', 0.30, 0),
	('fireitem', 'Fogo da morte', 100, 1, 'item_standard', 1, 1466, 1, '{}', 'nice item', 0.25, 0),
	('fireportal', 'Portal de Fogo', 100, 1, 'item_standard', 1, 1465, 1, '{}', 'nice item', 0.25, 0),
	('fivela', 'Fivela', 100, 1, 'item_standard', 1, 1387, 1, '{}', 'nice item', 0.50, 0),
	('flechacacapequena', 'Caixa de Munição de Flechas (Pequenas)', 20, 1, 'item_standard', 1, 1006, 1, '{}', 'nice item', 4.00, 0),
	('flechadinamite', 'Caixa de Munição de Flechachas (ex)', 4, 1, 'item_standard', 1, 1003, 1, '{}', 'nice item', 15.00, 0),
	('flechafogo', 'Caixa de Munição de Flechas (Fogo)', 1, 1, 'item_standard', 1, 1004, 1, '{}', 'nice item', 10.00, 0),
	('flechamelhorada', 'Caixa de Munição de Flechas Melhoradas', 20, 1, 'item_standard', 1, 1005, 1, '{}', 'nice item', 5.00, 0),
	('flechanormal', 'Caixa de Munição de Flechas', 20, 1, 'item_standard', 1, 1002, 1, '{}', 'nice item', 3.00, 0),
	('flechaveneno', 'Caixa de Munição de Flechas (Veneno)', 10, 1, 'item_standard', 1, 1007, 1, '{}', 'nice item', 8.00, 0),
	('florcardinal', 'Flor cardinal', 100, 1, 'item_standard', 1, 557, 1, '{}', 'nice item', 0.50, 0),
	('florsangue', 'Flor de sangue', 100, 1, 'item_standard', 1, 553, 1, '{}', 'nice item', 0.50, 0),
	('flowerboxes', 'Caixas de flores', 5, 1, 'item_standard', 1, 892, 1, '{}', 'nice item', 1.50, 0),
	('fogueiraritual', 'Fogueira Ritual', 100, 1, 'item_standard', 1, 1527, 1, '{}', 'nice item', 0.50, 0),
	('fogueira_a_prop', 'Fogueira', 5, 1, 'item_standard', 1, 772, 1, '{}', 'nice item', 3.00, 0),
	('folhacannabis', 'Folha Cannabis', 100, 1, 'item_standard', 1, 640, 1, '{}', 'nice item', 0.50, 0),
	('folhacoca', 'Folha de Coca', 100, 1, 'item_standard', 1, 517, 1, '{}', 'nice item', 0.50, 0),
	('food_barrel', 'Barril de comida', 5, 1, 'item_standard', 1, 899, 1, '{}', 'nice item', 4.00, 0),
	('formula_adolescente', 'Formula De Adolescente', 100, 1, 'item_standard', 1, 1418, 1, '{}', 'nice item', 0.50, 0),
	('formula_anao', 'Formula de Anão', 100, 1, 'item_standard', 1, 1417, 1, '{}', 'nice item', 0.50, 0),
	('formula_formiga', 'Formula de Formiga', 100, 1, 'item_standard', 1, 1416, 1, '{}', 'nice item', 0.50, 0),
	('formula_gigante', 'Formula de Gigante', 100, 1, 'item_standard', 1, 1421, 1, '{}', 'nice item', 0.50, 0),
	('formula_grande', 'Formula Grande', 100, 1, 'item_standard', 1, 1420, 1, '{}', 'nice item', 0.50, 0),
	('formula_normal', 'Formula Tamanho Normal', 100, 1, 'item_standard', 1, 1419, 1, '{}', 'nice item', 0.50, 0),
	('formula_titan', 'Formula de Titan', 100, 1, 'item_standard', 1, 1422, 1, '{}', 'nice item', 0.50, 0),
	('fosforo', 'Fosfo', 100, 1, 'item_standard', 1, 723, 1, '{}', 'nice item', 0.50, 0),
	('framboesa', 'Framboesa', 100, 1, 'item_standard', 1, 567, 1, '{}', 'nice item', 0.50, 0),
	('fundente', 'Fundente', 100, 1, 'item_standard', 1, 1192, 1, '{}', 'nice item', 0.50, 0),
	('fundicao_bw', 'Livro Fundição BW', 100, 1, 'item_standard', 1, 1047, 1, '{}', 'nice item', 0.50, 0),
	('fundicao_sd', 'Livro Fundição SD', 100, 1, 'item_standard', 1, 1048, 1, '{}', 'nice item', 0.50, 0),
	('fundicao_vl', 'Livro Fundição VL', 100, 1, 'item_standard', 1, 1040, 1, '{}', 'nice item', 0.50, 0),
	('galho_arvore', 'Galhos de árvore', 100, 1, 'item_standard', 1, 1201, 1, '{}', 'nice item', 0.50, 0),
	('garra', 'Garra', 100, 1, 'item_standard', 1, 865, 1, '{}', 'nice item', 0.20, 0),
	('garrafavazia', 'Garrafa Vazia', 100, 1, 'item_standard', 1, 722, 1, '{}', 'nice item', 0.50, 0),
	('garra_urso', 'Garra de Urso', 100, 1, 'item_standard', 1, 866, 1, '{}', 'nice item', 0.30, 0),
	('gigantinho', 'Aumenta o Tamanho', 100, 1, 'item_standard', 1, 840, 1, '{}', 'nice item', 0.50, 0),
	('ginseng', 'Ginseng', 100, 1, 'item_standard', 1, 527, 1, '{}', 'nice item', 0.50, 0),
	('ginsengalasca', 'Ginseng do Alasca', 100, 1, 'item_standard', 1, 590, 1, '{}', 'nice item', 0.50, 0),
	('glicinia', 'Glicínia', 100, 1, 'item_standard', 1, 549, 1, '{}', 'nice item', 0.50, 0),
	('goma_tabaco', 'Goma de Tabaco', 100, 1, 'item_standard', 1, 1289, 1, '{}', 'nice item', 0.25, 0),
	('gordura_animal', 'Gordura Animal', 100, 1, 'item_standard', 1, 869, 1, '{}', 'nice item', 0.50, 0),
	('gravatas', 'Gravatas', 100, 1, 'item_standard', 1, 1370, 1, '{}', 'nice item', 0.50, 0),
	('groselhadourada', 'Groselha dourada', 100, 1, 'item_standard', 1, 539, 1, '{}', 'nice item', 0.50, 0),
	('groselhapreta', 'Groselha preta', 100, 1, 'item_standard', 1, 521, 1, '{}', 'nice item', 0.50, 0),
	('gualteria', 'Gualtéria', 100, 1, 'item_standard', 1, 555, 1, '{}', 'nice item', 0.50, 0),
	('gun_barrel', 'Cano da arma', 10, 1, 'item_standard', 1, 896, 1, '{}', 'nice item', 2.00, 0),
	('handsaw', 'Serrote', 100, 1, 'item_standard', 1, 691, 1, '{}', 'nice item', 0.50, 0),
	('Headband1', 'Headband1', 100, 1, 'item_standard', 1, 1475, 1, '{}', 'nice item', 0.25, 0),
	('Headband2', 'Headband2', 100, 1, 'item_standard', 1, 1476, 1, '{}', 'nice item', 0.25, 0),
	('Headband3', 'Headband3', 100, 1, 'item_standard', 1, 1477, 1, '{}', 'nice item', 0.25, 0),
	('Headband4', 'Headband4', 100, 1, 'item_standard', 1, 1479, 1, '{}', 'nice item', 0.25, 0),
	('Headband5', 'Headband5', 100, 1, 'item_standard', 1, 1481, 1, '{}', 'nice item', 0.25, 0),
	('Headband6', 'Headband6', 100, 1, 'item_standard', 1, 1478, 1, '{}', 'nice item', 0.25, 0),
	('Headdress1', 'Headdress1', 5, 1, 'item_standard', 1, 1438, 1, '{}', 'nice item', 0.25, 0),
	('Headdress2', 'Headdress2', 5, 1, 'item_standard', 1, 1439, 1, '{}', 'nice item', 0.25, 0),
	('Headdress3', 'Headdress3', 5, 1, 'item_standard', 1, 1440, 1, '{}', 'nice item', 0.25, 0),
	('Headdress4', 'Headdress4', 5, 1, 'item_standard', 1, 1441, 1, '{}', 'nice item', 0.25, 0),
	('Headdress5', 'Headdress5', 5, 1, 'item_standard', 1, 1442, 1, '{}', 'nice item', 0.25, 0),
	('Headdress6', 'Headdress6', 5, 1, 'item_standard', 1, 1443, 1, '{}', 'nice item', 0.25, 0),
	('healingitemPoison', 'healingitemPoison', 100, 1, 'item_standard', 1, 1462, 1, '{}', 'nice item', 0.20, 0),
	('horse_asas_a', 'Asas Para Cima', 100, 1, 'item_standard', 1, 1484, 1, '{}', 'nice item', 0.50, 0),
	('horse_asas_b', 'Asas Reta', 100, 1, 'item_standard', 1, 1485, 1, '{}', 'nice item', 0.50, 0),
	('horse_asas_c', 'Asas Para Cima Escura', 100, 1, 'item_standard', 1, 1486, 1, '{}', 'nice item', 0.50, 0),
	('horse_asas_d', 'Asas Reta Escura', 100, 1, 'item_standard', 1, 1487, 1, '{}', 'nice item', 0.50, 0),
	('horse_espada', 'Espada Lateral', 100, 1, 'item_standard', 1, 1503, 1, '{}', 'nice item', 0.50, 0),
	('horse_hat_a', 'Chapeu Cowboy', 100, 1, 'item_standard', 1, 1488, 1, '{}', 'nice item', 0.50, 0),
	('horse_hat_b', 'Chapeu De Bruxos', 100, 1, 'item_standard', 1, 1489, 1, '{}', 'nice item', 0.50, 0),
	('horse_hat_c', 'Chapeu De Chines', 100, 1, 'item_standard', 1, 1490, 1, '{}', 'nice item', 0.50, 0),
	('horse_hat_d', 'Chapeu Com Oculos', 100, 1, 'item_standard', 1, 1491, 1, '{}', 'nice item', 0.50, 0),
	('horse_hat_e', 'Chapeu De Festa', 100, 1, 'item_standard', 1, 1492, 1, '{}', 'nice item', 0.50, 0),
	('horse_hat_f', 'Chapeu Verde', 100, 1, 'item_standard', 1, 1493, 1, '{}', 'nice item', 0.50, 0),
	('horse_hat_g', 'Chapeu Prata', 100, 1, 'item_standard', 1, 1494, 1, '{}', 'nice item', 0.50, 0),
	('horse_hat_h', 'Chapeu Pirata', 100, 1, 'item_standard', 1, 1495, 1, '{}', 'nice item', 0.50, 0),
	('horse_hat_i', 'Gorro de Natal', 100, 1, 'item_standard', 1, 1496, 1, '{}', 'nice item', 0.50, 0),
	('horse_hat_j', 'Chifres De Rena', 100, 1, 'item_standard', 1, 1497, 1, '{}', 'nice item', 0.50, 0),
	('horse_hat_k', 'Chapeu Explorador', 100, 1, 'item_standard', 1, 1498, 1, '{}', 'nice item', 0.50, 0),
	('horse_lenco_a', 'Lenço Vermelho', 100, 1, 'item_standard', 1, 1499, 1, '{}', 'nice item', 0.50, 0),
	('horse_lenco_b', 'Lenço Branco', 100, 1, 'item_standard', 1, 1500, 1, '{}', 'nice item', 0.50, 0),
	('horse_lenco_c', 'Lenço Roxo', 100, 1, 'item_standard', 1, 1501, 1, '{}', 'nice item', 0.50, 0),
	('horse_lenco_d', 'Lenço Bege', 100, 1, 'item_standard', 1, 1502, 1, '{}', 'nice item', 0.50, 0),
	('horse_shoe', 'Ferradura', 100, 1, 'item_standard', 1, 1249, 1, '{}', 'nice item', 0.50, 0),
	('hortelaselvagem', 'Hortelã selvagem', 100, 1, 'item_standard', 1, 588, 1, '{}', 'nice item', 0.50, 0),
	('iceitem', 'Feitiço do Gelo', 100, 1, 'item_standard', 1, 1463, 1, '{}', 'nice item', 0.25, 0),
	('icemagic', 'Congelar', 100, 1, 'item_standard', 1, 1474, 1, '{}', 'nice item', 0.25, 0),
	('identidade', 'Identidade', 100, 1, 'item_standard', 1, 832, 1, '{}', 'nice item', 0.50, 0),
	('ima', 'Imã', 100, 1, 'item_standard', 1, 1203, 1, '{}', 'nice item', 0.50, 0),
	('intestino', 'Intestino de cadaver', 100, 1, 'item_standard', 1, 702, 1, '{}', 'nice item', 0.50, 0),
	('jabuticaba', 'jabuticaba', 100, 1, 'item_standard', 1, 644, 1, '{}', 'nice item', 0.50, 0),
	('jornal', 'Jornal', 100, 1, 'item_standard', 1, 833, 1, '{}', 'nice item', 0.50, 0),
	('jornal1', 'Jornais', 100, 1, 'item_standard', 1, 1426, 1, '{}', 'nice item', 0.25, 0),
	('jumpitem', 'Super Pulo', 100, 1, 'item_standard', 1, 1459, 1, '{}', 'nice item', 0.25, 0),
	('junco', 'Junco', 100, 1, 'item_standard', 1, 559, 1, '{}', 'nice item', 0.50, 0),
	('kitchencounter', 'Balcão de cozinha', 10, 1, 'item_standard', 1, 938, 1, '{}', 'nice item', 10.00, 0),
	('kitmedico', 'Kit Medico', 100, 1, 'item_standard', 1, 1024, 1, '{}', 'nice item', 0.50, 0),
	('la', 'Lã', 100, 1, 'item_standard', 1, 877, 1, '{}', 'nice item', 0.30, 0),
	('lanco', 'Lanco', 100, 1, 'item_standard', 1, 1371, 1, '{}', 'nice item', 0.50, 0),
	('lanterna', 'Lanterna', 10, 1, 'item_standard', 1, 922, 1, '{}', 'nice item', 0.50, 0),
	('lanternadourada', 'Lanterna Dourada', 100, 1, 'item_standard', 1, 1530, 1, '{}', 'nice item', 0.50, 0),
	('lanternadouradas', 'Lanterna Dourada 2', 100, 1, 'item_standard', 1, 1531, 1, '{}', 'nice item', 0.50, 0),
	('laranja', 'laranja', 100, 1, 'item_standard', 1, 634, 1, '{}', 'nice item', 0.50, 0),
	('Laudano2', 'Laudano Concentrado', 100, 1, 'item_standard', 1, 704, 1, '{}', 'nice item', 0.50, 0),
	('lavanda', 'Lavanda', 100, 1, 'item_standard', 1, 642, 1, '{}', 'nice item', 0.50, 0),
	('leather_chair', 'Cadeira de couro', 10, 1, 'item_standard', 1, 883, 1, '{}', 'nice item', 2.50, 0),
	('leite', 'Leite', 100, 1, 'item_standard', 1, 1030, 1, '{}', 'nice item', 0.50, 0),
	('leite_cacau', 'Leite de Cacau', 100, 1, 'item_standard', 1, 1154, 1, '{}', 'nice item', 0.50, 0),
	('leite_fresco', 'Leite Fresco', 100, 1, 'item_standard', 1, 1189, 1, '{}', 'nice item', 0.50, 0),
	('lenha', 'Lenha', 100, 1, 'item_standard', 1, 1034, 1, '{}', 'nice item', 0.50, 0),
	('lenhador', 'Livro do Lenhador', 100, 1, 'item_standard', 1, 1039, 1, '{}', 'nice item', 0.50, 0),
	('levedura', 'Levedura', 100, 1, 'item_standard', 1, 1168, 1, '{}', 'nice item', 0.50, 0),
	('limao', 'Limão', 100, 1, 'item_standard', 1, 632, 1, '{}', 'nice item', 0.50, 0),
	('limpa_casco', 'Limpar cascos', 100, 1, 'item_standard', 1, 1088, 1, '{}', 'nice item', 0.50, 0),
	('lingote_aluminio', 'Lingote de Aluminio', 100, 1, 'item_standard', 1, 1042, 1, '{}', 'nice item', 0.50, 0),
	('lingote_cobre', 'Lingote de Cobre', 100, 1, 'item_standard', 1, 1044, 1, '{}', 'nice item', 0.50, 0),
	('lingote_ferro', 'Lingote de Ferro', 100, 1, 'item_standard', 1, 1045, 1, '{}', 'nice item', 0.50, 0),
	('lingote_ouro', 'Lingote de Ouro', 100, 1, 'item_standard', 1, 1043, 1, '{}', 'nice item', 0.50, 0),
	('lingote_prata', 'Lingote de Prata', 100, 1, 'item_standard', 1, 1041, 1, '{}', 'nice item', 0.50, 0),
	('linha', 'Linha', 100, 1, 'item_standard', 1, 1091, 1, '{}', 'nice item', 0.50, 0),
	('livro_campfire_comidas', 'Livro Comidas Fogueira ', 100, 1, 'item_standard', 1, 1361, 1, '{}', 'nice item', 0.25, 0),
	('livro_campfire_craft', 'Livro Craft Fogueira', 100, 1, 'item_standard', 1, 1362, 1, '{}', 'nice item', 0.25, 0),
	('lockpick', 'Lockpick', 100, 1, 'item_standard', 1, 730, 1, '{}', 'nice item', 0.50, 0),
	('log_bencha', 'Banco de toras 1', 10, 1, 'item_standard', 1, 909, 1, '{}', 'nice item', 3.00, 0),
	('log_benchb', 'Banco de toras 2', 10, 1, 'item_standard', 1, 910, 1, '{}', 'nice item', 3.00, 0),
	('loungechair', 'Espreguiçadeira', 10, 1, 'item_standard', 1, 942, 1, '{}', 'nice item', 4.00, 0),
	('loungechair2', 'Espreguiçadeira 2', 10, 1, 'item_standard', 1, 941, 1, '{}', 'nice item', 4.00, 0),
	('luvas', 'Luvas', 100, 1, 'item_standard', 1, 1363, 1, '{}', 'nice item', 0.50, 0),
	('maca', 'Maça', 100, 1, 'item_standard', 1, 853, 1, '{}', 'nice item', 0.50, 0),
	('macainglesa', 'Maça inglesa', 100, 1, 'item_standard', 1, 561, 1, '{}', 'nice item', 0.50, 0),
	('machado', 'Machado', 100, 1, 'item_standard', 1, 787, 1, '{}', 'nice item', 0.50, 0),
	('madeira', 'Madeira', 100, 1, 'item_standard', 1, 789, 1, '{}', 'nice item', 0.50, 0),
	('madeira_dura', 'Madeira Dura', 100, 1, 'item_standard', 1, 1035, 1, '{}', 'nice item', 0.50, 0),
	('madeira_macia', 'Madeira Macia', 100, 1, 'item_standard', 1, 1038, 1, '{}', 'nice item', 0.50, 0),
	('magicitem', 'Quebra osso', 100, 1, 'item_standard', 1, 1472, 1, '{}', 'nice item', 0.25, 0),
	('magicitem2', 'Quebra osso 2', 100, 1, 'item_standard', 1, 1473, 1, '{}', 'nice item', 0.25, 0),
	('manoplas', 'Manoplas', 100, 1, 'item_standard', 1, 1368, 1, '{}', 'nice item', 0.50, 0),
	('manto', 'Manto', 100, 1, 'item_standard', 1, 1375, 1, '{}', 'nice item', 0.50, 0),
	('manual_anfetamina', 'Manual de anfetamina', 100, 1, 'item_standard', 1, 1081, 1, '{}', 'nice item', 0.50, 0),
	('manual_cocaina', 'Manual de Cocaína', 100, 1, 'item_standard', 1, 1083, 1, '{}', 'nice item', 0.50, 0),
	('manual_espingarda_cano_duplo', 'Manual Espingarda de Cano Duplo', 100, 1, 'item_standard', 1, 1116, 1, '{}', 'nice item', 0.50, 0),
	('manual_espingarda_exotic', 'Manual Espingarda Exotic', 100, 1, 'item_standard', 1, 1117, 1, '{}', 'nice item', 0.50, 0),
	('manual_mooshine_azul', 'Manual Mooshine Azul', 100, 1, 'item_standard', 1, 1075, 1, '{}', 'nice item', 0.50, 0),
	('manual_mooshine_sangue', 'Manual de Moonshine Sangue', 100, 1, 'item_standard', 1, 1082, 1, '{}', 'nice item', 0.50, 0),
	('manual_opio', 'Manual de Ópio', 100, 1, 'item_standard', 1, 1079, 1, '{}', 'nice item', 0.50, 0),
	('manual_pistola_volcanic', 'Manual Pistola Volcanic', 100, 1, 'item_standard', 1, 1123, 1, '{}', 'nice item', 0.50, 0),
	('manual_repetidora_evans', 'Manual Repetidora Evans', 100, 1, 'item_standard', 1, 1125, 1, '{}', 'nice item', 0.50, 0),
	('manual_repetidora_winchester', 'Manual Repetidora Winchester', 100, 1, 'item_standard', 1, 1124, 1, '{}', 'nice item', 0.50, 0),
	('manual_revolver_acao_dupla', 'Manual Revólver de Ação Dupla', 100, 1, 'item_standard', 1, 1122, 1, '{}', 'nice item', 0.50, 0),
	('manual_revolver_cattleman', 'Manual Revólver Cattleman', 100, 1, 'item_standard', 1, 1121, 1, '{}', 'nice item', 0.50, 0),
	('manual_revolver_cattleman_mexicano', 'Manual Revólver Cattleman Mexicano', 100, 1, 'item_standard', 1, 1120, 1, '{}', 'nice item', 0.50, 0),
	('manual_revolver_lemat', 'Manual Revólver Lemat', 100, 1, 'item_standard', 1, 1118, 1, '{}', 'nice item', 0.50, 0),
	('manual_revolver_schofield', 'Manual Revólver Schofield', 100, 1, 'item_standard', 1, 1119, 1, '{}', 'nice item', 0.50, 0),
	('manual_rifle_ferrolho', 'Manual Rifle Ferrolho', 100, 1, 'item_standard', 1, 1126, 1, '{}', 'nice item', 0.50, 0),
	('manual_rifle_springfield', 'Manual Rifle Springfield', 100, 1, 'item_standard', 1, 1127, 1, '{}', 'nice item', 0.50, 0),
	('manual_rifle_varmint', 'Manual Rifle Varmint', 100, 1, 'item_standard', 1, 1129, 1, '{}', 'nice item', 0.50, 0),
	('manual_rollingblock', 'Manual de Rollingblock', 100, 1, 'item_standard', 1, 1128, 1, '{}', 'nice item', 0.50, 0),
	('mapa', 'Mapa', 100, 1, 'item_standard', 1, 834, 1, '{}', 'nice item', 0.50, 0),
	('mapa_alce_lendario', 'Mapa Alce Lendario', 100, 1, 'item_standard', 1, 1411, 1, '{}', 'nice item', 0.50, 0),
	('mapa_bisao_lendario', 'Mapa Bisão Lendario', 100, 1, 'item_standard', 1, 1408, 1, '{}', 'nice item', 0.50, 0),
	('mapa_buck_lendario', 'Mapa Buck Lendario', 100, 1, 'item_standard', 1, 1410, 1, '{}', 'nice item', 0.50, 0),
	('mapa_carneiro_lendario', 'Mapa Carneiro Lendario', 100, 1, 'item_standard', 1, 1413, 1, '{}', 'nice item', 0.50, 0),
	('mapa_castor_lendario', 'Mapa Castor Lendario', 100, 1, 'item_standard', 1, 1407, 1, '{}', 'nice item', 0.50, 0),
	('mapa_jacare_teca_lendario', 'Mapa Jacaré Teca Lendario', 100, 1, 'item_standard', 1, 1405, 1, '{}', 'nice item', 0.50, 0),
	('mapa_javali_lendario', 'Mapa Javali Lendario', 100, 1, 'item_standard', 1, 1409, 1, '{}', 'nice item', 0.50, 0),
	('mapa_lobo_lendario', 'Mapa Lobo Lendario', 100, 1, 'item_standard', 1, 1414, 1, '{}', 'nice item', 0.50, 0),
	('mapa_pantera_lendaria', 'Mapa Pantera Lendaria', 100, 1, 'item_standard', 1, 1412, 1, '{}', 'nice item', 0.50, 0),
	('mapa_urso_lendario', 'Mapa Urso Lendario', 100, 1, 'item_standard', 1, 1406, 1, '{}', 'nice item', 0.50, 0),
	('margaridachocolate', 'Margarida de Chocolate', 100, 1, 'item_standard', 1, 525, 1, '{}', 'nice item', 0.50, 0),
	('martelo_ferro', 'Martelo de Ferro', 100, 1, 'item_standard', 1, 692, 1, '{}', 'nice item', 0.50, 0),
	('mascara', 'Mascara', 100, 1, 'item_standard', 1, 1377, 1, '{}', 'nice item', 0.50, 0),
	('mascara_nativa_prop', 'Mascara Nativa', 10, 1, 'item_standard', 1, 735, 1, '{}', 'nice item', 0.50, 0),
	('mashalcool', 'Purê de alcool', 100, 1, 'item_standard', 1, 666, 1, '{}', 'nice item', 0.50, 0),
	('mashapple', 'Purê de maçã', 100, 1, 'item_standard', 1, 673, 1, '{}', 'nice item', 0.50, 0),
	('mashblackberry', 'Purê de amora', 100, 1, 'item_standard', 1, 671, 1, '{}', 'nice item', 0.50, 0),
	('mashcorn', 'Purê de milho', 100, 1, 'item_standard', 1, 670, 1, '{}', 'nice item', 0.50, 0),
	('mashstrawberry', 'Purê de morango', 100, 1, 'item_standard', 1, 672, 1, '{}', 'nice item', 0.50, 0),
	('mashtropical', 'Purê Tropical', 100, 1, 'item_standard', 1, 675, 1, '{}', 'nice item', 0.50, 0),
	('medico_valentine', 'Livro Medico Valentine', 100, 1, 'item_standard', 1, 1205, 1, '{}', 'nice item', 0.50, 0),
	('mel', 'Mel', 100, 1, 'item_standard', 1, 1147, 1, '{}', 'nice item', 0.50, 0),
	('mesa_cacador_a_prop', 'Mesa De Caçador 1', 2, 1, 'item_standard', 1, 762, 1, '{}', 'nice item', 12.00, 0),
	('mesa_cacador_b_prop', 'Mesa De Caçador 2', 2, 1, 'item_standard', 1, 763, 1, '{}', 'nice item', 8.00, 0),
	('mesa_cacador_c_prop', 'Mesa De Caçador 3', 3, 1, 'item_standard', 1, 764, 1, '{}', 'nice item', 5.00, 0),
	('mesa_de_madeira_prop', 'Mesa De Madeira', 5, 1, 'item_standard', 1, 771, 1, '{}', 'nice item', 6.00, 0),
	('mesa_montada_prop', 'Mesa Montada', 3, 1, 'item_standard', 1, 757, 1, '{}', 'nice item', 10.00, 0),
	('mesa_redonda_prop', 'Mesa Redonda', 3, 1, 'item_standard', 1, 770, 1, '{}', 'nice item', 7.00, 0),
	('milho', 'Milho', 100, 1, 'item_standard', 1, 600, 1, '{}', 'nice item', 0.50, 0),
	('millefolium', 'Millefolium', 100, 1, 'item_standard', 1, 565, 1, '{}', 'nice item', 0.50, 0),
	('mindmagic', 'Hipinoze', 100, 1, 'item_standard', 1, 1464, 1, '{}', 'nice item', 0.25, 0),
	('minerio_bauxita', 'Minério com Bauxita', 100, 1, 'item_standard', 1, 656, 1, '{}', 'nice item', 0.50, 0),
	('minerio_carvao', 'Minério com Carvão', 100, 1, 'item_standard', 1, 653, 1, '{}', 'nice item', 0.50, 0),
	('minerio_cobre', 'Minério com Cobre', 100, 1, 'item_standard', 1, 655, 1, '{}', 'nice item', 0.50, 0),
	('minerio_esmeralda', 'Minério de Esmeralda', 100, 1, 'item_standard', 1, 1067, 1, '{}', 'nice item', 0.50, 0),
	('minerio_ferro', 'Minério com Ferro', 100, 1, 'item_standard', 1, 654, 1, '{}', 'nice item', 0.50, 0),
	('minerio_prata', 'Minério com Prata', 100, 1, 'item_standard', 1, 657, 1, '{}', 'nice item', 0.50, 0),
	('minerio_quartzo', 'Minério de Quartzo', 100, 1, 'item_standard', 1, 1200, 1, '{}', 'nice item', 0.50, 0),
	('minerio_salitre', 'Minério de Salitre', 100, 1, 'item_standard', 1, 658, 1, '{}', 'nice item', 0.50, 0),
	('mirtilo', 'Mirtilo', 100, 1, 'item_standard', 1, 543, 1, '{}', 'nice item', 0.50, 0),
	('mochila_10', 'Mochila +10 Slot', 100, 1, 'item_standard', 1, 716, 1, '{}', 'nice item', 0.50, 0),
	('mochila_5', 'Mochila +5 Slot', 100, 1, 'item_standard', 1, 714, 1, '{}', 'nice item', 0.50, 0),
	('mochila_8', 'Mochila +8 Slot', 100, 1, 'item_standard', 1, 715, 1, '{}', 'nice item', 0.50, 0),
	('moeda_bando', 'Moeda Criação de Bando', 100, 1, 'item_standard', 1, 729, 1, '{}', 'nice item', 0.50, 0),
	('molde', 'Molde de lamina', 100, 1, 'item_standard', 1, 1065, 1, '{}', 'nice item', 0.50, 0),
	('moonshinealcool', 'Moonshine Puro', 100, 1, 'item_standard', 1, 679, 1, '{}', 'nice item', 0.50, 0),
	('moonshineapple', 'Moonshine de maça', 100, 1, 'item_standard', 1, 682, 1, '{}', 'nice item', 0.50, 0),
	('moonshineblackberry', 'Moonshine de amora', 100, 1, 'item_standard', 1, 680, 1, '{}', 'nice item', 0.50, 0),
	('moonshinecorn', 'Moonshine de milho', 100, 1, 'item_standard', 1, 676, 1, '{}', 'nice item', 0.50, 0),
	('moonshinestrawberry', 'Moonshine de morango', 100, 1, 'item_standard', 1, 681, 1, '{}', 'nice item', 0.50, 0),
	('moonshinetropical', 'Moonshine Tropical', 100, 1, 'item_standard', 1, 683, 1, '{}', 'nice item', 0.50, 0),
	('mooshine_azul', 'Mooshine Azul', 100, 1, 'item_standard', 1, 1074, 1, '{}', 'nice item', 0.50, 0),
	('moqueca_peixe', 'Moqueca de peixe', 100, 1, 'item_standard', 1, 1163, 1, '{}', 'nice item', 0.50, 0),
	('morango', 'Morango', 100, 1, 'item_standard', 1, 710, 1, '{}', 'nice item', 0.50, 0),
	('mosto', 'Mosto', 100, 1, 'item_standard', 1, 1076, 1, '{}', 'nice item', 0.50, 0),
	('municaobolla', 'Bolla Munição', 5, 1, 'item_standard', 1, 1013, 1, '{}', 'nice item', 4.00, 0),
	('municaobollafalcao', 'Munição Hawkmoth Bolla', 5, 1, 'item_standard', 1, 1014, 1, '{}', 'nice item', 7.00, 0),
	('municaobollainterligada', 'Munição Bolla Interligada', 5, 1, 'item_standard', 1, 1015, 1, '{}', 'nice item', 6.00, 0),
	('municaobollapontas', 'Munição Bolla com Pontas de Ferro', 5, 1, 'item_standard', 1, 1016, 1, '{}', 'nice item', 8.00, 0),
	('municaodinamite', 'Munição de Dinamite', 5, 1, 'item_standard', 1, 1017, 1, '{}', 'nice item', 12.00, 0),
	('municaodinamitevolatil', 'Munição Volátil de Dinamite', 3, 1, 'item_standard', 1, 1018, 1, '{}', 'nice item', 20.00, 0),
	('municaoelefante', 'Munição de Rifle de Elefante', 10, 1, 'item_standard', 1, 988, 1, '{}', 'nice item', 20.00, 0),
	('municaoespingardabala', 'Bala de Munição de Espingarda', 25, 1, 'item_standard', 1, 996, 1, '{}', 'nice item', 5.00, 0),
	('municaoespingardaexplosiva', 'Explosivo de Munição de Espingarda', 10, 1, 'item_standard', 1, 994, 1, '{}', 'nice item', 16.00, 0),
	('municaoespingardaincendiaria', 'Munição de Espingarda Incendiária', 10, 1, 'item_standard', 1, 993, 1, '{}', 'nice item', 12.00, 0),
	('municaoespingardanormal', 'Munição de Espingarda Normal', 25, 1, 'item_standard', 1, 995, 1, '{}', 'nice item', 4.00, 0),
	('municaofacas', 'Munição de Facas', 5, 1, 'item_standard', 1, 1010, 1, '{}', 'nice item', 5.00, 0),
	('municaogarrafaveneno', 'Munição de Garrafa Venenosa', 5, 1, 'item_standard', 1, 1012, 1, '{}', 'nice item', 8.00, 0),
	('municaomolotov', 'Munição Molotov', 3, 1, 'item_standard', 1, 1019, 1, '{}', 'nice item', 10.00, 0),
	('municaomolotovvolatil', 'Munição Molotov Volátil', 3, 1, 'item_standard', 1, 1020, 1, '{}', 'nice item', 18.00, 0),
	('municaopistolaexplosiva', 'Munição de Pistola Explosiva', 5, 1, 'item_standard', 1, 999, 1, '{}', 'nice item', 15.00, 0),
	('municaopistolaexpressa', 'Munição de Pistola Expressa', 100, 1, 'item_standard', 1, 998, 1, '{}', 'nice item', 6.00, 0),
	('municaopistolanormal', 'Munição de Pistola Normal', 100, 1, 'item_standard', 1, 997, 1, '{}', 'nice item', 4.00, 0),
	('municaopistolapontodivisao', 'Ponto Dividido de Munição de Pistola', 50, 1, 'item_standard', 1, 1001, 1, '{}', 'nice item', 7.00, 0),
	('municaopistolavelocidade', 'Velocidade de Munição de Pistola', 100, 1, 'item_standard', 1, 1000, 1, '{}', 'nice item', 5.00, 0),
	('municaorepetidorexplosiva', 'Munição Explosiva de Repetidor', 30, 1, 'item_standard', 1, 979, 1, '{}', 'nice item', 15.00, 0),
	('municaorepetidorexpressa', 'Munição Repetidora Expressa', 100, 1, 'item_standard', 1, 978, 1, '{}', 'nice item', 6.00, 0),
	('municaorepetidornormal', 'Munição de Repetidor Normal', 100, 1, 'item_standard', 1, 977, 1, '{}', 'nice item', 4.00, 0),
	('municaorepetidorpontodivisao', 'Ponto de Divisão de Munição de Repetidor', 50, 1, 'item_standard', 1, 981, 1, '{}', 'nice item', 7.00, 0),
	('municaorepetidorvelocidade', 'Velocidade de Munição do Repetidor', 100, 1, 'item_standard', 1, 980, 1, '{}', 'nice item', 5.00, 0),
	('municaorevolverexplosiva', 'Explosivo de Munição de Revólver', 5, 1, 'item_standard', 1, 984, 1, '{}', 'nice item', 15.00, 0),
	('municaorevolverexpressa', 'Revólver Munição Expressa', 100, 1, 'item_standard', 1, 983, 1, '{}', 'nice item', 6.00, 0),
	('municaorevolvernormal', 'Munição de Revólver Normal', 100, 1, 'item_standard', 1, 982, 1, '{}', 'nice item', 4.00, 0),
	('municaorevolverpontodivisao', 'Ponto Dividido de Munição de Revólver', 50, 1, 'item_standard', 1, 986, 1, '{}', 'nice item', 8.00, 0),
	('municaorevolvervelocidade', 'Velocidade da Munição do Revólver', 100, 1, 'item_standard', 1, 985, 1, '{}', 'nice item', 5.00, 0),
	('municaorifleexplosiva', 'Explosivo de Munição de Rifle', 5, 1, 'item_standard', 1, 990, 1, '{}', 'nice item', 18.00, 0),
	('municaorifleexpressa', 'Munição Expressa de Rifle', 100, 1, 'item_standard', 1, 989, 1, '{}', 'nice item', 6.00, 0),
	('municaoriflenormal', 'Munição de Rifle Normal', 100, 1, 'item_standard', 1, 987, 1, '{}', 'nice item', 4.00, 0),
	('municaoriflepontodivisao', 'Ponto Dividido de Munição de Rifle', 50, 1, 'item_standard', 1, 992, 1, '{}', 'nice item', 7.00, 0),
	('municaoriflevelocidade', 'Velocidade de Munição de Rifle', 100, 1, 'item_standard', 1, 991, 1, '{}', 'nice item', 5.00, 0),
	('municaotomahawk', 'Munição Tomahawk', 5, 1, 'item_standard', 1, 1011, 1, '{}', 'nice item', 6.00, 0),
	('municaovarmint', 'Munição de Varmint', 50, 1, 'item_standard', 1, 1008, 1, '{}', 'nice item', 4.00, 0),
	('municaovarminttranquilizante', 'Munição Tranquilizante Varmint', 100, 1, 'item_standard', 1, 1009, 1, '{}', 'nice item', 6.00, 0),
	('na1', 'Aljava Lateral', 100, 1, 'item_standard', 1, 1240, 1, '{}', 'nice item', 0.50, 0),
	('na2', 'Aljava traseira', 100, 1, 'item_standard', 1, 1241, 1, '{}', 'nice item', 0.50, 0),
	('na3', 'na3', 5, 1, 'item_standard', 1, 1469, 1, '{}', 'nice item', 0.25, 0),
	('na4', 'Cachimbo da Paz', 100, 1, 'item_standard', 1, 1242, 1, '{}', 'nice item', 0.50, 0),
	('na5', 'Pulseira de penas', 100, 1, 'item_standard', 1, 1243, 1, '{}', 'nice item', 0.50, 0),
	('na6', 'na6', 5, 1, 'item_standard', 1, 1471, 1, '{}', 'nice item', 0.25, 0),
	('na7', 'Acessório Tomahawk Antigo', 100, 1, 'item_standard', 1, 1244, 1, '{}', 'nice item', 0.50, 0),
	('na8', 'na8', 5, 1, 'item_standard', 1, 1470, 1, '{}', 'nice item', 0.25, 0),
	('nativearms', 'Armas Nativas', 10, 1, 'item_standard', 1, 956, 1, '{}', 'nice item', 2.00, 0),
	('nativearrowdisplay', 'Exibição de seta', 10, 1, 'item_standard', 1, 974, 1, '{}', 'nice item', 1.50, 0),
	('nativebasket1', 'Cesta Nativa 1', 10, 1, 'item_standard', 1, 946, 1, '{}', 'nice item', 1.00, 0),
	('nativebasket2', 'Cesta Nativa 2', 10, 1, 'item_standard', 1, 945, 1, '{}', 'nice item', 1.00, 0),
	('nativebed', 'Cama Nativa', 10, 1, 'item_standard', 1, 954, 1, '{}', 'nice item', 10.00, 0),
	('nativebench', 'Banco Nativo', 10, 1, 'item_standard', 1, 963, 1, '{}', 'nice item', 3.50, 0),
	('nativebloodrock', 'Estrutura Rochosa Nativa', 10, 1, 'item_standard', 1, 970, 1, '{}', 'nice item', 20.00, 0),
	('nativebowdisplay', 'Exibição de arco', 10, 1, 'item_standard', 1, 972, 1, '{}', 'nice item', 2.00, 0),
	('nativebuckskull', 'Crânio de Buck nativo', 10, 1, 'item_standard', 1, 975, 1, '{}', 'nice item', 2.00, 0),
	('nativecage', 'Gaiola de madeira nativa', 10, 1, 'item_standard', 1, 971, 1, '{}', 'nice item', 12.00, 0),
	('nativechair', 'Cadeira Nativa', 10, 1, 'item_standard', 1, 961, 1, '{}', 'nice item', 2.50, 0),
	('nativecookpot', 'Panela Nativa', 10, 1, 'item_standard', 1, 973, 1, '{}', 'nice item', 2.50, 0),
	('nativeelkcanvas', 'Tela de alce nativo', 10, 1, 'item_standard', 1, 965, 1, '{}', 'nice item', 8.00, 0),
	('nativeleatherstand', 'Suporte de couro nativo', 10, 1, 'item_standard', 1, 976, 1, '{}', 'nice item', 4.00, 0),
	('nativemask', 'Máscara Nativa', 10, 1, 'item_standard', 1, 955, 1, '{}', 'nice item', 0.50, 0),
	('nativeplatform', 'Plataforma Nativa', 10, 1, 'item_standard', 1, 968, 1, '{}', 'nice item', 10.00, 0),
	('nativepot', 'Pote Nativo', 10, 1, 'item_standard', 1, 947, 1, '{}', 'nice item', 1.50, 0),
	('nativeskull', 'Decoração Nativa 1', 10, 1, 'item_standard', 1, 944, 1, '{}', 'nice item', 1.50, 0),
	('nativeskullchair', 'Cadeira do Homem Morto', 10, 1, 'item_standard', 1, 960, 1, '{}', 'nice item', 3.00, 0),
	('nativesmoker', 'Estrutura de culinária nativa', 10, 1, 'item_standard', 1, 969, 1, '{}', 'nice item', 6.00, 0),
	('nativewickchair', 'Cadeira de vime nativa', 10, 1, 'item_standard', 1, 962, 1, '{}', 'nice item', 2.50, 0),
	('nightstand', 'Mesa de cabeceira', 20, 1, 'item_standard', 1, 916, 1, '{}', 'nice item', 3.00, 0),
	('ns1', 'Escudo 1', 100, 1, 'item_standard', 1, 1218, 1, '{}', 'nice item', 0.50, 0),
	('ns10', 'Escudo 10', 100, 1, 'item_standard', 1, 1227, 1, '{}', 'nice item', 0.50, 0),
	('ns11', 'Escudo 11', 100, 1, 'item_standard', 1, 1228, 1, '{}', 'nice item', 0.50, 0),
	('ns12', 'Escudo 12', 100, 1, 'item_standard', 1, 1229, 1, '{}', 'nice item', 0.50, 0),
	('ns13', 'Escudo 13', 100, 1, 'item_standard', 1, 1230, 1, '{}', 'nice item', 0.50, 0),
	('ns14', 'Escudo 14', 100, 1, 'item_standard', 1, 1231, 1, '{}', 'nice item', 0.50, 0),
	('ns2', 'Escudo 2', 100, 1, 'item_standard', 1, 1219, 1, '{}', 'nice item', 0.50, 0),
	('ns3', 'Escudo 3', 100, 1, 'item_standard', 1, 1220, 1, '{}', 'nice item', 0.50, 0),
	('ns4', 'Escudo 4', 100, 1, 'item_standard', 1, 1221, 1, '{}', 'nice item', 0.50, 0),
	('ns5', 'Escudo 5', 100, 1, 'item_standard', 1, 1222, 1, '{}', 'nice item', 0.50, 0),
	('ns6', 'Escudo 6', 100, 1, 'item_standard', 1, 1223, 1, '{}', 'nice item', 0.50, 0),
	('ns7', 'Escudo 7', 100, 1, 'item_standard', 1, 1224, 1, '{}', 'nice item', 0.50, 0),
	('ns8', 'Escudo 8', 100, 1, 'item_standard', 1, 1225, 1, '{}', 'nice item', 0.50, 0),
	('ns9', 'Escudo 9', 100, 1, 'item_standard', 1, 1226, 1, '{}', 'nice item', 0.50, 0),
	('obed', 'Cama velha', 10, 1, 'item_standard', 1, 927, 1, '{}', 'nice item', 10.00, 0),
	('oculos', 'Oculos', 100, 1, 'item_standard', 1, 1364, 1, '{}', 'nice item', 0.50, 0),
	('oleandro', 'Oleandro', 100, 1, 'item_standard', 1, 529, 1, '{}', 'nice item', 0.50, 0),
	('oleocopaiba', 'Oleo de CopaIba', 100, 1, 'item_standard', 1, 1214, 1, '{}', 'nice item', 0.50, 0),
	('oleovegetal', 'Óleo Vegetal', 100, 1, 'item_standard', 1, 1103, 1, '{}', 'nice item', 0.50, 0),
	('olho_de_vidro', 'Olho de Vidro', 100, 1, 'item_standard', 1, 848, 1, '{}', 'nice item', 0.50, 0),
	('oregano', 'Orégano', 100, 1, 'item_standard', 1, 583, 1, '{}', 'nice item', 0.50, 0),
	('ovo', 'Ovo', 100, 1, 'item_standard', 1, 1031, 1, '{}', 'nice item', 0.50, 0),
	('pa', 'Pá', 100, 1, 'item_standard', 1, 852, 1, '{}', 'nice item', 0.50, 0),
	('padaria_blackwater', 'Livro Padaria Blackwater', 100, 1, 'item_standard', 1, 1138, 1, '{}', 'nice item', 0.50, 0),
	('panela', 'Panela', 25, 1, 'item_standard', 1, 889, 1, '{}', 'nice item', 2.00, 0),
	('pao', 'Pão', 100, 1, 'item_standard', 1, 719, 1, '{}', 'nice item', 0.50, 0),
	('paoqueijo', 'Pão de queijo', 100, 1, 'item_standard', 1, 1151, 1, '{}', 'nice item', 0.50, 0),
	('papel', 'Papel', 100, 1, 'item_standard', 1, 1199, 1, '{}', 'nice item', 0.50, 0),
	('papoulapradaria', 'Papoula da pradaria', 100, 1, 'item_standard', 1, 573, 1, '{}', 'nice item', 0.50, 0),
	('peca_escopeta', 'Peça de Escopeta', 100, 1, 'item_standard', 1, 1058, 1, '{}', 'nice item', 0.50, 0),
	('peca_pistola', 'Peça de Pistola', 100, 1, 'item_standard', 1, 1060, 1, '{}', 'nice item', 0.50, 0),
	('peca_revolver', 'Peça de Revolver', 100, 1, 'item_standard', 1, 1061, 1, '{}', 'nice item', 0.50, 0),
	('peca_rifle', 'Peça de Rifle', 100, 1, 'item_standard', 1, 1059, 1, '{}', 'nice item', 0.50, 0),
	('pedra', 'Pedra', 100, 1, 'item_standard', 1, 659, 1, '{}', 'nice item', 0.50, 0),
	('peixe_assadol', 'Peixe assado com Limao', 100, 1, 'item_standard', 1, 1171, 1, '{}', 'nice item', 0.50, 0),
	('pele_grande', 'Pele Grande', 100, 1, 'item_standard', 1, 863, 1, '{}', 'nice item', 3.00, 0),
	('pele_media', 'Pele Média', 100, 1, 'item_standard', 1, 862, 1, '{}', 'nice item', 1.50, 0),
	('pele_pequena', 'Pele Pequena', 100, 1, 'item_standard', 1, 861, 1, '{}', 'nice item', 0.50, 0),
	('pena', 'Pena', 100, 1, 'item_standard', 1, 870, 1, '{}', 'nice item', 0.05, 0),
	('pepita_ouro', 'Pepita de ouro', 100, 1, 'item_standard', 1, 845, 1, '{}', 'nice item', 0.50, 0),
	('pequenino', 'Reduz o Tamanho', 100, 1, 'item_standard', 1, 839, 1, '{}', 'nice item', 0.50, 0),
	('pessego', 'Pêssego', 100, 1, 'item_standard', 1, 636, 1, '{}', 'nice item', 0.50, 0),
	('petfood', 'Comida para Pet', 1, 1, 'item_standard', 1, 1297, 1, '{}', 'nice item', 0.25, 0),
	('petrevive', 'Seringa para Pet', 1, 1, 'item_standard', 1, 1306, 1, '{}', 'nice item', 0.25, 0),
	('petroleo_bruto', 'Petroleo Bruto', 100, 1, 'item_standard', 1, 1517, 1, '{}', 'nice item', 0.25, 0),
	('pe_coelho', 'Pé de Coelho', 100, 1, 'item_standard', 1, 873, 1, '{}', 'nice item', 0.10, 0),
	('pheasant_taxidermy', 'Taxidermia de faisão', 10, 1, 'item_standard', 1, 904, 1, '{}', 'nice item', 1.50, 0),
	('picareta', 'Picareta', 100, 1, 'item_standard', 1, 1055, 1, '{}', 'nice item', 0.50, 0),
	('pimenta', 'Pimenta', 100, 1, 'item_standard', 1, 652, 1, '{}', 'nice item', 0.50, 0),
	('pipecopper', 'Tubo de cobre', 100, 1, 'item_standard', 1, 661, 1, '{}', 'nice item', 0.50, 0),
	('poisonItem', 'poisonItem', 100, 1, 'item_standard', 1, 1461, 1, '{}', 'nice item', 0.10, 0),
	('polvora', 'Pólvora', 100, 1, 'item_standard', 1, 1052, 1, '{}', 'nice item', 0.50, 0),
	('pomadaindio', 'Pomada Indígenas', 100, 1, 'item_standard', 1, 1247, 1, '{}', 'nice item', 0.50, 0),
	('ponchos', 'Poncho', 100, 1, 'item_standard', 1, 1376, 1, '{}', 'nice item', 0.50, 0),
	('poster', 'Posters', 100, 1, 'item_standard', 1, 841, 1, '{}', 'nice item', 0.50, 0),
	('poste_cavalo_prop', 'Poste Amarração', 5, 1, 'item_standard', 1, 761, 1, '{}', 'nice item', 6.00, 0),
	('pot', 'Pote de Destilaria', 100, 1, 'item_standard', 1, 662, 1, '{}', 'nice item', 0.50, 0),
	('pote_nativo_prop', 'Pote Nativo', 15, 1, 'item_standard', 1, 745, 1, '{}', 'nice item', 0.80, 0),
	('potion1', 'Poção do Lobo', 100, 1, 'item_standard', 1, 1428, 1, '{}', 'nice item', 0.25, 0),
	('potion2', 'Poção de Pantera', 100, 1, 'item_standard', 1, 1429, 1, '{}', 'nice item', 0.25, 0),
	('potion3', 'Poção do Pato', 100, 1, 'item_standard', 1, 1430, 1, '{}', 'nice item', 0.25, 0),
	('potion4', 'Poção da rapoza', 100, 1, 'item_standard', 1, 1431, 1, '{}', 'nice item', 0.25, 0),
	('potion5', 'Poção da Coruja', 100, 1, 'item_standard', 1, 1432, 1, '{}', 'nice item', 0.25, 0),
	('potion6', 'Poção do Urso', 100, 1, 'item_standard', 1, 1433, 1, '{}', 'nice item', 0.25, 0),
	('potion7', 'Poção do Rato', 100, 1, 'item_standard', 1, 1434, 1, '{}', 'nice item', 0.25, 0),
	('po_serra', 'Pó de Serra', 100, 1, 'item_standard', 1, 1037, 1, '{}', 'nice item', 0.50, 0),
	('prancheta', 'Prancheta', 100, 1, 'item_standard', 1, 1027, 1, '{}', 'nice item', 0.50, 0),
	('prato_texas', 'Prato Texano', 100, 1, 'item_standard', 1, 1176, 1, '{}', 'nice item', 0.50, 0),
	('prego', 'Prego', 100, 1, 'item_standard', 1, 881, 1, '{}', 'nice item', 0.50, 0),
	('presa', 'Presa', 100, 1, 'item_standard', 1, 867, 1, '{}', 'nice item', 0.20, 0),
	('pudim', 'Pudim', 100, 1, 'item_standard', 1, 1159, 1, '{}', 'nice item', 0.50, 0),
	('punchitem', 'Super Soco', 100, 1, 'item_standard', 1, 1458, 1, '{}', 'nice item', 0.25, 0),
	('p_baitBread01x', 'Isca de Pão', 100, 1, 'item_standard', 1, 790, 1, '{}', 'nice item', 0.50, 0),
	('p_baitCheese01x', 'Isca De Queijo', 100, 1, 'item_standard', 1, 792, 1, '{}', 'nice item', 0.50, 0),
	('p_baitCorn01x', 'Isca de Milho', 100, 1, 'item_standard', 1, 791, 1, '{}', 'nice item', 0.50, 0),
	('p_baitCricket01x', 'Isca de críquete', 100, 1, 'item_standard', 1, 794, 1, '{}', 'nice item', 0.50, 0),
	('p_baitWorm01x', 'Isca de minhoca', 100, 1, 'item_standard', 1, 793, 1, '{}', 'nice item', 0.50, 0),
	('p_crawdad01x', 'Isca de lagostim', 100, 1, 'item_standard', 1, 795, 1, '{}', 'nice item', 0.50, 0),
	('p_FinisdFishlure01x', 'Isca de peixe', 100, 1, 'item_standard', 1, 797, 1, '{}', 'nice item', 0.50, 0),
	('p_finisdfishlurelegendary01x', 'Isca de peixe lendária', 100, 1, 'item_standard', 1, 800, 1, '{}', 'nice item', 0.50, 0),
	('p_finishdcrawd01x', 'Isca de lagostim', 100, 1, 'item_standard', 1, 798, 1, '{}', 'nice item', 0.50, 0),
	('p_finishdcrawdlegendary01x', 'Isca lendária de lagostim', 100, 1, 'item_standard', 1, 801, 1, '{}', 'nice item', 0.50, 0),
	('p_finishedragonfly01x', 'Isca de libélula', 100, 1, 'item_standard', 1, 796, 1, '{}', 'nice item', 0.50, 0),
	('p_finishedragonflylegendary01x', 'Isca de libélula lendária', 100, 1, 'item_standard', 1, 799, 1, '{}', 'nice item', 0.50, 0),
	('p_lgoc_spinner_v4', 'Girador V4', 100, 1, 'item_standard', 1, 802, 1, '{}', 'nice item', 0.50, 0),
	('p_lgoc_spinner_v6', 'Girador V6', 100, 1, 'item_standard', 1, 803, 1, '{}', 'nice item', 0.50, 0),
	('queijo', 'Queijo', 100, 1, 'item_standard', 1, 1152, 1, '{}', 'nice item', 0.50, 0),
	('racaocavalo', 'Ração de Cavalo', 100, 1, 'item_standard', 1, 1425, 1, '{}', 'nice item', 0.25, 0),
	('racaogalinha', 'Ração de Galinha', 1, 1, 'item_standard', 1, 1296, 1, '{}', 'nice item', 0.25, 0),
	('racaoovelha', 'Ração de Ovelha', 1, 1, 'item_standard', 1, 1295, 1, '{}', 'nice item', 0.25, 0),
	('racaoporco', 'Ração de Porco', 1, 1, 'item_standard', 1, 1294, 1, '{}', 'nice item', 0.25, 0),
	('racaovaca', 'Ração de Vaca', 1, 1, 'item_standard', 1, 1293, 1, '{}', 'nice item', 0.25, 0),
	('racao_pet', 'Ração Pet', 100, 1, 'item_standard', 1, 836, 1, '{}', 'nice item', 0.50, 0),
	('raizbardana', 'Raiz de bardana', 100, 1, 'item_standard', 1, 531, 1, '{}', 'nice item', 0.50, 0),
	('ramos', 'Ramos', 100, 1, 'item_standard', 1, 551, 1, '{}', 'nice item', 0.50, 0),
	('raspadinha', 'Raspadinha', 100, 1, 'item_standard', 1, 842, 1, '{}', 'nice item', 0.50, 0),
	('rastelo', 'Rastelo', 100, 1, 'item_standard', 1, 1056, 1, '{}', 'nice item', 0.50, 0),
	('rectangle_table', 'Mesa Retângulo', 20, 1, 'item_standard', 1, 886, 1, '{}', 'nice item', 6.00, 0),
	('regador', 'Regador', 100, 1, 'item_standard', 1, 1661, 1, '{}', 'nice item', 0.25, 0),
	('relogio_velho', 'Relogio Velho', 100, 1, 'item_standard', 1, 847, 1, '{}', 'nice item', 0.50, 0),
	('remediogalinha', 'Remédio de Galinha', 1, 1, 'item_standard', 1, 1301, 1, '{}', 'nice item', 0.25, 0),
	('remedioovelha', 'Remédio de Ovelha', 1, 1, 'item_standard', 1, 1300, 1, '{}', 'nice item', 0.25, 0),
	('remedioporco', 'Remédio de Porco', 1, 1, 'item_standard', 1, 1299, 1, '{}', 'nice item', 0.25, 0),
	('remediovaca', 'Remédio de Vaca', 1, 1, 'item_standard', 1, 1298, 1, '{}', 'nice item', 0.25, 0),
	('remedio_pet', 'Remedio Pet', 100, 1, 'item_standard', 1, 837, 1, '{}', 'nice item', 0.50, 0),
	('revive_horse', 'Revive Horse', 100, 1, 'item_standard', 1, 1086, 1, '{}', 'nice item', 0.50, 0),
	('rotulo', 'Rótulo', 100, 1, 'item_standard', 1, 1166, 1, '{}', 'nice item', 0.50, 0),
	('round_table', 'Mesa redonda', 20, 1, 'item_standard', 1, 884, 1, '{}', 'nice item', 5.00, 0),
	('roupas', 'Suas Roupas', 100, 1, 'item_standard', 1, 785, 1, '{}', 'nice item', 0.50, 0),
	('roupas_comum', 'Roupas Comuns', 100, 1, 'item_standard', 1, 775, 1, '{}', 'nice item', 0.50, 0),
	('roupa_indios', 'Roupas indígenas', 100, 1, 'item_standard', 1, 1217, 1, '{}', 'nice item', 0.50, 0),
	('rubbertube', 'Tubo de borracha', 100, 1, 'item_standard', 1, 663, 1, '{}', 'nice item', 0.50, 0),
	('ruibarbo', 'Ruibarbo', 100, 1, 'item_standard', 1, 612, 1, '{}', 'nice item', 0.50, 0),
	('ruibarboselvagem', 'Ruibarbo selvagem', 100, 1, 'item_standard', 1, 563, 1, '{}', 'nice item', 0.50, 0),
	('runacristal', 'Runo de Cristal', 100, 1, 'item_standard', 1, 1529, 1, '{}', 'nice item', 0.50, 0),
	('sabonete', 'Sabonete', 100, 1, 'item_standard', 1, 844, 1, '{}', 'nice item', 0.50, 0),
	('saias', 'Saias', 100, 1, 'item_standard', 1, 1385, 1, '{}', 'nice item', 0.50, 0),
	('saloon_annesburg', 'Livro Saloon Annesburg', 100, 1, 'item_standard', 1, 1250, 1, '{}', 'nice item', 0.50, 0),
	('saloon_blackwater', 'Livro Saloon Blackwater', 100, 1, 'item_standard', 1, 1251, 1, '{}', 'nice item', 0.50, 0),
	('saloon_rhodes', 'Livro Saloon Rhodes', 100, 1, 'item_standard', 1, 1173, 1, '{}', 'nice item', 0.50, 0),
	('saloon_saintdenis', 'Livro Saloon Saint Denis', 100, 1, 'item_standard', 1, 1175, 1, '{}', 'nice item', 0.50, 0),
	('saloon_strawberry', 'Livro Saloon Strawberry', 100, 1, 'item_standard', 1, 1182, 1, '{}', 'nice item', 0.50, 0),
	('saloon_valentine', 'Livro Saloon Valentine', 100, 1, 'item_standard', 1, 1172, 1, '{}', 'nice item', 0.50, 0),
	('saloon_vanhorn', 'Livro Saloon Van Horn', 100, 1, 'item_standard', 1, 1174, 1, '{}', 'nice item', 0.50, 0),
	('salvia', 'Sálvia', 100, 1, 'item_standard', 1, 577, 1, '{}', 'nice item', 0.50, 0),
	('salviadeserto', 'Sálvia do deserto', 100, 1, 'item_standard', 1, 523, 1, '{}', 'nice item', 0.50, 0),
	('salviavermelha', 'Sálvia Vermelha', 100, 1, 'item_standard', 1, 547, 1, '{}', 'nice item', 0.50, 0),
	('sangue', 'Sangue', 100, 1, 'item_standard', 1, 1455, 1, '{}', 'nice item', 0.20, 0),
	('sapatos', 'Sapatos', 100, 1, 'item_standard', 1, 1392, 1, '{}', 'nice item', 0.50, 0),
	('Scalp1', 'Scalp1', 5, 1, 'item_standard', 1, 1444, 1, '{}', 'nice item', 0.25, 0),
	('Scalp2', 'Scalp2', 5, 1, 'item_standard', 1, 1445, 1, '{}', 'nice item', 0.25, 0),
	('Scalp3', 'Scalp3', 5, 1, 'item_standard', 1, 1446, 1, '{}', 'nice item', 0.25, 0),
	('Scalp4', 'Scalp4', 5, 1, 'item_standard', 1, 1447, 1, '{}', 'nice item', 0.25, 0),
	('Scalp5', 'Scalp5', 5, 1, 'item_standard', 1, 1448, 1, '{}', 'nice item', 0.25, 0),
	('Scalp6', 'Scalp6', 5, 1, 'item_standard', 1, 1449, 1, '{}', 'nice item', 0.25, 0),
	('Scalp7', 'Scalp7', 5, 1, 'item_standard', 1, 1450, 1, '{}', 'nice item', 0.25, 0),
	('Scalp8', 'Scalp8', 5, 1, 'item_standard', 1, 1451, 1, '{}', 'nice item', 0.25, 0),
	('sebo', 'Sebo', 100, 1, 'item_standard', 1, 1196, 1, '{}', 'nice item', 0.50, 0),
	('segundachanse', 'Sua segunda chance', 100, 1, 'item_standard', 1, 1437, 1, '{}', 'nice item', 0.25, 0),
	('seiva', 'Seiva', 100, 1, 'item_standard', 1, 788, 1, '{}', 'nice item', 0.50, 0),
	('sementeabacaxi', 'semente abacaxi', 100, 1, 'item_standard', 1, 637, 1, '{}', 'nice item', 0.50, 0),
	('sementeagarita', 'semente agarita', 100, 1, 'item_standard', 1, 578, 1, '{}', 'nice item', 0.50, 0),
	('sementealcachofra', 'semente alcachofra', 100, 1, 'item_standard', 1, 601, 1, '{}', 'nice item', 0.50, 0),
	('sementealface', 'semente alface', 100, 1, 'item_standard', 1, 605, 1, '{}', 'nice item', 0.50, 0),
	('sementealgodao', 'semente algodao', 100, 1, 'item_standard', 1, 615, 1, '{}', 'nice item', 0.50, 0),
	('sementealho', 'semente alho', 100, 1, 'item_standard', 1, 603, 1, '{}', 'nice item', 0.50, 0),
	('sementeameixa', 'semente ameixa', 100, 1, 'item_standard', 1, 586, 1, '{}', 'nice item', 0.50, 0),
	('sementeamora', 'semente amora', 100, 1, 'item_standard', 1, 570, 1, '{}', 'nice item', 0.50, 0),
	('sementearroz', 'semente arroz', 100, 1, 'item_standard', 1, 619, 1, '{}', 'nice item', 0.50, 0),
	('sementeasclepias', 'semente asclepias', 100, 1, 'item_standard', 1, 593, 1, '{}', 'nice item', 0.50, 0),
	('sementebabosa', 'semente babosa', 100, 1, 'item_standard', 1, 607, 1, '{}', 'nice item', 0.50, 0),
	('sementebambu', 'semente bambu', 100, 1, 'item_standard', 1, 647, 1, '{}', 'nice item', 0.50, 0),
	('sementebanana', 'semente banana', 100, 1, 'item_standard', 1, 623, 1, '{}', 'nice item', 0.50, 0),
	('sementebatata', 'semente batata', 100, 1, 'item_standard', 1, 597, 1, '{}', 'nice item', 0.50, 0),
	('sementebrocolis', 'semente brocolis', 100, 1, 'item_standard', 1, 613, 1, '{}', 'nice item', 0.50, 0),
	('sementecacau', 'semente cacau', 100, 1, 'item_standard', 1, 629, 1, '{}', 'nice item', 0.50, 0),
	('sementecactos', 'semente cactos', 100, 1, 'item_standard', 1, 649, 1, '{}', 'nice item', 0.50, 0),
	('sementecafe', 'semente cafe', 100, 1, 'item_standard', 1, 625, 1, '{}', 'nice item', 0.50, 0),
	('sementecalendula', 'semente calendula', 100, 1, 'item_standard', 1, 540, 1, '{}', 'nice item', 0.50, 0),
	('sementecanaacucar', 'semente cana acucar', 100, 1, 'item_standard', 1, 621, 1, '{}', 'nice item', 0.50, 0),
	('sementecardinal', 'semente cardinal', 100, 1, 'item_standard', 1, 556, 1, '{}', 'nice item', 0.50, 0),
	('sementecenoura', 'semente cenoura', 100, 1, 'item_standard', 1, 574, 1, '{}', 'nice item', 0.50, 0),
	('sementecogumelobolete', 'semente cogumelo bolete', 100, 1, 'item_standard', 1, 544, 1, '{}', 'nice item', 0.50, 0),
	('sementecogumelochant', 'semente cogumelo chant', 100, 1, 'item_standard', 1, 580, 1, '{}', 'nice item', 0.50, 0),
	('sementecogumentog', 'cogumelo guarda sol', 100, 1, 'item_standard', 1, 532, 1, '{}', 'nice item', 0.50, 0),
	('sementeervaamarga', 'semente erva amarga', 100, 1, 'item_standard', 1, 536, 1, '{}', 'nice item', 0.50, 0),
	('sementefeijao', 'semente feijao', 100, 1, 'item_standard', 1, 609, 1, '{}', 'nice item', 0.50, 0),
	('sementeflorsangue', 'semente flor sangue', 100, 1, 'item_standard', 1, 552, 1, '{}', 'nice item', 0.50, 0),
	('sementefolhacannabis', 'semente folha cannabis', 100, 1, 'item_standard', 1, 639, 1, '{}', 'nice item', 0.50, 0),
	('sementefolhacoca', 'Semente Folha de Caca', 100, 1, 'item_standard', 1, 516, 1, '{}', 'nice item', 0.50, 0),
	('sementeframboesa', 'semente framboesa', 100, 1, 'item_standard', 1, 566, 1, '{}', 'nice item', 0.50, 0),
	('sementeginseng', 'semente ginseng', 100, 1, 'item_standard', 1, 526, 1, '{}', 'nice item', 0.50, 0),
	('sementeginsengalasca', 'semente ginseng alasca', 100, 1, 'item_standard', 1, 589, 1, '{}', 'nice item', 0.50, 0),
	('sementeglicinia', 'semente glicinia', 100, 1, 'item_standard', 1, 548, 1, '{}', 'nice item', 0.50, 0),
	('sementegroselhad', 'semente groselha d', 100, 1, 'item_standard', 1, 538, 1, '{}', 'nice item', 0.50, 0),
	('sementegroselhap', 'semente groselha p', 100, 1, 'item_standard', 1, 520, 1, '{}', 'nice item', 0.50, 0),
	('sementegualteria', 'semente gualteria', 100, 1, 'item_standard', 1, 554, 1, '{}', 'nice item', 0.50, 0),
	('sementehortela', 'semente hortela', 100, 1, 'item_standard', 1, 587, 1, '{}', 'nice item', 0.50, 0),
	('sementejabuticaba', 'semente jabuticaba', 100, 1, 'item_standard', 1, 643, 1, '{}', 'nice item', 0.50, 0),
	('sementejunco', 'semente junco', 100, 1, 'item_standard', 1, 558, 1, '{}', 'nice item', 0.50, 0),
	('sementelaranja', 'semente laranja', 100, 1, 'item_standard', 1, 633, 1, '{}', 'nice item', 0.50, 0),
	('sementelavanda', 'semente lavanda', 100, 1, 'item_standard', 1, 641, 1, '{}', 'nice item', 0.50, 0),
	('sementelimao', 'semente limao', 100, 1, 'item_standard', 1, 631, 1, '{}', 'nice item', 0.50, 0),
	('sementemaca', 'semente maca', 100, 1, 'item_standard', 1, 560, 1, '{}', 'nice item', 0.50, 0),
	('sementemargaridachoc', 'semente margarida choc', 100, 1, 'item_standard', 1, 524, 1, '{}', 'nice item', 0.50, 0),
	('sementemilho', 'semente milho', 100, 1, 'item_standard', 1, 599, 1, '{}', 'nice item', 0.50, 0),
	('sementemillefolium', 'semente millefolium', 100, 1, 'item_standard', 1, 564, 1, '{}', 'nice item', 0.50, 0),
	('sementemirtilo', 'semente mirtilo', 100, 1, 'item_standard', 1, 542, 1, '{}', 'nice item', 0.50, 0),
	('sementeoleandro', 'semente oleandro', 100, 1, 'item_standard', 1, 528, 1, '{}', 'nice item', 0.50, 0),
	('sementeoregano', 'semente oregano', 100, 1, 'item_standard', 1, 582, 1, '{}', 'nice item', 0.50, 0),
	('sementepapoula', 'semente papoula', 100, 1, 'item_standard', 1, 572, 1, '{}', 'nice item', 0.50, 0),
	('sementepessego', 'semente pessego', 100, 1, 'item_standard', 1, 635, 1, '{}', 'nice item', 0.50, 0),
	('sementepimenta', 'semente pimenta', 100, 1, 'item_standard', 1, 651, 1, '{}', 'nice item', 0.50, 0),
	('sementeraizbardana', 'semente raiz bardana', 100, 1, 'item_standard', 1, 530, 1, '{}', 'nice item', 0.50, 0),
	('sementeramos', 'semente ramos', 100, 1, 'item_standard', 1, 550, 1, '{}', 'nice item', 0.50, 0),
	('sementeruibarbo', 'semente ruibarbo', 100, 1, 'item_standard', 1, 611, 1, '{}', 'nice item', 0.50, 0),
	('sementeruibardo', 'semente ruibardo', 100, 1, 'item_standard', 1, 562, 1, '{}', 'nice item', 0.50, 0),
	('sementesalvia', 'semente salvia', 100, 1, 'item_standard', 1, 576, 1, '{}', 'nice item', 0.50, 0),
	('sementesalviadeserto', 'semente salvia deserto', 100, 1, 'item_standard', 1, 522, 1, '{}', 'nice item', 0.50, 0),
	('sementesalviavermelha', 'semente salvia vermelha', 100, 1, 'item_standard', 1, 546, 1, '{}', 'nice item', 0.50, 0),
	('sementetabacoindiano', 'semente tabaco indiano', 100, 1, 'item_standard', 1, 591, 1, '{}', 'nice item', 0.50, 0),
	('sementetanaceto', 'semente tanaceto', 100, 1, 'item_standard', 1, 534, 1, '{}', 'nice item', 0.50, 0),
	('sementetexas', 'semente texas', 100, 1, 'item_standard', 1, 518, 1, '{}', 'nice item', 0.50, 0),
	('sementetomate', 'semente tomate', 100, 1, 'item_standard', 1, 595, 1, '{}', 'nice item', 0.50, 0),
	('sementetomilho', 'semente tomilho', 100, 1, 'item_standard', 1, 584, 1, '{}', 'nice item', 0.50, 0),
	('sementetrigo', 'semente trigo', 100, 1, 'item_standard', 1, 617, 1, '{}', 'nice item', 0.50, 0),
	('sementeuva', 'semente uva', 100, 1, 'item_standard', 1, 645, 1, '{}', 'nice item', 0.50, 0),
	('sementevioleta', 'semente violeta', 100, 1, 'item_standard', 1, 568, 1, '{}', 'nice item', 0.50, 0),
	('sementezebrina', 'semente zebrina', 100, 1, 'item_standard', 1, 627, 1, '{}', 'nice item', 0.50, 0),
	('serigaequina', 'Seringa Equina', 100, 1, 'item_standard', 1, 1254, 1, '{}', 'nice item', 0.25, 0),
	('shootingtarget', 'Alvo de tiro', 10, 1, 'item_standard', 1, 937, 1, '{}', 'nice item', 5.00, 0),
	('shoptoken', 'Licença para loja unica', 100, 1, 'item_standard', 1, 1435, 1, '{}', 'nice item', 0.25, 0),
	('side_table', 'Mesa de apoio 1', 15, 1, 'item_standard', 1, 917, 1, '{}', 'nice item', 2.50, 0),
	('side_tablea', 'Mesa de apoio 2', 15, 1, 'item_standard', 1, 918, 1, '{}', 'nice item', 2.50, 0),
	('side_tableb', 'Mesa de apoio 3', 15, 1, 'item_standard', 1, 919, 1, '{}', 'nice item', 2.50, 0),
	('simplenativetent', 'Tenda Nativa Simples', 10, 1, 'item_standard', 1, 964, 1, '{}', 'nice item', 12.00, 0),
	('singlebed', 'Cama de solteiro', 30, 1, 'item_standard', 1, 929, 1, '{}', 'nice item', 12.00, 0),
	('skullpost', 'Postagem de Caveira', 10, 1, 'item_standard', 1, 943, 1, '{}', 'nice item', 2.00, 0),
	('smallmcandle', 'Vela Derretida Pequena', 5, 1, 'item_standard', 1, 925, 1, '{}', 'nice item', 0.20, 0),
	('small_firecracker', 'pequeno foguete', 100, 1, 'item_standard', 1, 1401, 1, '{}', 'nice item', 0.25, 0),
	('small_fireworks', 'pequenos fogos de artifício', 100, 1, 'item_standard', 1, 1399, 1, '{}', 'nice item', 0.25, 0),
	('smoke_campfire', 'fogueira de fumaça', 100, 1, 'item_standard', 1, 1402, 1, '{}', 'nice item', 0.25, 0),
	('societytoken', 'Licença para lojas compartilhadas', 100, 1, 'item_standard', 1, 1436, 1, '{}', 'nice item', 0.25, 0),
	('sofa_medio_a_prop', 'Sofa Medio', 2, 1, 'item_standard', 1, 750, 1, '{}', 'nice item', 12.00, 0),
	('sofa_medio_b_prop', 'Sofa Medio 2', 2, 1, 'item_standard', 1, 751, 1, '{}', 'nice item', 12.00, 0),
	('sopa_tatu', 'Sopa de Tatu', 100, 1, 'item_standard', 1, 1178, 1, '{}', 'nice item', 0.50, 0),
	('sopa_tomate', 'Macarronada ao molho', 100, 1, 'item_standard', 1, 1184, 1, '{}', 'nice item', 0.50, 0),
	('speeditem', 'Super Velocidade', 100, 1, 'item_standard', 1, 1460, 1, '{}', 'nice item', 0.25, 0),
	('standard_table', 'Mesa', 20, 1, 'item_standard', 1, 885, 1, '{}', 'nice item', 5.00, 0),
	('stillkit', 'Kit de destilação', 100, 1, 'item_standard', 1, 664, 1, '{}', 'nice item', 0.50, 0),
	('sucodegroselhanegra', 'Suco de Groselha Negra', 100, 1, 'item_standard', 1, 705, 1, '{}', 'nice item', 0.50, 0),
	('suco_abacaxim', 'Suco de Abacaxi com morango', 100, 1, 'item_standard', 1, 1164, 1, '{}', 'nice item', 0.50, 0),
	('suco_laranja', 'Suco de Laranja', 100, 1, 'item_standard', 1, 1181, 1, '{}', 'nice item', 0.50, 0),
	('suco_morango', 'Suco de Morango', 100, 1, 'item_standard', 1, 1187, 1, '{}', 'nice item', 0.50, 0),
	('suco_pessegomaca', 'Suco de Pessego com Maça', 100, 1, 'item_standard', 1, 1165, 1, '{}', 'nice item', 0.50, 0),
	('sugar', 'Açucar', 100, 1, 'item_standard', 1, 668, 1, '{}', 'nice item', 0.50, 0),
	('suspensorios', 'Suspensorios', 100, 1, 'item_standard', 1, 1369, 1, '{}', 'nice item', 0.50, 0),
	('tabacaria_blackwater', 'Livro Tabacaria Blackwater', 100, 1, 'item_standard', 1, 1136, 1, '{}', 'nice item', 0.50, 0),
	('tabacaria_valentine', 'Livro Tabacaria Valentine', 100, 1, 'item_standard', 1, 1137, 1, '{}', 'nice item', 0.50, 0),
	('tabacodesfiado', 'Tabaco Desfiado', 100, 1, 'item_standard', 1, 724, 1, '{}', 'nice item', 0.50, 0),
	('tabacoindiano', 'Tabaco indiano', 100, 1, 'item_standard', 1, 592, 1, '{}', 'nice item', 0.50, 0),
	('tabua', 'Tábua', 100, 1, 'item_standard', 1, 1036, 1, '{}', 'nice item', 0.50, 0),
	('tanaceto', 'Tanaceto', 100, 1, 'item_standard', 1, 535, 1, '{}', 'nice item', 0.50, 0),
	('teleitem', 'Telecinese', 100, 1, 'item_standard', 1, 1457, 1, '{}', 'nice item', 0.25, 0),
	('tempero_texas', 'Tempero Texas', 100, 1, 'item_standard', 1, 1170, 1, '{}', 'nice item', 0.50, 0),
	('tenda_nativa_a_prop', 'Tenda Nativa', 2, 1, 'item_standard', 1, 739, 1, '{}', 'nice item', 12.00, 0),
	('tenda_nativa_b_prop', 'Tenda Nativa Moderna', 2, 1, 'item_standard', 1, 740, 1, '{}', 'nice item', 15.00, 0),
	('tenda_nativa_c_prop', 'Tenda Simples', 2, 1, 'item_standard', 1, 741, 1, '{}', 'nice item', 10.00, 0),
	('tenda_nativa_d_prop', 'Tenda Simples 2', 2, 1, 'item_standard', 1, 742, 1, '{}', 'nice item', 10.00, 0),
	('tenda_nativa_e_prop', 'Tenda do Caçador', 2, 1, 'item_standard', 1, 767, 1, '{}', 'nice item', 12.00, 0),
	('tent', 'Tenda de Caçador de Recompensas', 10, 1, 'item_standard', 1, 932, 1, '{}', 'nice item', 15.00, 0),
	('tent2', 'Tenda do comerciante', 10, 1, 'item_standard', 1, 951, 1, '{}', 'nice item', 14.00, 0),
	('tent3', 'Tenda Simples', 10, 1, 'item_standard', 1, 950, 1, '{}', 'nice item', 12.00, 0),
	('tent4', 'Sombra de tela', 10, 1, 'item_standard', 1, 949, 1, '{}', 'nice item', 12.00, 0),
	('tesoura_poda', 'Tesoura de Poda', 100, 1, 'item_standard', 1, 1257, 1, '{}', 'nice item', 0.25, 0),
	('texasbon', 'texas bon', 100, 1, 'item_standard', 1, 519, 1, '{}', 'nice item', 0.50, 0),
	('ticket_cinema', 'Ticket do Cinema', 100, 1, 'item_standard', 1, 1516, 1, '{}', 'nice item', 0.25, 0),
	('timber_table', 'Mesa de madeira', 20, 1, 'item_standard', 1, 887, 1, '{}', 'nice item', 5.50, 0),
	('tinta', 'Tinta', 100, 1, 'item_standard', 1, 1193, 1, '{}', 'nice item', 0.50, 0),
	('tipi', 'Tipos', 10, 1, 'item_standard', 1, 931, 1, '{}', 'nice item', 20.00, 0),
	('toalha', 'Toalha', 100, 1, 'item_standard', 1, 851, 1, '{}', 'nice item', 0.50, 0),
	('tocha_comprida_prop', 'Tocha Comprida', 15, 1, 'item_standard', 1, 755, 1, '{}', 'nice item', 1.50, 0),
	('tomate', 'Tomate', 100, 1, 'item_standard', 1, 596, 1, '{}', 'nice item', 0.50, 0),
	('tomilho', 'Tomilho', 100, 1, 'item_standard', 1, 585, 1, '{}', 'nice item', 0.50, 0),
	('tonicococa', 'Tônico de coca', 100, 1, 'item_standard', 1, 1210, 1, '{}', 'nice item', 0.50, 0),
	('tonicovital', 'Tônico Vital', 100, 1, 'item_standard', 1, 1209, 1, '{}', 'nice item', 0.50, 0),
	('tonico_medicina', 'Tonico de Medicina', 100, 1, 'item_standard', 1, 1023, 1, '{}', 'nice item', 0.50, 0),
	('tool_barrel', 'Barril de ferramentas', 10, 1, 'item_standard', 1, 902, 1, '{}', 'nice item', 4.50, 0),
	('torta_de_laranja', 'Torta de Laranja', 100, 1, 'item_standard', 1, 1143, 1, '{}', 'nice item', 0.50, 0),
	('torta_frango', 'Torta de Frango', 100, 1, 'item_standard', 1, 1179, 1, '{}', 'nice item', 0.50, 0),
	('torta_morango', 'Torta Morango', 100, 1, 'item_standard', 1, 1185, 1, '{}', 'nice item', 0.50, 0),
	('transformar_alligator', 'Poção Jacaré', 1, 1, 'item_standard', 1, 1532, 1, '{}', 'nice item', 0.50, 0),
	('transformar_alligator2', 'Poção Jacaré Grande', 1, 1, 'item_standard', 1, 1534, 1, '{}', 'nice item', 0.50, 0),
	('transformar_alligator3', 'Poção Jacaré Gigante', 1, 1, 'item_standard', 1, 1535, 1, '{}', 'nice item', 0.50, 0),
	('transformar_alligator4', 'Poção Jacaré MP', 1, 1, 'item_standard', 1, 1650, 1, '{}', 'nice item', 0.50, 0),
	('transformar_alligator_0', 'Poção Jacaré V2', 1, 1, 'item_standard', 1, 1533, 1, '{}', 'nice item', 0.50, 0),
	('transformar_armadillo', 'Poção Tatu', 1, 1, 'item_standard', 1, 1536, 1, '{}', 'nice item', 0.50, 0),
	('transformar_badger', 'Poção Texugo', 1, 1, 'item_standard', 1, 1537, 1, '{}', 'nice item', 0.50, 0),
	('transformar_bat', 'Poção Morcego', 1, 1, 'item_standard', 1, 1538, 1, '{}', 'nice item', 0.50, 0),
	('transformar_bear', 'Poção Urso', 1, 1, 'item_standard', 1, 1539, 1, '{}', 'nice item', 0.50, 0),
	('transformar_bearblack', 'Poção Urso Negro', 1, 1, 'item_standard', 1, 1540, 1, '{}', 'nice item', 0.50, 0),
	('transformar_beaver', 'Poção Castor', 1, 1, 'item_standard', 1, 1541, 1, '{}', 'nice item', 0.50, 0),
	('transformar_bighornram', 'Poção Carneiro', 1, 1, 'item_standard', 1, 1542, 1, '{}', 'nice item', 0.50, 0),
	('transformar_bluejay', 'Poção Gaio Azul', 1, 1, 'item_standard', 1, 1543, 1, '{}', 'nice item', 0.50, 0),
	('transformar_boar', 'Poção Javali', 1, 1, 'item_standard', 1, 1544, 1, '{}', 'nice item', 0.50, 0),
	('transformar_boarlegendary', 'Poção Javali Lendário', 1, 1, 'item_standard', 1, 1545, 1, '{}', 'nice item', 0.50, 0),
	('transformar_buck', 'Poção Veado Macho', 1, 1, 'item_standard', 1, 1546, 1, '{}', 'nice item', 0.50, 0),
	('transformar_buffalo', 'Poção Búfalo', 1, 1, 'item_standard', 1, 1547, 1, '{}', 'nice item', 0.50, 0),
	('transformar_buffalo2', 'Poção Búfalo Tatanka', 1, 1, 'item_standard', 1, 1548, 1, '{}', 'nice item', 0.50, 0),
	('transformar_californiacondor', 'Poção Condor', 1, 1, 'item_standard', 1, 1549, 1, '{}', 'nice item', 0.50, 0),
	('transformar_cardinal', 'Poção Cardeal', 1, 1, 'item_standard', 1, 1550, 1, '{}', 'nice item', 0.50, 0),
	('transformar_carolinaparakeet', 'Poção Periquito', 1, 1, 'item_standard', 1, 1551, 1, '{}', 'nice item', 0.50, 0),
	('transformar_cat', 'Poção Gato', 1, 1, 'item_standard', 1, 1552, 1, '{}', 'nice item', 0.50, 0),
	('transformar_cedarwaxwing', 'Poção Pássaro Cedro', 1, 1, 'item_standard', 1, 1553, 1, '{}', 'nice item', 0.50, 0),
	('transformar_chicken', 'Poção Galinha', 1, 1, 'item_standard', 1, 1554, 1, '{}', 'nice item', 0.50, 0),
	('transformar_chipmunk', 'Poção Esquilo Listrado', 1, 1, 'item_standard', 1, 1555, 1, '{}', 'nice item', 0.50, 0),
	('transformar_cormorant', 'Poção Corvo Marinho', 1, 1, 'item_standard', 1, 1556, 1, '{}', 'nice item', 0.50, 0),
	('transformar_cougar', 'Poção Puma', 1, 1, 'item_standard', 1, 1557, 1, '{}', 'nice item', 0.50, 0),
	('transformar_cow', 'Poção Vaca', 1, 1, 'item_standard', 1, 1558, 1, '{}', 'nice item', 0.50, 0),
	('transformar_coyote', 'Poção Coiote', 1, 1, 'item_standard', 1, 1559, 1, '{}', 'nice item', 0.50, 0),
	('transformar_crab', 'Poção Caranguejo', 1, 1, 'item_standard', 1, 1560, 1, '{}', 'nice item', 0.50, 0),
	('transformar_cranewhooping', 'Poção Grou', 1, 1, 'item_standard', 1, 1561, 1, '{}', 'nice item', 0.50, 0),
	('transformar_crawfish', 'Poção Lagostim', 1, 1, 'item_standard', 1, 1562, 1, '{}', 'nice item', 0.50, 0),
	('transformar_crow', 'Poção Corvo', 1, 1, 'item_standard', 1, 1563, 1, '{}', 'nice item', 0.50, 0),
	('transformar_deer', 'Poção Veado', 1, 1, 'item_standard', 1, 1564, 1, '{}', 'nice item', 0.50, 0),
	('transformar_dogamericanfoxhound', 'Poção Cachorro Foxhound', 1, 1, 'item_standard', 1, 1565, 1, '{}', 'nice item', 0.50, 0),
	('transformar_dogaustraliansheperd', 'Poção Pastor Australiano', 1, 1, 'item_standard', 1, 1566, 1, '{}', 'nice item', 0.50, 0),
	('transformar_dogbluetickcoonhound', 'Poção Coonhound', 1, 1, 'item_standard', 1, 1567, 1, '{}', 'nice item', 0.50, 0),
	('transformar_dogcatahoula', 'Poção Catahoula', 1, 1, 'item_standard', 1, 1568, 1, '{}', 'nice item', 0.50, 0),
	('transformar_dogchesbayretriever', 'Poção Retriever', 1, 1, 'item_standard', 1, 1569, 1, '{}', 'nice item', 0.50, 0),
	('transformar_dogcollie', 'Poção Collie', 1, 1, 'item_standard', 1, 1570, 1, '{}', 'nice item', 0.50, 0),
	('transformar_doghobo', 'Poção Cachorro Vadio', 1, 1, 'item_standard', 1, 1571, 1, '{}', 'nice item', 0.50, 0),
	('transformar_doghound', 'Poção Hound', 1, 1, 'item_standard', 1, 1572, 1, '{}', 'nice item', 0.50, 0),
	('transformar_doghusky', 'Poção Husky', 1, 1, 'item_standard', 1, 1573, 1, '{}', 'nice item', 0.50, 0),
	('transformar_doglab', 'Poção Labrador', 1, 1, 'item_standard', 1, 1574, 1, '{}', 'nice item', 0.50, 0),
	('transformar_doglion', 'Poção Cachorro Leão', 1, 1, 'item_standard', 1, 1575, 1, '{}', 'nice item', 0.50, 0),
	('transformar_dogpoodle', 'Poção Poodle', 1, 1, 'item_standard', 1, 1576, 1, '{}', 'nice item', 0.50, 0),
	('transformar_dogrufus', 'Poção Rufus', 1, 1, 'item_standard', 1, 1577, 1, '{}', 'nice item', 0.50, 0),
	('transformar_dogstreet', 'Poção Cachorro Vira-lata', 1, 1, 'item_standard', 1, 1578, 1, '{}', 'nice item', 0.50, 0),
	('transformar_donkey', 'Poção Burro', 1, 1, 'item_standard', 1, 1579, 1, '{}', 'nice item', 0.50, 0),
	('transformar_duck', 'Poção Pato', 1, 1, 'item_standard', 1, 1580, 1, '{}', 'nice item', 0.50, 0),
	('transformar_eagle', 'Poção Águia', 1, 1, 'item_standard', 1, 1581, 1, '{}', 'nice item', 0.50, 0),
	('transformar_egret', 'Poção Garça', 1, 1, 'item_standard', 1, 1582, 1, '{}', 'nice item', 0.50, 0),
	('transformar_elk', 'Poção Alce', 1, 1, 'item_standard', 1, 1583, 1, '{}', 'nice item', 0.50, 0),
	('transformar_fox', 'Poção Raposa', 1, 1, 'item_standard', 1, 1584, 1, '{}', 'nice item', 0.50, 0),
	('transformar_frogbull', 'Poção Sapo-touro', 1, 1, 'item_standard', 1, 1585, 1, '{}', 'nice item', 0.50, 0),
	('transformar_gilamonster', 'Poção Lagarto Gila', 1, 1, 'item_standard', 1, 1586, 1, '{}', 'nice item', 0.50, 0),
	('transformar_goat', 'Poção Cabra', 1, 1, 'item_standard', 1, 1587, 1, '{}', 'nice item', 0.50, 0),
	('transformar_goosecanada', 'Poção Ganso', 1, 1, 'item_standard', 1, 1588, 1, '{}', 'nice item', 0.50, 0),
	('transformar_hawk', 'Poção Falcão', 1, 1, 'item_standard', 1, 1589, 1, '{}', 'nice item', 0.50, 0),
	('transformar_heron', 'Poção Garça Real', 1, 1, 'item_standard', 1, 1590, 1, '{}', 'nice item', 0.50, 0),
	('transformar_horsecorpse', 'Poção Cavalo Morto', 1, 1, 'item_standard', 1, 1651, 1, '{}', 'nice item', 0.50, 0),
	('transformar_iguana', 'Poção Iguana', 1, 1, 'item_standard', 1, 1591, 1, '{}', 'nice item', 0.50, 0),
	('transformar_iguanadesert', 'Poção Iguana Deserto', 1, 1, 'item_standard', 1, 1592, 1, '{}', 'nice item', 0.50, 0),
	('transformar_javelina', 'Poção Porco Selvagem', 1, 1, 'item_standard', 1, 1593, 1, '{}', 'nice item', 0.50, 0),
	('transformar_legendarybounty', 'Poção Caçador Lendário', 1, 1, 'item_standard', 1, 1654, 1, '{}', 'nice item', 0.50, 0),
	('transformar_legendarypanther', 'Poção Pantera Lendária', 1, 1, 'item_standard', 1, 1594, 1, '{}', 'nice item', 0.50, 0),
	('transformar_lionmangy', 'Poção Leão Sarnento', 1, 1, 'item_standard', 1, 1595, 1, '{}', 'nice item', 0.50, 0),
	('transformar_loon', 'Poção Mergulhão', 1, 1, 'item_standard', 1, 1596, 1, '{}', 'nice item', 0.50, 0),
	('transformar_moose', 'Poção Alce Gigante', 1, 1, 'item_standard', 1, 1597, 1, '{}', 'nice item', 0.50, 0),
	('transformar_muskrat', 'Poção Rato Almiscarado', 1, 1, 'item_standard', 1, 1598, 1, '{}', 'nice item', 0.50, 0),
	('transformar_oriole', 'Poção Oriole', 1, 1, 'item_standard', 1, 1599, 1, '{}', 'nice item', 0.50, 0),
	('transformar_owl', 'Poção Coruja', 1, 1, 'item_standard', 1, 1600, 1, '{}', 'nice item', 0.50, 0),
	('transformar_owlhootvictim', 'Poção Vítima Owlhoot', 1, 1, 'item_standard', 1, 1653, 1, '{}', 'nice item', 0.50, 0),
	('transformar_panther', 'Poção Pantera', 1, 1, 'item_standard', 1, 1601, 1, '{}', 'nice item', 0.50, 0),
	('transformar_pantherlegendaryr', 'Poção Pantera Lendária Rara', 1, 1, 'item_standard', 1, 1602, 1, '{}', 'nice item', 0.50, 0),
	('transformar_parrot', 'Poção Papagaio', 1, 1, 'item_standard', 1, 1603, 1, '{}', 'nice item', 0.50, 0),
	('transformar_pelican', 'Poção Pelicano', 1, 1, 'item_standard', 1, 1604, 1, '{}', 'nice item', 0.50, 0),
	('transformar_pheasant', 'Poção Faisão', 1, 1, 'item_standard', 1, 1605, 1, '{}', 'nice item', 0.50, 0),
	('transformar_pig', 'Poção Porco', 1, 1, 'item_standard', 1, 1606, 1, '{}', 'nice item', 0.50, 0),
	('transformar_pigeon', 'Poção Pombo', 1, 1, 'item_standard', 1, 1607, 1, '{}', 'nice item', 0.50, 0),
	('transformar_possum', 'Poção Gambá', 1, 1, 'item_standard', 1, 1608, 1, '{}', 'nice item', 0.50, 0),
	('transformar_prairiechicken', 'Poção Galinha do Campo', 1, 1, 'item_standard', 1, 1609, 1, '{}', 'nice item', 0.50, 0),
	('transformar_pronghorn', 'Poção Antilocapra', 1, 1, 'item_standard', 1, 1610, 1, '{}', 'nice item', 0.50, 0),
	('transformar_quail', 'Poção Codorna', 1, 1, 'item_standard', 1, 1611, 1, '{}', 'nice item', 0.50, 0),
	('transformar_rabbit', 'Poção Coelho', 1, 1, 'item_standard', 1, 1612, 1, '{}', 'nice item', 0.50, 0),
	('transformar_raccoon', 'Poção Guaxinim', 1, 1, 'item_standard', 1, 1613, 1, '{}', 'nice item', 0.50, 0),
	('transformar_ram', 'Poção Carneiro Selvagem', 1, 1, 'item_standard', 1, 1652, 1, '{}', 'nice item', 0.50, 0),
	('transformar_rat', 'Poção Rato', 1, 1, 'item_standard', 1, 1614, 1, '{}', 'nice item', 0.50, 0),
	('transformar_raven', 'Poção Corvo Grande', 1, 1, 'item_standard', 1, 1615, 1, '{}', 'nice item', 0.50, 0),
	('transformar_redfootedbooby', 'Poção Atobá', 1, 1, 'item_standard', 1, 1616, 1, '{}', 'nice item', 0.50, 0),
	('transformar_robin', 'Poção Tordo', 1, 1, 'item_standard', 1, 1617, 1, '{}', 'nice item', 0.50, 0),
	('transformar_rooster', 'Poção Galo', 1, 1, 'item_standard', 1, 1618, 1, '{}', 'nice item', 0.50, 0),
	('transformar_roseatespoonbill', 'Poção Colhereiro', 1, 1, 'item_standard', 1, 1619, 1, '{}', 'nice item', 0.50, 0),
	('transformar_seagull', 'Poção Gaivota', 1, 1, 'item_standard', 1, 1620, 1, '{}', 'nice item', 0.50, 0),
	('transformar_sheep', 'Poção Ovelha', 1, 1, 'item_standard', 1, 1621, 1, '{}', 'nice item', 0.50, 0),
	('transformar_skunk', 'Poção Gambá Fedorento', 1, 1, 'item_standard', 1, 1622, 1, '{}', 'nice item', 0.50, 0),
	('transformar_snake', 'Poção Cobra', 1, 1, 'item_standard', 1, 1623, 1, '{}', 'nice item', 0.50, 0),
	('transformar_snakeblacktailrattle', 'Poção Cascavel', 1, 1, 'item_standard', 1, 1625, 1, '{}', 'nice item', 0.50, 0),
	('transformar_snakeblacktailrattle_pelt', 'Poção Cascavel Pele', 1, 1, 'item_standard', 1, 1626, 1, '{}', 'nice item', 0.50, 0),
	('transformar_snakeferdelance', 'Poção Jararaca', 1, 1, 'item_standard', 1, 1627, 1, '{}', 'nice item', 0.50, 0),
	('transformar_snakeferdelance_pelt', 'Poção Jararaca Pele', 1, 1, 'item_standard', 1, 1628, 1, '{}', 'nice item', 0.50, 0),
	('transformar_snakeredboa', 'Poção Jiboia Vermelha', 1, 1, 'item_standard', 1, 1629, 1, '{}', 'nice item', 0.50, 0),
	('transformar_snakeredboa10ft', 'Poção Jiboia Gigante', 1, 1, 'item_standard', 1, 1631, 1, '{}', 'nice item', 0.50, 0),
	('transformar_snakeredboa_pelt', 'Poção Jiboia Pele', 1, 1, 'item_standard', 1, 1630, 1, '{}', 'nice item', 0.50, 0),
	('transformar_snakewater', 'Poção Cobra Dágua', 1, 1, 'item_standard', 1, 1632, 1, '{}', 'nice item', 0.50, 0),
	('transformar_snakewater_pelt', 'Poção Cobra Dágua Pele', 1, 1, 'item_standard', 1, 1633, 1, '{}', 'nice item', 0.50, 0),
	('transformar_snake_pelt', 'Poção Cobra Pele', 1, 1, 'item_standard', 1, 1624, 1, '{}', 'nice item', 0.50, 0),
	('transformar_songbird', 'Poção Pássaro Cantor', 1, 1, 'item_standard', 1, 1634, 1, '{}', 'nice item', 0.50, 0),
	('transformar_sparrow', 'Poção Pardal', 1, 1, 'item_standard', 1, 1635, 1, '{}', 'nice item', 0.50, 0),
	('transformar_spot_gang_charles', 'Poção Charles', 1, 1, 'item_standard', 1, 1636, 1, '{}', 'nice item', 0.50, 0),
	('transformar_squirrel', 'Poção Esquilo', 1, 1, 'item_standard', 1, 1637, 1, '{}', 'nice item', 0.50, 0),
	('transformar_toad', 'Poção Sapo', 1, 1, 'item_standard', 1, 1638, 1, '{}', 'nice item', 0.50, 0),
	('transformar_turkey', 'Poção Peru', 1, 1, 'item_standard', 1, 1639, 1, '{}', 'nice item', 0.50, 0),
	('transformar_turkey2', 'Poção Peru Grande', 1, 1, 'item_standard', 1, 1640, 1, '{}', 'nice item', 0.50, 0),
	('transformar_turkeywild', 'Poção Peru Selvagem', 1, 1, 'item_standard', 1, 1641, 1, '{}', 'nice item', 0.50, 0),
	('transformar_turtlesnapping', 'Poção Tartaruga Mordedora', 1, 1, 'item_standard', 1, 1643, 1, '{}', 'nice item', 0.50, 0),
	('transformar_turtletsea', 'Poção Tartaruga Marinha', 1, 1, 'item_standard', 1, 1642, 1, '{}', 'nice item', 0.50, 0),
	('transformar_vulture', 'Poção Abutre', 1, 1, 'item_standard', 1, 1644, 1, '{}', 'nice item', 0.50, 0),
	('transformar_wolf', 'Poção Lobo', 1, 1, 'item_standard', 1, 1645, 1, '{}', 'nice item', 0.50, 0),
	('transformar_wolfm', 'Poção Lobo Médio', 1, 1, 'item_standard', 1, 1646, 1, '{}', 'nice item', 0.50, 0),
	('transformar_wolfs', 'Poção Lobo Pequeno', 1, 1, 'item_standard', 1, 1647, 1, '{}', 'nice item', 0.50, 0),
	('transformar_woodpecker', 'Poção Pica-pau', 1, 1, 'item_standard', 1, 1648, 1, '{}', 'nice item', 0.50, 0),
	('transformar_woodpecker2', 'Poção Pica-pau Grande', 1, 1, 'item_standard', 1, 1649, 1, '{}', 'nice item', 0.50, 0),
	('trayoffood', 'Mesa de servir', 10, 1, 'item_standard', 1, 936, 1, '{}', 'nice item', 6.00, 0),
	('treinador_armadillo', 'Livro Treinador Armadillo', 100, 1, 'item_standard', 1, 1092, 1, '{}', 'nice item', 0.50, 0),
	('treinador_blackwater', 'Livro Treinador Blackwater', 100, 1, 'item_standard', 1, 1097, 1, '{}', 'nice item', 0.50, 0),
	('treinador_esmerald', 'Livro Treinador Esmerald', 100, 1, 'item_standard', 1, 1094, 1, '{}', 'nice item', 0.50, 0),
	('treinador_mcf', 'Livro Treinador Mac Farlane', 100, 1, 'item_standard', 1, 1099, 1, '{}', 'nice item', 0.50, 0),
	('treinador_rhodes', 'Livro Treinador Rhodes', 100, 1, 'item_standard', 1, 1093, 1, '{}', 'nice item', 0.50, 0),
	('treinador_saintdenis', 'Livro Treinador Saint Denis', 100, 1, 'item_standard', 1, 1095, 1, '{}', 'nice item', 0.50, 0),
	('treinador_strawberry', 'Livro Treinador Strawberry', 100, 1, 'item_standard', 1, 1098, 1, '{}', 'nice item', 0.50, 0),
	('treinador_tumbleweed', 'Livro Treinador Tumbleweed', 100, 1, 'item_standard', 1, 1100, 1, '{}', 'nice item', 0.50, 0),
	('treinador_valentine', 'Livro Treinador Valentine', 100, 1, 'item_standard', 1, 1096, 1, '{}', 'nice item', 0.50, 0),
	('tribo_01', 'Livro Tribo 01', 100, 1, 'item_standard', 1, 1211, 1, '{}', 'nice item', 0.50, 0),
	('trigo', 'Trigo', 100, 1, 'item_standard', 1, 618, 1, '{}', 'nice item', 0.50, 0),
	('uva', 'uva', 100, 1, 'item_standard', 1, 646, 1, '{}', 'nice item', 0.50, 0),
	('vacinagalinha', 'Vacina para Galinha', 1, 1, 'item_standard', 1, 1305, 1, '{}', 'nice item', 0.25, 0),
	('vacinaovelha', 'Vacina para Ovelha', 1, 1, 'item_standard', 1, 1304, 1, '{}', 'nice item', 0.25, 0),
	('vacinaporco', 'Vacina para Porcos', 1, 1, 'item_standard', 1, 1303, 1, '{}', 'nice item', 0.25, 0),
	('vacinavaca', 'Vacina para Vacas', 1, 1, 'item_standard', 1, 1302, 1, '{}', 'nice item', 0.25, 0),
	('vampire', 'Vampiro Dreno', 100, 1, 'item_standard', 1, 1454, 1, '{}', 'nice item', 0.10, 0),
	('vela', 'Vela', 100, 1, 'item_standard', 1, 1518, 1, '{}', 'nice item', 0.50, 0),
	('velaaromatica', 'Vela aromatica', 100, 1, 'item_standard', 1, 1519, 1, '{}', 'nice item', 0.50, 0),
	('velaaromatica2', 'Vela aromatica 2', 100, 1, 'item_standard', 1, 1520, 1, '{}', 'nice item', 0.50, 0),
	('velagarrafa', 'Vela de Garrafa', 100, 1, 'item_standard', 1, 1521, 1, '{}', 'nice item', 0.50, 0),
	('velasetedias', 'Vela 7 dias', 100, 1, 'item_standard', 1, 1522, 1, '{}', 'nice item', 0.50, 0),
	('veneno_cobra', 'Veneno de Cobra', 100, 1, 'item_standard', 1, 871, 1, '{}', 'nice item', 0.10, 0),
	('veneno_vespa', 'Veneno de Vespa', 1, 1, 'item_standard', 1, 1350, 1, '{}', 'nice item', 0.50, 0),
	('veneno_vespa_mex', 'Veneno Vespa Mexicana', 1, 1, 'item_standard', 1, 1351, 1, '{}', 'nice item', 0.50, 0),
	('verniz', 'Verniz', 100, 1, 'item_standard', 1, 1191, 1, '{}', 'nice item', 0.50, 0),
	('vestido', 'Vestido', 100, 1, 'item_standard', 1, 1365, 1, '{}', 'nice item', 0.50, 0),
	('vidro', 'Vidro', 100, 1, 'item_standard', 1, 1068, 1, '{}', 'nice item', 0.50, 0),
	('vinho_branco', 'Vinho Branco', 100, 1, 'item_standard', 1, 1167, 1, '{}', 'nice item', 0.50, 0),
	('violetasnowdrop', 'Violeta Snowdrop', 100, 1, 'item_standard', 1, 569, 1, '{}', 'nice item', 0.50, 0),
	('vitamina_de_maca', 'Vitamina de Maça', 100, 1, 'item_standard', 1, 1148, 1, '{}', 'nice item', 0.50, 0),
	('vitamina_jabuticaba', 'Vitamina de Jabuticaba', 100, 1, 'item_standard', 1, 1161, 1, '{}', 'nice item', 0.50, 0),
	('vitamina_uva', 'Vitamina de Uva', 100, 1, 'item_standard', 1, 1156, 1, '{}', 'nice item', 0.50, 0),
	('vitrola', 'Vitrola Antiga', 100, 1, 'item_standard', 1, 838, 1, '{}', 'nice item', 0.50, 0),
	('vulture_taxidermy', 'Taxidermia de Abutre', 10, 1, 'item_standard', 1, 907, 1, '{}', 'nice item', 1.50, 0),
	('washtub', 'Banheira de lavagem', 5, 1, 'item_standard', 1, 900, 1, '{}', 'nice item', 3.00, 0),
	('WEAPON_BOW', 'Arco', 1, 1, 'item_weapon', 1, 1258, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_FISHINGROD', 'Vara de Pesca', 1, 1, 'item_weapon', 1, 1259, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_KIT_BINOCULARS', 'Binóculos', 1, 1, 'item_weapon', 1, 1260, 1, '{}', 'nice item', 0.25, 0),
	('weapon_kit_binoculars_improved', 'Binóculos Aprimorados', 1, 1, 'item_weapon', 1, 1261, 1, '{}', 'nice item', 0.25, 0),
	('weapon_kit_metal_detector', 'Detector de Metal', 1, 1, 'item_weapon', 1, 1262, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_LASSO', 'Laço', 1, 1, 'item_weapon', 1, 1263, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_LASSO_REINFORCED', 'Laço Reforçado', 1, 1, 'item_weapon', 1, 1264, 1, '{}', 'nice item', 0.25, 0),
	('weapon_melee_hammer', 'Martelo', 1, 1, 'item_weapon', 1, 1265, 1, '{}', 'nice item', 0.25, 0),
	('weapon_melee_hatchet', 'Machadinha', 1, 1, 'item_weapon', 1, 1266, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_MELEE_KNIFE', 'Faca Padrão', 1, 1, 'item_weapon', 1, 1267, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_MELEE_LANTERN_HALOWEEN', 'Lanterna de Halloween', 1, 1, 'item_weapon', 1, 1268, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_MELEE_MACHETE_COLLECTOR', 'Facão Colecionador', 1, 1, 'item_weapon', 1, 1269, 1, '{}', 'nice item', 0.25, 0),
	('weapon_melee_torch', 'Tocha', 1, 1, 'item_weapon', 1, 1270, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_PISTOL_M1899', 'Pistola M1899', 1, 1, 'item_weapon', 1, 1271, 1, '{}', 'nice item', 0.25, 0),
	('weapon_reinforced_lasso', 'Laço de Treino', 1, 1, 'item_weapon', 1, 1272, 1, '{}', 'nice item', 0.25, 0),
	('weapon_repair_kit', 'Kit Reparo de Armas', 100, 1, 'item_standard', 1, 1102, 1, '{}', 'nice item', 0.50, 0),
	('WEAPON_REPEATER_HENRY', 'Repetidora Henry', 1, 1, 'item_weapon', 1, 1273, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_REPEATER_WINCHESTER', 'Repetidora Winchester', 1, 1, 'item_weapon', 1, 1274, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_REVOLVER_CATTLEMAN', 'Revólver Cattleman', 1, 1, 'item_weapon', 1, 1275, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_REVOLVER_DOUBLEACTION', 'Revólver Dupla Ação', 1, 1, 'item_weapon', 1, 1276, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_REVOLVER_LEMAT', 'Revólver Lemat', 1, 1, 'item_weapon', 1, 1277, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_REVOLVER_NAVY', 'Revólver Navy', 1, 1, 'item_weapon', 1, 1278, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_RIFLE_SPRINGFIELD', 'Rifle Springfield', 1, 1, 'item_weapon', 1, 1279, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_SHOTGUN_DOUBLEBARREL', 'Escopeta Cano Duplo', 1, 1, 'item_weapon', 1, 1280, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_SNIPERRIFLE_ROLLINGBLOCK', 'Rifle de Precisão Rollingblock', 1, 1, 'item_weapon', 1, 1281, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_THROWN_BOLAS', 'Bolas', 10, 1, 'item_weapon', 1, 1282, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_THROWN_MOLOTOV', 'Coquetel Molotov', 10, 1, 'item_weapon', 1, 1283, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_THROWN_POISONBOTTLE', 'Garrafa de Veneno', 10, 1, 'item_weapon', 1, 1284, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_THROWN_THROWING_KNIVES', 'Facas de Arremesso', 10, 1, 'item_weapon', 1, 1285, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_THROWN_TOMAHAWK', 'Machado de Arremesso', 10, 1, 'item_weapon', 1, 1286, 1, '{}', 'nice item', 0.25, 0),
	('weapon_thrown_tomahawk2', 'Machado de Arremesso Antigo', 10, 1, 'item_weapon', 1, 1287, 1, '{}', 'nice item', 0.25, 0),
	('wicker_bench', 'Banco de vime', 25, 1, 'item_standard', 1, 913, 1, '{}', 'nice item', 3.00, 0),
	('wolfnativetent', 'Tenda Nativa Pele de Lobo', 10, 1, 'item_standard', 1, 967, 1, '{}', 'nice item', 14.00, 0),
	('wooden_bench', 'Banco de madeira', 20, 1, 'item_standard', 1, 912, 1, '{}', 'nice item', 3.50, 0),
	('woodfence', 'Cerca de madeira', 50, 1, 'item_standard', 1, 891, 1, '{}', 'nice item', 8.00, 0),
	('wood_chair', 'Cadeira de madeira', 10, 1, 'item_standard', 1, 882, 1, '{}', 'nice item', 2.00, 0),
	('xmaspole', 'Pólo de Natal', 10, 1, 'item_standard', 1, 953, 1, '{}', 'nice item', 3.00, 0),
	('xmastree', 'Árvore de natal', 10, 1, 'item_standard', 1, 952, 1, '{}', 'nice item', 8.00, 0),
	('zebrina', 'Zebrina', 100, 1, 'item_standard', 1, 628, 1, '{}', 'nice item', 0.50, 0);

-- Copiando estrutura para tabela modelo_m2.items_crafted
CREATE TABLE IF NOT EXISTS `items_crafted` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_name` varchar(50) DEFAULT 'item',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`metadata`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID` (`id`),
  KEY `crafted_item_idx` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.items_crafted: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.item_group
CREATE TABLE IF NOT EXISTS `item_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL COMMENT 'Description of Item Group',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.item_group: ~11 rows (aproximadamente)
INSERT IGNORE INTO `item_group` (`id`, `description`) VALUES
	(1, 'default'),
	(2, 'medical'),
	(3, 'foods'),
	(4, 'tools'),
	(5, 'weapons'),
	(6, 'ammo'),
	(7, 'documents'),
	(8, 'animals'),
	(9, 'valuables'),
	(10, 'horse'),
	(11, 'herbs');

-- Copiando estrutura para tabela modelo_m2.jail
CREATE TABLE IF NOT EXISTS `jail` (
  `identifier` varchar(100) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '0',
  `characterid` varchar(5) NOT NULL DEFAULT '0',
  `time` varchar(100) NOT NULL DEFAULT '0',
  `time_s` varchar(100) NOT NULL DEFAULT '0',
  `jaillocation` varchar(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela modelo_m2.jail: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.loadout
CREATE TABLE IF NOT EXISTS `loadout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `ammo` varchar(255) NOT NULL DEFAULT '{}',
  `components` varchar(255) NOT NULL DEFAULT '{}',
  `dirtlevel` double DEFAULT 0,
  `mudlevel` double DEFAULT 0,
  `conditionlevel` double DEFAULT 0,
  `rustlevel` double DEFAULT 0,
  `used` tinyint(4) DEFAULT 0,
  `used2` tinyint(4) DEFAULT 0,
  `dropped` int(11) NOT NULL DEFAULT 0,
  `comps` longtext NOT NULL DEFAULT '{}',
  `label` varchar(50) DEFAULT NULL,
  `curr_inv` varchar(100) NOT NULL DEFAULT 'default',
  `serial_number` varchar(50) DEFAULT NULL,
  `custom_label` varchar(50) DEFAULT NULL,
  `custom_desc` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.loadout: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.mail
CREATE TABLE IF NOT EXISTS `mail` (
  `address` int(11) NOT NULL AUTO_INCREMENT,
  `charidentifier` int(11) DEFAULT NULL,
  PRIMARY KEY (`address`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.mail: ~0 rows (aproximadamente)
INSERT IGNORE INTO `mail` (`address`, `charidentifier`) VALUES
	(1, 1);

-- Copiando estrutura para tabela modelo_m2.mailbox_mails
CREATE TABLE IF NOT EXISTS `mailbox_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` varchar(50) DEFAULT NULL,
  `sender_firstname` varchar(50) DEFAULT NULL,
  `sender_lastname` varchar(50) DEFAULT NULL,
  `receiver_id` varchar(50) DEFAULT NULL,
  `receiver_firstname` varchar(50) DEFAULT NULL,
  `receiver_lastname` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `opened` tinyint(1) DEFAULT 0,
  `received_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.mailbox_mails: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.mails
CREATE TABLE IF NOT EXISTS `mails` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `anon` tinyint(1) DEFAULT NULL,
  `read` tinyint(1) DEFAULT NULL,
  `from` longtext DEFAULT NULL,
  `to` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `subject` longtext DEFAULT NULL,
  `body` longtext DEFAULT NULL,
  `folder` longtext DEFAULT NULL,
  `fromName` longtext DEFAULT NULL,
  `toNames` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `date` longtext DEFAULT NULL,
  `hidesent` tinyint(4) DEFAULT 0,
  `copyTo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.mails: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.mail_addressbook
CREATE TABLE IF NOT EXISTS `mail_addressbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `poBox` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `address` (`address`),
  CONSTRAINT `mail_addressbook_ibfk_1` FOREIGN KEY (`address`) REFERENCES `mail` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.mail_addressbook: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.mail_editablefolders
CREATE TABLE IF NOT EXISTS `mail_editablefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` int(11) DEFAULT NULL,
  `folderName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `address` (`address`),
  CONSTRAINT `mail_editablefolders_ibfk_1` FOREIGN KEY (`address`) REFERENCES `mail` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.mail_editablefolders: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.mdg_clothes_state
CREATE TABLE IF NOT EXISTS `mdg_clothes_state` (
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `category` varchar(20) NOT NULL,
  `state` int(11) NOT NULL,
  PRIMARY KEY (`identifier`,`charid`,`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.mdg_clothes_state: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.mdg_horses
CREATE TABLE IF NOT EXISTS `mdg_horses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `stable` varchar(50) NOT NULL,
  `model` varchar(100) NOT NULL,
  `isFemale` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL,
  `birth` timestamp NULL DEFAULT current_timestamp(),
  `deathAge` float DEFAULT 30,
  `speed` tinyint(4) NOT NULL,
  `acceleration` tinyint(4) NOT NULL,
  `handling` tinyint(4) NOT NULL,
  `favourite` tinyint(1) NOT NULL DEFAULT 0,
  `isDead` tinyint(1) NOT NULL DEFAULT 0,
  `isOut` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.mdg_horses: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.mdg_horses_stats
CREATE TABLE IF NOT EXISTS `mdg_horses_stats` (
  `horseid` int(11) NOT NULL,
  `distance` int(11) NOT NULL DEFAULT 0,
  `lastNewShoes` int(11) NOT NULL DEFAULT 0,
  `bonding` int(11) NOT NULL DEFAULT 0,
  `speedTraining` int(11) NOT NULL DEFAULT 0,
  `accelerationTraining` int(11) NOT NULL DEFAULT 0,
  `handlingTraining` int(11) NOT NULL DEFAULT 0,
  `stamina` int(11) NOT NULL DEFAULT 0,
  `health` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`horseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.mdg_horses_stats: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.mdg_matabolism_v2
CREATE TABLE IF NOT EXISTS `mdg_matabolism_v2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `personaId` int(11) DEFAULT NULL,
  `statHunger` int(11) NOT NULL DEFAULT 0,
  `statThirst` int(11) NOT NULL DEFAULT 0,
  `statHealth` int(11) NOT NULL DEFAULT 200,
  `statHealthCore` int(11) NOT NULL DEFAULT 100,
  `statStamina` int(11) NOT NULL DEFAULT 200,
  `statStaminaCore` int(11) NOT NULL DEFAULT 100,
  `statStress` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `personaId` (`personaId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.mdg_matabolism_v2: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.mdg_outfits
CREATE TABLE IF NOT EXISTS `mdg_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL,
  `charid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `outfit` varchar(5000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`,`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.mdg_outfits: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.mdg_stable_bought
CREATE TABLE IF NOT EXISTS `mdg_stable_bought` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `hash` bigint(20) NOT NULL,
  `equiped_on` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`,`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.mdg_stable_bought: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.mdg_stable_color
CREATE TABLE IF NOT EXISTS `mdg_stable_color` (
  `id` int(11) NOT NULL,
  `drawable` int(11) DEFAULT NULL,
  `albedo` int(11) DEFAULT NULL,
  `normal` int(11) DEFAULT NULL,
  `material` int(11) DEFAULT NULL,
  `palette` varchar(100) DEFAULT NULL,
  `tint1` tinyint(3) unsigned DEFAULT NULL,
  `tint2` tinyint(3) unsigned DEFAULT NULL,
  `tint3` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.mdg_stable_color: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.mdg_vip
CREATE TABLE IF NOT EXISTS `mdg_vip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` text DEFAULT NULL,
  `charid` int(11) DEFAULT NULL,
  `vip` text DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `charid` (`charid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.mdg_vip: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.mdg_wagons
CREATE TABLE IF NOT EXISTS `mdg_wagons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `stable` varchar(50) NOT NULL,
  `model` varchar(100) NOT NULL,
  `name` varchar(100) DEFAULT '',
  `vehicle_tints` int(11) NOT NULL DEFAULT -2,
  `vehicle_propsets` varchar(50) NOT NULL DEFAULT '-1',
  `vehicle_liveries` int(11) NOT NULL DEFAULT -1,
  `vehicle_lantern_propsets` varchar(50) NOT NULL DEFAULT '-1',
  `vehicle_extras` int(11) NOT NULL DEFAULT -1,
  `isOut` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.mdg_wagons: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.outfits
CREATE TABLE IF NOT EXISTS `outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(45) NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `comps` longtext DEFAULT NULL,
  `compTints` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela modelo_m2.outfits: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.pets
CREATE TABLE IF NOT EXISTS `pets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(500) DEFAULT NULL,
  `charid` int(11) DEFAULT 0,
  `selected` int(11) DEFAULT 0,
  `pets_info` varchar(3000) DEFAULT NULL,
  `is_dead` int(11) DEFAULT 0,
  `favorite` longtext NOT NULL DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.pets: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.playerhousing
CREATE TABLE IF NOT EXISTS `playerhousing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT 0,
  `primarydoor` longtext NOT NULL DEFAULT '[]',
  `otherdoors` longtext NOT NULL DEFAULT '[]',
  `range` int(11) DEFAULT 0,
  `owned` int(11) DEFAULT 0,
  `selleridentifier` varchar(50) NOT NULL DEFAULT '',
  `sellercharidentifier` int(11) NOT NULL DEFAULT 0,
  `ledger` double NOT NULL DEFAULT 0,
  `tax` int(11) NOT NULL DEFAULT 0,
  `repoed` int(11) NOT NULL DEFAULT 0,
  `invspace` int(11) NOT NULL DEFAULT 0,
  `upgrade` int(11) NOT NULL DEFAULT 0,
  `keyholders` longtext NOT NULL DEFAULT '[]',
  `changingroom` longtext NOT NULL DEFAULT '[]',
  `inventorylocation` longtext NOT NULL DEFAULT '[]',
  `items` longtext NOT NULL DEFAULT '[]',
  `furniture` longtext NOT NULL DEFAULT '[]',
  `price` int(11) NOT NULL DEFAULT 0,
  `buyeridentifier` varchar(50) NOT NULL DEFAULT '0',
  `buyercharidentifier` int(11) NOT NULL DEFAULT 0,
  `taxledger` int(11) DEFAULT 0,
  `motel` longtext DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `primarydoor` (`primarydoor`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.playerhousing: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.playerhousing_sold_home_ledger
CREATE TABLE IF NOT EXISTS `playerhousing_sold_home_ledger` (
  `id` int(11) NOT NULL DEFAULT 0,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.playerhousing_sold_home_ledger: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.playershops
CREATE TABLE IF NOT EXISTS `playershops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL DEFAULT '0',
  `charidentifier` int(11) NOT NULL DEFAULT 0,
  `items` longtext NOT NULL DEFAULT '[]',
  `weapons` longtext NOT NULL DEFAULT '[]',
  `price` float NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT '',
  `slots` int(11) NOT NULL DEFAULT 0,
  `coords` longtext NOT NULL DEFAULT '[]',
  `owned` int(11) DEFAULT 0,
  `blip` int(11) DEFAULT 1,
  `ledger` double DEFAULT 0,
  `level` int(255) DEFAULT 0,
  `taxledger` double DEFAULT 0,
  `repo` int(11) DEFAULT 0,
  `buyitems` longtext DEFAULT '{}',
  `webhook` longtext DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `items` (`items`(768)),
  KEY `weapons` (`weapons`(768))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.playershops: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.playershops2
CREATE TABLE IF NOT EXISTS `playershops2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `society` varchar(50) NOT NULL DEFAULT '0',
  `items` longtext NOT NULL DEFAULT '[]',
  `weapons` longtext NOT NULL DEFAULT '[]',
  `slots` int(11) NOT NULL DEFAULT 50,
  `level` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) DEFAULT '',
  `coords` longtext DEFAULT '{}',
  `rank` int(11) DEFAULT 0,
  `blip` int(11) DEFAULT 0,
  `buyitems` longtext DEFAULT '{}',
  `webhook` longtext DEFAULT '{}',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.playershops2: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.ranch
CREATE TABLE IF NOT EXISTS `ranch` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `steam` varchar(100) DEFAULT NULL,
  `charid` int(11) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `shared` longtext NOT NULL,
  `money` double(255,0) DEFAULT 0,
  `coords` longtext NOT NULL,
  `trash` longtext NOT NULL,
  `chicken` longtext NOT NULL,
  `cow` longtext NOT NULL,
  `sheep` longtext NOT NULL,
  `goat` longtext NOT NULL,
  `horse` longtext NOT NULL,
  `pig` longtext NOT NULL,
  `trough` longtext NOT NULL,
  `prepayed` varchar(255) DEFAULT '0',
  `prepayed_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela modelo_m2.ranch: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.real_logic_pets
CREATE TABLE IF NOT EXISTS `real_logic_pets` (
  `update_time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.real_logic_pets: ~0 rows (aproximadamente)
INSERT IGNORE INTO `real_logic_pets` (`update_time`) VALUES
	(0);

-- Copiando estrutura para tabela modelo_m2.real_logic_ranch
CREATE TABLE IF NOT EXISTS `real_logic_ranch` (
  `update_time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.real_logic_ranch: ~0 rows (aproximadamente)
INSERT IGNORE INTO `real_logic_ranch` (`update_time`) VALUES
	(0);

-- Copiando estrutura para tabela modelo_m2.rooms
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `key` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela modelo_m2.rooms: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.society
CREATE TABLE IF NOT EXISTS `society` (
  `job` longtext DEFAULT NULL,
  `jobgrade` int(11) DEFAULT NULL,
  `salary` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.society: ~53 rows (aproximadamente)
INSERT IGNORE INTO `society` (`job`, `jobgrade`, `salary`) VALUES
	('Marshal', NULL, 0),
	('Doutor', NULL, 0),
	('Lenhador', NULL, 0),
	('Fundicao_Valentine', NULL, 0),
	('Fundicao_Blackwater', NULL, 0),
	('Fundicao_Sd', NULL, 0),
	('Ferraria_Armadillo', NULL, 0),
	('Ferraria_Blackwater', NULL, 0),
	('Ferraria_Strawberry', NULL, 0),
	('Ferraria_Valentine', NULL, 0),
	('Ferraria_Rhodes', NULL, 0),
	('Ferraria_Saint_Denis', NULL, 0),
	('Treinador_Rhodes', NULL, 0),
	('Treinador_Armadillo', NULL, 0),
	('Treinador_SaitDenis', NULL, 0),
	('Treinador_Esmerald', NULL, 0),
	('Treinador_Valentine', NULL, 0),
	('Treinador_Strawberry', NULL, 0),
	('Treinador_Blackwater', NULL, 0),
	('Treinador_Mcf', NULL, 0),
	('Treinador_Tumbleweed', NULL, 0),
	('Veterinario_Esmerald', NULL, 0),
	('Armaria_Rhodes', NULL, 0),
	('Armaria_SaintDenis', NULL, 0),
	('Armaria_Annesburg', NULL, 0),
	('Armaria_Valentine', NULL, 0),
	('Armaria_Blackwater', NULL, 0),
	('Armaria_Strawberry', NULL, 0),
	('Armaria_Tumbleweed', NULL, 0),
	('Tabacaria_Valentine', NULL, 0),
	('Tabacaria_Blackwater', NULL, 0),
	('Padaria_Blackwater', NULL, 0),
	('Padaria_SaintDenis', NULL, 0),
	('Saloon_Valentine', NULL, 0),
	('Saloon_Rhodes', NULL, 0),
	('Saloon_Armadillo', NULL, 0),
	('Saloon_VanHorn', NULL, 0),
	('Saloon_SaintDenis', NULL, 0),
	('Saloon_Blackwater', NULL, 0),
	('Saloon_Strawberry', NULL, 0),
	('Saloon_Annesburg', NULL, 0),
	('Fazenda_01', NULL, 0),
	('Fazenda_02', NULL, 0),
	('Fazenda_03', NULL, 0),
	('Fazenda_04', NULL, 0),
	('Fazenda_05', NULL, 0),
	('Fazenda_06', NULL, 0),
	('Fazenda_07', NULL, 0),
	('Fazenda_08', NULL, 0),
	('Fazenda_09', NULL, 0),
	('Fazenda_10', NULL, 0),
	('Artesanato_Blackwater', NULL, 0),
	('Tribo_01', NULL, 0);

-- Copiando estrutura para tabela modelo_m2.society_ledger
CREATE TABLE IF NOT EXISTS `society_ledger` (
  `job` longtext DEFAULT NULL,
  `ledger` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.society_ledger: ~70 rows (aproximadamente)
INSERT IGNORE INTO `society_ledger` (`job`, `ledger`) VALUES
	('Marshal', 0),
	('Doutor', 0),
	('Lenhador', 0),
	('Fundicao_Valentine', 0),
	('Fundicao_Blackwater', 0),
	('Fundicao_Sd', 0),
	('Ferraria_Armadillo', 0),
	('Ferraria_Blackwater', 0),
	('Ferraria_Strawberry', 0),
	('Ferraria_Valentine', 0),
	('Ferraria_Rhodes', 0),
	('Ferraria_Saint_Denis', 0),
	('Treinador_Rhodes', 0),
	('Treinador_Armadillo', 0),
	('Treinador_SaitDenis', 0),
	('Treinador_Esmerald', 0),
	('Treinador_Valentine', 0),
	('Treinador_Strawberry', 0),
	('Treinador_Blackwater', 0),
	('Treinador_Mcf', 0),
	('Treinador_Tumbleweed', 0),
	('Veterinario_Esmerald', 0),
	('Armaria_Rhodes', 0),
	('Armaria_SaintDenis', 0),
	('Armaria_Annesburg', 0),
	('Armaria_Valentine', 0),
	('Armaria_Blackwater', 0),
	('Armaria_Strawberry', 0),
	('Armaria_Tumbleweed', 0),
	('Tabacaria_Valentine', 0),
	('Tabacaria_Blackwater', 0),
	('Padaria_Blackwater', 0),
	('Padaria_SaintDenis', 0),
	('Saloon_Valentine', 0),
	('Saloon_Rhodes', 0),
	('Saloon_Armadillo', 0),
	('Saloon_VanHorn', 0),
	('Saloon_SaintDenis', 0),
	('Saloon_Blackwater', 0),
	('Saloon_Strawberry', 0),
	('Saloon_Annesburg', 0),
	('Fazenda_01', 0),
	('Fazenda_02', 0),
	('Fazenda_03', 0),
	('Fazenda_04', 0),
	('Fazenda_05', 0),
	('Fazenda_06', 0),
	('Fazenda_07', 0),
	('Fazenda_08', 0),
	('Fazenda_09', 0),
	('Fazenda_10', 0),
	('Artesanato_Blackwater', 0),
	('Tribo_01', 0),
	('Fazenda_11', 0),
	('Fazenda_12', 0),
	('Fazenda_13', 0),
	('Fazenda_14', 0),
	('Fazenda_15', 0),
	('Fazenda_16', 0),
	('Fazenda_17', 0),
	('Fazenda_18', 0),
	('Fazenda_19', 0),
	('Fazenda_20', 0),
	('Fazenda_21', 0),
	('Fazenda_22', 0),
	('Fazenda_23', 0),
	('Fazenda_24', 0),
	('Fazenda_25', 0),
	('Fazenda_26', 0),
	('Fazenda_27', 0);

-- Copiando estrutura para tabela modelo_m2.stables
CREATE TABLE IF NOT EXISTS `stables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `modelname` varchar(70) NOT NULL,
  `type` varchar(11) NOT NULL,
  `status` longtext DEFAULT NULL,
  `xp` int(11) DEFAULT 0,
  `injured` int(11) DEFAULT 0,
  `gear` longtext DEFAULT NULL,
  `isDefault` int(11) NOT NULL DEFAULT 0,
  `inventory` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela modelo_m2.stables: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.underground
CREATE TABLE IF NOT EXISTS `underground` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `coords` longtext DEFAULT NULL,
  `zone` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `theme` varchar(50) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `upgrades` longtext DEFAULT '[]',
  `owned` int(11) DEFAULT 0,
  `ledger` double DEFAULT 0,
  `items` longtext DEFAULT '[]',
  `invslots` int(11) DEFAULT 0,
  `invlevel` int(11) DEFAULT 0,
  `bookie` int(11) DEFAULT 0,
  `justraided` int(11) DEFAULT 0,
  `raidcooldown` int(11) DEFAULT 0,
  `raidday` int(11) DEFAULT 0,
  `lasttimer` int(11) DEFAULT 0,
  `lasttimer2` int(11) DEFAULT 0,
  `mashinfo` longtext DEFAULT '[]',
  `stillinfo` longtext DEFAULT '[]',
  `still` longtext DEFAULT '[]',
  `coowners` longtext DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.underground: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `group` varchar(50) DEFAULT 'user',
  `warnings` int(11) DEFAULT 0,
  `banned` tinyint(1) DEFAULT NULL,
  `banneduntil` int(10) DEFAULT 0,
  `char` int(11) DEFAULT 5,
  `max_jobs` int(11) DEFAULT 3,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.users: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.vlt_balloons
CREATE TABLE IF NOT EXISTS `vlt_balloons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `balloon_type` varchar(50) NOT NULL DEFAULT 'hotairballoon01',
  `is_permanent` tinyint(1) NOT NULL DEFAULT 0,
  `rental_days` int(11) DEFAULT NULL,
  `purchase_date` bigint(20) DEFAULT NULL,
  `expire_date` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`),
  KEY `charid` (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.vlt_balloons: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.vlt_bank
CREATE TABLE IF NOT EXISTS `vlt_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `money` double(22,2) NOT NULL DEFAULT 0.00,
  `gold` double(22,2) NOT NULL DEFAULT 0.00,
  `items` longtext DEFAULT '[]',
  `invspace` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.vlt_bank: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.vlt_barber_system
CREATE TABLE IF NOT EXISTS `vlt_barber_system` (
  `id` int(3) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `charid` int(5) NOT NULL,
  `ownername` varchar(50) NOT NULL,
  `money` int(20) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL,
  `price` int(20) NOT NULL DEFAULT 0,
  `blipsprite` bigint(32) NOT NULL DEFAULT 0,
  `blipmodif` bigint(32) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.vlt_barber_system: ~2 rows (aproximadamente)
INSERT IGNORE INTO `vlt_barber_system` (`id`, `identifier`, `charid`, `ownername`, `money`, `name`, `price`, `blipsprite`, `blipmodif`) VALUES
	(1, '0', 0, '', 8, 'Blackwater Barber', 100000, -2090472724, 0),
	(2, '0', 0, '', 0, 'Valentine Barber', 100000, -2090472724, 0),
	(3, '0', 0, '', 0, 'Saint Denis Barber', 100000, -2090472724, 0);

-- Copiando estrutura para tabela modelo_m2.vlt_boats_system
CREATE TABLE IF NOT EXISTS `vlt_boats_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `charid` int(5) NOT NULL,
  `model` int(40) NOT NULL,
  `name` varchar(50) NOT NULL,
  `components` varchar(5000) NOT NULL,
  `price` int(8) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.vlt_boats_system: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.vlt_identity
CREATE TABLE IF NOT EXISTS `vlt_identity` (
  `identifier` varchar(60) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `birthdate` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.vlt_identity: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.vlt_madame_nazar
CREATE TABLE IF NOT EXISTS `vlt_madame_nazar` (
  `charid` int(11) DEFAULT NULL,
  `identifier` varchar(100) DEFAULT NULL,
  `VLT_madame_nazar` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela modelo_m2.vlt_madame_nazar: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.wagons
CREATE TABLE IF NOT EXISTS `wagons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `items` longtext DEFAULT '{}',
  PRIMARY KEY (`id`),
  KEY `FK_horses_characters` (`charid`),
  KEY `model` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela modelo_m2.wagons: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela modelo_m2.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `firstconnection` tinyint(1) DEFAULT 1,
  `discordid` varchar(255) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela modelo_m2.whitelist: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
