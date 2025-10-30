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


-- Copiando estrutura do banco de dados para mdg_ultimate
CREATE DATABASE IF NOT EXISTS `mdg_ultimate` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `mdg_ultimate`;

-- Copiando estrutura para procedure mdg_ultimate.AlterTableMail
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

-- Copiando estrutura para tabela mdg_ultimate.animations
CREATE TABLE IF NOT EXISTS `animations` (
  `charid` int(11) NOT NULL,
  `steam` varchar(255) DEFAULT NULL,
  `animations` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.animations: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.animationsfavorite
CREATE TABLE IF NOT EXISTS `animationsfavorite` (
  `charid` int(11) NOT NULL DEFAULT 0,
  `steam` varchar(255) DEFAULT NULL,
  `favorite` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.animationsfavorite: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.bills
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

-- Copiando dados para a tabela mdg_ultimate.bills: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.birds
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

-- Copiando dados para a tabela mdg_ultimate.birds: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.characters
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
  `motel` longtext DEFAULT '0',
  `moonshineenty` longtext DEFAULT '{}',
  `clan` int(11) DEFAULT 0,
  `info` longtext DEFAULT '{}',
  `mdg_faxina` int(11) DEFAULT 0,
  `trust` int(11) DEFAULT 0,
  `hud_positions` text DEFAULT NULL,
  `VLT_sweep` int(11) DEFAULT 0,
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

-- Copiando dados para a tabela mdg_ultimate.characters: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.character_inventories
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

-- Copiando dados para a tabela mdg_ultimate.character_inventories: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.clan
CREATE TABLE IF NOT EXISTS `clan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `info` longtext NOT NULL DEFAULT '[]',
  `cash` tinytext NOT NULL DEFAULT 0,
  `inventory` longtext NOT NULL DEFAULT '[]',
  `invlimit` int(11) DEFAULT 1000,
  `repo` int(11) DEFAULT 0,
  `taxmoney` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `coords` (`id`),
  KEY `container` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.clan: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.clothes_bought
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

-- Copiando dados para a tabela mdg_ultimate.clothes_bought: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.communityservice
CREATE TABLE IF NOT EXISTS `communityservice` (
  `identifier` varchar(100) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '0',
  `characterid` varchar(5) NOT NULL DEFAULT '0',
  `communityservice` varchar(100) NOT NULL DEFAULT '0',
  `servicecount` varchar(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela mdg_ultimate.communityservice: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.container
CREATE TABLE IF NOT EXISTS `container` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT NULL,
  `items` longtext NOT NULL DEFAULT '{}',
  `invslots` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.container: ~84 rows (aproximadamente)
INSERT IGNORE INTO `container` (`id`, `name`, `items`, `invslots`) VALUES
	(1, 'police', '[]', 0),
	(2, 'miner', '[]', 0),
	(3, 'horsetrainer', '[]', 0),
	(4, 'doctor', '[]', 0),
	(5, 'ArmariaVL', '[]', 5000),
	(6, 'ArmariaRH', '[]', 5000),
	(7, 'ArmariaTW', '[]', 5000),
	(8, 'ArmariaSD', '[]', 5000),
	(9, 'ArmariaAN', '[]', 5000),
	(10, 'SaloonVL', '[]', 5000),
	(11, 'SaloonARM', '[]', 5000),
	(12, 'SaloonRH', '[]', 5000),
	(13, 'SaloonBW', '[]', 5000),
	(14, 'FerrariaVL', '[]', 5000),
	(15, 'FerrariaSD', '[]', 5000),
	(16, 'FerrariaSB', '[]', 5000),
	(17, 'FerrariaRH', '[]', 5000),
	(18, 'Fazenda01', '[]', 5000),
	(19, 'Fazenda02', '[]', 5000),
	(20, 'Fazenda03', '[]', 5000),
	(21, 'Fazenda04', '[]', 5000),
	(22, 'Fazenda05', '[]', 5000),
	(23, 'Fazenda06', '[]', 5000),
	(24, 'PadariaBW', '[]', 5000),
	(25, 'PadariaESM', '[]', 5000),
	(26, 'MoonshinerSD', '[]', 5000),
	(27, 'MoonshinerVL', '[]', 5000),
	(28, 'MoonshinerBW', '[]', 5000),
	(29, 'Aldeia01', '[]', 5000),
	(30, 'Aldeia02', '[]', 5000),
	(31, 'Aldeia03', '[]', 5000),
	(32, 'TreinadorRH', '[]', 5000),
	(33, 'TreinadorVL', '[]', 5000),
	(34, 'TreinadorMFR', '[]', 5000),
	(35, 'TreinadorBW', '[]', 5000),
	(36, 'FerrariaBW', '[]', 5000),
	(37, 'ArtesanatoRH', '[]', 5000),
	(38, 'ArtesanatoBW', '[]', 5000),
	(39, 'SaloonESM', '[]', 5000),
	(40, 'SaloonVH', '[]', 5000),
	(41, 'TabacariaVL', '[]', 5000),
	(42, 'Petrolifera', '[]', 5000),
	(43, 'Papelaria', '[]', 5000),
	(44, 'Fazenda07', '[]', 5000),
	(45, 'Fazenda08', '[]', 5000),
	(46, 'Fazenda09', '[]', 5000),
	(47, 'Fazenda10', '[]', 5000),
	(48, 'Fazenda11', '[]', 5000),
	(49, 'Fazenda12', '[]', 5000),
	(50, 'Fazenda13', '[]', 5000),
	(51, 'Fazenda14', '[]', 5000),
	(52, 'Fazenda15', '[]', 5000),
	(53, 'Fazenda16', '[]', 5000),
	(54, 'Fazenda17', '[]', 5000),
	(55, 'Fazenda18', '[]', 5000),
	(56, 'Fazenda19', '[]', 5000),
	(57, 'Fazenda20', '[]', 5000),
	(58, 'Fazenda21', '[]', 5000),
	(59, 'Fazenda22', '[]', 5000),
	(60, 'Fazenda23', '[]', 5000),
	(61, 'Fazenda24', '[]', 5000),
	(62, 'Fazenda25', '[]', 5000),
	(63, 'Fazenda26', '[]', 5000),
	(64, 'Fazenda27', '[]', 5000),
	(65, 'Fazenda28', '[]', 5000),
	(66, 'Fazenda29', '[]', 5000),
	(67, 'Fazenda30', '[]', 5000),
	(68, 'Fazenda31', '[]', 5000),
	(69, 'Fazenda32', '[]', 5000),
	(70, 'Fazenda33', '[]', 5000),
	(71, 'Fazenda34', '[]', 5000),
	(72, 'Fazenda35', '[]', 5000),
	(73, 'Fazenda36', '[]', 5000),
	(74, 'Fazenda37', '[]', 5000),
	(75, 'Fazenda38', '[]', 5000),
	(76, 'Fazenda39', '[]', 5000),
	(77, 'Fazenda40', '[]', 5000),
	(78, 'Fazenda41', '[]', 5000),
	(79, 'Fazenda42', '[]', 5000),
	(80, 'Fazenda43', '[]', 5000),
	(81, 'SerrariaBW', '[]', 5000),
	(82, 'SaloonSD', '[]', 5000),
	(83, 'ArmariaBW', '[]', 5000),
	(84, 'TabacariaBW', '[]', 5000);

-- Copiando estrutura para tabela mdg_ultimate.doors
CREATE TABLE IF NOT EXISTS `doors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doorinfo` longtext NOT NULL DEFAULT '[]',
  `job` longtext NOT NULL DEFAULT '[]',
  `item` longtext NOT NULL,
  `breakin` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.doors: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.herbalists
CREATE TABLE IF NOT EXISTS `herbalists` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`identifier`) USING BTREE,
  UNIQUE KEY `identifier_charidentifier` (`identifier`,`charidentifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela mdg_ultimate.herbalists: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.horses
CREATE TABLE IF NOT EXISTS `horses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(600) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `components` longtext DEFAULT NULL,
  `exp` int(11) NOT NULL DEFAULT 0,
  `age` varchar(50) DEFAULT '0',
  `clothes` longtext DEFAULT NULL,
  `courage` int(11) NOT NULL DEFAULT 0,
  `cityPosition` int(11) NOT NULL DEFAULT 0,
  `spotPosition` int(11) NOT NULL DEFAULT 0,
  `interiorPosition` int(11) NOT NULL DEFAULT 0,
  `horseCompany` int(11) NOT NULL DEFAULT 0,
  `housePosition` int(11) NOT NULL DEFAULT 0,
  `status` longtext DEFAULT NULL,
  `friendly` int(11) NOT NULL DEFAULT 0,
  `breeding` varchar(255) DEFAULT '0',
  `sex` varchar(255) DEFAULT NULL,
  `isdead` varchar(255) DEFAULT '0',
  `state` varchar(255) DEFAULT '{}',
  PRIMARY KEY (`id`),
  KEY `FK_horses_characters` (`charid`),
  KEY `model` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.horses: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.horsesstore
CREATE TABLE IF NOT EXISTS `horsesstore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `components` longtext DEFAULT NULL,
  `exp` int(11) NOT NULL DEFAULT 0,
  `courage` int(11) NOT NULL DEFAULT 0,
  `status` longtext DEFAULT NULL,
  `friendly` int(11) NOT NULL DEFAULT 0,
  `age` varchar(50) DEFAULT '0',
  `breeding` varchar(255) DEFAULT '0',
  `sex` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT '{}',
  `isBuyed` int(11) DEFAULT 0,
  `storePosition` varchar(500) DEFAULT NULL,
  `price` varchar(500) DEFAULT NULL,
  `descriptions` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `model` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.horsesstore: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.horsestrainers
CREATE TABLE IF NOT EXISTS `horsestrainers` (
  `steam` varchar(600) DEFAULT NULL,
  `charidentifier` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `name` varchar(600) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.horsestrainers: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.horses_breeding
CREATE TABLE IF NOT EXISTS `horses_breeding` (
  `identifier` varchar(600) NOT NULL,
  `charid` varchar(255) NOT NULL,
  `reward_model` varchar(255) DEFAULT '0',
  `reward_sex` varchar(255) DEFAULT '0',
  `breeding_id_horse_1` varchar(255) DEFAULT '0',
  `breeding_name_horse_1` varchar(255) DEFAULT '0',
  `breeding_model_horse_1` varchar(255) DEFAULT '0',
  `breeding_id_horse_2` varchar(255) DEFAULT '0',
  `breeding_name_horse_2` varchar(255) DEFAULT '0',
  `breeding_model_horse_2` varchar(255) DEFAULT '0',
  `breeding_time` varchar(50) DEFAULT '0',
  `exp` longtext NOT NULL DEFAULT '0',
  `breeding_comp_horse_1` longtext DEFAULT NULL,
  `breeding_comp_horse_2` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.horses_breeding: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.horse_breeding
CREATE TABLE IF NOT EXISTS `horse_breeding` (
  `horse` int(11) NOT NULL,
  `dateStart` bigint(20) NOT NULL,
  `foal` int(11) NOT NULL,
  PRIMARY KEY (`horse`),
  KEY `foal` (`foal`),
  CONSTRAINT `horse_breeding_ibfk_1` FOREIGN KEY (`foal`) REFERENCES `mdg_horses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `horse_breeding_ibfk_2` FOREIGN KEY (`horse`) REFERENCES `mdg_horses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.horse_breeding: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.horse_breeding_history
CREATE TABLE IF NOT EXISTS `horse_breeding_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `horse_id` int(11) NOT NULL,
  `partner_id` int(11) NOT NULL,
  `breeding_date` bigint(20) NOT NULL,
  `foal_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_horse_id` (`horse_id`),
  KEY `idx_partner_id` (`partner_id`),
  KEY `foal_id` (`foal_id`),
  CONSTRAINT `horse_breeding_history_ibfk_1` FOREIGN KEY (`horse_id`) REFERENCES `mdg_horses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `horse_breeding_history_ibfk_2` FOREIGN KEY (`partner_id`) REFERENCES `mdg_horses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `horse_breeding_history_ibfk_3` FOREIGN KEY (`foal_id`) REFERENCES `mdg_horses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.horse_breeding_history: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.horse_complements
CREATE TABLE IF NOT EXISTS `horse_complements` (
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) NOT NULL,
  `complements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela mdg_ultimate.horse_complements: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.horse_components
CREATE TABLE IF NOT EXISTS `horse_components` (
  `horse_id` int(11) NOT NULL,
  `components` longtext DEFAULT NULL,
  PRIMARY KEY (`horse_id`),
  CONSTRAINT `horse_components_ibfk_1` FOREIGN KEY (`horse_id`) REFERENCES `mdg_horses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.horse_components: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.housing
CREATE TABLE IF NOT EXISTS `housing` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `charidentifier` int(11) NOT NULL,
  `key` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela mdg_ultimate.housing: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.items
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
) ENGINE=InnoDB AUTO_INCREMENT=216655 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela mdg_ultimate.items: ~2.092 rows (aproximadamente)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `id`, `groupId`, `metadata`, `desc`, `weight`, `degradation`) VALUES
	('absinthe', 'Absinto', 100, 1, 'item_standard', 1, 1600, 1, '{}', '', 0.25, 0),
	('accessories', 'Accessories', 20, 1, 'item_standard', 1, 17605, 1, '{}', 'nice item', 0.25, 0),
	('acid', 'Ácido', 100, 1, 'item_standard', 1, 1, 1, '{}', '', 0.25, 0),
	('Agarita', 'Agarita ', 100, 1, 'item_standard', 1, 2, 1, '{}', '', 0.25, 0),
	('Agarita_Seed', 'Agarita Seed', 100, 1, 'item_standard', 1, 3, 1, '{}', '', 0.25, 0),
	('agerato', 'Agerato', 100, 1, 'item_standard', 1, 216152, 1, '{}', 'nice item', 0.50, 0),
	('aguapurificada', 'Agua Fervida', 100, 1, 'item_standard', 1, 215673, 1, '{}', 'nice item', 0.25, 0),
	('Alaskan_Ginseng', 'Alaskan Ginseng', 100, 1, 'item_standard', 1, 4, 1, '{}', '', 0.25, 0),
	('Alaskan_Ginseng_Seed', 'Alaskan Ginseng Seed', 100, 1, 'item_standard', 1, 5, 1, '{}', '', 0.25, 0),
	('alcool', 'Álcool', 100, 1, 'item_standard', 1, 16805, 1, '{}', '', 0.25, 0),
	('alcool_industrial', 'alcool industrial', 100, 1, 'item_standard', 1, 16804, 1, '{}', '', 0.25, 0),
	('aldeia01', 'Aldeia 01', 100, 1, 'item_standard', 1, 215813, 1, '{}', 'nice item', 0.25, 0),
	('algodao', 'Algodão', 100, 1, 'item_standard', 1, 215814, 1, '{}', 'nice item', 0.25, 0),
	('algodao_Seed', 'Semente de Algodão', 100, 1, 'item_standard', 1, 215800, 1, '{}', 'nice item', 0.25, 0),
	('aligatormeat', 'carne de jacaré', 100, 1, 'item_standard', 1, 568, 1, '{}', '', 0.25, 0),
	('aligators', 'pele de jacare', 100, 1, 'item_standard', 1, 544, 1, '{}', '', 5.00, 0),
	('aligatorto', 'cabeça de jacare', 100, 1, 'item_standard', 1, 543, 1, '{}', '', 5.00, 0),
	('alligators', 'Jacarés', 100, 1, 'item_standard', 1, 215937, 1, '{}', 'nice item', 0.25, 0),
	('alligatorto', 'Jacaré Morto', 100, 1, 'item_standard', 1, 215938, 1, '{}', 'nice item', 0.25, 0),
	('American_Ginseng', 'Ginseng Americano', 100, 1, 'item_standard', 1, 7, 1, '{}', '', 0.25, 0),
	('American_Ginseng_Seed', 'Semente de Ginseng Americano', 100, 1, 'item_standard', 1, 8, 1, '{}', '', 0.25, 0),
	('amidomilho', 'Amido de Milho', 100, 1, 'item_standard', 1, 170503, 1, '{}', 'nice item', 0.25, 0),
	('ammoarrmownormal', 'flecha  Normal', 100, 1, 'item_standard', 1, 1238, 1, '{}', '', 0.25, 0),
	('ammoarrowdynamite', 'flecha Dynamite', 100, 1, 'item_standard', 1, 10, 1, '{}', '', 0.25, 0),
	('ammoarrowfire', 'flecha Fire', 100, 1, 'item_standard', 1, 11, 1, '{}', '', 0.25, 0),
	('ammoarrowimproved', 'flecha Improved', 100, 1, 'item_standard', 1, 12, 1, '{}', '', 0.25, 0),
	('ammoarrownormal', 'flexa normal', 100, 1, 'item_standard', 1, 16929, 1, '{}', '', 0.25, 0),
	('ammoarrowpoison', 'flecha Poison', 100, 1, 'item_standard', 1, 13, 1, '{}', '', 0.25, 0),
	('ammoarrowsmallgame', 'flecha Small Game', 100, 1, 'item_standard', 1, 14, 1, '{}', '', 0.25, 0),
	('ammobolahawk', 'Bola Ammo Hawk', 100, 1, 'item_standard', 1, 15, 1, '{}', '', 0.25, 0),
	('ammobolainterwired', 'Bola Ammo Interwired', 100, 1, 'item_standard', 1, 16, 1, '{}', '', 0.25, 0),
	('ammobolaironspiked', 'Bola Ammo Ironspiked', 100, 1, 'item_standard', 1, 17, 1, '{}', '', 0.25, 0),
	('ammobolla', 'Munição Bolla ', 100, 1, 'item_standard', 1, 18, 1, '{}', '', 0.25, 0),
	('ammodynamite', 'munição de dinamite', 100, 1, 'item_standard', 1, 19, 1, '{}', '', 0.25, 0),
	('ammoelephant', 'Elefante Rifle Munição', 100, 1, 'item_standard', 1, 20, 1, '{}', '', 0.25, 0),
	('ammoknives', 'munição de facas', 100, 1, 'item_standard', 1, 21, 1, '{}', '', 0.25, 0),
	('ammomolotov', 'munição molotov', 100, 1, 'item_standard', 1, 22, 1, '{}', '', 0.25, 0),
	('ammopistolexplosive', 'Munição de Pistola Explosiva', 100, 1, 'item_standard', 1, 23, 1, '{}', '', 0.25, 0),
	('ammopistolexpress', 'Munição de Pistola Expressa', 100, 1, 'item_standard', 1, 24, 1, '{}', '', 0.25, 0),
	('ammopistolnormal', 'Arma Munição Normal', 100, 1, 'item_standard', 1, 25, 1, '{}', '', 0.25, 0),
	('ammopistolsplitpoint', 'Ponto de divisão de munição de pistola', 100, 1, 'item_standard', 1, 26, 1, '{}', '', 0.25, 0),
	('ammopistolvelocity', 'Velocidade de Munição de Pistola', 100, 1, 'item_standard', 1, 27, 1, '{}', '', 0.25, 0),
	('ammopoisonbottle', 'Munição de garrafa de veneno', 100, 1, 'item_standard', 1, 28, 1, '{}', '', 0.25, 0),
	('ammorepeaterexplosive', 'Repetidor Munição Explosiva', 100, 1, 'item_standard', 1, 29, 1, '{}', '', 0.25, 0),
	('ammorepeaterexpress', 'Repetidor Ammo Express', 100, 1, 'item_standard', 1, 30, 1, '{}', '', 0.25, 0),
	('ammorepeaternormal', 'Repetidor Munição Normal', 100, 1, 'item_standard', 1, 31, 1, '{}', '', 0.25, 0),
	('ammorepeatersplitpoint', 'Ponto de divisão de munição do repetidor', 100, 1, 'item_standard', 1, 32, 1, '{}', '', 0.25, 0),
	('ammorepeatervelocity', 'Velocidade da munição do repetidor', 100, 1, 'item_standard', 1, 33, 1, '{}', '', 0.25, 0),
	('ammorevolverexplosive', 'Revolver Munição Explosiva', 100, 1, 'item_standard', 1, 34, 1, '{}', '', 0.25, 0),
	('ammorevolverexpress', 'Revolver Ammo Express', 100, 1, 'item_standard', 1, 35, 1, '{}', '', 0.25, 0),
	('ammorevolvernormal', 'Munição de revólver normal', 100, 1, 'item_standard', 1, 36, 1, '{}', '', 0.25, 0),
	('ammorevolversplitpoint', 'Ponto de divisão de munição de revólver', 100, 1, 'item_standard', 1, 37, 1, '{}', '', 0.25, 0),
	('ammorevolvervelocity', 'Velocidade da munição do revólver', 100, 1, 'item_standard', 1, 38, 1, '{}', '', 0.25, 0),
	('ammorifleexplosive', 'Munição de Rifle Explosiva', 100, 1, 'item_standard', 1, 39, 1, '{}', '', 0.25, 0),
	('ammorifleexpress', 'Munição de Rifle Express', 100, 1, 'item_standard', 1, 40, 1, '{}', '', 0.25, 0),
	('ammoriflenormal', 'Munição de Rifle Normal', 100, 1, 'item_standard', 1, 41, 1, '{}', '', 0.25, 0),
	('ammoriflesplitpoint', 'Ponto de divisão de munição de rifle', 100, 1, 'item_standard', 1, 42, 1, '{}', '', 0.25, 0),
	('ammoriflevelocity', 'Velocidade da munição do rifle', 100, 1, 'item_standard', 1, 43, 1, '{}', '', 0.25, 0),
	('ammoshotgunexplosive', 'Munição de Espingarda Explosiva', 100, 1, 'item_standard', 1, 44, 1, '{}', '', 0.25, 0),
	('ammoshotgunincendiary', 'Munição de Espingarda Incendiária', 100, 1, 'item_standard', 1, 45, 1, '{}', '', 0.25, 0),
	('ammoshotgunnormal', 'Munição de Espingarda Normal', 100, 1, 'item_standard', 1, 46, 1, '{}', '', 0.25, 0),
	('ammoshotgunslug', 'Bala de munição de espingarda', 100, 1, 'item_standard', 1, 47, 1, '{}', '', 0.25, 0),
	('ammothrowingknives', 'test', 100, 1, 'item_standard', 1, 17342, 1, '{}', 'nice item', 0.25, 0),
	('ammotomahawk', 'Munição Tomahawk', 100, 1, 'item_standard', 1, 48, 1, '{}', '', 0.25, 0),
	('ammovarmint', 'Munição Varmint', 100, 1, 'item_standard', 1, 49, 1, '{}', '', 0.25, 0),
	('ammovarminttranq', 'Munição Tranquilizante Varmint', 100, 1, 'item_standard', 1, 50, 1, '{}', '', 0.25, 0),
	('ammovoldynamite', 'Munição Volátil de Dinamite', 100, 1, 'item_standard', 1, 51, 1, '{}', '', 0.25, 0),
	('ammovolmolotov', 'Munição Molotov Volátil', 100, 1, 'item_standard', 1, 52, 1, '{}', '', 0.25, 0),
	('ammo_arrow', 'flecha', 100, 1, 'item_standard', 1, 16816, 1, '{}', '', 0.25, 0),
	('ammo_arrow_fire', 'flexa de fogo', 100, 1, 'item_standard', 1, 17101, 1, '{}', '', 0.25, 0),
	('AMMO_SHOTGUN', 'munição normal de espingarda', 100, 1, 'item_standard', 1, 17220, 1, '{}', '', 0.25, 0),
	('AMMO_THROWING_KNIVES', 'muni', 100, 1, 'item_standard', 1, 17341, 1, '{}', 'nice item', 0.25, 0),
	('amora', 'Amora', 100, 1, 'item_standard', 1, 216119, 1, '{}', 'nice item', 0.50, 0),
	('animal_crab', 'Caranguejo', 100, 1, 'item_standard', 1, 17195, 1, '{}', '', 2.00, 0),
	('animal_crawfish', 'Lagostin', 100, 1, 'item_standard', 1, 215812, 1, '{}', 'nice item', 0.25, 0),
	('Antilopepronta', 'Carne de antilope pronta', 100, 1, 'item_standard', 1, 216616, 1, '{}', 'nice item', 0.25, 0),
	('antipoison', 'Anti-coral', 100, 1, 'item_standard', 1, 53, 1, '{}', '', 0.25, 0),
	('antipoison2', 'Veneno anti-cobra', 100, 1, 'item_standard', 1, 617, 1, '{}', '', 0.25, 0),
	('aoemagic', 'Poção quebra ossos 2', 100, 1, 'item_standard', 1, 1202, 1, '{}', 'nice item', 0.25, 0),
	('apiary_bee_gk', 'abelhas', 10, 1, 'item_standard', 1, 17039, 1, '{}', '', 0.25, 0),
	('apiary_honeycomb_gk', 'Favo de mel', 100, 1, 'item_standard', 1, 17040, 1, '{}', '', 0.25, 0),
	('apito', 'Apito para passaros', 100, 1, 'item_standard', 1, 216653, 1, '{}', 'nice item', 0.25, 0),
	('apple', 'Maçã', 30, 1, 'item_standard', 1, 54, 1, '{}', '', 0.25, 0),
	('Apple Tree', 'arvore de maça', 100, 1, 'item_standard', 1, 16882, 1, '{}', '', 0.25, 0),
	('applebarrel', 'barril de maçã', 100, 1, 'item_standard', 1, 762, 1, '{}', '', 0.25, 0),
	('applebasket', 'Cesta de Maçã', 100, 1, 'item_standard', 1, 763, 1, '{}', '', 0.25, 0),
	('appleCrumbMash', 'Purê de Minty Berry', 100, 1, 'item_standard', 1, 55, 1, '{}', '', 0.25, 0),
	('appleCrumbMoonshine', 'Minty Berry Moonshine', 100, 1, 'item_standard', 1, 56, 1, '{}', '', 0.25, 0),
	('apple_barrel', 'barril de maçã', 100, 1, 'item_standard', 1, 634, 1, '{}', '', 0.25, 0),
	('apple_basket', 'Cesta de Maçã', 100, 1, 'item_standard', 1, 635, 1, '{}', '', 0.25, 0),
	('Apple_Seed', 'semente de maçã', 100, 1, 'item_standard', 1, 727, 1, '{}', '', 0.25, 0),
	('aprons', 'aventais', 100, 1, 'item_standard', 1, 216040, 1, '{}', 'nice item', 0.25, 0),
	('archivesbook', 'aquivo policial', 100, 1, 'item_standard', 1, 17107, 1, '{}', '', 0.25, 0),
	('ardu', 'Revolver Ação Dupla', 10, 1, 'item_standard', 1, 1016, 1, '{}', '010', 0.25, 0),
	('areaheal', 'Poção da cura ', 100, 1, 'item_standard', 1, 1203, 1, '{}', 'nice item', 0.25, 0),
	('arm1', 'Revolver Vaqueiro', 5, 1, 'item_standard', 1, 1022, 1, '{}', 'nice item', 0.25, 0),
	('arm2', 'Revolver Ação Dupla', 5, 1, 'item_standard', 1, 1023, 1, '{}', 'nice item', 0.25, 0),
	('arm3', 'Revolver Lemat', 5, 1, 'item_standard', 1, 1024, 1, '{}', 'nice item', 0.25, 0),
	('arm4', 'Repetidora Winchester', 5, 1, 'item_standard', 1, 1025, 1, '{}', 'nice item', 0.25, 0),
	('arm5', 'Rifle De Ferrolho', 5, 1, 'item_standard', 1, 1026, 1, '{}', 'nice item', 0.25, 0),
	('arm6', 'Escopeta Cano Duplo', 5, 1, 'item_standard', 1, 1027, 1, '{}', 'nice item', 0.25, 0),
	('armadilloc', 'Tatu Morto', 100, 1, 'item_standard', 1, 449, 1, '{}', '', 4.00, 0),
	('armadillos', 'Tatu', 100, 1, 'item_standard', 1, 448, 1, '{}', '', 4.00, 0),
	('armduplo', 'Escopeta Cano Duplo', 10, 1, 'item_standard', 1, 1013, 1, '{}', '007', 0.25, 0),
	('armfe', 'Rifle de Ferrolho', 10, 1, 'item_standard', 1, 1012, 1, '{}', '006', 0.25, 0),
	('armor', 'Armor', 20, 1, 'item_standard', 1, 17612, 1, '{}', 'nice item', 0.25, 0),
	('arrowhead1', 'Arrowhead 1', 100, 1, 'item_standard', 1, 17510, 1, '{}', 'nice item', 0.25, 0),
	('arrowhead10', 'Crude Arrowhead', 100, 1, 'item_standard', 1, 17519, 1, '{}', 'nice item', 0.25, 0),
	('arrowhead11', 'Chipped Arrowhead', 100, 1, 'item_standard', 1, 17520, 1, '{}', 'nice item', 0.25, 0),
	('arrowhead12', 'Bone Arrowhead', 100, 1, 'item_standard', 1, 17521, 1, '{}', 'nice item', 0.25, 0),
	('arrowhead13', 'Agate Arrowhead', 100, 1, 'item_standard', 1, 17522, 1, '{}', 'nice item', 0.25, 0),
	('arrowhead2', 'Arrowhead 2', 100, 1, 'item_standard', 1, 17511, 1, '{}', 'nice item', 0.25, 0),
	('arrowhead3', 'Arrowhead 3', 100, 1, 'item_standard', 1, 17512, 1, '{}', 'nice item', 0.25, 0),
	('arrowhead4', 'Rough Arrowhead', 100, 1, 'item_standard', 1, 17513, 1, '{}', 'nice item', 0.25, 0),
	('arrowhead5', 'Raw Arrowhead', 100, 1, 'item_standard', 1, 17514, 1, '{}', 'nice item', 0.25, 0),
	('arrowhead6', 'Quartz Arrowhead', 100, 1, 'item_standard', 1, 17515, 1, '{}', 'nice item', 0.25, 0),
	('arrowhead7', 'Obsidian Arrowhead', 100, 1, 'item_standard', 1, 17516, 1, '{}', 'nice item', 0.25, 0),
	('arrowhead8', 'Granite Arrowhead', 100, 1, 'item_standard', 1, 17517, 1, '{}', 'nice item', 0.25, 0),
	('arrowhead9', 'Feldspar Arrowhead', 100, 1, 'item_standard', 1, 17518, 1, '{}', 'nice item', 0.25, 0),
	('arroz', 'arroz', 100, 1, 'item_standard', 1, 16793, 1, '{}', '', 0.25, 0),
	('artichokeseed', 'Artichoke seed', 50, 1, 'item_standard', 1, 17688, 1, '{}', 'an item', 0.25, 0),
	('arva', 'Revolver Vaqueiro', 10, 1, 'item_standard', 1, 1008, 1, '{}', '002', 0.25, 0),
	('asclepia', 'Asclépia', 100, 1, 'item_standard', 1, 216127, 1, '{}', 'nice item', 0.50, 0),
	('asnakes', 'Copperhead pele de cobra', 100, 1, 'item_standard', 1, 487, 1, '{}', '', 0.25, 0),
	('assada', 'Casco de Tartaruga', 100, 1, 'item_standard', 1, 215983, 1, '{}', 'nice item', 2.50, 0),
	('azeite', 'azeite', 100, 1, 'item_standard', 1, 17146, 1, '{}', '', 0.25, 0),
	('azeitona', 'azeitona', 100, 1, 'item_standard', 1, 17147, 1, '{}', '', 0.25, 0),
	('a_c_fishbluegil_01_ms', 'Bluegill médio', 100, 1, 'item_standard', 1, 57, 1, '{}', '', 0.25, 0),
	('a_c_fishbluegil_01_sm', 'Bluegill pequeno', 100, 1, 'item_standard', 1, 58, 1, '{}', '', 0.25, 0),
	('a_c_fishbullheadcat_01_ms', 'Bullhead Médio', 100, 1, 'item_standard', 1, 59, 1, '{}', '', 0.25, 0),
	('a_c_fishbullheadcat_01_sm', 'Bullhead pequeno', 100, 1, 'item_standard', 1, 60, 1, '{}', '', 0.25, 0),
	('a_c_fishchainpickerel_01_ms', 'Picanha Média', 100, 1, 'item_standard', 1, 61, 1, '{}', '', 0.25, 0),
	('a_c_fishchainpickerel_01_sm', 'Pickerel pequeno', 100, 1, 'item_standard', 1, 62, 1, '{}', '', 0.25, 0),
	('a_c_fishchannelcatfish_01_lg', 'Peixe-gato do canal (grande)', 100, 1, 'item_standard', 1, 16761, 1, '{}', '', 0.25, 0),
	('a_c_fishchannelcatfish_01_xl', 'Bagre do Canal (Extra Grande)', 100, 1, 'item_standard', 1, 16762, 1, '{}', '', 0.25, 0),
	('a_c_fishlakesturgeon_01_lg', 'Lago Sturgeon (Grande)', 100, 1, 'item_standard', 1, 16763, 1, '{}', '', 0.25, 0),
	('a_c_fishlargemouthbass_01_lg', 'Baixo de boca grande (grande)', 100, 1, 'item_standard', 1, 16764, 1, '{}', '', 0.25, 0),
	('a_c_fishlargemouthbass_01_ms', 'Achigã', 100, 1, 'item_standard', 1, 63, 1, '{}', '', 0.25, 0),
	('a_c_fishlongnosegar_01_lg', 'Gar de Nariz Longo (Grande)', 100, 1, 'item_standard', 1, 16765, 1, '{}', '', 0.25, 0),
	('a_c_fishmuskie_01_lg', 'Muskie (Grande)', 100, 1, 'item_standard', 1, 16766, 1, '{}', '', 0.25, 0),
	('a_c_fishnorthernpike_01_lg', 'Pique do Norte (Grande)', 100, 1, 'item_standard', 1, 16767, 1, '{}', '', 0.25, 0),
	('a_c_fishperch_01_ms', 'poleiro médio', 100, 1, 'item_standard', 1, 64, 1, '{}', '', 0.25, 0),
	('a_c_fishperch_01_sm', 'poleiro pequeno', 100, 1, 'item_standard', 1, 65, 1, '{}', '', 0.25, 0),
	('a_c_fishrainbowtrout_01_lg', 'Truta arco-íris (grande)', 100, 1, 'item_standard', 1, 16768, 1, '{}', '', 0.25, 0),
	('a_c_fishrainbowtrout_01_ms', 'Truta arco-íris', 100, 1, 'item_standard', 1, 66, 1, '{}', '', 0.25, 0),
	('a_c_fishredfinpickerel_01_ms', 'Pickerel Redfin médio', 100, 1, 'item_standard', 1, 67, 1, '{}', '', 0.25, 0),
	('a_c_fishredfinpickerel_01_sm', 'Small Redfin Pickerel', 100, 1, 'item_standard', 1, 68, 1, '{}', '', 0.25, 0),
	('a_c_fishrockbass_01_ms', 'Rock baixo médio', 100, 1, 'item_standard', 1, 69, 1, '{}', '', 0.25, 0),
	('a_c_fishrockbass_01_sm', 'baixo baixo rock', 100, 1, 'item_standard', 1, 70, 1, '{}', '', 0.25, 0),
	('a_c_fishsalmonsockeye_01_lg', 'Sockeye Salmão (Grande)', 100, 1, 'item_standard', 1, 16769, 1, '{}', '', 0.25, 0),
	('a_c_fishsalmonsockeye_01_ml', 'Salmão sockeye (médio-grande)', 100, 1, 'item_standard', 1, 16770, 1, '{}', '', 0.25, 0),
	('a_c_fishsalmonsockeye_01_ms', 'Salmão Sockeye', 100, 1, 'item_standard', 1, 71, 1, '{}', '', 0.25, 0),
	('a_c_fishsmallmouthbass_01_lg', 'Baixo de boca pequena (grande)', 100, 1, 'item_standard', 1, 16771, 1, '{}', '', 0.25, 0),
	('a_c_fishsmallmouthbass_01_ms', 'baixo smallmouth', 100, 1, 'item_standard', 1, 72, 1, '{}', '', 0.25, 0),
	('a_c_frogbull_01', 'Sapo-Touro', 100, 1, 'item_standard', 1, 215955, 1, '{}', 'nice item', 0.25, 0),
	('backpack1', 'Mochila 100kg', 100, 1, 'item_standard', 1, 98664, 1, '{}', 'mochila 100kg', 0.25, 0),
	('backpack2', 'Mochila v2', 100, 1, 'item_standard', 1, 98665, 1, '{}', 'mochila 100kg', 0.25, 0),
	('backpack_10', 'mochila +10', 100, 1, 'item_standard', 1, 17250, 1, '{}', '', 0.25, 0),
	('backpack_100', 'Mochila +100', 100, 1, 'item_standard', 1, 216561, 1, '{}', 'nice item', 0.10, 0),
	('backpack_15', 'Backpack 15', 10, 1, 'item_standard', 1, 17345, 1, '{}', 'nice item', 0.25, 0),
	('backpack_20', 'Backpack 20', 10, 1, 'item_standard', 1, 17346, 1, '{}', 'nice item', 0.25, 0),
	('backpack_200', 'Mochila +200', 100, 1, 'item_standard', 1, 216562, 1, '{}', 'nice item', 0.10, 0),
	('backpack_25', 'Mochila +25', 100, 1, 'item_standard', 1, 216554, 1, '{}', 'nice item', 0.10, 0),
	('backpack_30', 'Mochila +30', 100, 1, 'item_standard', 1, 216555, 1, '{}', 'nice item', 0.10, 0),
	('backpack_300', 'Mochila +300', 100, 1, 'item_standard', 1, 216563, 1, '{}', 'nice item', 0.10, 0),
	('backpack_35', 'Mochila +35', 100, 1, 'item_standard', 1, 216556, 1, '{}', 'nice item', 0.10, 0),
	('backpack_40', 'Mochila +40', 100, 1, 'item_standard', 1, 216557, 1, '{}', 'nice item', 0.10, 0),
	('backpack_400', 'Mochila +400', 100, 1, 'item_standard', 1, 216564, 1, '{}', 'nice item', 0.10, 0),
	('backpack_45', 'Mochila +45', 100, 1, 'item_standard', 1, 216558, 1, '{}', 'nice item', 0.10, 0),
	('backpack_5', 'mochila +5', 100, 1, 'item_standard', 1, 17249, 1, '{}', '', 0.25, 0),
	('backpack_50', 'Mochila +50', 100, 1, 'item_standard', 1, 216610, 1, '{}', 'nice item', 0.25, 0),
	('backpack_500', 'Mochila +500', 100, 1, 'item_standard', 1, 216565, 1, '{}', 'nice item', 0.10, 0),
	('backpack_55', 'Mochila +55', 100, 1, 'item_standard', 1, 216559, 1, '{}', 'nice item', 0.10, 0),
	('backpack_60', 'Mochila +60', 100, 1, 'item_standard', 1, 216560, 1, '{}', 'nice item', 0.10, 0),
	('backpack_600', 'Mochila +600', 100, 1, 'item_standard', 1, 216566, 1, '{}', 'nice item', 0.10, 0),
	('backpack_700', 'Mochila +700', 100, 1, 'item_standard', 1, 216567, 1, '{}', 'nice item', 0.10, 0),
	('bacon', 'bacon', 100, 1, 'item_standard', 1, 1601, 1, '{}', '', 0.10, 0),
	('badge', 'distintivo', 1, 1, 'item_standard', 1, 17106, 1, '{}', '', 0.25, 0),
	('badgers', 'pele de texugo', 100, 1, 'item_standard', 1, 491, 1, '{}', '', 0.25, 0),
	('badges', 'emblemas', 100, 1, 'item_standard', 1, 216039, 1, '{}', 'nice item', 0.25, 0),
	('badge_deputy', 'badge_deputy', 100, 1, 'item_standard', 1, 216045, 1, '{}', 'nice item', 0.25, 0),
	('badge_deputyy', 'badge_deputyy', 100, 1, 'item_standard', 1, 216051, 1, '{}', 'nice item', 0.25, 0),
	('badge_marshal', 'badge_marshal', 100, 1, 'item_standard', 1, 216050, 1, '{}', 'nice item', 0.25, 0),
	('badge_officer', 'badge_officer', 100, 1, 'item_standard', 1, 216046, 1, '{}', 'nice item', 0.25, 0),
	('badge_police', 'badge_police', 100, 1, 'item_standard', 1, 216048, 1, '{}', 'nice item', 0.25, 0),
	('badge_sheriff', 'badge_sheriff', 100, 1, 'item_standard', 1, 216047, 1, '{}', 'nice item', 0.25, 0),
	('badge_texas_ranger', 'badge_texas_ranger', 100, 1, 'item_standard', 1, 216049, 1, '{}', 'nice item', 0.25, 0),
	('bagofcoal', 'Carvão', 100, 1, 'item_standard', 1, 16930, 1, '{}', '', 0.25, 0),
	('bait', 'Isca', 100, 1, 'item_standard', 1, 73, 1, '{}', '', 0.25, 0),
	('banana', 'Banana', 100, 1, 'item_standard', 1, 74, 1, '{}', '', 0.25, 0),
	('banana_seed', 'semente de banana', 100, 1, 'item_standard', 1, 16947, 1, '{}', '', 0.25, 0),
	('bandage', 'Curativo', 100, 1, 'item_standard', 1, 75, 1, '{}', '', 0.25, 0),
	('bandage_clean', 'Bandage Clean', 10, 1, 'item_standard', 1, 17278, 1, '{}', 'A clean bandage for medical use.', 0.25, 0),
	('bandage_dirty', 'Bandage Dirty', 10, 1, 'item_standard', 1, 17279, 1, '{}', 'A dirty bandage, not ideal for treatment.', 0.25, 0),
	('bandage_medic', 'Bandagem tratamento', 100, 1, 'item_standard', 1, 216038, 1, '{}', 'nice item', 0.10, 0),
	('bardana', 'Bardana', 100, 1, 'item_standard', 1, 216113, 1, '{}', 'nice item', 0.50, 0),
	('Barley', 'Cevada', 100, 1, 'item_standard', 1, 1673, 1, '{}', '', 0.25, 0),
	('Barley_Seed', 'semente de cevada', 100, 1, 'item_standard', 1, 1674, 1, '{}', '', 0.25, 0),
	('barra_de_prata', 'barra de prata', 100, 1, 'item_standard', 1, 16921, 1, '{}', '', 0.25, 0),
	('barrel', 'Barril', 100, 1, 'item_standard', 1, 800, 1, '{}', '', 0.25, 0),
	('barrier', 'barricada', 100, 1, 'item_standard', 1, 16978, 1, '{}', '', 0.25, 0),
	('barriloil', 'Barril de Oleo', 10, 1, 'item_standard', 1, 170501, 1, '{}', 'nice item', 0.25, 0),
	('bat_c', 'Morcego Morto', 100, 1, 'item_standard', 1, 420, 1, '{}', '', 0.50, 0),
	('Bay_Bolete', 'Bay Bolete', 100, 1, 'item_standard', 1, 76, 1, '{}', '', 0.25, 0),
	('Bay_Bolete_Seed', 'Bay Bolete Seed', 100, 1, 'item_standard', 1, 77, 1, '{}', '', 0.25, 0),
	('bbears', 'pele de urso preto', 100, 1, 'item_standard', 1, 452, 1, '{}', '', 0.25, 0),
	('bbirdb', 'bico de cormorão', 100, 1, 'item_standard', 1, 528, 1, '{}', '', 0.25, 0),
	('bbirdf', 'pena de cormorão', 100, 1, 'item_standard', 1, 527, 1, '{}', '', 0.25, 0),
	('bcandle', 'garrafa de vela', 100, 1, 'item_standard', 1, 663, 1, '{}', '', 0.25, 0),
	('bearbench', 'banco de urso', 100, 1, 'item_standard', 1, 773, 1, '{}', '', 0.25, 0),
	('bearc', 'Urso Morto', 100, 1, 'item_standard', 1, 450, 1, '{}', '', 6.00, 0),
	('beart', 'dente de urso', 100, 1, 'item_standard', 1, 451, 1, '{}', '', 0.25, 0),
	('beartrap', 'Armadilha para urso', 1, 1, 'item_standard', 1, 1602, 1, '{}', '', 0.25, 0),
	('bear_bench', 'banco de urso', 100, 1, 'item_standard', 1, 645, 1, '{}', '', 0.25, 0),
	('beavertail', 'cauda de castor', 100, 1, 'item_standard', 1, 542, 1, '{}', '', 0.25, 0),
	('beawers', 'pele de castor', 100, 1, 'item_standard', 1, 541, 1, '{}', '', 0.25, 0),
	('bedroll', 'Saco de Dormir', 100, 1, 'item_standard', 1, 215664, 1, '{}', 'nice item', 0.25, 0),
	('beef', 'Carne bovina', 100, 1, 'item_standard', 1, 567, 1, '{}', '', 0.25, 0),
	('beefjerky', 'Carne seca', 100, 1, 'item_standard', 1, 78, 1, '{}', '', 0.25, 0),
	('beer', 'Cerveja', 20, 1, 'item_standard', 1, 79, 1, '{}', '', 0.25, 0),
	('beerbarrel', 'barril ', 20, 1, 'item_standard', 1, 17260, 1, '{}', 'nice item', 0.25, 0),
	('beerbox', 'caixa de cerveja', 100, 1, 'item_standard', 1, 586, 1, '{}', '', 0.25, 0),
	('bee_house_gk_1', 'Caixa de Abelha 1', 100, 1, 'item_standard', 1, 17042, 1, '{}', '', 0.25, 0),
	('bee_house_gk_2', 'Caixa de Abelha 2', 100, 1, 'item_standard', 1, 17043, 1, '{}', '', 0.25, 0),
	('bee_house_gk_3', 'Caixa de Abelha 3', 100, 1, 'item_standard', 1, 17044, 1, '{}', '', 0.25, 0),
	('bee_house_gk_4', 'Caixa de Abelha 4', 100, 1, 'item_standard', 1, 17045, 1, '{}', '', 0.25, 0),
	('bee_house_gk_5', 'Caixa de Abelha 5', 100, 1, 'item_standard', 1, 170464, 1, '{}', '', 0.25, 0),
	('bee_house_gk_6', 'Caixa de Abelha 6', 100, 1, 'item_standard', 1, 17046, 1, '{}', '', 0.25, 0),
	('beggarhat', 'Mendigo', 100, 1, 'item_standard', 1, 215810, 1, '{}', 'nice item', 0.25, 0),
	('bell_pepper_assorted', 'Pimentão Misto', 100, 1, 'item_standard', 1, 216342, 1, '{}', 'nice item', 0.30, 0),
	('bell_pepper_green', 'Pimentão Verde', 100, 1, 'item_standard', 1, 216353, 1, '{}', 'nice item', 0.30, 0),
	('belts', 'Belt', 20, 1, 'item_standard', 1, 17608, 1, '{}', 'nice item', 0.25, 0),
	('belt_buckles', 'Buckle', 20, 1, 'item_standard', 1, 17606, 1, '{}', 'nice item', 0.25, 0),
	('Bicabornato', 'Bicabornato de Sodio', 100, 1, 'item_standard', 1, 215625, 1, '{}', 'nice item', 0.25, 0),
	('bifedeveado', 'Bife de Veado', 100, 1, 'item_standard', 1, 170473, 1, '{}', 'nice item', 0.25, 0),
	('bigchest', 'baú grande', 100, 1, 'item_standard', 1, 658, 1, '{}', '', 0.25, 0),
	('biggame', 'carne de caça grossa', 100, 1, 'item_standard', 1, 565, 1, '{}', '', 0.25, 0),
	('biggamemeat', 'Big Game Meat', 30, 1, 'item_standard', 1, 17566, 1, '{}', 'nice item', 0.25, 0),
	('biggamesteak', 'prato de carne de caça grande', 100, 1, 'item_standard', 1, 17172, 1, '{}', '', 0.25, 0),
	('big_firecracker', 'foguete', 100, 1, 'item_standard', 1, 16897, 1, '{}', '', 0.25, 0),
	('big_fireworks', 'fogos', 100, 1, 'item_standard', 1, 16989, 1, '{}', '', 0.25, 0),
	('Big_Leather', 'Couro grande ', 100, 1, 'item_standard', 1, 80, 1, '{}', '', 0.25, 0),
	('bird', 'Carne ave', 100, 1, 'item_standard', 1, 569, 1, '{}', '', 0.80, 0),
	('birdalert', 'pombo alerta ', 20, 1, 'item_standard', 1, 17127, 1, '{}', '', 0.25, 0),
	('birdmeat', 'Bird meat', 30, 1, 'item_standard', 1, 17559, 1, '{}', 'nice item', 0.25, 0),
	('birdmeatcook', 'carne de ave assada ', 100, 1, 'item_standard', 1, 17173, 1, '{}', '', 0.25, 0),
	('biscuitbox', 'caixa de biscoitos', 100, 1, 'item_standard', 1, 1603, 1, '{}', '', 0.25, 0),
	('bisonhorn', 'bisonhorn', 100, 1, 'item_standard', 1, 461, 1, '{}', '', 0.25, 0),
	('bisons', 'pele de bisão', 100, 1, 'item_standard', 1, 462, 1, '{}', '', 0.25, 0),
	('bisturi_mato', 'Bisturi-do-Mato', 100, 1, 'item_standard', 1, 216137, 1, '{}', 'nice item', 0.50, 0),
	('Bitter_Weed', 'Erva Amarga', 100, 1, 'item_standard', 1, 81, 1, '{}', '', 0.25, 0),
	('Bitter_Weed_Seed', 'Semente de Erva Amarga', 100, 1, 'item_standard', 1, 82, 1, '{}', '', 0.25, 0),
	('bituca', 'Bituca de Cigarro', 100, 1, 'item_standard', 1, 215647, 1, '{}', 'nice item', 0.25, 0),
	('blackberry', 'amora', 100, 1, 'item_standard', 1, 16885, 1, '{}', '', 0.25, 0),
	('blackberryale', 'cerveja', 100, 1, 'item_standard', 1, 83, 1, '{}', '', 0.25, 0),
	('blacktelegram', 'telegrama anonimo', 5, 1, 'item_standard', 1, 17155, 1, '{}', '', 0.25, 0),
	('Black_Berry', 'Amora', 100, 1, 'item_standard', 1, 84, 1, '{}', '', 0.25, 0),
	('Black_Berry_Seed', 'Semente de amora', 100, 1, 'item_standard', 1, 85, 1, '{}', '', 0.25, 0),
	('Black_Currant', 'Groselha Preta', 100, 1, 'item_standard', 1, 86, 1, '{}', '', 0.20, 0),
	('Black_Currant_Seed', 'Semente de Groselha Preta', 100, 1, 'item_standard', 1, 87, 1, '{}', '', 0.25, 0),
	('blanketbox', 'Caixa de cobertor', 100, 1, 'item_standard', 1, 760, 1, '{}', '', 0.25, 0),
	('blanket_box', 'Caixa de cobertor', 100, 1, 'item_standard', 1, 632, 1, '{}', '', 0.25, 0),
	('blindfold', 'De olhos vendados', 100, 1, 'item_standard', 1, 16977, 1, '{}', '', 0.25, 0),
	('bloodflower', 'Bloodflower', 50, 1, 'item_standard', 1, 17684, 1, '{}', 'an item', 0.25, 0),
	('blooditem', 'sangue', 100, 1, 'item_standard', 1, 215991, 1, '{}', 'nice item', 0.25, 0),
	('Blood_Flower', 'flor de sangue', 100, 1, 'item_standard', 1, 88, 1, '{}', '', 0.25, 0),
	('Blood_Flower_Seed', 'flor de sangue Seed', 100, 1, 'item_standard', 1, 89, 1, '{}', '', 0.25, 0),
	('Blueberries Shrub', 'Arbusto de Mirtilos', 100, 1, 'item_standard', 1, 16883, 1, '{}', '', 0.25, 0),
	('blueberry', 'Mirtilo', 100, 1, 'item_standard', 1, 90, 1, '{}', '', 0.25, 0),
	('bluejay_c', 'gaio azul', 100, 1, 'item_standard', 1, 421, 1, '{}', '', 0.25, 0),
	('bmdresser', 'cômoda com espelho marrom', 100, 1, 'item_standard', 1, 652, 1, '{}', '', 0.25, 0),
	('boarmusk', 'Musk de Javali', 100, 1, 'item_standard', 1, 456, 1, '{}', '', 1.00, 0),
	('boars', 'pele de javali', 100, 1, 'item_standard', 1, 457, 1, '{}', '', 0.25, 0),
	('boaskin', 'Pele de Boa Cobra', 100, 1, 'item_standard', 1, 486, 1, '{}', '', 0.25, 0),
	('boat_ticket', 'Bilhete de Barco', 100, 1, 'item_standard', 1, 16926, 1, '{}', '', 0.25, 0),
	('boifood', 'Ração de Vacas', 100, 1, 'item_standard', 1, 6342, 1, '{}', 'nice item', 0.25, 0),
	('boiledegg', 'Ovo Cozido', 100, 1, 'item_standard', 1, 91, 1, '{}', '', 0.25, 0),
	('bolado', 'Charuto  de Weed', 100, 1, 'item_standard', 1, 17164, 1, '{}', '', 0.25, 0),
	('boleto_baio', 'Boleto Baio', 100, 1, 'item_standard', 1, 216115, 1, '{}', 'nice item', 0.50, 0),
	('bolts', 'Parafusos', 100, 1, 'item_standard', 1, 1604, 1, '{}', '', 0.25, 0),
	('bomb', 'bomba pegajosa', 100, 1, 'item_standard', 1, 16894, 1, '{}', '', 0.25, 0),
	('bonesmagic', 'Poção quebra ossos', 100, 1, 'item_standard', 1, 215704, 1, '{}', 'nice item', 0.25, 0),
	('bone_deer', 'Deer Bone', 50, 1, 'item_standard', 1, 17570, 1, '{}', 'nice item', 0.25, 0),
	('bone_mice', 'Mice Bone', 50, 1, 'item_standard', 1, 17574, 1, '{}', 'nice item', 0.25, 0),
	('bone_owl', 'Owl Bone', 50, 1, 'item_standard', 1, 17575, 1, '{}', 'nice item', 0.25, 0),
	('bone_rabbit', 'Rabbit Bone', 50, 1, 'item_standard', 1, 17573, 1, '{}', 'nice item', 0.25, 0),
	('bone_raccoon', 'Raccoon Bone', 50, 1, 'item_standard', 1, 17572, 1, '{}', 'nice item', 0.25, 0),
	('bone_skunk', 'Skunk Bone', 50, 1, 'item_standard', 1, 17571, 1, '{}', 'nice item', 0.25, 0),
	('boobyb', 'Bico de patas vermelhas', 100, 1, 'item_standard', 1, 501, 1, '{}', '', 0.25, 0),
	('boobyf', 'Pena de atobá-de-pés-vermelhos', 100, 1, 'item_standard', 1, 500, 1, '{}', '', 0.25, 0),
	('book', 'Livro', 100, 1, 'item_standard', 1, 92, 1, '{}', '', 0.25, 0),
	('bookarm', 'Livro do Armeiro', 100, 1, 'item_standard', 1, 98680, 1, '{}', 'nice item', 0.25, 0),
	('bookart', 'Livro do Artesanato', 100, 1, 'item_standard', 1, 98678, 1, '{}', 'nice item', 0.25, 0),
	('bookcase', 'Bookcase', 100, 1, 'item_standard', 1, 216009, 1, '{}', 'nice item', 1.00, 0),
	('bookestab', 'Livro do Estabulo', 100, 1, 'item_standard', 1, 98679, 1, '{}', 'nice item', 0.25, 0),
	('bookferr', 'Livro da Ferraria', 100, 1, 'item_standard', 1, 98681, 1, '{}', 'nice item', 0.25, 0),
	('bookileg', 'Livro Ilegal', 100, 1, 'item_standard', 1, 98721, 1, '{}', 'nice item', 0.25, 0),
	('bookmedic', 'Livro Medico', 100, 1, 'item_standard', 1, 98716, 1, '{}', 'nice item', 0.25, 0),
	('booksbw', 'Livro Saloon BW', 100, 1, 'item_standard', 1, 98713, 1, '{}', 'nice item', 0.25, 0),
	('booksrh', 'Livro Saloon RH', 100, 1, 'item_standard', 1, 98676, 1, '{}', 'nice item', 0.25, 0),
	('bookssd', 'Livro Saloon SD', 100, 1, 'item_standard', 1, 98714, 1, '{}', 'nice item', 0.25, 0),
	('booksvh', 'Livro Saloon VH', 100, 1, 'item_standard', 1, 98715, 1, '{}', 'nice item', 0.25, 0),
	('booksvl', 'Livro Saloon VL', 100, 1, 'item_standard', 1, 98712, 1, '{}', 'nice item', 0.25, 0),
	('boots', 'Boots', 20, 1, 'item_standard', 1, 17609, 1, '{}', 'nice item', 0.25, 0),
	('boot_accessories', 'Spurs', 20, 1, 'item_standard', 1, 17607, 1, '{}', 'nice item', 0.25, 0),
	('bountylicns', 'Licença de Caçador de Recompensas', 100, 1, 'item_standard', 1, 93, 1, '{}', '', 0.25, 0),
	('bouquet', 'Ramalhete', 100, 1, 'item_standard', 1, 342, 1, '{}', '', 0.25, 0),
	('boxempty', 'caixa de munição vazia', 100, 1, 'item_standard', 1, 17202, 1, '{}', '', 0.25, 0),
	('boxmister', 'Caixa Misteriosa', 100, 1, 'item_standard', 1, 98663, 1, '{}', 'nice item', 0.25, 0),
	('bparrotb', 'bico de papagaio', 100, 1, 'item_standard', 1, 522, 1, '{}', '', 0.25, 0),
	('bparrotf', 'pena de papagaio', 100, 1, 'item_standard', 1, 521, 1, '{}', '', 0.25, 0),
	('bread', 'Pão', 100, 1, 'item_standard', 1, 170512, 1, '{}', 'nice item', 0.25, 0),
	('breedpills', 'pilula da criação', 100, 1, 'item_standard', 1, 16903, 1, '{}', '', 0.25, 0),
	('brokenpearlnecklace', 'colar de pérolas quebradas', 100, 1, 'item_standard', 1, 1605, 1, '{}', '', 0.25, 0),
	('bronzeticket', 'bilhete', 100, 1, 'item_standard', 1, 16911, 1, '{}', '', 0.25, 0),
	('btobaccoseed', 'Burnley Tobacco', 50, 1, 'item_standard', 1, 17696, 1, '{}', 'an item', 0.25, 0),
	('buckantler', 'Galhada de Veado', 100, 1, 'item_standard', 1, 459, 1, '{}', '', 2.50, 0),
	('bucket', 'Bucket', 3, 1, 'item_standard', 1, 17322, 1, '{}', 'nice item', 0.25, 0),
	('bucks', 'Pele de Buck', 100, 1, 'item_standard', 1, 460, 1, '{}', '', 0.25, 0),
	('bullhorn', 'chifre de touro', 100, 1, 'item_standard', 1, 463, 1, '{}', '', 0.25, 0),
	('bulls', 'pele de touro', 100, 1, 'item_standard', 1, 464, 1, '{}', '', 0.25, 0),
	('Bulrush', 'Junco', 100, 1, 'item_standard', 1, 94, 1, '{}', '', 0.25, 0),
	('bulrushseed', 'Bulrush seed', 50, 1, 'item_standard', 1, 17695, 1, '{}', 'an item', 0.25, 0),
	('Bulrush_Seed', 'semente de junco', 100, 1, 'item_standard', 1, 95, 1, '{}', '', 0.25, 0),
	('bunkbed', 'beliche', 100, 1, 'item_standard', 1, 665, 1, '{}', '', 0.25, 0),
	('Burdock_Root', 'raiz de bardana', 100, 1, 'item_standard', 1, 96, 1, '{}', '', 0.25, 0),
	('Burdock_Root_Seed', 'Semente de Raiz de Bardana', 100, 1, 'item_standard', 1, 97, 1, '{}', '', 0.25, 0),
	('burialoil', 'Burial Perfume Oil', 20, 1, 'item_standard', 1, 17455, 1, '{}', 'nice item', 0.25, 0),
	('burialwraps', 'Burial Wraps', 20, 1, 'item_standard', 1, 17456, 1, '{}', 'nice item', 0.25, 0),
	('butchertable1', 'Mesa de açougueiro pequena', 100, 1, 'item_standard', 1, 583, 1, '{}', '', 0.25, 0),
	('butchertable2', 'Mesa de Açougueiro Média', 100, 1, 'item_standard', 1, 582, 1, '{}', '', 0.25, 0),
	('butchertable3', 'Mesa de açougueiro grande', 100, 1, 'item_standard', 1, 581, 1, '{}', '', 0.25, 0),
	('bwdresser', 'cômoda de madeira marrom', 100, 1, 'item_standard', 1, 651, 1, '{}', '', 0.25, 0),
	('C1', 'C1', 100, 1, 'item_standard', 1, 215715, 1, '{}', 'nice item', 0.25, 0),
	('C2', 'C2', 100, 1, 'item_standard', 1, 215716, 1, '{}', 'nice item', 0.25, 0),
	('Cabbage', 'Repolho', 100, 1, 'item_standard', 1, 215820, 1, '{}', 'nice item', 0.25, 0),
	('Cabbage_Seed', 'Semente de Repolho', 100, 1, 'item_standard', 1, 215795, 1, '{}', 'nice item', 0.25, 0),
	('cabelo', 'cabelo', 100, 1, 'item_standard', 1, 215975, 1, '{}', 'nice item', 0.25, 0),
	('cabomadeira', 'Cabo de madeira', 100, 1, 'item_standard', 1, 170470, 1, '{}', 'nice item', 0.10, 0),
	('cabrafood', 'Ração para Cabras', 100, 1, 'item_standard', 1, 98353, 1, '{}', 'nice item', 0.25, 0),
	('cacau', 'cacau ', 100, 1, 'item_standard', 1, 17148, 1, '{}', '', 0.25, 0),
	('cacau_Seed', 'semente de cacau', 100, 1, 'item_standard', 1, 17149, 1, '{}', '', 0.25, 0),
	('cage', 'Cage', 100, 1, 'item_standard', 1, 216029, 1, '{}', 'nice item', 1.00, 0),
	('caixaarma', 'Caixa de Arma', 50, 1, 'item_standard', 1, 20583, 1, '{}', 'Beschreibung', 0.25, 0),
	('caixacavalo', 'Caixa de Cavalo', 50, 1, 'item_standard', 1, 7461, 1, '{}', 'Beschreibung', 0.25, 0),
	('caixadollar', 'Caixa de Dollar', 50, 1, 'item_standard', 1, 74531, 1, '{}', 'Beschreibung', 0.25, 0),
	('caixagold', 'Caixa Gold', 50, 1, 'item_standard', 1, 18521, 1, '{}', 'Beschreibung', 0.25, 0),
	('caixavip', 'Caixa Vip', 50, 1, 'item_standard', 1, 1006, 1, '{}', '019', 0.25, 0),
	('caladenia', 'Caladenia', 100, 1, 'item_standard', 1, 216132, 1, '{}', 'nice item', 0.50, 0),
	('callbird', 'chamar passaro', 1, 1, 'item_standard', 1, 17677, 1, '{}', 'nice item', 0.25, 0),
	('CalledBird', 'CHAMAR PASSARO 1 ', 1, 1, 'item_standard', 1, 17676, 1, '{}', 'nice item', 0.25, 0),
	('calmante', 'tira stress', 20, 1, 'item_standard', 1, 17037, 1, '{}', '', 0.25, 0),
	('camera', 'Camera', 100, 1, 'item_standard', 1, 346, 1, '{}', '', 0.25, 0),
	('camomila', 'Camomila', 100, 1, 'item_standard', 1, 98682, 1, '{}', 'nice item', 0.25, 0),
	('campfire', 'fogueira', 100, 1, 'item_standard', 1, 98, 1, '{}', '', 0.25, 0),
	('Camp_Book', 'Livro de acampamento', 100, 1, 'item_standard', 1, 17471, 1, '{}', 'nice item', 0.25, 0),
	('candlea', 'Vela', 100, 1, 'item_standard', 1, 661, 1, '{}', '', 0.25, 0),
	('cane', 'Bengala', 100, 1, 'item_standard', 1, 344, 1, '{}', '', 0.25, 0),
	('cannedevieux', 'Bengala Esquerda', 100, 1, 'item_standard', 1, 215828, 1, '{}', 'nice item', 0.25, 0),
	('cantarelo', 'Cantarelo', 100, 1, 'item_standard', 1, 216139, 1, '{}', 'nice item', 0.50, 0),
	('canteen', 'Canteen', 1, 1, 'item_standard', 1, 16723, 1, '{}', '', 0.25, 0),
	('canteenempty', 'cantil vazio', 1, 1, 'item_standard', 1, 17222, 1, '{}', '', 0.25, 0),
	('canteen_100', 'Canteen', 3, 1, 'item_standard', 1, 17317, 1, '{}', 'nice item', 0.25, 0),
	('canteen_25', 'Canteen', 3, 1, 'item_standard', 1, 17320, 1, '{}', 'nice item', 0.25, 0),
	('canteen_50', 'Canteen', 3, 1, 'item_standard', 1, 17319, 1, '{}', 'nice item', 0.25, 0),
	('canteen_75', 'Canteen', 3, 1, 'item_standard', 1, 17318, 1, '{}', 'nice item', 0.25, 0),
	('can_100', 'cantil 100%', 100, 1, 'item_standard', 1, 16914, 1, '{}', '', 0.25, 0),
	('can_25', 'cantil 25%', 100, 1, 'item_standard', 1, 16917, 1, '{}', '', 0.25, 0),
	('can_50', 'cantil 50%', 100, 1, 'item_standard', 1, 16916, 1, '{}', '', 0.25, 0),
	('can_75', 'cantil 75%', 100, 1, 'item_standard', 1, 16915, 1, '{}', '', 0.25, 0),
	('cardinal_c', 'pássaro cardeal', 100, 1, 'item_standard', 1, 422, 1, '{}', '', 0.25, 0),
	('Cardinal_Flower', 'flor cardeal', 100, 1, 'item_standard', 1, 99, 1, '{}', '', 0.25, 0),
	('Cardinal_Flower_Seed', 'semente de flor cardinal', 100, 1, 'item_standard', 1, 100, 1, '{}', '', 0.25, 0),
	('carne', 'Carne', 100, 1, 'item_standard', 1, 215933, 1, '{}', 'nice item', 1.00, 0),
	('carnebatata', 'Carne com Batatas', 100, 1, 'item_standard', 1, 170481, 1, '{}', 'nice item', 0.25, 0),
	('carnegrelha', 'Carne Grelhada', 100, 1, 'item_standard', 1, 170482, 1, '{}', 'nice item', 0.25, 0),
	('carnepronta', 'Carne Pronta', 100, 1, 'item_standard', 1, 216615, 1, '{}', 'nice item', 0.25, 0),
	('carne_carneiro', 'Carne de Carneiro', 100, 1, 'item_standard', 1, 216366, 1, '{}', 'nice item', 1.50, 0),
	('carriage_parts', 'kit reparo carroça', 100, 1, 'item_standard', 1, 16902, 1, '{}', '', 0.25, 0),
	('carrots', 'Cenoura', 100, 1, 'item_standard', 1, 101, 1, '{}', '', 0.25, 0),
	('Carrot_Seed', 'semente de cenoura ', 100, 1, 'item_standard', 1, 17139, 1, '{}', '', 0.25, 0),
	('cassis', 'Cassis', 100, 1, 'item_standard', 1, 216140, 1, '{}', 'nice item', 0.50, 0),
	('cassis_dourado', 'Cassis Dourado', 100, 1, 'item_standard', 1, 216154, 1, '{}', 'nice item', 0.50, 0),
	('cavalofood', 'Ração de Cavalos', 100, 1, 'item_standard', 1, 2463, 1, '{}', 'nice item', 0.25, 0),
	('cebola', 'Cebola', 100, 1, 'item_standard', 1, 17259, 1, '{}', 'nice item', 0.30, 0),
	('cebola_Seed', 'Semente de Cebola', 100, 1, 'item_standard', 1, 215808, 1, '{}', 'nice item', 0.25, 0),
	('cedarwaxwing_c', 'cera de cedro', 100, 1, 'item_standard', 1, 423, 1, '{}', '', 0.25, 0),
	('cenoura_selvagem', 'Cenoura Selvagem', 100, 1, 'item_standard', 1, 216120, 1, '{}', 'nice item', 0.50, 0),
	('Chamomile', 'camomila', 100, 1, 'item_standard', 1, 215824, 1, '{}', 'nice item', 0.25, 0),
	('Chamomile_Seed', 'Semente de Camomila', 100, 1, 'item_standard', 1, 215792, 1, '{}', 'nice item', 0.25, 0),
	('changer', 'Changer', 100, 1, 'item_standard', 1, 216032, 1, '{}', 'nice item', 1.00, 0),
	('Chanterelles', 'chanterelles', 100, 1, 'item_standard', 1, 102, 1, '{}', '', 0.25, 0),
	('Chanterelles_Seed', 'semente de chanterelle', 100, 1, 'item_standard', 1, 103, 1, '{}', '', 0.25, 0),
	('chaps', 'Chaps', 20, 1, 'item_standard', 1, 17610, 1, '{}', 'nice item', 0.25, 0),
	('char', 'Caracteres', 100, 1, 'item_standard', 1, 104, 1, '{}', '', 0.25, 0),
	('cheesecake', 'bolo de queijo', 100, 1, 'item_standard', 1, 1606, 1, '{}', '', 0.25, 0),
	('chesta', 'chest 1', 20, 1, 'item_standard', 1, 17430, 1, '{}', 'nice item', 0.25, 0),
	('chestb', 'chest 2', 20, 1, 'item_standard', 1, 17431, 1, '{}', 'nice item', 0.25, 0),
	('chestc', 'Peito C', 100, 1, 'item_standard', 1, 578, 1, '{}', '', 0.25, 0),
	('chest_shovel', 'Chest Shovel', 10, 1, 'item_standard', 1, 98711, 1, '{}', 'nice item', 0.25, 0),
	('chewingtobacco', 'Mastigar tabaco', 100, 1, 'item_standard', 1, 105, 1, '{}', '', 0.25, 0),
	('chewingtobacco2', 'Tobacco de Mascar', 100, 1, 'item_standard', 1, 215639, 1, '{}', 'You have 4 doses left', 0.25, 0),
	('chewingtobacco3', 'Tobacco de Mascar', 100, 1, 'item_standard', 1, 215640, 1, '{}', 'You have 3 doses left', 0.25, 0),
	('chewingtobacco4', 'Tobacco de Mascar', 100, 1, 'item_standard', 1, 215641, 1, '{}', 'You have 2 doses left', 0.25, 0),
	('chewingtobacco5', 'Tobacco de Mascar', 100, 1, 'item_standard', 1, 215642, 1, '{}', 'You have 1 dose left', 0.25, 0),
	('chickenf', 'pena de galinha', 100, 1, 'item_standard', 1, 525, 1, '{}', '', 0.25, 0),
	('chickenheart', 'Coração de galinha', 100, 1, 'item_standard', 1, 526, 1, '{}', '', 0.25, 0),
	('chipmunk_c', 'Esquilo', 100, 1, 'item_standard', 1, 419, 1, '{}', '', 0.25, 0),
	('chococake', 'fatia de chocolate', 20, 1, 'item_standard', 1, 1607, 1, '{}', '', 0.25, 0),
	('Choc_Daisy', 'Shock Daisy', 100, 1, 'item_standard', 1, 106, 1, '{}', '', 0.25, 0),
	('Choc_Daisy_Seed', 'Choc Daisy Seed', 100, 1, 'item_standard', 1, 107, 1, '{}', '', 0.25, 0),
	('cigar', 'Charuto', 20, 1, 'item_standard', 1, 108, 1, '{}', '', 0.25, 0),
	('cigarcard1', 'Carteira de Cigarro 10uni', 100, 1, 'item_standard', 1, 215644, 1, '{}', 'nice item', 0.25, 0),
	('cigarcard2', 'Carteira de Cigarro 5uni', 100, 1, 'item_standard', 1, 215645, 1, '{}', 'nice item', 0.25, 0),
	('cigarcard3', 'Carteira de Cigarro Vazia', 100, 1, 'item_standard', 1, 215646, 1, '{}', 'nice item', 0.25, 0),
	('cigaret', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215628, 1, '{}', 'New package', 0.25, 0),
	('cigaret10', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215637, 1, '{}', 'You have 1 cigarette left', 0.25, 0),
	('cigaret2', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215629, 1, '{}', 'You have 9 cigarettes left', 0.25, 0),
	('cigaret3', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215630, 1, '{}', 'You have 8 cigarettes left', 0.25, 0),
	('cigaret4', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215631, 1, '{}', 'You have 7 cigarettes left', 0.25, 0),
	('cigaret5', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215632, 1, '{}', 'You have 6 cigarettes left', 0.25, 0),
	('cigaret6', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215633, 1, '{}', 'You have 5 cigarettes left', 0.25, 0),
	('cigaret7', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215634, 1, '{}', 'You have 4 cigarettes left', 0.25, 0),
	('cigaret8', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215635, 1, '{}', 'You have 3 cigarettes left', 0.25, 0),
	('cigaret9', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215636, 1, '{}', 'You have 2 cigarettes left', 0.25, 0),
	('cigarette', 'Cigarro', 20, 1, 'item_standard', 1, 109, 1, '{}', '', 0.25, 0),
	('cigarettefilter', 'Filtro Cig', 100, 1, 'item_standard', 1, 110, 1, '{}', '', 0.25, 0),
	('cigarety', 'carteira de cigarro vazia', 100, 1, 'item_standard', 1, 17197, 1, '{}', '', 0.25, 0),
	('cigcard01', 'cigcard01', 1, 1, 'item_standard', 1, 17206, 1, '{}', '', 0.25, 0),
	('cigcard02', 'cigcard02', 1, 1, 'item_standard', 1, 17207, 1, '{}', '', 0.25, 0),
	('cigcard03', 'cigcard03', 1, 1, 'item_standard', 1, 17208, 1, '{}', '', 0.25, 0),
	('cigcard04', 'cigcard04', 1, 1, 'item_standard', 1, 17209, 1, '{}', '', 0.25, 0),
	('cigcard05', 'cigcard05', 1, 1, 'item_standard', 1, 17210, 1, '{}', '', 0.25, 0),
	('cigcard06', 'cigcard06', 1, 1, 'item_standard', 1, 17211, 1, '{}', '', 0.25, 0),
	('cigcard07', 'cigcard07', 1, 1, 'item_standard', 1, 17212, 1, '{}', '', 0.25, 0),
	('cigcard08', 'cigcard08', 1, 1, 'item_standard', 1, 17213, 1, '{}', '', 0.25, 0),
	('cigcard09', 'cigcard09', 1, 1, 'item_standard', 1, 17214, 1, '{}', '', 0.25, 0),
	('cigcard10', 'cigcard10', 1, 1, 'item_standard', 1, 17215, 1, '{}', '', 0.25, 0),
	('cigcard11', 'cigcard11', 1, 1, 'item_standard', 1, 17216, 1, '{}', '', 0.25, 0),
	('cigcard12', 'cigcard12', 1, 1, 'item_standard', 1, 17217, 1, '{}', '', 0.25, 0),
	('cinematicket', 'Ticket', 100, 1, 'item_standard', 1, 351, 1, '{}', '', 0.25, 0),
	('clay', 'Argila', 100, 1, 'item_standard', 1, 111, 1, '{}', '', 0.25, 0),
	('cleanser', 'Limpador', 100, 1, 'item_standard', 1, 340, 1, '{}', '', 0.25, 0),
	('cleanshort', 'Pano', 100, 1, 'item_standard', 1, 1608, 1, '{}', '', 0.25, 0),
	('cloaks', 'Cloak', 20, 1, 'item_standard', 1, 17625, 1, '{}', 'nice item', 0.25, 0),
	('cloth', 'paninho', 100, 1, 'item_standard', 1, 215694, 1, '{}', 'nice item', 0.25, 0),
	('clothbench', 'banco de pano', 100, 1, 'item_standard', 1, 776, 1, '{}', '', 0.25, 0),
	('clothe1', 'Roupas 1', 100, 1, 'item_standard', 1, 216625, 1, '{}', 'nice item', 0.50, 0),
	('clothe10', 'Roupas 10', 100, 1, 'item_standard', 1, 216634, 1, '{}', 'nice item', 0.50, 0),
	('clothe11', 'Roupas 11', 100, 1, 'item_standard', 1, 216635, 1, '{}', 'nice item', 0.50, 0),
	('clothe12', 'Roupas 12', 100, 1, 'item_standard', 1, 216636, 1, '{}', 'nice item', 0.50, 0),
	('clothe13', 'Roupas 13', 100, 1, 'item_standard', 1, 216637, 1, '{}', 'nice item', 0.50, 0),
	('clothe14', 'Roupas 14', 100, 1, 'item_standard', 1, 216638, 1, '{}', 'nice item', 0.50, 0),
	('clothe15', 'Roupas 15', 100, 1, 'item_standard', 1, 216639, 1, '{}', 'nice item', 0.50, 0),
	('clothe16', 'Roupas 16', 100, 1, 'item_standard', 1, 216640, 1, '{}', 'nice item', 0.50, 0),
	('clothe17', 'Roupas 17', 100, 1, 'item_standard', 1, 216641, 1, '{}', 'nice item', 0.50, 0),
	('clothe18', 'Roupas 18', 100, 1, 'item_standard', 1, 216642, 1, '{}', 'nice item', 0.50, 0),
	('clothe19', 'Roupas 19', 100, 1, 'item_standard', 1, 216643, 1, '{}', 'nice item', 0.50, 0),
	('clothe2', 'Roupas 2', 100, 1, 'item_standard', 1, 216626, 1, '{}', 'nice item', 0.50, 0),
	('clothe20', 'Roupas 20', 100, 1, 'item_standard', 1, 216644, 1, '{}', 'nice item', 0.50, 0),
	('clothe3', 'Roupas 3', 100, 1, 'item_standard', 1, 216627, 1, '{}', 'nice item', 0.50, 0),
	('clothe4', 'Roupas 4', 100, 1, 'item_standard', 1, 216628, 1, '{}', 'nice item', 0.50, 0),
	('clothe5', 'Roupas 5', 100, 1, 'item_standard', 1, 216629, 1, '{}', 'nice item', 0.50, 0),
	('clothe6', 'Roupas 6', 100, 1, 'item_standard', 1, 216630, 1, '{}', 'nice item', 0.50, 0),
	('clothe7', 'Roupas 7', 100, 1, 'item_standard', 1, 216631, 1, '{}', 'nice item', 0.50, 0),
	('clothe8', 'Roupas 8', 100, 1, 'item_standard', 1, 216632, 1, '{}', 'nice item', 0.50, 0),
	('clothe9', 'Roupas 9', 100, 1, 'item_standard', 1, 216633, 1, '{}', 'nice item', 0.50, 0),
	('clothepolice1', 'Uniforme 1', 100, 1, 'item_standard', 1, 215976, 1, '{}', 'nice item', 0.25, 0),
	('clothepolice2', 'Uniforme 2', 100, 1, 'item_standard', 1, 215977, 1, '{}', 'nice item', 0.25, 0),
	('clothepolice3', 'Uniforme 3', 100, 1, 'item_standard', 1, 215978, 1, '{}', 'nice item', 0.25, 0),
	('clothepolice4', 'Uniforme 4', 100, 1, 'item_standard', 1, 215979, 1, '{}', 'nice item', 0.25, 0),
	('clothepolice5', 'Uniforme 5', 100, 1, 'item_standard', 1, 215980, 1, '{}', 'nice item', 0.25, 0),
	('clothepolice6', 'Uniforme 6', 100, 1, 'item_standard', 1, 215981, 1, '{}', 'nice item', 0.25, 0),
	('clothepolice7', 'Uniforme 7', 100, 1, 'item_standard', 1, 215982, 1, '{}', 'nice item', 0.25, 0),
	('clothesline', 'Varal de roupas', 100, 1, 'item_standard', 1, 766, 1, '{}', '', 0.25, 0),
	('clothes_line', 'Varal de roupas', 100, 1, 'item_standard', 1, 638, 1, '{}', '', 0.25, 0),
	('clothingset', 'Kit Roupa 1', 20, 1, 'item_standard', 1, 17602, 1, '{}', 'nice item', 0.25, 0),
	('clothingset2', 'Kit Roupa 2', 20, 1, 'item_standard', 1, 17603, 1, '{}', 'nice item', 0.25, 0),
	('cloth_bench', 'banco de pano', 100, 1, 'item_standard', 1, 648, 1, '{}', '', 0.25, 0),
	('coal', 'carvão', 100, 1, 'item_standard', 1, 112, 1, '{}', '', 0.25, 0),
	('coats', 'Coat', 20, 1, 'item_standard', 1, 17627, 1, '{}', 'nice item', 0.25, 0),
	('coats_closed', 'Closed Coat', 20, 1, 'item_standard', 1, 17615, 1, '{}', 'nice item', 0.25, 0),
	('Coca', 'Coca', 100, 1, 'item_standard', 1, 215815, 1, '{}', 'nice item', 0.25, 0),
	('cocaina', 'Cocaina', 100, 1, 'item_standard', 1, 16936, 1, '{}', '', 0.25, 0),
	('cocaine', 'tonic de cocaina', 100, 1, 'item_standard', 1, 16923, 1, '{}', '', 0.25, 0),
	('cocain_seed', 'semente de cocaina', 100, 1, 'item_standard', 1, 1677, 1, '{}', '', 0.25, 0),
	('Coca_Seed', 'Semente de coca', 100, 1, 'item_standard', 1, 215791, 1, '{}', 'nice item', 0.25, 0),
	('cockc', 'garras de galo', 100, 1, 'item_standard', 1, 499, 1, '{}', '', 0.25, 0),
	('cockf', 'pena de galo', 100, 1, 'item_standard', 1, 498, 1, '{}', '', 0.25, 0),
	('cocoa', 'Cocoa', 100, 1, 'item_standard', 1, 113, 1, '{}', '', 0.25, 0),
	('cocoaseeds', 'Cocoa Seeds', 100, 1, 'item_standard', 1, 733, 1, '{}', '', 0.25, 0),
	('coffe', 'cafe', 100, 1, 'item_standard', 1, 17177, 1, '{}', '', 0.25, 0),
	('coffeebeans', 'grãos de café', 100, 1, 'item_standard', 1, 1678, 1, '{}', '', 0.25, 0),
	('coffeefilter', 'Coffee Filter', 100, 1, 'item_standard', 1, 1610, 1, '{}', '', 0.25, 0),
	('coffee_beans', 'Grãos de Café', 100, 1, 'item_standard', 1, 216347, 1, '{}', 'nice item', 0.30, 0),
	('Coffee_Seed', 'semente de caffe', 100, 1, 'item_standard', 1, 1679, 1, '{}', '', 0.25, 0),
	('coffindecor', 'decoração de caixão', 100, 1, 'item_standard', 1, 629, 1, '{}', '', 0.25, 0),
	('cogomelo', 'Cogomelo Selvagem', 100, 1, 'item_standard', 1, 215850, 1, '{}', 'nice item', 0.25, 0),
	('cogumelo_guarda_sol', 'Cogumelo Guarda-Sol', 100, 1, 'item_standard', 1, 216124, 1, '{}', 'nice item', 0.50, 0),
	('coin1', 'Coin 1800 Half Dime', 100, 1, 'item_standard', 1, 17493, 1, '{}', 'nice item', 0.25, 0),
	('coin10', 'Coin 1792 Quarter', 100, 1, 'item_standard', 1, 17502, 1, '{}', 'nice item', 0.25, 0),
	('coin11', 'Coin 1792 Nickel', 100, 1, 'item_standard', 1, 17503, 1, '{}', 'nice item', 0.25, 0),
	('coin12', 'Coin 1792 Liberty', 100, 1, 'item_standard', 1, 17504, 1, '{}', 'nice item', 0.25, 0),
	('coin13', 'Coin 1789 Penny', 100, 1, 'item_standard', 1, 17505, 1, '{}', 'nice item', 0.25, 0),
	('coin14', 'Coin 1787 Cent', 100, 1, 'item_standard', 1, 17506, 1, '{}', 'nice item', 0.25, 0),
	('coin15', 'Coin 1700', 100, 1, 'item_standard', 1, 17507, 1, '{}', 'nice item', 0.25, 0),
	('coin16', 'Coin Loanshark', 100, 1, 'item_standard', 1, 17508, 1, '{}', 'nice item', 0.25, 0),
	('coin17', 'Money Coin', 100, 1, 'item_standard', 1, 17509, 1, '{}', 'nice item', 0.25, 0),
	('coin2', 'Coin 1800 Gold Quarter', 100, 1, 'item_standard', 1, 17494, 1, '{}', 'nice item', 0.25, 0),
	('coin3', 'Coin 1800 Gold Dollar', 100, 1, 'item_standard', 1, 17495, 1, '{}', 'nice item', 0.25, 0),
	('coin4', 'Coin 1800 Five Dollar', 100, 1, 'item_standard', 1, 17496, 1, '{}', 'nice item', 0.25, 0),
	('coin5', 'Coin 1798 Silver Dollar', 100, 1, 'item_standard', 1, 17497, 1, '{}', 'nice item', 0.25, 0),
	('coin6', 'Coin 1797 Gold Eagle', 100, 1, 'item_standard', 1, 17498, 1, '{}', 'nice item', 0.25, 0),
	('coin7', 'Coin 1796 Half Penny', 100, 1, 'item_standard', 1, 17499, 1, '{}', 'nice item', 0.25, 0),
	('coin8', 'Coin 1795 Half Eagle', 100, 1, 'item_standard', 1, 17500, 1, '{}', 'nice item', 0.25, 0),
	('coin9', 'Coin 1794 Silver Dollar', 100, 1, 'item_standard', 1, 17501, 1, '{}', 'nice item', 0.25, 0),
	('collector_fossil_bivalve', 'fóssil bivalve', 100, 1, 'item_standard', 1, 1611, 1, '{}', '', 0.25, 0),
	('collector_fossil_brachiopod', 'Fóssil de Braquiópode', 100, 1, 'item_standard', 1, 1612, 1, '{}', '', 0.25, 0),
	('collector_fossil_brow_horn', 'Fóssil de Chifre Frontal', 100, 1, 'item_standard', 1, 1613, 1, '{}', '', 0.25, 0),
	('collector_fossil_cephalopod', 'Fóssil de cefalópode', 100, 1, 'item_standard', 1, 1614, 1, '{}', '', 0.25, 0),
	('collector_fossil_coral', 'Fóssil de Coral Agatizado', 100, 1, 'item_standard', 1, 1615, 1, '{}', '', 0.25, 0),
	('collector_fossil_neo', 'Fóssil Neospirífero', 100, 1, 'item_standard', 1, 1616, 1, '{}', '', 0.25, 0),
	('collector_fossil_pet_wood', 'Fóssil Comum de Madeira Petrificada', 100, 1, 'item_standard', 1, 1617, 1, '{}', '', 0.25, 0),
	('collector_fossil_pet_wood_rainbow', 'Fóssil de madeira petrificada arco-íris', 100, 1, 'item_standard', 1, 1618, 1, '{}', '', 0.25, 0),
	('collector_fossil_pet_wood_yellow_cat', 'Fóssil de madeira petrificada de gato amarelo', 100, 1, 'item_standard', 1, 1619, 1, '{}', '', 0.25, 0),
	('collector_fossil_sea_lily', 'Fóssil de Lírio do Mar', 100, 1, 'item_standard', 1, 1620, 1, '{}', '', 0.25, 0),
	('collector_fossil_sea_scorpion', 'Fóssil de Escorpião Marinho', 100, 1, 'item_standard', 1, 1621, 1, '{}', '', 0.25, 0),
	('collector_fossil_stone', 'Fóssil de Pedra Petoskey', 100, 1, 'item_standard', 1, 1622, 1, '{}', '', 0.25, 0),
	('collector_fossil_tail_spike', 'Fóssil de Espiga de Cauda', 100, 1, 'item_standard', 1, 1623, 1, '{}', '', 0.25, 0),
	('collector_fossil_toe_claw', 'Fóssil de garra de foice', 100, 1, 'item_standard', 1, 1624, 1, '{}', '', 0.25, 0),
	('collector_fossil_tooth_mega', 'Fóssil de dente superior', 100, 1, 'item_standard', 1, 1625, 1, '{}', '', 0.25, 0),
	('collector_fossil_tooth_serrated', 'Fóssil de Dente Serrado', 100, 1, 'item_standard', 1, 1626, 1, '{}', '', 0.25, 0),
	('collector_fossil_tooth_trex', 'Fóssil de dente da frente', 100, 1, 'item_standard', 1, 1627, 1, '{}', '', 0.25, 0),
	('collector_fossil_trilobite_crypto', 'Fóssil de Cryptolithus Trilobite', 100, 1, 'item_standard', 1, 1628, 1, '{}', '', 0.25, 0),
	('collector_fossil_trilobite_iso', 'Fóssil de Isotelus Trilobite', 100, 1, 'item_standard', 1, 1629, 1, '{}', '', 0.25, 0),
	('collector_fossil_tully_monster', 'Fóssil do Monstro Tully', 100, 1, 'item_standard', 1, 1630, 1, '{}', '', 0.25, 0),
	('comidahorse', 'ração de cavalo', 100, 1, 'item_standard', 1, 17062, 1, '{}', '', 0.25, 0),
	('commomclothes', 'Roupas Comuns', 100, 1, 'item_standard', 1, 215987, 1, '{}', 'nice item', 0.25, 0),
	('compas', 'Compas', 100, 1, 'item_standard', 1, 16975, 1, '{}', '', 0.25, 0),
	('condenser', 'Condensador', 100, 1, 'item_standard', 1, 816, 1, '{}', '', 0.25, 0),
	('condorb', 'bico de condor', 100, 1, 'item_standard', 1, 480, 1, '{}', '', 0.25, 0),
	('condorf', 'pena de condor', 100, 1, 'item_standard', 1, 479, 1, '{}', '', 0.25, 0),
	('consumable_alcohol', 'alcohol', 100, 1, 'item_standard', 1, 216428, 1, '{}', 'nice item', 0.10, 0),
	('consumable_apple_candy', 'maça caramelizada com morango', 100, 1, 'item_standard', 1, 216419, 1, '{}', 'nice item', 0.10, 0),
	('consumable_asian_soda_grape', 'suvo de uva', 100, 1, 'item_standard', 1, 216427, 1, '{}', 'nice item', 0.10, 0),
	('consumable_asian_soda_lime', 'Suco Limão', 100, 1, 'item_standard', 1, 216044, 1, '{}', 'nice item', 0.10, 0),
	('consumable_asian_soda_strawberry', 'suco de morango', 100, 1, 'item_standard', 1, 216416, 1, '{}', 'nice item', 0.10, 0),
	('consumable_bagel_egg_bacon', 'hamburguer ovo e bacon', 100, 1, 'item_standard', 1, 216417, 1, '{}', 'nice item', 0.10, 0),
	('consumable_blueberrypie', 'torta de amora', 20, 1, 'item_standard', 1, 1631, 1, '{}', '', 0.25, 0),
	('consumable_bluegil', 'Bluegil Seco', 100, 1, 'item_standard', 1, 114, 1, '{}', '', 0.25, 0),
	('consumable_boiled_egg', 'ovo frito', 100, 1, 'item_standard', 1, 216424, 1, '{}', 'nice item', 0.10, 0),
	('consumable_breakfast', 'Café da manhã', 20, 1, 'item_standard', 1, 115, 1, '{}', '', 0.25, 0),
	('consumable_canned_corn', 'milho em conserva', 100, 1, 'item_standard', 1, 216420, 1, '{}', 'nice item', 0.10, 0),
	('consumable_caramel', 'Caramelo', 100, 1, 'item_standard', 1, 116, 1, '{}', '', 0.25, 0),
	('consumable_chickenpie', 'cozido de frango', 20, 1, 'item_standard', 1, 1632, 1, '{}', '', 0.25, 0),
	('consumable_chocolate', 'Barra de Chocolate', 100, 1, 'item_standard', 1, 117, 1, '{}', '', 0.25, 0),
	('consumable_chocolatecake', 'torta de chocolate', 20, 1, 'item_standard', 1, 1633, 1, '{}', '', 0.25, 0),
	('consumable_chocolatecoffee', 'café achocolatado', 20, 1, 'item_standard', 1, 1634, 1, '{}', '', 0.25, 0),
	('consumable_coffee', 'Cafe', 100, 1, 'item_standard', 1, 118, 1, '{}', '', 0.10, 0),
	('consumable_coffeecake', 'bolo de cafe', 20, 1, 'item_standard', 1, 1635, 1, '{}', '', 0.25, 0),
	('consumable_coffee_filter', 'Filtro de cafe', 100, 1, 'item_standard', 1, 216423, 1, '{}', 'nice item', 0.10, 0),
	('consumable_corn', 'milho cozido', 100, 1, 'item_standard', 1, 16721, 1, '{}', '', 0.25, 0),
	('consumable_corncob', 'milho cozido', 20, 1, 'item_standard', 1, 17254, 1, '{}', 'nice item', 0.25, 0),
	('consumable_cowboychilli', 'cozinhada', 20, 1, 'item_standard', 1, 17253, 1, '{}', 'nice item', 0.25, 0),
	('consumable_crumbcake', 'bolo de migalhas', 20, 1, 'item_standard', 1, 1636, 1, '{}', '', 0.25, 0),
	('consumable_cupcake', 'Cupcake', 100, 1, 'item_standard', 1, 1637, 1, '{}', '', 0.25, 0),
	('consumable_donut', 'rosquinha', 20, 1, 'item_standard', 1, 1638, 1, '{}', '', 0.25, 0),
	('consumable_fishstew', 'mix peixe', 20, 1, 'item_standard', 1, 17255, 1, '{}', 'nice item', 0.25, 0),
	('consumable_fruitsalad', 'Salada de frutas', 100, 1, 'item_standard', 1, 119, 1, '{}', '', 0.25, 0),
	('consumable_game', 'carne de caça seca', 100, 1, 'item_standard', 1, 120, 1, '{}', '', 0.25, 0),
	('consumable_grapejelly', 'Geleia de uva', 100, 1, 'item_standard', 1, 1639, 1, '{}', '', 0.25, 0),
	('consumable_grilled_fish', 'prato de peixe', 100, 1, 'item_standard', 1, 17171, 1, '{}', '', 0.25, 0),
	('consumable_haycube', 'cubo de feno', 100, 1, 'item_standard', 1, 121, 1, '{}', '', 0.25, 0),
	('consumable_herb_chanterelles', 'chanterelles', 100, 1, 'item_standard', 1, 122, 1, '{}', '', 0.25, 0),
	('consumable_herb_evergreen_huckleberry', 'Evergreen Huckleberry', 100, 1, 'item_standard', 1, 123, 1, '{}', '', 0.25, 0),
	('consumable_herb_ginseng', 'erva ginseng', 100, 1, 'item_standard', 1, 17099, 1, '{}', '', 0.25, 0),
	('consumable_herb_oregano', 'Oregano', 100, 1, 'item_standard', 1, 124, 1, '{}', '', 0.25, 0),
	('consumable_herb_vanilla_flower', 'flor de baunilha', 100, 1, 'item_standard', 1, 125, 1, '{}', '', 0.25, 0),
	('consumable_herb_wintergreen_berry', 'Wintergreen Berry', 100, 1, 'item_standard', 1, 126, 1, '{}', '', 0.25, 0),
	('consumable_horsepeppermints', 'bastão de hortelã-pimenta', 100, 1, 'item_standard', 1, 1640, 1, '{}', '', 0.25, 0),
	('consumable_horse_meal', 'Comida cavalo', 100, 1, 'item_standard', 1, 216433, 1, '{}', 'nice item', 0.10, 0),
	('consumable_horse_medicine', 'remedio pra cavalo', 100, 1, 'item_standard', 1, 16811, 1, '{}', '', 0.25, 0),
	('consumable_horse_reviver', 'adrenalina cavalo', 100, 1, 'item_standard', 1, 16810, 1, '{}', '', 0.25, 0),
	('consumable_horse_stimulant', 'estimulante de cavalo', 100, 1, 'item_standard', 1, 16808, 1, '{}', '', 0.25, 0),
	('consumable_kidneybeans_can', 'Feijão em lata', 100, 1, 'item_standard', 1, 127, 1, '{}', '', 0.25, 0),
	('consumable_lemoncake', 'Bolo de limão', 100, 1, 'item_standard', 1, 1641, 1, '{}', '', 0.25, 0),
	('consumable_lemondrops', 'Gotas de Limão', 100, 1, 'item_standard', 1, 1642, 1, '{}', '', 0.25, 0),
	('consumable_lock_breaker', 'Disjuntor', 100, 1, 'item_standard', 1, 128, 1, '{}', '', 0.25, 0),
	('consumable_meat_alligator', 'Carne de Jacaré', 100, 1, 'item_standard', 1, 215939, 1, '{}', 'nice item', 1.50, 0),
	('consumable_meat_fish_flakey', 'Carne de Peixe Flocada', 100, 1, 'item_standard', 1, 216371, 1, '{}', 'nice item', 1.00, 0),
	('consumable_meat_greavy', 'Ensopado de carne', 100, 1, 'item_standard', 1, 129, 1, '{}', '', 0.25, 0),
	('consumable_meat_mutton_cooked', 'carne assada', 100, 1, 'item_standard', 1, 216429, 1, '{}', 'nice item', 0.10, 0),
	('consumable_meat_plump_bird_cooked', 'ave ', 100, 1, 'item_standard', 1, 17141, 1, '{}', '', 0.25, 0),
	('consumable_meat_rabbit', 'Carne de Coelho', 100, 1, 'item_standard', 1, 216362, 1, '{}', 'nice item', 1.00, 0),
	('consumable_meat_snake', 'Carne de Cobra', 100, 1, 'item_standard', 1, 216367, 1, '{}', 'nice item', 1.00, 0),
	('consumable_medicine', 'Medicamento', 100, 1, 'item_standard', 1, 130, 1, '{}', '', 0.25, 0),
	('consumable_milk_bucket', 'Barril de leite', 100, 1, 'item_standard', 1, 216439, 1, '{}', 'nice item', 0.10, 0),
	('consumable_orange_chicken', 'Prato frango com laranja', 100, 1, 'item_standard', 1, 216425, 1, '{}', 'nice item', 0.10, 0),
	('consumable_peach', 'Pêssego', 100, 1, 'item_standard', 1, 131, 1, '{}', '', 0.25, 0),
	('consumable_peachcobbler', 'torta de pêssego', 100, 1, 'item_standard', 1, 1643, 1, '{}', '', 0.25, 0),
	('consumable_peachjelly', 'geleia de pêssego', 100, 1, 'item_standard', 1, 1644, 1, '{}', '', 0.25, 0),
	('consumable_peanuts_roasted', 'saco de amendoin', 100, 1, 'item_standard', 1, 216430, 1, '{}', 'nice item', 0.10, 0),
	('consumable_pear', 'Pera', 100, 1, 'item_standard', 1, 132, 1, '{}', '', 0.25, 0),
	('consumable_peppermint', 'hortelã-pimenta', 100, 1, 'item_standard', 1, 1645, 1, '{}', '', 0.25, 0),
	('consumable_poundcake', 'Bolo de Libra', 100, 1, 'item_standard', 1, 1646, 1, '{}', '', 0.25, 0),
	('consumable_pretzel', 'cebolitas', 100, 1, 'item_standard', 1, 1647, 1, '{}', '', 0.25, 0),
	('consumable_raspberryjelly', 'geleia de framboesa', 100, 1, 'item_standard', 1, 1648, 1, '{}', '', 0.25, 0),
	('consumable_raspberrywater', 'água de baga', 100, 1, 'item_standard', 1, 133, 1, '{}', '', 0.25, 0),
	('consumable_salmon', 'Salmão Seco', 100, 1, 'item_standard', 1, 134, 1, '{}', '', 0.25, 0),
	('consumable_salmon_can', 'lata de salmão', 100, 1, 'item_standard', 1, 135, 1, '{}', '', 0.25, 0),
	('consumable_spongecake', 'Pão de ló', 100, 1, 'item_standard', 1, 1649, 1, '{}', '', 0.25, 0),
	('consumable_steakpie', 'cozido de boi', 20, 1, 'item_standard', 1, 1650, 1, '{}', '', 0.25, 0),
	('consumable_stew_reptile', 'guizado de reptil', 100, 1, 'item_standard', 1, 216426, 1, '{}', 'nice item', 0.10, 0),
	('consumable_sugarcube', 'cubo de feno', 100, 1, 'item_standard', 1, 16728, 1, '{}', '', 0.25, 0),
	('consumable_tea_chamomile', 'cha de camomila', 100, 1, 'item_standard', 1, 216451, 1, '{}', 'nice item', 0.25, 0),
	('consumable_trout', 'Truta Cozida', 100, 1, 'item_standard', 1, 136, 1, '{}', '', 0.25, 0),
	('consumable_veggies', 'Vegetais comestíveis', 100, 1, 'item_standard', 1, 137, 1, '{}', '', 0.25, 0),
	('cookedbluegil', 'cozido com legumes', 100, 1, 'item_standard', 1, 138, 1, '{}', '', 0.25, 0),
	('copper', 'Barra de Cobre', 100, 1, 'item_standard', 1, 139, 1, '{}', '', 0.25, 0),
	('cordbow', 'corda de arco', 100, 1, 'item_standard', 1, 1651, 1, '{}', '', 0.25, 0),
	('corn', 'Milho', 100, 1, 'item_standard', 1, 140, 1, '{}', '', 0.30, 0),
	('cornseed', 'semente de milho', 100, 1, 'item_standard', 1, 141, 1, '{}', '', 0.25, 0),
	('Corn_Seed', 'Semente de Milho', 100, 1, 'item_standard', 1, 215805, 1, '{}', 'nice item', 0.25, 0),
	('cougarf', 'dente de puma', 100, 1, 'item_standard', 1, 558, 1, '{}', '', 0.25, 0),
	('cougars', 'Puma', 100, 1, 'item_standard', 1, 557, 1, '{}', '', 8.00, 0),
	('cougartaxi', 'Taxidermia do puma', 100, 1, 'item_standard', 1, 771, 1, '{}', '', 0.25, 0),
	('cougar_taxidermy', 'Taxidermia do puma', 100, 1, 'item_standard', 1, 643, 1, '{}', '', 0.25, 0),
	('coverbook', 'coverbook', 100, 1, 'item_standard', 1, 17237, 1, '{}', '', 0.25, 0),
	('cowh', 'Chifre de vaca', 100, 1, 'item_standard', 1, 562, 1, '{}', '', 0.25, 0),
	('cows', 'pele de vaca', 100, 1, 'item_standard', 1, 561, 1, '{}', '', 0.25, 0),
	('coyotef', 'Pele de Coiote', 100, 1, 'item_standard', 1, 560, 1, '{}', '', 2.20, 0),
	('coyotepelt', 'pele de coiote', 100, 1, 'item_standard', 1, 759, 1, '{}', '', 0.25, 0),
	('coyotes', 'pele de coiote', 100, 1, 'item_standard', 1, 559, 1, '{}', '', 0.25, 0),
	('coyotetaxi', 'Taxidermia do coiote', 100, 1, 'item_standard', 1, 768, 1, '{}', '', 0.25, 0),
	('coyote_pelt', 'pele de coiote', 100, 1, 'item_standard', 1, 631, 1, '{}', '', 0.25, 0),
	('coyote_taxidermy', 'Taxidermia do coiote', 100, 1, 'item_standard', 1, 640, 1, '{}', '', 0.25, 0),
	('crabbutter', 'Manteiga de Caranguejo', 100, 1, 'item_standard', 1, 1652, 1, '{}', '', 0.25, 0),
	('crablegs', 'Pernas de Caranguejo', 100, 1, 'item_standard', 1, 1653, 1, '{}', '', 1.20, 0),
	('crab_c', 'Caranguejo', 100, 1, 'item_standard', 1, 425, 1, '{}', '', 0.25, 0),
	('craftingfire', 'Criando Fogo', 100, 1, 'item_standard', 1, 753, 1, '{}', '', 0.25, 0),
	('crafting_fire', 'Criando Fogo', 100, 1, 'item_standard', 1, 625, 1, '{}', '', 0.25, 0),
	('cranio_humano', 'cranio humano', 100, 1, 'item_standard', 1, 17289, 1, '{}', 'nice item', 0.25, 0),
	('crawfish_c', 'lagosta', 100, 1, 'item_standard', 1, 424, 1, '{}', '', 0.25, 0),
	('Creeking_Thyme', 'Tomilho Rastejante', 100, 1, 'item_standard', 1, 142, 1, '{}', '', 0.25, 0),
	('Creeking_Thyme_Seed', 'Semente de Tomilho Rastejante', 100, 1, 'item_standard', 1, 143, 1, '{}', '', 0.25, 0),
	('Creekplum', 'Creekplum', 100, 1, 'item_standard', 1, 144, 1, '{}', '', 0.25, 0),
	('Creekplum_Seed', 'Creekplum', 100, 1, 'item_standard', 1, 145, 1, '{}', '', 0.25, 0),
	('Crows_Garlic', 'Corvo Alho', 100, 1, 'item_standard', 1, 146, 1, '{}', '', 0.25, 0),
	('Crows_Garlic_Seed', 'alho Seed', 100, 1, 'item_standard', 1, 147, 1, '{}', '', 0.25, 0),
	('crow_c', 'Corvo', 100, 1, 'item_standard', 1, 426, 1, '{}', '', 0.25, 0),
	('cure', 'cure', 100, 1, 'item_standard', 1, 216005, 1, '{}', 'nice item', 0.20, 0),
	('Currant Bush', 'grosselha', 100, 1, 'item_standard', 1, 16880, 1, '{}', '', 0.25, 0),
	('darub', 'bico de guindaste', 100, 1, 'item_standard', 1, 530, 1, '{}', '', 0.25, 0),
	('daruf', 'pena de guindaste', 100, 1, 'item_standard', 1, 529, 1, '{}', '', 0.25, 0),
	('dbcandle', 'vela dbl', 100, 1, 'item_standard', 1, 660, 1, '{}', '', 0.25, 0),
	('decortent1', 'Tenda Decorativa 1 Conjunto', 100, 1, 'item_standard', 1, 600, 1, '{}', '', 0.25, 0),
	('decortent2', 'Conjunto de 2 tendas decorativas', 100, 1, 'item_standard', 1, 601, 1, '{}', '', 0.25, 0),
	('decortent3', 'Conjunto de 3 tendas decorativas', 100, 1, 'item_standard', 1, 602, 1, '{}', '', 0.25, 0),
	('deerheart', 'Coração de Cervo', 100, 1, 'item_standard', 1, 466, 1, '{}', '', 1.20, 0),
	('deernativetent', 'Deer Native Tent', 100, 1, 'item_standard', 1, 216030, 1, '{}', 'nice item', 1.00, 0),
	('deerpelt', 'pele de veado', 100, 1, 'item_standard', 1, 758, 1, '{}', '', 0.25, 0),
	('deerskin', 'pele de veado', 100, 1, 'item_standard', 1, 465, 1, '{}', '', 0.25, 0),
	('deertaxi', 'Taxidermia de Cervos', 100, 1, 'item_standard', 1, 770, 1, '{}', '', 0.25, 0),
	('deertrophy', 'Cabeça de Veado', 100, 1, 'item_standard', 1, 17219, 1, '{}', '', 0.25, 0),
	('deer_pelt', 'Pele de Cervo', 100, 1, 'item_standard', 1, 630, 1, '{}', '', 2.50, 0),
	('deer_taxidermy', 'Taxidermia de Cervos', 100, 1, 'item_standard', 1, 642, 1, '{}', '', 0.25, 0),
	('desativado', 'Item Desativado', 100, 1, 'item_standard', 1, 216652, 1, '{}', 'nice item', 0.25, 0),
	('desertsage', 'Desert Sage', 50, 1, 'item_standard', 1, 17690, 1, '{}', 'an item', 0.25, 0),
	('desertsageseed', 'Desert Sage seed', 50, 1, 'item_standard', 1, 17694, 1, '{}', 'an item', 0.25, 0),
	('Desert_Sage', 'Sálvia do Deserto', 100, 1, 'item_standard', 1, 148, 1, '{}', '', 0.25, 0),
	('Desert_Sage_Seed', 'Semente de Sálvia do Deserto', 100, 1, 'item_standard', 1, 149, 1, '{}', '', 0.25, 0),
	('detectiveverify', 'Verifique o kit de morte', 2, 1, 'item_standard', 1, 17105, 1, '{}', '', 0.25, 0),
	('detector', 'detector de metal', 2, 1, 'item_standard', 1, 17248, 1, '{}', 'nice item', 0.25, 0),
	('diamond', 'Diamante', 100, 1, 'item_standard', 1, 150, 1, '{}', '', 0.25, 0),
	('diamondore', 'diamante falso', 100, 1, 'item_standard', 1, 17203, 1, '{}', '', 0.25, 0),
	('diario', 'diario', 100, 1, 'item_standard', 1, 216613, 1, '{}', 'nice item', 0.25, 0),
	('dino_bone', 'Dinosaur Bone', 5, 1, 'item_standard', 1, 17286, 1, '{}', 'A dinosaur bone.', 0.25, 0),
	('dleguans', 'pele de iguana do deserto', 100, 1, 'item_standard', 1, 551, 1, '{}', '', 0.25, 0),
	('docanimalkit', 'kit morte de animal', 100, 1, 'item_standard', 1, 16901, 1, '{}', '', 0.25, 0),
	('docbandage', 'Curar Bandagem', 20, 1, 'item_standard', 1, 17137, 1, '{}', '', 0.25, 0),
	('docburnedkit', 'kit queimadura', 20, 1, 'item_standard', 1, 17133, 1, '{}', '', 0.25, 0),
	('docfirstaidkit', 'kit medico', 20, 1, 'item_standard', 1, 17128, 1, '{}', '', 0.25, 0),
	('dochitkit', 'kit medico basico', 20, 1, 'item_standard', 1, 17132, 1, '{}', '', 0.25, 0),
	('docmeleekit', 'kit medico facada', 20, 1, 'item_standard', 1, 17130, 1, '{}', '', 0.25, 0),
	('docsnakekit', 'remedio de cobra', 2, 1, 'item_standard', 1, 17129, 1, '{}', '', 0.25, 0),
	('doctorbag', 'Sac du docteur', 10, 1, 'item_standard', 1, 912, 1, '{}', '', 0.25, 0),
	('docunarmedkit', 'Kit Médico Desarmado', 20, 1, 'item_standard', 1, 17134, 1, '{}', '', 0.25, 0),
	('docverify', 'Verifique o kit de lesões', 20, 1, 'item_standard', 1, 17138, 1, '{}', '', 0.25, 0),
	('docweaponskit', 'kit medico tiro', 100, 1, 'item_standard', 1, 17131, 1, '{}', '', 0.25, 0),
	('dog_syringe', 'Dog Syringe', 10, 1, 'item_standard', 1, 17569, 1, '{}', 'nice item', 0.25, 0),
	('dog_whistle', 'Dog Whistle', 1, 1, 'item_standard', 1, 17568, 1, '{}', 'nice item', 0.25, 0),
	('domination', 'Item de Dominação', 100, 1, 'item_standard', 1, 216614, 1, '{}', 'nice item', 0.25, 0),
	('dreamcatcher', 'Apanhador de Sonhos', 100, 1, 'item_standard', 1, 591, 1, '{}', '', 0.25, 0),
	('dresses', 'vestidos', 100, 1, 'item_standard', 1, 216043, 1, '{}', 'nice item', 0.25, 0),
	('dring', 'anel de noivado', 100, 1, 'item_standard', 1, 17205, 1, '{}', '', 0.25, 0),
	('Drink_For_Dog', 'água para animais de estimação', 100, 1, 'item_standard', 1, 151, 1, '{}', '', 0.25, 0),
	('duckfat', 'gordura de pato', 100, 1, 'item_standard', 1, 467, 1, '{}', '', 0.25, 0),
	('Duck_Egg', 'Ovo de pato', 100, 1, 'item_standard', 1, 152, 1, '{}', '', 0.25, 0),
	('dynamite', 'dinamite de carga de tubo', 100, 1, 'item_standard', 1, 153, 1, '{}', '', 0.25, 0),
	('dynamitebundle', 'pacote de dinamite', 100, 1, 'item_standard', 1, 16932, 1, '{}', '', 0.25, 0),
	('eaglef', 'Pena de águia', 100, 1, 'item_standard', 1, 468, 1, '{}', '', 0.25, 0),
	('eaglet', 'garras de águia', 100, 1, 'item_standard', 1, 469, 1, '{}', '', 0.25, 0),
	('egg', 'ovo', 100, 1, 'item_standard', 1, 796, 1, '{}', '', 0.25, 0),
	('eggs', 'ovos', 100, 1, 'item_standard', 1, 154, 1, '{}', '', 0.10, 0),
	('egg_condor', 'Condor Egg', 50, 1, 'item_standard', 1, 17340, 1, '{}', 'nice item', 0.25, 0),
	('egg_duck', 'Duck Egg', 50, 1, 'item_standard', 1, 17336, 1, '{}', 'nice item', 0.25, 0),
	('egg_gator', 'Gator Egg', 50, 1, 'item_standard', 1, 17338, 1, '{}', 'nice item', 0.25, 0),
	('egg_loon', 'Loon Egg', 50, 1, 'item_standard', 1, 17337, 1, '{}', 'nice item', 0.25, 0),
	('egg_vulture', 'Vulture Egg', 50, 1, 'item_standard', 1, 17339, 1, '{}', 'nice item', 0.25, 0),
	('egretb', 'bico de garça nevada', 100, 1, 'item_standard', 1, 473, 1, '{}', '', 0.25, 0),
	('egretf', 'Pena de garça-das-neves', 100, 1, 'item_standard', 1, 472, 1, '{}', '', 0.25, 0),
	('electricitypaper', 'Papel de Instruções de Eletricidade', 100, 1, 'item_standard', 1, 16789, 1, '{}', '', 0.25, 0),
	('elkantler', 'chifre de alce', 100, 1, 'item_standard', 1, 474, 1, '{}', '', 0.25, 0),
	('elks', 'pele de alce', 100, 1, 'item_standard', 1, 475, 1, '{}', '', 0.25, 0),
	('elktrophy', 'Troféu de Alce', 100, 1, 'item_standard', 1, 215951, 1, '{}', 'nice item', 6.50, 0),
	('embalagem', 'Embalagem plastica', 100, 1, 'item_standard', 1, 170502, 1, '{}', 'nice item', 0.10, 0),
	('emerald', 'Esmeralda', 100, 1, 'item_standard', 1, 155, 1, '{}', '', 0.25, 0),
	('emptybottle', 'Garrafa Vazia ', 100, 1, 'item_standard', 1, 215674, 1, '{}', 'nice item', 0.25, 0),
	('emptypills', 'recipiente vazio', 100, 1, 'item_standard', 1, 17196, 1, '{}', '', 0.25, 0),
	('empty_bucket', 'Empty Bucket', 3, 1, 'item_standard', 1, 17323, 1, '{}', 'nice item', 0.25, 0),
	('empty_can', 'cantil', 1, 1, 'item_standard', 1, 16918, 1, '{}', '', 0.25, 0),
	('empty_canteen', 'Canteen', 3, 1, 'item_standard', 1, 17321, 1, '{}', 'nice item', 0.25, 0),
	('empty_mud_bucket', 'jaro 2', 100, 1, 'item_standard', 1, 98695, 1, '{}', 'nice item', 0.25, 0),
	('English_Mace', 'maça inglesa', 100, 1, 'item_standard', 1, 156, 1, '{}', '', 0.25, 0),
	('English_Mace_Seed', 'Semente de Mace Inglesa', 100, 1, 'item_standard', 1, 157, 1, '{}', '', 0.25, 0),
	('ensopado', 'Ensopado de carne', 1, 1, 'item_standard', 1, 170474, 1, '{}', 'nice item', 0.25, 0),
	('enxofre', 'enxofre', 100, 1, 'item_standard', 1, 17163, 1, '{}', '', 0.25, 0),
	('escada', 'Escada', 100, 1, 'item_standard', 1, 215688, 1, '{}', 'nice item', 0.25, 0),
	('escudo1', 'Escudo 1', 100, 1, 'item_standard', 1, 215741, 1, '{}', 'nice item', 0.25, 0),
	('escudo10', 'Escudo 10', 100, 1, 'item_standard', 1, 215750, 1, '{}', 'nice item', 0.25, 0),
	('escudo11', 'Escudo 11', 100, 1, 'item_standard', 1, 215751, 1, '{}', 'nice item', 0.25, 0),
	('escudo12', 'Escudo 12', 100, 1, 'item_standard', 1, 215752, 1, '{}', 'nice item', 0.25, 0),
	('escudo13', 'Escudo 13', 100, 1, 'item_standard', 1, 215753, 1, '{}', 'nice item', 0.25, 0),
	('escudo14', 'Escudo 14', 100, 1, 'item_standard', 1, 215766, 1, '{}', 'nice item', 0.25, 0),
	('escudo2', 'Escudo 2', 100, 1, 'item_standard', 1, 215742, 1, '{}', 'nice item', 0.25, 0),
	('escudo3', 'Escudo 3', 100, 1, 'item_standard', 1, 215743, 1, '{}', 'nice item', 0.25, 0),
	('escudo4', 'Escudo 4', 100, 1, 'item_standard', 1, 215744, 1, '{}', 'nice item', 0.25, 0),
	('escudo5', 'Escudo 5', 100, 1, 'item_standard', 1, 215745, 1, '{}', 'nice item', 0.25, 0),
	('escudo6', 'Escudo 6', 100, 1, 'item_standard', 1, 215746, 1, '{}', 'nice item', 0.25, 0),
	('escudo7', 'Escudo 7', 100, 1, 'item_standard', 1, 215747, 1, '{}', 'nice item', 0.25, 0),
	('escudo8', 'Escudo 8', 100, 1, 'item_standard', 1, 215748, 1, '{}', 'nice item', 0.25, 0),
	('escudo9', 'Escudo 9', 100, 1, 'item_standard', 1, 215749, 1, '{}', 'nice item', 0.25, 0),
	('esterco', 'esterco ', 100, 1, 'item_standard', 1, 17290, 1, '{}', 'nice item', 0.25, 0),
	('Evergreen_Huckleberry', 'Mirtilo perene', 100, 1, 'item_standard', 1, 158, 1, '{}', '', 0.25, 0),
	('Evergreen_Huckleberry_Seed', 'Semente de Mirtilo perene', 100, 1, 'item_standard', 1, 159, 1, '{}', '', 0.25, 0),
	('expensiveclothes', 'Roupas caras', 100, 1, 'item_standard', 1, 215988, 1, '{}', 'nice item', 0.25, 0),
	('eyewear', 'Eyewear', 20, 1, 'item_standard', 1, 17633, 1, '{}', 'nice item', 0.25, 0),
	('fan', 'Fan', 100, 1, 'item_standard', 1, 160, 1, '{}', '', 0.25, 0),
	('fancydouble', 'Quarto Duplo Extravagante', 100, 1, 'item_standard', 1, 667, 1, '{}', '', 0.25, 0),
	('farelo_trigo', 'farelo de trigo', 100, 1, 'item_standard', 1, 17061, 1, '{}', '', 0.25, 0),
	('farinha', 'farinha', 100, 1, 'item_standard', 1, 17123, 1, '{}', '', 0.10, 0),
	('Fat', 'Gordura Animal', 100, 1, 'item_standard', 1, 161, 1, '{}', '', 0.80, 0),
	('fazenda01', 'Livro da Fazenda 1', 100, 1, 'item_standard', 1, 170504, 1, '{}', 'nice item', 0.25, 0),
	('fazenda02', 'Livro da Fazenda 2', 100, 1, 'item_standard', 1, 170509, 1, '{}', 'nice item', 0.25, 0),
	('fazenda03', 'Livro da Fazenda 3', 100, 1, 'item_standard', 1, 170510, 1, '{}', 'nice item', 0.25, 0),
	('fazenda04', 'Livro da Fazenda 4', 100, 1, 'item_standard', 1, 170513, 1, '{}', 'nice item', 0.25, 0),
	('fazenda19', 'livro fazenda 19', 100, 1, 'item_standard', 1, 216034, 1, '{}', 'nice item', 0.25, 0),
	('fazenda20', 'Livro fazenda 20', 100, 1, 'item_standard', 1, 216036, 1, '{}', 'nice item', 0.25, 0),
	('fazenda36', 'Livro fazenda 36', 100, 1, 'item_standard', 1, 216035, 1, '{}', 'nice item', 0.25, 0),
	('Feather', 'Pena', 100, 1, 'item_standard', 1, 162, 1, '{}', '', 0.10, 0),
	('Feather1', 'Penar 1', 100, 1, 'item_standard', 1, 215756, 1, '{}', 'nice item', 0.25, 0),
	('Feather2', 'Penar 2', 100, 1, 'item_standard', 1, 215757, 1, '{}', 'nice item', 0.25, 0),
	('Feather3', 'Penar 3', 100, 1, 'item_standard', 1, 215758, 1, '{}', 'nice item', 0.25, 0),
	('Feather4', 'Penar 4', 100, 1, 'item_standard', 1, 215759, 1, '{}', 'nice item', 0.25, 0),
	('Feather5', 'Penar 5', 100, 1, 'item_standard', 1, 215760, 1, '{}', 'nice item', 0.25, 0),
	('Feather6', 'Penar 6', 100, 1, 'item_standard', 1, 215761, 1, '{}', 'nice item', 0.25, 0),
	('Feather7', 'Penar 7', 100, 1, 'item_standard', 1, 215762, 1, '{}', 'nice item', 0.25, 0),
	('Feather8', 'Penar 8', 100, 1, 'item_standard', 1, 215763, 1, '{}', 'nice item', 0.25, 0),
	('feathers', 'pena', 100, 1, 'item_standard', 1, 16995, 1, '{}', '', 0.25, 0),
	('Feed_For_Dog', 'Comida de cão', 100, 1, 'item_standard', 1, 163, 1, '{}', '', 0.25, 0),
	('feijao', 'feijao', 100, 1, 'item_standard', 1, 16795, 1, '{}', '', 0.25, 0),
	('feijaoisland', 'Feijão Island', 100, 1, 'item_standard', 1, 170475, 1, '{}', 'nice item', 0.25, 0),
	('fermento', 'fermento', 100, 1, 'item_standard', 1, 17095, 1, '{}', '', 0.25, 0),
	('ferradura', 'ferradura ', 100, 1, 'item_standard', 1, 16806, 1, '{}', '', 0.25, 0),
	('ferreirovl', 'Livro Ferreiro', 100, 1, 'item_standard', 1, 98677, 1, '{}', 'nice item', 0.25, 0),
	('Fertilizer', 'Fertilizante', 100, 1, 'item_standard', 1, 736, 1, '{}', '', 0.25, 0),
	('fertilizerbless', 'Abençoado Fertilizante', 100, 1, 'item_standard', 1, 738, 1, '{}', '', 0.25, 0),
	('fertilizeregg', 'Adubo com ovos', 100, 1, 'item_standard', 1, 737, 1, '{}', '', 0.25, 0),
	('fertilizerpro', 'Fertilizante com Produtos', 100, 1, 'item_standard', 1, 740, 1, '{}', '', 0.25, 0),
	('fertilizerpulpsap', 'Fertilizante com Polpa/Seiva', 100, 1, 'item_standard', 1, 741, 1, '{}', '', 0.25, 0),
	('fertilizersn', 'fertilizante com cobra', 100, 1, 'item_standard', 1, 742, 1, '{}', '', 0.25, 0),
	('fertilizersq', 'Fertilizante com Esquilo', 100, 1, 'item_standard', 1, 743, 1, '{}', '', 0.25, 0),
	('fertilizersw', 'Adubo com Madeira Macia', 100, 1, 'item_standard', 1, 745, 1, '{}', '', 0.25, 0),
	('fertilizersyn', 'Fertilizante Synful', 100, 1, 'item_standard', 1, 739, 1, '{}', '', 0.25, 0),
	('fertilizerwoj', 'Fertilizante com Wojape', 100, 1, 'item_standard', 1, 744, 1, '{}', '', 0.25, 0),
	('feuilletabac', 'folha estimulante', 100, 1, 'item_standard', 1, 17100, 1, '{}', '', 0.25, 0),
	('feuille_tabac', 'folha de tabaco', 100, 1, 'item_standard', 1, 16891, 1, '{}', '', 0.25, 0),
	('feverfewseed', 'Wild Feverfew seed', 50, 1, 'item_standard', 1, 17692, 1, '{}', 'an item', 0.25, 0),
	('fibers', 'Fibras', 100, 1, 'item_standard', 1, 164, 1, '{}', '', 1.00, 0),
	('fiche', 'Fichas', 100, 1, 'item_standard', 1, 215656, 1, '{}', 'nice item', 0.25, 0),
	('fireitem', 'Fogo', 100, 1, 'item_standard', 1, 215993, 1, '{}', 'nice item', 0.25, 0),
	('fireportal', 'Portal', 100, 1, 'item_standard', 1, 215831, 1, '{}', 'nice item', 0.25, 0),
	('fish', 'Peixe', 100, 1, 'item_standard', 1, 165, 1, '{}', '', 0.25, 0),
	('fishbait', 'Isca de pesca', 100, 1, 'item_standard', 1, 166, 1, '{}', '', 0.25, 0),
	('fishchips', 'Peixe e batata frita', 100, 1, 'item_standard', 1, 167, 1, '{}', '', 0.25, 0),
	('fishmeat', 'carne de peixe grande', 100, 1, 'item_standard', 1, 572, 1, '{}', '', 0.25, 0),
	('fivela', 'Fivela de Cinto', 100, 1, 'item_standard', 1, 215665, 1, '{}', 'nice item', 0.25, 0),
	('flag', 'bandeira do acampamento', 100, 1, 'item_standard', 1, 168, 1, '{}', '', 0.25, 0),
	('florzinha', 'Flor de Marijuana', 100, 1, 'item_standard', 1, 215651, 1, '{}', 'nice item', 0.25, 0),
	('flor_baunilha', 'Flor-de-Baunilha', 100, 1, 'item_standard', 1, 216133, 1, '{}', 'nice item', 0.50, 0),
	('flour', 'Farinha', 100, 1, 'item_standard', 1, 1654, 1, '{}', '', 0.25, 0),
	('floursack', 'Saco de farinha', 100, 1, 'item_standard', 1, 1655, 1, '{}', '', 0.25, 0),
	('flowerarrangement', 'Flower Arrangement', 20, 1, 'item_standard', 1, 17458, 1, '{}', 'nice item', 0.25, 0),
	('flowerboxes', 'floreiras', 100, 1, 'item_standard', 1, 628, 1, '{}', '', 0.25, 0),
	('folder_skill_pages', 'cartazes', 100, 1, 'item_standard', 1, 16983, 1, '{}', '', 0.25, 0),
	('folha_cocain', 'folha de cocaina', 100, 1, 'item_standard', 1, 16922, 1, '{}', '', 0.25, 0),
	('foodbarrel', 'barril de comida', 100, 1, 'item_standard', 1, 764, 1, '{}', '', 0.25, 0),
	('food_barrel', 'barril de comida', 100, 1, 'item_standard', 1, 636, 1, '{}', '', 0.25, 0),
	('formula_adolescente', 'Formula De Adolescente', 100, 1, 'item_standard', 1, 216647, 1, '{}', 'nice item', 0.50, 0),
	('formula_anao', 'Formula de Anão', 100, 1, 'item_standard', 1, 216646, 1, '{}', 'nice item', 0.50, 0),
	('formula_formiga', 'Formula de Formiga', 100, 1, 'item_standard', 1, 216645, 1, '{}', 'nice item', 0.50, 0),
	('formula_gigante', 'Formula de Gigante', 100, 1, 'item_standard', 1, 216650, 1, '{}', 'nice item', 0.50, 0),
	('formula_grande', 'Formula Grande', 100, 1, 'item_standard', 1, 216649, 1, '{}', 'nice item', 0.50, 0),
	('formula_normal', 'Formula Tamanho Normal', 100, 1, 'item_standard', 1, 216648, 1, '{}', 'nice item', 0.50, 0),
	('formula_titan', 'Formula de Titan', 100, 1, 'item_standard', 1, 216651, 1, '{}', 'nice item', 0.50, 0),
	('fosforo', 'fosforos', 100, 1, 'item_standard', 1, 215643, 1, '{}', 'nice item', 0.25, 0),
	('foxskin', 'pele de raposa', 100, 1, 'item_standard', 1, 512, 1, '{}', '', 0.25, 0),
	('foxt', 'dente de raposa', 100, 1, 'item_standard', 1, 513, 1, '{}', '', 0.25, 0),
	('foxtrophy', 'Troféu de Raposa', 100, 1, 'item_standard', 1, 215953, 1, '{}', 'nice item', 3.00, 0),
	('fox_meat', 'Carne de Raposa', 100, 1, 'item_standard', 1, 215952, 1, '{}', 'nice item', 1.20, 0),
	('framboesa', 'Framboesa', 100, 1, 'item_standard', 1, 216121, 1, '{}', 'nice item', 0.50, 0),
	('friedtater', 'batata Frita', 100, 1, 'item_standard', 1, 169, 1, '{}', '', 0.25, 0),
	('frogbull2_c', 'Frogbull envenenado', 100, 1, 'item_standard', 1, 428, 1, '{}', '', 0.25, 0),
	('frogbull_c', 'Frogbull', 100, 1, 'item_standard', 1, 427, 1, '{}', '', 0.25, 0),
	('Fruit Tree', 'arvore frutifera', 100, 1, 'item_standard', 1, 16881, 1, '{}', '', 0.25, 0),
	('fsnakes', 'Pele de cascavel Blacktail', 100, 1, 'item_standard', 1, 488, 1, '{}', '', 0.25, 0),
	('galinhafood', 'Ração de Galinha', 100, 1, 'item_standard', 1, 98356, 1, '{}', 'nice item', 0.25, 0),
	('game', 'carne de caça', 100, 1, 'item_standard', 1, 570, 1, '{}', '', 0.25, 0),
	('Gamey_Meat', 'carne de caça', 30, 1, 'item_standard', 1, 170, 1, '{}', '', 0.25, 0),
	('Gator_Egg_3', 'Ovo de Jacaré 3', 100, 1, 'item_standard', 1, 171, 1, '{}', '', 0.25, 0),
	('Gator_Egg_4', 'Ovos de Jacaré 4', 100, 1, 'item_standard', 1, 172, 1, '{}', '', 0.25, 0),
	('Gator_Egg_5', 'Ovo de Jacaré 5', 100, 1, 'item_standard', 1, 173, 1, '{}', '', 0.25, 0),
	('gauntlets', 'Gauntlets', 20, 1, 'item_standard', 1, 17619, 1, '{}', 'nice item', 0.25, 0),
	('gbarrelx', 'Cano da arma', 100, 1, 'item_standard', 1, 761, 1, '{}', '', 0.25, 0),
	('gbears', 'Urso', 100, 1, 'item_standard', 1, 453, 1, '{}', '', 6.00, 0),
	('gemstone', 'Stone', 100, 1, 'item_standard', 1, 98666, 1, '{}', 'nice item', 0.25, 0),
	('generic_list', 'carta de desconhecido', 100, 1, 'item_standard', 1, 17198, 1, '{}', '', 0.25, 0),
	('gigantinho', 'Formula para crecer', 5, 1, 'item_standard', 1, 215672, 1, '{}', 'nice item', 0.25, 0),
	('ginseng', 'Ginseng', 50, 1, 'item_standard', 1, 17683, 1, '{}', 'an item', 0.25, 0),
	('Ginseng Americano', 'Ginseng Americano', 100, 1, 'item_standard', 1, 16876, 1, '{}', '', 0.25, 0),
	('ginsengtea', 'chá de ginseng', 100, 1, 'item_standard', 1, 174, 1, '{}', '', 0.25, 0),
	('ginseng_alasca', 'Ginseng do Alasca', 100, 1, 'item_standard', 1, 216145, 1, '{}', 'nice item', 0.50, 0),
	('ginseng_americano', 'Ginseng Americano', 100, 1, 'item_standard', 1, 216142, 1, '{}', 'nice item', 0.50, 0),
	('glass', 'vidro quebrado', 100, 1, 'item_standard', 1, 17200, 1, '{}', '', 0.25, 0),
	('glassbottle', 'Garrafa vazia', 100, 1, 'item_standard', 1, 175, 1, '{}', '', 0.10, 0),
	('glasseye', 'Olho de vidro', 100, 1, 'item_standard', 1, 1656, 1, '{}', '', 0.25, 0),
	('gleguans', 'pele de iguana verde', 100, 1, 'item_standard', 1, 552, 1, '{}', '', 0.25, 0),
	('gloves', 'Gloves', 20, 1, 'item_standard', 1, 17624, 1, '{}', 'nice item', 0.25, 0),
	('goathead', 'cabeça de bode', 100, 1, 'item_standard', 1, 556, 1, '{}', '', 0.25, 0),
	('goats', 'pele de cabra', 100, 1, 'item_standard', 1, 555, 1, '{}', '', 0.25, 0),
	('goat_meat', 'Carne de Cabra', 100, 1, 'item_standard', 1, 215934, 1, '{}', 'nice item', 1.00, 0),
	('goldbar', 'Barra de ouro', 100, 1, 'item_standard', 1, 176, 1, '{}', '', 0.25, 0),
	('goldcraddlestand', 'planta de garimpo', 10, 1, 'item_standard', 1, 17262, 1, '{}', 'nice item', 0.25, 0),
	('golddust', 'pepita de ouro', 100, 1, 'item_standard', 1, 16979, 1, '{}', '', 0.25, 0),
	('Golden_Currant', 'groselha dourada', 100, 1, 'item_standard', 1, 177, 1, '{}', '', 0.25, 0),
	('Golden_Currant_Seed', 'semente de groselha dourada', 100, 1, 'item_standard', 1, 178, 1, '{}', '', 0.25, 0),
	('golden_nugget', 'Golden Nugget', 40, 1, 'item_standard', 1, 17325, 1, '{}', 'nice item', 0.25, 0),
	('goldfish', 'peixe dourado', 100, 1, 'item_standard', 1, 179, 1, '{}', '', 0.25, 0),
	('goldhorseshoe', 'ferradura de ouro', 100, 1, 'item_standard', 1, 16909, 1, '{}', '', 0.25, 0),
	('goldnugget', 'pepita', 100, 1, 'item_standard', 1, 16987, 1, '{}', '', 0.25, 0),
	('goldpan', 'prato de garimpo', 2, 1, 'item_standard', 1, 181, 1, '{}', '', 0.25, 0),
	('goldring', 'Anel de ouro', 100, 1, 'item_standard', 1, 182, 1, '{}', '', 0.25, 0),
	('goldticket', 'bilhete 3', 100, 1, 'item_standard', 1, 16913, 1, '{}', '', 0.25, 0),
	('goldtooth', 'Dente de Ouro', 100, 1, 'item_standard', 1, 215657, 1, '{}', 'nice item', 0.25, 0),
	('gold_flakes', 'Flocos de Ouro', 100, 1, 'item_standard', 1, 98693, 1, '{}', 'nice item', 0.25, 0),
	('gold_nugget', 'Pepita de ouro', 100, 1, 'item_standard', 1, 180, 1, '{}', '', 0.25, 0),
	('gold_pan', 'Gold Pan', 1, 1, 'item_standard', 1, 17324, 1, '{}', 'nice item', 0.25, 0),
	('gold_panning_license', 'Licença de garimpo de ouro', 100, 1, 'item_standard', 1, 1657, 1, '{}', '', 0.25, 0),
	('goodbyliquor', 'Good-bye Liquor', 20, 1, 'item_standard', 1, 17457, 1, '{}', 'nice item', 0.25, 0),
	('gooseb', 'bico de ganso', 100, 1, 'item_standard', 1, 532, 1, '{}', '', 0.25, 0),
	('goosef', 'Pena de ganso', 100, 1, 'item_standard', 1, 531, 1, '{}', '', 0.25, 0),
	('Goose_Egg_4', 'ovo de ganso', 100, 1, 'item_standard', 1, 183, 1, '{}', '', 0.25, 0),
	('gota_leite_violeta', 'Gota-de-Leite Violeta', 100, 1, 'item_standard', 1, 216147, 1, '{}', 'nice item', 0.50, 0),
	('Grain', 'Grão', 100, 1, 'item_standard', 1, 215816, 1, '{}', 'nice item', 0.25, 0),
	('grainmill', 'Moinho de grãos', 100, 1, 'item_standard', 1, 1658, 1, '{}', '', 0.25, 0),
	('grain_barley', 'Cevada', 100, 1, 'item_standard', 1, 216344, 1, '{}', 'nice item', 0.40, 0),
	('Grain_Seed', 'Semente de Grão', 100, 1, 'item_standard', 1, 215804, 1, '{}', 'nice item', 0.25, 0),
	('Granuls', 'Comida para passaros', 100, 1, 'item_standard', 1, 215690, 1, '{}', 'nice item', 0.25, 0),
	('grapes', 'Uvas', 100, 1, 'item_standard', 1, 1680, 1, '{}', '', 0.30, 0),
	('Grape_Seed', 'semente de uva', 100, 1, 'item_standard', 1, 1681, 1, '{}', '', 0.25, 0),
	('grinder', 'grinder', 100, 1, 'item_standard', 1, 1660, 1, '{}', '', 0.25, 0),
	('gringohat1', 'Coração de Lobo', 100, 1, 'item_standard', 1, 215984, 1, '{}', 'nice item', 1.50, 0),
	('gringohat2', 'Pele de Lobo', 100, 1, 'item_standard', 1, 215985, 1, '{}', 'nice item', 2.50, 0),
	('gringohat3', '3', 100, 1, 'item_standard', 1, 215986, 1, '{}', 'nice item', 0.25, 0),
	('gualteria', 'Gualtéria', 100, 1, 'item_standard', 1, 216144, 1, '{}', 'nice item', 0.50, 0),
	('Guarma_Tobacco', 'Tabaco de Guarma', 100, 1, 'item_standard', 1, 215825, 1, '{}', 'nice item', 0.25, 0),
	('Guarma_Tobacco_Seed', 'Semente de Tabaco Guarma', 100, 1, 'item_standard', 1, 215793, 1, '{}', 'nice item', 0.25, 0),
	('guitar', 'Guitarra Clássica', 100, 1, 'item_standard', 1, 341, 1, '{}', '', 0.25, 0),
	('gunbelts', 'Gunbelt', 20, 1, 'item_standard', 1, 17614, 1, '{}', 'nice item', 0.25, 0),
	('gunbelt_accs', 'Gunbelt Accs', 20, 1, 'item_standard', 1, 17616, 1, '{}', 'nice item', 0.25, 0),
	('guncloth', 'pano', 100, 1, 'item_standard', 1, 215693, 1, '{}', 'nice item', 0.25, 0),
	('gun_barrel', 'Cano da arma', 100, 1, 'item_standard', 1, 633, 1, '{}', '', 0.25, 0),
	('gypsywagon', 'Conjunto de Carroça Cigana', 100, 1, 'item_standard', 1, 585, 1, '{}', '', 0.25, 0),
	('hairpomade', 'pomada para cabelo', 100, 1, 'item_standard', 1, 184, 1, '{}', '', 0.25, 0),
	('hair_accessories', 'Bow', 20, 1, 'item_standard', 1, 17611, 1, '{}', 'nice item', 0.25, 0),
	('hammer', 'martelo', 100, 1, 'item_standard', 1, 17234, 1, '{}', '', 0.25, 0),
	('handcuffs', 'Algemas', 100, 1, 'item_standard', 1, 185, 1, '{}', '', 0.25, 0),
	('handcuffskey', 'chave de algemas', 1, 1, 'item_standard', 1, 17108, 1, '{}', '', 0.25, 0),
	('handmixer', 'batedeira', 100, 1, 'item_standard', 1, 1661, 1, '{}', '', 0.25, 0),
	('handsaw', 'serrote', 100, 1, 'item_standard', 1, 1662, 1, '{}', '', 0.25, 0),
	('hatchet', 'machado', 100, 1, 'item_standard', 1, 186, 1, '{}', '', 0.25, 0),
	('hats', 'Hat', 20, 1, 'item_standard', 1, 17635, 1, '{}', 'nice item', 0.25, 0),
	('hawkf', 'pena de gavião', 100, 1, 'item_standard', 1, 535, 1, '{}', '', 0.25, 0),
	('hawkt', 'garras de falcão', 100, 1, 'item_standard', 1, 536, 1, '{}', '', 0.25, 0),
	('hay', 'cubo de feno', 20, 1, 'item_standard', 1, 16925, 1, '{}', '', 0.25, 0),
	('Headband1', 'Headband1', 5, 1, 'item_standard', 1, 17481, 1, '{}', 'nice item', 0.25, 0),
	('Headband2', 'Headband2', 5, 1, 'item_standard', 1, 17482, 1, '{}', 'nice item', 0.25, 0),
	('Headband3', 'Headband3', 5, 1, 'item_standard', 1, 17483, 1, '{}', 'nice item', 0.25, 0),
	('Headband4', 'Headband4', 5, 1, 'item_standard', 1, 17484, 1, '{}', 'nice item', 0.25, 0),
	('Headband5', 'Headband5', 5, 1, 'item_standard', 1, 17485, 1, '{}', 'nice item', 0.25, 0),
	('Headband6', 'Headband6', 5, 1, 'item_standard', 1, 17486, 1, '{}', 'nice item', 0.25, 0),
	('Headdress1', 'Headdress1', 5, 1, 'item_standard', 1, 17487, 1, '{}', 'nice item', 0.25, 0),
	('Headdress2', 'Headdress2', 5, 1, 'item_standard', 1, 17488, 1, '{}', 'nice item', 0.25, 0),
	('Headdress3', 'Headdress3', 5, 1, 'item_standard', 1, 17489, 1, '{}', 'nice item', 0.25, 0),
	('Headdress4', 'Headdress4', 5, 1, 'item_standard', 1, 17490, 1, '{}', 'nice item', 0.25, 0),
	('Headdress5', 'Headdress5', 5, 1, 'item_standard', 1, 17491, 1, '{}', 'nice item', 0.25, 0),
	('Headdress6', 'Headdress6', 6, 1, 'item_standard', 1, 17492, 1, '{}', 'nice item', 0.25, 0),
	('healingitem', 'healingitem', 100, 1, 'item_standard', 1, 216006, 1, '{}', 'nice item', 0.10, 0),
	('healingitemPoison', 'healingitemPoison', 100, 1, 'item_standard', 1, 216002, 1, '{}', 'nice item', 0.20, 0),
	('Health_For_Dog', 'Bandagens para animais de estimação', 100, 1, 'item_standard', 1, 187, 1, '{}', '', 0.25, 0),
	('heart_chicken', 'Coração de Galinha', 100, 1, 'item_standard', 1, 215949, 1, '{}', 'nice item', 0.50, 0),
	('heart_panther', 'Coração de Pantera', 100, 1, 'item_standard', 1, 215964, 1, '{}', 'nice item', 1.50, 0),
	('heart_pig_boar', 'Coração de Javali', 100, 1, 'item_standard', 1, 215945, 1, '{}', 'nice item', 1.30, 0),
	('heart_wolf', 'Coração de Lobo', 100, 1, 'item_standard', 1, 216622, 1, '{}', 'nice item', 0.25, 0),
	('hemp', 'Cânhamo', 100, 1, 'item_standard', 1, 188, 1, '{}', '', 0.25, 0),
	('hemp_cig', 'cigarro de cânhamo', 100, 1, 'item_standard', 1, 189, 1, '{}', '', 0.25, 0),
	('hemp_seed', 'Sementes de cânhamo', 100, 1, 'item_standard', 1, 615, 1, '{}', '', 0.25, 0),
	('herbal_medicine', 'Fitoterapia', 100, 1, 'item_standard', 1, 338, 1, '{}', '', 0.25, 0),
	('herbal_tonic', 'tonico de ervas', 100, 1, 'item_standard', 1, 339, 1, '{}', '', 0.25, 0),
	('herbmed', 'Fitoterápico', 100, 1, 'item_standard', 1, 190, 1, '{}', '', 0.25, 0),
	('herb_agarita', 'Erva de Agarita', 100, 1, 'item_standard', 1, 216236, 1, '{}', 'nice item', 0.20, 0),
	('herb_alaskan_ginseng', 'Ginseng do Alasca', 100, 1, 'item_standard', 1, 216254, 1, '{}', 'nice item', 0.20, 0),
	('herb_chamomile', 'Camomila', 100, 1, 'item_standard', 1, 216265, 1, '{}', 'nice item', 0.20, 0),
	('herb_cotton', 'Erva Algodão', 100, 1, 'item_standard', 1, 216348, 1, '{}', 'nice item', 0.20, 0),
	('herb_creekplum', 'Erva Creek Plum', 100, 1, 'item_standard', 1, 216339, 1, '{}', 'nice item', 0.20, 0),
	('herb_crows_garlic', 'Erva Alho do Corvo', 100, 1, 'item_standard', 1, 216351, 1, '{}', 'nice item', 0.20, 0),
	('herb_evergreen_huckleberry', 'Mirtilo Perene', 100, 1, 'item_standard', 1, 216252, 1, '{}', 'nice item', 0.20, 0),
	('herb_hummingbird_sage', 'Sálvia Beija-flor', 100, 1, 'item_standard', 1, 216250, 1, '{}', 'nice item', 0.20, 0),
	('herb_indian_tobacco', 'Tabaco Indiano', 100, 1, 'item_standard', 1, 216240, 1, '{}', 'nice item', 0.20, 0),
	('herb_prairie_poppy', 'Erva Papoula do Prado', 100, 1, 'item_standard', 1, 216354, 1, '{}', 'nice item', 0.20, 0),
	('herb_rams_head', 'Cabeça de Carneiro', 100, 1, 'item_standard', 1, 216246, 1, '{}', 'nice item', 0.20, 0),
	('herb_sugar', 'Cana Açúcar', 100, 1, 'item_standard', 1, 216256, 1, '{}', 'nice item', 0.20, 0),
	('herb_wild_carrot', 'Cenoura Selvagem', 100, 1, 'item_standard', 1, 216238, 1, '{}', 'nice item', 0.20, 0),
	('herb_wild_mint', 'Menta Selvagem', 100, 1, 'item_standard', 1, 216244, 1, '{}', 'nice item', 0.20, 0),
	('heroin', 'Heroin', 100, 1, 'item_standard', 1, 191, 1, '{}', '', 0.25, 0),
	('herptile', 'carne herptil', 100, 1, 'item_standard', 1, 573, 1, '{}', '', 0.25, 0),
	('hitchingpost', 'Posto de amarração', 100, 1, 'item_standard', 1, 580, 1, '{}', '', 0.25, 0),
	('hoe', 'rastelo', 100, 1, 'item_standard', 1, 679, 1, '{}', '', 0.25, 0),
	('hojacocaina', 'Hoja de Cocaina', 100, 1, 'item_standard', 1, 16934, 1, '{}', '', 0.25, 0),
	('hojaepi', 'Hoja Epi (Methanfetamina)', 100, 1, 'item_standard', 1, 16938, 1, '{}', '', 0.25, 0),
	('holsters', 'coldres', 100, 1, 'item_standard', 1, 216042, 1, '{}', 'nice item', 0.25, 0),
	('holsters_left', 'Holster', 20, 1, 'item_standard', 1, 17621, 1, '{}', 'nice item', 0.25, 0),
	('honey', 'mel', 30, 1, 'item_standard', 1, 192, 1, '{}', '', 0.25, 0),
	('honeywhisky', 'Whisky de Mel', 100, 1, 'item_standard', 1, 215775, 1, '{}', 'nice item', 0.25, 0),
	('honey_gk', 'Mel', 100, 1, 'item_standard', 1, 17041, 1, '{}', '', 0.25, 0),
	('hop', 'lúpulo', 100, 1, 'item_standard', 1, 685, 1, '{}', '', 0.25, 0),
	('hop_seed', 'Semente de lúpulo', 100, 1, 'item_standard', 1, 684, 1, '{}', '', 0.25, 0),
	('horapa', 'Cavalo Appaloosa', 5, 1, 'item_standard', 1, 1015, 1, '{}', '009', 0.25, 0),
	('horbre', 'Cavalo Breton ', 5, 1, 'item_standard', 1, 1014, 1, '{}', '008', 0.25, 0),
	('hormis', 'Cavalo Missourifox', 10, 1, 'item_standard', 1, 1010, 1, '{}', '004', 0.25, 0),
	('horse1', 'Vale Cavalo 1', 5, 1, 'item_standard', 1, 1028, 1, '{}', 'nice item', 0.25, 0),
	('horse2', 'Vale Cavalo 2', 5, 1, 'item_standard', 1, 1029, 1, '{}', 'nice item', 0.25, 0),
	('horse3', 'Vale Cavalo 3', 5, 1, 'item_standard', 1, 1030, 1, '{}', 'nice item', 0.25, 0),
	('horse4', 'Vale Cavalo 4', 5, 1, 'item_standard', 1, 1031, 1, '{}', 'nice item', 0.25, 0),
	('horsebrush', 'escova de cavalo', 100, 1, 'item_standard', 1, 193, 1, '{}', '', 0.25, 0),
	('HorseCartTag', 'Licensa de carroça', 100, 1, 'item_standard', 1, 215768, 1, '{}', 'nice item', 0.25, 0),
	('horsehitches', 'Conjunto de engates de cavalo', 100, 1, 'item_standard', 1, 603, 1, '{}', '', 0.25, 0),
	('horsemeal', 'Ração de cavalo', 100, 1, 'item_standard', 1, 348, 1, '{}', '', 0.25, 0),
	('horserevive', 'revive cavalo', 100, 1, 'item_standard', 1, 17184, 1, '{}', '', 0.25, 0),
	('hortur', 'Cavalo Turkoman', 5, 1, 'item_standard', 1, 1009, 1, '{}', '003', 0.25, 0),
	('huckleberry_california', 'Huckleberry da Califórnia', 100, 1, 'item_standard', 1, 216123, 1, '{}', 'nice item', 0.50, 0),
	('humbirdsage', 'Hummingbird Sage', 50, 1, 'item_standard', 1, 17697, 1, '{}', 'an item', 0.25, 0),
	('Hummingbird_Sage', 'Sálvia Beija-flor', 100, 1, 'item_standard', 1, 194, 1, '{}', '', 0.25, 0),
	('Hummingbird_Sage_Seed', 'Semente de Sálvia Beija-flor', 100, 1, 'item_standard', 1, 195, 1, '{}', '', 0.25, 0),
	('hwood', 'madeira dura', 30, 1, 'item_standard', 1, 196, 1, '{}', '', 0.25, 0),
	('iceitem', 'Gelo', 100, 1, 'item_standard', 1, 215994, 1, '{}', 'nice item', 0.25, 0),
	('icemagic', 'Poção do gelo', 100, 1, 'item_standard', 1, 215829, 1, '{}', 'nice item', 0.25, 0),
	('idcard', 'Identidade', 1, 1, 'item_standard', 1, 17327, 1, '{}', 'nice item', 0.25, 0),
	('identitycard', 'identidade', 1, 1, 'item_standard', 1, 17074, 1, '{}', '', 0.25, 0),
	('identitycardfalsa', 'identidade', 1, 1, 'item_standard', 1, 17073, 1, '{}', '', 0.25, 0),
	('idfalsa', 'identidade falsa', 1, 1, 'item_standard', 1, 17072, 1, '{}', '', 0.25, 0),
	('id_card', 'Cartao de Identidade', 1, 1, 'item_standard', 1, 17247, 1, '{}', '', 0.25, 0),
	('iguanabits', 'Partes de Iguana', 100, 1, 'item_standard', 1, 1663, 1, '{}', '', 0.25, 0),
	('iguana_meat', 'Carne de Iguana', 100, 1, 'item_standard', 1, 215956, 1, '{}', 'nice item', 0.25, 0),
	('Indian_Tobbaco', 'tabaco indiano', 100, 1, 'item_standard', 1, 197, 1, '{}', '', 0.25, 0),
	('Indian_Tobbaco_Seed', 'Semente de Tabaco Indiano', 100, 1, 'item_standard', 1, 198, 1, '{}', '', 0.25, 0),
	('Indigo', 'Indigo', 100, 1, 'item_standard', 1, 215826, 1, '{}', 'nice item', 0.25, 0),
	('Indigo_Seed', 'Semente de Indico', 100, 1, 'item_standard', 1, 215802, 1, '{}', 'nice item', 0.25, 0),
	('indovinello', 'indovinello', 100, 1, 'item_standard', 1, 215687, 1, '{}', 'nice item', 0.25, 0),
	('inelargintsmarald', 'Anel de Esmeralda', 100, 1, 'item_standard', 1, 215658, 1, '{}', 'nice item', 0.25, 0),
	('inelmagic', 'Anel Magico', 100, 1, 'item_standard', 1, 215659, 1, '{}', 'nice item', 0.25, 0),
	('Ingredient_Beef_Meat', 'carne de vaca', 100, 1, 'item_standard', 1, 16968, 1, '{}', '', 0.25, 0),
	('Ingredient_Goat_Meat', 'carne de cabra ', 100, 1, 'item_standard', 1, 16970, 1, '{}', '', 0.25, 0),
	('Ingredient_Pig_Meat', 'Carne de Porco', 100, 1, 'item_standard', 1, 16969, 1, '{}', '', 1.50, 0),
	('injeanimal', 'Injeção de Animais', 100, 1, 'item_standard', 1, 98355, 1, '{}', 'nice item', 0.25, 0),
	('ink', 'Tinta', 100, 1, 'item_standard', 1, 1664, 1, '{}', '', 0.25, 0),
	('iogurtem', 'Iogurte de Morango', 100, 1, 'item_standard', 1, 170508, 1, '{}', 'nice item', 0.25, 0),
	('iron', 'ferro', 100, 1, 'item_standard', 1, 199, 1, '{}', '', 0.25, 0),
	('ironbar', 'barra de ferro', 100, 1, 'item_standard', 1, 200, 1, '{}', '', 0.25, 0),
	('ironextract', 'Extrato de ferro', 100, 1, 'item_standard', 1, 201, 1, '{}', '', 0.25, 0),
	('ironhammer', 'martelo de ferro', 100, 1, 'item_standard', 1, 202, 1, '{}', '', 0.25, 0),
	('ironhorseshoe', 'ferradura de ferro', 100, 1, 'item_standard', 1, 16907, 1, '{}', '', 0.25, 0),
	('jewelry', 'joias', 100, 1, 'item_standard', 1, 216041, 1, '{}', 'nice item', 0.25, 0),
	('jewelrybook', 'livro', 100, 1, 'item_standard', 1, 17236, 1, '{}', '', 0.25, 0),
	('jewelry_bracelets', 'Bracelet', 20, 1, 'item_standard', 1, 17636, 1, '{}', 'nice item', 0.25, 0),
	('jewelry_rings_left', 'Ring Lh', 20, 1, 'item_standard', 1, 17622, 1, '{}', 'nice item', 0.25, 0),
	('jewelry_rings_right', 'Ring Rh', 20, 1, 'item_standard', 1, 17623, 1, '{}', 'nice item', 0.25, 0),
	('jobnotepad', 'Bloco de notas de trabalho', 100, 1, 'item_standard', 1, 16887, 1, '{}', '', 0.25, 0),
	('joint', 'Joint', 20, 1, 'item_standard', 1, 17461, 1, '{}', 'nice item', 0.25, 0),
	('journal', 'journal', 100, 1, 'item_standard', 1, 216612, 1, '{}', 'nice item', 0.25, 0),
	('jumpitem', 'Super Pulo', 100, 1, 'item_standard', 1, 215995, 1, '{}', 'nice item', 0.25, 0),
	('kbirdb', 'Grande bico de garça azul', 100, 1, 'item_standard', 1, 534, 1, '{}', '', 0.25, 0),
	('kbirdf', 'Pena de garça-real', 100, 1, 'item_standard', 1, 533, 1, '{}', '', 0.25, 0),
	('kitbandagem', 'Bandagem', 100, 1, 'item_standard', 1, 215666, 1, '{}', '', 0.25, 0),
	('kitchencounter', 'Balcão de cozinha', 100, 1, 'item_standard', 1, 611, 1, '{}', '', 0.25, 0),
	('kitmedicamento', 'Medicamento simples', 100, 1, 'item_standard', 1, 215667, 1, '{}', '', 0.25, 0),
	('kitmedicervas', 'Medicamento de Ervas', 100, 1, 'item_standard', 1, 215668, 1, '{}', '', 0.25, 0),
	('kitmedico', 'Kit Medico', 100, 1, 'item_standard', 1, 215669, 1, '{}', '', 0.25, 0),
	('kittonicoervas', 'Tonico de Ervas', 100, 1, 'item_standard', 1, 215670, 1, '{}', '', 0.25, 0),
	('kit_bandana', 'Bandana', 100, 1, 'item_standard', 1, 203, 1, '{}', '', 0.25, 0),
	('kit_camp', 'kit acampamento', 1, 1, 'item_standard', 1, 16740, 1, '{}', '', 0.25, 0),
	('kit_camp_simple', 'kit acampamento simples', 100, 1, 'item_standard', 1, 16739, 1, '{}', '', 0.25, 0),
	('kit_collectors_bag', 'mochila', 100, 1, 'item_standard', 1, 17299, 1, '{}', 'nice item', 0.25, 0),
	('kit_collector_spade', 'pá de coleta', 100, 1, 'item_standard', 1, 16734, 1, '{}', '', 0.25, 0),
	('lamppost1', 'Poste de luz 1 conjunto', 100, 1, 'item_standard', 1, 606, 1, '{}', '', 0.25, 0),
	('lamppost2', 'Poste de luz 2 conjunto', 100, 1, 'item_standard', 1, 607, 1, '{}', '', 0.25, 0),
	('lanterna', 'lanterna', 100, 1, 'item_standard', 1, 659, 1, '{}', '', 0.25, 0),
	('laranja', 'laranja ', 100, 1, 'item_standard', 1, 17117, 1, '{}', '', 0.25, 0),
	('laranja_seed', 'semente de laranja', 100, 1, 'item_standard', 1, 17112, 1, '{}', '', 0.25, 0),
	('leather', 'Couro', 100, 1, 'item_standard', 1, 204, 1, '{}', '', 0.25, 0),
	('leatherchair', 'cadeira de couro', 100, 1, 'item_standard', 1, 748, 1, '{}', '', 0.25, 0),
	('leather_chair', 'cadeira de couro', 100, 1, 'item_standard', 1, 620, 1, '{}', '', 0.25, 0),
	('legalbook', 'livro legal', 100, 1, 'item_standard', 1, 892, 1, '{}', '', 0.25, 0),
	('legaligators', 'Pele de Jacaré Lendária', 100, 1, 'item_standard', 1, 417, 1, '{}', '', 0.25, 0),
	('legaligators1', 'Legendary Teca Alligator pelt', 100, 1, 'item_standard', 1, 400, 1, '{}', '', 0.25, 0),
	('legaligators2', 'Pele Lendária de Jacaré do Sol', 100, 1, 'item_standard', 1, 401, 1, '{}', '', 0.25, 0),
	('legaligators3', 'Pele lendária de crocodilo com faixas', 100, 1, 'item_standard', 1, 402, 1, '{}', '', 0.25, 0),
	('legalpaper', 'Papel Legal', 100, 1, 'item_standard', 1, 891, 1, '{}', '', 0.25, 0),
	('legbears1', 'Pele Lendária de Urso Mortal', 100, 1, 'item_standard', 1, 376, 1, '{}', '', 0.25, 0),
	('legbears2', 'Pele lendária do Urso Owiza', 100, 1, 'item_standard', 1, 377, 1, '{}', '', 0.25, 0),
	('legbears3', 'Pele Lendária do Urso Espírito Ridgeback', 100, 1, 'item_standard', 1, 378, 1, '{}', '', 0.25, 0),
	('legbears4', 'Pele Lendária do Urso Espírito Dourado', 100, 1, 'item_standard', 1, 379, 1, '{}', '', 0.25, 0),
	('legbeavers1', 'Pele Lendária de Castor Cinzento', 100, 1, 'item_standard', 1, 397, 1, '{}', '', 0.25, 0),
	('legbeavers2', 'Pele Lendária de Castor Branco', 100, 1, 'item_standard', 1, 398, 1, '{}', '', 0.25, 0),
	('legbeavers3', 'Pele Lendária de Castor Negro', 100, 1, 'item_standard', 1, 399, 1, '{}', '', 0.25, 0),
	('legbeawers', 'Pele de castor lendária', 100, 1, 'item_standard', 1, 411, 1, '{}', '', 0.25, 0),
	('legbisonhorn', 'Chifres de Bisão Lendários', 100, 1, 'item_standard', 1, 353, 1, '{}', '', 0.25, 0),
	('legbisons', 'Pele de Bisão Lendária', 100, 1, 'item_standard', 1, 416, 1, '{}', '', 0.25, 0),
	('legbisons1', 'Pele lendária de Tatanka Bison', 100, 1, 'item_standard', 1, 365, 1, '{}', '', 0.25, 0),
	('legbisons2', 'Pele lendária de Winyan Bison', 100, 1, 'item_standard', 1, 366, 1, '{}', '', 0.25, 0),
	('legbisons3', 'Pele lendária de Payata Bison', 100, 1, 'item_standard', 1, 367, 1, '{}', '', 0.25, 0),
	('legbisonstak', 'Pele lendária de Takanta Bison', 100, 1, 'item_standard', 1, 415, 1, '{}', '', 0.25, 0),
	('legboars', 'Pele de javali lendária', 100, 1, 'item_standard', 1, 414, 1, '{}', '', 0.25, 0),
	('legboars1', 'Pele de Javali Cogi Lendária', 100, 1, 'item_standard', 1, 393, 1, '{}', '', 0.25, 0),
	('legboars2', 'Pele de Javali Wakpa Lendária', 100, 1, 'item_standard', 1, 394, 1, '{}', '', 0.25, 0),
	('legboars3', 'Pele de Javali Icahi Lendária', 100, 1, 'item_standard', 1, 395, 1, '{}', '', 0.25, 0),
	('legboars4', 'Pele de Wildhog lendária', 100, 1, 'item_standard', 1, 396, 1, '{}', '', 0.25, 0),
	('legbucks', 'Skin Lendária Buck', 100, 1, 'item_standard', 1, 410, 1, '{}', '', 0.25, 0),
	('legbucks1', 'Pele de Buck Lendária', 100, 1, 'item_standard', 1, 368, 1, '{}', '', 0.25, 0),
	('legbucks2', 'Pele Lendária Mudrunner Buck', 100, 1, 'item_standard', 1, 369, 1, '{}', '', 0.25, 0),
	('legbucks3', 'Pele Lendária de Snow Buck', 100, 1, 'item_standard', 1, 370, 1, '{}', '', 0.25, 0),
	('legbucks4', 'Pele Lendária de Shadow Buck', 100, 1, 'item_standard', 1, 371, 1, '{}', '', 0.25, 0),
	('legcougars', 'Pele lendária de puma', 100, 1, 'item_standard', 1, 409, 1, '{}', '', 0.25, 0),
	('legcougars1', 'Pele lendária de Iguga Cougar', 100, 1, 'item_standard', 1, 389, 1, '{}', '', 0.25, 0),
	('legcougars2', 'Pele lendária de Maza Cougar', 100, 1, 'item_standard', 1, 390, 1, '{}', '', 0.25, 0),
	('legcougars3', 'Pele lendária de Sapa Cougar', 100, 1, 'item_standard', 1, 391, 1, '{}', '', 0.25, 0),
	('legcougars4', 'Pele de Puma Negra Lendária', 100, 1, 'item_standard', 1, 392, 1, '{}', '', 0.25, 0),
	('legcoyotes', 'Pele lendária de coiote', 100, 1, 'item_standard', 1, 408, 1, '{}', '', 0.25, 0),
	('legcoyotes1', 'Pele de Coiote Lendária Red Streak', 100, 1, 'item_standard', 1, 386, 1, '{}', '', 0.25, 0),
	('legcoyotes2', 'Pele Lendária Midnight Paw Coyote', 100, 1, 'item_standard', 1, 387, 1, '{}', '', 0.25, 0),
	('legcoyotes3', 'Pele lendária de coiote de leite', 100, 1, 'item_standard', 1, 388, 1, '{}', '', 0.25, 0),
	('legelkantler', 'Chifres de Alce Lendários', 100, 1, 'item_standard', 1, 355, 1, '{}', '', 0.25, 0),
	('legelks', 'Pele de Alce Lendária', 100, 1, 'item_standard', 1, 403, 1, '{}', '', 0.25, 0),
	('legelks1', 'Pele Lendária de Alce Katata', 100, 1, 'item_standard', 1, 362, 1, '{}', '', 0.25, 0),
	('legelks2', 'Pele lendária de alce Ozula', 100, 1, 'item_standard', 1, 363, 1, '{}', '', 0.25, 0),
	('legelks3', 'Legendary Inahme Elk pelt', 20, 1, 'item_standard', 1, 364, 1, '{}', 'An exquisite pelt from a legendary Inahme Elk', 0.25, 0),
	('legendbuckantler', 'Lendário Buck Antlers', 100, 1, 'item_standard', 1, 356, 1, '{}', '', 0.25, 0),
	('legendsnakes', 'Legendary Boa pelt', 100, 1, 'item_standard', 1, 418, 1, '{}', '', 0.25, 0),
	('legfoxs2', 'Pele de raposa de mármore lendária', 100, 1, 'item_standard', 1, 360, 1, '{}', '', 0.25, 0),
	('legfoxs3', 'Pele Lendária de Raposa Cruzada', 100, 1, 'item_standard', 1, 361, 1, '{}', '', 0.25, 0),
	('legfoxskin', 'Skin Lendária da Raposa', 100, 1, 'item_standard', 1, 413, 1, '{}', '', 0.25, 0),
	('leggbears', 'Pele de urso lendária', 100, 1, 'item_standard', 1, 404, 1, '{}', '', 0.25, 0),
	('legmooseantler', 'Chifres de Alce Lendários', 100, 1, 'item_standard', 1, 352, 1, '{}', '', 0.25, 0),
	('legmooses', 'Pele de alce lendária', 100, 1, 'item_standard', 1, 405, 1, '{}', '', 0.25, 0),
	('legmooses1', 'Pele de Alce Floco de Neve Lendária', 100, 1, 'item_standard', 1, 357, 1, '{}', '', 0.25, 0),
	('legmooses2', 'Pele Lendária de Alce Cavaleiro', 100, 1, 'item_standard', 1, 358, 1, '{}', '', 0.25, 0),
	('legmooses3', 'Pele lendária de Rudy Moose', 100, 1, 'item_standard', 1, 359, 1, '{}', '', 0.25, 0),
	('legpanthers1', 'Pele de Pantera Nightwalker Lendária', 100, 1, 'item_standard', 1, 383, 1, '{}', '', 0.25, 0),
	('legpanthers2', 'Pele Lendária de Iwakta Panther', 100, 1, 'item_standard', 1, 384, 1, '{}', '', 0.25, 0),
	('legpanthers3', 'Pele Lendária de Iwakta Panther', 100, 1, 'item_standard', 1, 385, 1, '{}', '', 0.25, 0),
	('legprongs', 'Pele Lendária Pronghorn', 100, 1, 'item_standard', 1, 407, 1, '{}', '', 0.25, 0),
	('legramhorn', 'Chifres de Carneiro Lendários', 100, 1, 'item_standard', 1, 354, 1, '{}', '', 0.25, 0),
	('legrams', 'Pele de Carneiro Lendária', 100, 1, 'item_standard', 1, 412, 1, '{}', '', 0.25, 0),
	('legrams1', 'Pele Lendária Gabbro Horn Ram', 100, 1, 'item_standard', 1, 372, 1, '{}', '', 0.25, 0),
	('legrams2', 'Pele de carneiro com chifre de giz lendária', 100, 1, 'item_standard', 1, 373, 1, '{}', '', 0.25, 0),
	('legrams3', 'Pele de carneiro com chifre de rutilo lendário', 100, 1, 'item_standard', 1, 374, 1, '{}', '', 0.25, 0),
	('legrams4', 'Pele Lendária de Carneiro Grande Chifre', 100, 1, 'item_standard', 1, 375, 1, '{}', '', 0.25, 0),
	('legwolfpelt', 'Pele de Lobo Lendário', 100, 1, 'item_standard', 1, 406, 1, '{}', '', 0.25, 0),
	('legwolfs1', 'Pele Lendária do Lobo Esmeralda', 100, 1, 'item_standard', 1, 380, 1, '{}', '', 0.25, 0),
	('legwolfs2', 'Pele lendária de lobo ônix', 100, 1, 'item_standard', 1, 381, 1, '{}', '', 0.25, 0),
	('legwolfs3', 'Pele Lendária do Lobo da Pedra da Lua', 100, 1, 'item_standard', 1, 382, 1, '{}', '', 0.25, 0),
	('lettuce', 'Alface', 100, 1, 'item_standard', 1, 216355, 1, '{}', 'nice item', 0.30, 0),
	('lighter', 'Isqueiro antigo', 100, 1, 'item_standard', 1, 215660, 1, '{}', 'nice item', 0.25, 0),
	('limao', 'limão', 100, 1, 'item_standard', 1, 17118, 1, '{}', '', 0.25, 0),
	('limao_seed', 'semente de limão', 100, 1, 'item_standard', 1, 17113, 1, '{}', '', 0.25, 0),
	('lime', 'Limão', 100, 1, 'item_standard', 1, 216343, 1, '{}', 'nice item', 0.30, 0),
	('limpacasco', 'Limpa casco', 100, 1, 'item_standard', 1, 215767, 1, '{}', 'nice item', 0.25, 0),
	('Livrofazendasvip', 'Livro de Produção Fazendas VIP', 100, 1, 'item_standard', 1, 1005, 1, '{}', '018', 0.25, 0),
	('lizardl', 'pé de lagarto', 100, 1, 'item_standard', 1, 554, 1, '{}', '', 0.25, 0),
	('lizards', 'pele de lagarto', 100, 1, 'item_standard', 1, 553, 1, '{}', '', 0.25, 0),
	('loadouts', 'Loadout', 20, 1, 'item_standard', 1, 17618, 1, '{}', 'nice item', 0.25, 0),
	('lockpick', 'Lockpick', 100, 1, 'item_standard', 1, 205, 1, '{}', '', 0.25, 0),
	('lockpickmold', 'Molde Lockpick', 100, 1, 'item_standard', 1, 206, 1, '{}', '', 0.25, 0),
	('logbechs', 'banco de toras 2', 100, 1, 'item_standard', 1, 775, 1, '{}', '', 0.25, 0),
	('logbench', 'Banco de toras 1', 100, 1, 'item_standard', 1, 774, 1, '{}', '', 0.25, 0),
	('log_bencha', 'Banco de toras 1', 100, 1, 'item_standard', 1, 646, 1, '{}', '', 0.25, 0),
	('log_benchb', 'banco de toras 2', 100, 1, 'item_standard', 1, 647, 1, '{}', '', 0.25, 0),
	('loonb', 'bico de mergulhão comum', 100, 1, 'item_standard', 1, 538, 1, '{}', '', 0.25, 0),
	('loonf', 'pena de mergulhão comum', 100, 1, 'item_standard', 1, 537, 1, '{}', '', 0.25, 0),
	('loungechair', 'Espreguiçadeira', 100, 1, 'item_standard', 1, 598, 1, '{}', '', 0.25, 0),
	('loungechair2', 'Espreguiçadeira 2', 100, 1, 'item_standard', 1, 599, 1, '{}', '', 0.25, 0),
	('lumberaxe', 'machado de madeira', 100, 1, 'item_standard', 1, 345, 1, '{}', '', 0.25, 0),
	('lumber_rubber', 'seiva', 100, 1, 'item_standard', 1, 216434, 1, '{}', 'nice item', 0.10, 0),
	('maca', 'Maçã', 100, 1, 'item_standard', 1, 216263, 1, '{}', 'nice item', 0.30, 0),
	('mackerel', 'Cavalinha', 100, 1, 'item_standard', 1, 207, 1, '{}', '', 0.25, 0),
	('madeira', 'madeira', 100, 1, 'item_standard', 1, 216412, 1, '{}', 'nice item', 1.00, 0),
	('madeira_cerno', 'madeira de cerno', 100, 1, 'item_standard', 1, 216413, 1, '{}', 'nice item', 1.00, 0),
	('magicitem', 'magicitem', 100, 1, 'item_standard', 1, 216003, 1, '{}', 'nice item', 0.10, 0),
	('magicitem2', 'magicitem2', 100, 1, 'item_standard', 1, 216004, 1, '{}', 'nice item', 0.20, 0),
	('magicpoison', 'Poção magica', 100, 1, 'item_standard', 1, 215832, 1, '{}', 'nice item', 0.25, 0),
	('maitake', 'Maitake', 100, 1, 'item_standard', 1, 216146, 1, '{}', 'nice item', 0.50, 0),
	('man_idcard', 'Identificação', 1, 1, 'item_standard', 1, 215653, 1, '{}', 'Identity card with information written on it', 0.25, 0),
	('map', 'map', 1, 1, 'item_standard', 1, 17094, 1, '{}', '', 0.25, 0),
	('map1', 'mapa 1', 100, 1, 'item_standard', 1, 215676, 1, '{}', 'nice item', 0.25, 0),
	('map10', 'mapa 10', 100, 1, 'item_standard', 1, 215685, 1, '{}', 'nice item', 0.25, 0),
	('map2', 'mapa 2', 100, 1, 'item_standard', 1, 215677, 1, '{}', 'nice item', 0.25, 0),
	('map3', 'mapa 3', 100, 1, 'item_standard', 1, 215678, 1, '{}', 'nice item', 0.25, 0),
	('map4', 'mapa 4', 100, 1, 'item_standard', 1, 215679, 1, '{}', 'nice item', 0.25, 0),
	('map5', 'mapa 5', 100, 1, 'item_standard', 1, 215680, 1, '{}', 'nice item', 0.25, 0),
	('map6', 'mapa 6', 100, 1, 'item_standard', 1, 215681, 1, '{}', 'nice item', 0.25, 0),
	('map7', 'mapa 7', 100, 1, 'item_standard', 1, 215682, 1, '{}', 'nice item', 0.25, 0),
	('map8', 'mapa 8', 100, 1, 'item_standard', 1, 215683, 1, '{}', 'nice item', 0.25, 0),
	('map9', 'mapa 9', 100, 1, 'item_standard', 1, 215684, 1, '{}', 'nice item', 0.25, 0),
	('mapa', 'mapa', 1, 1, 'item_standard', 1, 16726, 1, '{}', '', 0.25, 0),
	('mappa', 'mapa completo', 100, 1, 'item_standard', 1, 215686, 1, '{}', 'nice item', 0.25, 0),
	('Mariuhana', 'Maconha ', 100, 1, 'item_standard', 1, 215624, 1, '{}', 'nice item', 0.25, 0),
	('marriagebook', 'livro de casamento', 100, 1, 'item_standard', 1, 894, 1, '{}', '', 0.25, 0),
	('marriagecertification', 'Certidão de Casamento', 100, 1, 'item_standard', 1, 895, 1, '{}', '', 0.25, 0),
	('mascado', 'Tabacco mascado', 100, 1, 'item_standard', 1, 215648, 1, '{}', 'nice item', 0.25, 0),
	('mashalaskan', 'Purê de Gin do Alasca', 100, 1, 'item_standard', 1, 824, 1, '{}', '', 0.25, 0),
	('mashamerican', 'Purê de Gin do Alasca', 100, 1, 'item_standard', 1, 825, 1, '{}', '', 0.25, 0),
	('mashapple', 'purê de maçã', 100, 1, 'item_standard', 1, 826, 1, '{}', '', 0.25, 0),
	('mashblackberry', 'Purê de Amora', 100, 1, 'item_standard', 1, 827, 1, '{}', '', 0.25, 0),
	('mashblackberry90p', 'Puré De Amora 90p', 100, 1, 'item_standard', 1, 828, 1, '{}', '', 0.25, 0),
	('mashpeach', 'purê de pêssego', 100, 1, 'item_standard', 1, 829, 1, '{}', '', 0.25, 0),
	('mashplum', 'purê de ameixa', 100, 1, 'item_standard', 1, 830, 1, '{}', '', 0.25, 0),
	('mashraspberry', 'purê de framboesa', 100, 1, 'item_standard', 1, 831, 1, '{}', '', 0.25, 0),
	('mashraspberry90p', 'Purê de Framboesa 90p', 100, 1, 'item_standard', 1, 832, 1, '{}', '', 0.25, 0),
	('mashstrong', 'Lote de Mash Forte', 100, 1, 'item_standard', 1, 833, 1, '{}', '', 0.25, 0),
	('masks', 'Mask', 20, 1, 'item_standard', 1, 17634, 1, '{}', 'nice item', 0.25, 0),
	('meat', 'Carne', 30, 1, 'item_standard', 1, 208, 1, '{}', '', 0.25, 0),
	('med1', 'Faixa medica', 100, 1, 'item_standard', 1, 215849, 1, '{}', 'nice item', 0.25, 0),
	('melado_de_cana', 'melado de cana', 100, 1, 'item_standard', 1, 17056, 1, '{}', '', 0.25, 0),
	('melone', 'Melancia', 100, 1, 'item_standard', 1, 98683, 1, '{}', 'nice item', 0.25, 0),
	('menta_silvestre', 'Menta Silvestre', 100, 1, 'item_standard', 1, 216116, 1, '{}', 'nice item', 0.50, 0),
	('metal_gear', 'engrenagem de metal', 100, 1, 'item_standard', 1, 1665, 1, '{}', '', 0.25, 0),
	('metha', 'Methanfetamina', 100, 1, 'item_standard', 1, 16940, 1, '{}', '', 0.25, 0),
	('mexitillas', 'mexicanos', 100, 1, 'item_standard', 1, 1666, 1, '{}', '', 0.25, 0),
	('mexitillastaco', 'taco mexicano', 100, 1, 'item_standard', 1, 1667, 1, '{}', '', 0.25, 0),
	('milk', 'leite', 100, 1, 'item_standard', 1, 209, 1, '{}', '', 0.25, 0),
	('milkweedseed', 'Milkweed seed', 50, 1, 'item_standard', 1, 17686, 1, '{}', 'an item', 0.25, 0),
	('Milk_Weed', 'erva de leite', 100, 1, 'item_standard', 1, 210, 1, '{}', '', 0.25, 0),
	('Milk_Weed_Seed', 'semente de serralha', 100, 1, 'item_standard', 1, 211, 1, '{}', '', 0.25, 0),
	('mil_folhas', 'Mil-Folhas', 100, 1, 'item_standard', 1, 216122, 1, '{}', 'nice item', 0.50, 0),
	('mindmagic', 'Poção2', 100, 1, 'item_standard', 1, 215830, 1, '{}', 'nice item', 0.25, 0),
	('MinerHat1', 'Capacete de Minerador', 100, 1, 'item_standard', 1, 215697, 1, '{}', 'nice item', 0.25, 0),
	('minerio_de_cobre', 'minerio de cobre', 100, 1, 'item_standard', 1, 17054, 1, '{}', '', 0.25, 0),
	('minerio_de_ferro', 'minerio de ferro', 100, 1, 'item_standard', 1, 17055, 1, '{}', '', 0.25, 0),
	('minerio_de_prata', 'minerio de prata ', 100, 1, 'item_standard', 1, 16973, 1, '{}', '', 0.25, 0),
	('moneybagfv', 'Saco de Dinheiro de Bando', 100, 1, 'item_standard', 1, 170519, 1, '{}', 'nice item', 0.25, 0),
	('moneysujo', 'Dinheiro Sujo', 10000, 1, 'item_standard', 1, 170514, 1, '{}', 'nice item', 0.00, 0),
	('money_coin', 'Moeda', 100, 1, 'item_standard', 1, 1668, 1, '{}', '', 0.25, 0),
	('money_coinpurse', 'porta-moedas', 100, 1, 'item_standard', 1, 1669, 1, '{}', '', 0.25, 0),
	('moonshine', 'aguardente', 100, 1, 'item_standard', 1, 212, 1, '{}', '', 0.25, 0),
	('mooseantler', 'chifres de alce', 100, 1, 'item_standard', 1, 548, 1, '{}', '', 0.25, 0),
	('mooses', 'pele de alce', 100, 1, 'item_standard', 1, 549, 1, '{}', '', 0.25, 0),
	('morango', 'Morango', 100, 1, 'item_standard', 1, 98685, 1, '{}', 'nice item', 0.25, 0),
	('morango_Seed', 'Semente de Morango', 100, 1, 'item_standard', 1, 215797, 1, '{}', 'nice item', 0.25, 0),
	('morpcert', 'Prescrição de Morfina', 100, 1, 'item_standard', 1, 213, 1, '{}', '', 0.25, 0),
	('morphine', 'Prescrição de Morfina', 100, 1, 'item_standard', 1, 214, 1, '{}', '', 0.25, 0),
	('mountainmen', 'mountainmen', 100, 1, 'item_standard', 1, 608, 1, '{}', '', 0.25, 0),
	('mp001_p_mp_still02x', 'destilaria', 100, 1, 'item_standard', 1, 215, 1, '{}', '', 0.25, 0),
	('mud_bucket', 'Jaro 1', 100, 1, 'item_standard', 1, 98694, 1, '{}', 'nice item', 0.25, 0),
	('mushroom_chanterelles', 'Cogumelo Chanterelles', 100, 1, 'item_standard', 1, 216349, 1, '{}', 'nice item', 0.30, 0),
	('mushroom_parasol_mushroom', 'Cogumelo Guarda-sol', 100, 1, 'item_standard', 1, 216248, 1, '{}', 'nice item', 0.20, 0),
	('muskrats', 'Rato-Almiscarado', 100, 1, 'item_standard', 1, 547, 1, '{}', '', 1.50, 0),
	('Mutton', 'pork', 100, 1, 'item_standard', 1, 216, 1, '{}', '', 0.25, 0),
	('Na1', 'Aljava Lateral', 10, 1, 'item_standard', 1, 17473, 1, '{}', 'nice item', 0.25, 0),
	('Na2', 'Aljava traseira', 10, 1, 'item_standard', 1, 17474, 1, '{}', 'nice item', 0.25, 0),
	('Na3', 'Saco de cachimbo', 10, 1, 'item_standard', 1, 17475, 1, '{}', 'nice item', 0.25, 0),
	('Na4', 'Cachimbo da Paz', 10, 1, 'item_standard', 1, 17476, 1, '{}', 'nice item', 0.25, 0),
	('Na5', 'Pulseira de Penas', 10, 1, 'item_standard', 1, 17477, 1, '{}', 'nice item', 0.25, 0),
	('Na6', 'Peça de cabelo pena dourada', 10, 1, 'item_standard', 1, 17478, 1, '{}', 'nice item', 0.25, 0),
	('Na7', 'Acessório Tomahawk Antigo', 10, 1, 'item_standard', 1, 17479, 1, '{}', 'nice item', 0.25, 0),
	('Na8', 'Acessório de escudo e lança', 10, 1, 'item_standard', 1, 17480, 1, '{}', 'nice item', 0.25, 0),
	('nails', 'pregos', 100, 1, 'item_standard', 1, 217, 1, '{}', '', 0.25, 0),
	('nativearms', 'Native Arms Display', 100, 1, 'item_standard', 1, 216012, 1, '{}', 'nice item', 1.00, 0),
	('nativearrowdisplay', 'Native Arrow Display', 100, 1, 'item_standard', 1, 216007, 1, '{}', 'nice item', 1.00, 0),
	('nativebasket1', 'Cesta Nativa 1', 100, 1, 'item_standard', 1, 593, 1, '{}', '', 0.25, 0),
	('nativebasket2', 'Cesta Nativa 2', 100, 1, 'item_standard', 1, 594, 1, '{}', '', 0.25, 0),
	('nativebed', 'Native Bed', 100, 1, 'item_standard', 1, 216027, 1, '{}', 'nice item', 1.00, 0),
	('nativebench', 'Native Bench', 100, 1, 'item_standard', 1, 216021, 1, '{}', 'nice item', 1.00, 0),
	('nativebloodrock', 'Native Blood Rock', 100, 1, 'item_standard', 1, 216018, 1, '{}', 'nice item', 1.00, 0),
	('nativebowdisplay', 'Native Bow Display', 100, 1, 'item_standard', 1, 216016, 1, '{}', 'nice item', 1.00, 0),
	('nativebuckskull', 'Native Buck Skull', 100, 1, 'item_standard', 1, 216011, 1, '{}', 'nice item', 1.00, 0),
	('nativecage', 'Native Cage', 100, 1, 'item_standard', 1, 216024, 1, '{}', 'nice item', 1.00, 0),
	('nativechair', 'Native Chair', 100, 1, 'item_standard', 1, 216022, 1, '{}', 'nice item', 1.00, 0),
	('nativecookpot', 'Native Cook Pot', 100, 1, 'item_standard', 1, 216015, 1, '{}', 'nice item', 1.00, 0),
	('nativedecor', 'Conjunto de decoração nativa', 100, 1, 'item_standard', 1, 584, 1, '{}', '', 0.25, 0),
	('nativeelkcanvas', 'Native Elk Canvas', 100, 1, 'item_standard', 1, 216026, 1, '{}', 'nice item', 1.00, 0),
	('nativeleatherstand', 'Native Leather Stand', 100, 1, 'item_standard', 1, 216014, 1, '{}', 'nice item', 1.00, 0),
	('nativemask', 'Native Mask', 100, 1, 'item_standard', 1, 216010, 1, '{}', 'nice item', 1.00, 0),
	('nativeplatform', 'Native Platform', 100, 1, 'item_standard', 1, 216020, 1, '{}', 'nice item', 1.00, 0),
	('nativepot', 'panela nativa', 100, 1, 'item_standard', 1, 592, 1, '{}', '', 0.25, 0),
	('nativeskull', 'Decoração nativa 1', 100, 1, 'item_standard', 1, 595, 1, '{}', '', 0.25, 0),
	('nativeskullchair', 'Native Skull Chair', 100, 1, 'item_standard', 1, 216023, 1, '{}', 'nice item', 1.00, 0),
	('nativesmoker', 'Native Smoker', 100, 1, 'item_standard', 1, 216019, 1, '{}', 'nice item', 1.00, 0),
	('nativewickchair', 'Native Wick Chair', 100, 1, 'item_standard', 1, 216017, 1, '{}', 'nice item', 1.00, 0),
	('naturalwagon', 'Conjunto de Vagões de Naturalistas', 100, 1, 'item_standard', 1, 605, 1, '{}', '', 0.25, 0),
	('neckties', 'NeckTie', 20, 1, 'item_standard', 1, 17631, 1, '{}', 'nice item', 0.25, 0),
	('neckwear', 'Neckwear', 20, 1, 'item_standard', 1, 17632, 1, '{}', 'nice item', 0.25, 0),
	('NeedleandThread', 'Agulha e linha', 100, 1, 'item_standard', 1, 215786, 1, '{}', 'nice item', 0.25, 0),
	('newspaper', 'Jornal', 100, 1, 'item_standard', 1, 218, 1, '{}', '', 0.25, 0),
	('nightstand', 'Criado-mudo', 100, 1, 'item_standard', 1, 653, 1, '{}', '', 0.25, 0),
	('nitroglyserolia', 'Nitroglycerol', 100, 1, 'item_standard', 1, 220, 1, '{}', '', 0.25, 0),
	('nn1', 'Colar 1', 100, 1, 'item_standard', 1, 1250, 1, '{}', 'nice item', 0.25, 0),
	('nn10', 'Colar 10', 100, 1, 'item_standard', 1, 1251, 1, '{}', 'nice item', 0.25, 0),
	('nn11', 'Colar 11', 100, 1, 'item_standard', 1, 1252, 1, '{}', 'nice item', 0.25, 0),
	('nn12', 'Colar 12', 100, 1, 'item_standard', 1, 1253, 1, '{}', 'nice item', 0.25, 0),
	('nn13', 'Colar 13 Feminino', 100, 1, 'item_standard', 1, 1254, 1, '{}', 'nice item', 0.25, 0),
	('nn14', 'Colar 14  Feminino', 100, 1, 'item_standard', 1, 1255, 1, '{}', 'nice item', 0.25, 0),
	('nn15', 'Colar 15 Feminino', 100, 1, 'item_standard', 1, 1256, 1, '{}', 'nice item', 0.25, 0),
	('nn16', 'Colar 16 Feminino', 100, 1, 'item_standard', 1, 1257, 1, '{}', 'nice item', 0.25, 0),
	('nn17', 'Colar 17 Feminino', 100, 1, 'item_standard', 1, 1258, 1, '{}', 'nice item', 0.25, 0),
	('nn18', 'Colar 18 Feminino', 100, 1, 'item_standard', 1, 1259, 1, '{}', 'nice item', 0.25, 0),
	('nn19', 'Colar 19 Femino', 100, 1, 'item_standard', 1, 1260, 1, '{}', 'nice item', 0.25, 0),
	('nn2', 'Colar 2', 100, 1, 'item_standard', 1, 1261, 1, '{}', 'nice item', 0.25, 0),
	('nn20', 'Colar 20 Feminino', 100, 1, 'item_standard', 1, 1262, 1, '{}', 'nice item', 0.25, 0),
	('nn21', 'Colar 21 Feminino', 100, 1, 'item_standard', 1, 1263, 1, '{}', 'nice item', 0.25, 0),
	('nn22', 'Colar 22 Feminino', 100, 1, 'item_standard', 1, 1264, 1, '{}', 'nice item', 0.25, 0),
	('nn23', 'Colar 23 Feminino', 100, 1, 'item_standard', 1, 1265, 1, '{}', 'nice item', 0.25, 0),
	('nn24', 'Colar 24 Feminino', 100, 1, 'item_standard', 1, 1266, 1, '{}', 'nice item', 0.25, 0),
	('nn3', 'Colar 3', 100, 1, 'item_standard', 1, 1267, 1, '{}', 'nice item', 0.25, 0),
	('nn4', 'Colar 4', 100, 1, 'item_standard', 1, 1268, 1, '{}', 'nice item', 0.25, 0),
	('nn5', 'Colar 5', 100, 1, 'item_standard', 1, 1269, 1, '{}', 'nice item', 0.25, 0),
	('nn6', 'Colar 6', 100, 1, 'item_standard', 1, 1270, 1, '{}', 'nice item', 0.25, 0),
	('nn7', 'Colar 7', 100, 1, 'item_standard', 1, 1271, 1, '{}', 'nice item', 0.25, 0),
	('nn8', 'Colar 8', 100, 1, 'item_standard', 1, 1272, 1, '{}', 'nice item', 0.25, 0),
	('nn9', 'Colar 9', 100, 1, 'item_standard', 1, 1273, 1, '{}', 'nice item', 0.25, 0),
	('normaltable', 'Mesa', 100, 1, 'item_standard', 1, 750, 1, '{}', '', 0.25, 0),
	('notebook', 'planilia', 100, 1, 'item_standard', 1, 221, 1, '{}', '', 0.25, 0),
	('notepad', 'Bloco de anotações', 100, 1, 'item_standard', 1, 16966, 1, '{}', '', 0.25, 0),
	('ns1', 'Escudo 1', 100, 1, 'item_standard', 1, 215835, 1, '{}', 'nice item', 0.25, 0),
	('ns10', 'Escudo 10', 100, 1, 'item_standard', 1, 215844, 1, '{}', 'nice item', 0.25, 0),
	('ns11', 'Escudo 11', 100, 1, 'item_standard', 1, 215845, 1, '{}', 'nice item', 0.25, 0),
	('ns12', 'Escudo 12', 100, 1, 'item_standard', 1, 215846, 1, '{}', 'nice item', 0.25, 0),
	('ns13', 'Escudo 13', 100, 1, 'item_standard', 1, 215847, 1, '{}', 'nice item', 0.25, 0),
	('ns14', 'Escudo 14', 100, 1, 'item_standard', 1, 215848, 1, '{}', 'nice item', 0.25, 0),
	('ns2', 'Escudo 2', 100, 1, 'item_standard', 1, 215836, 1, '{}', 'nice item', 0.25, 0),
	('ns3', 'Escudo 3', 100, 1, 'item_standard', 1, 215837, 1, '{}', 'nice item', 0.25, 0),
	('ns4', 'Escudo 4', 100, 1, 'item_standard', 1, 215838, 1, '{}', 'nice item', 0.25, 0),
	('ns5', 'Escudo 5', 100, 1, 'item_standard', 1, 215839, 1, '{}', 'nice item', 0.25, 0),
	('ns6', 'Escudo 6', 100, 1, 'item_standard', 1, 215840, 1, '{}', 'nice item', 0.25, 0),
	('ns7', 'Escudo 7', 100, 1, 'item_standard', 1, 215841, 1, '{}', 'nice item', 0.25, 0),
	('ns8', 'Escudo 8 ', 100, 1, 'item_standard', 1, 215842, 1, '{}', 'nice item', 0.25, 0),
	('ns9', 'Escudo 9', 100, 1, 'item_standard', 1, 215843, 1, '{}', 'nice item', 0.25, 0),
	('obed', 'cama velha', 100, 1, 'item_standard', 1, 664, 1, '{}', '', 0.25, 0),
	('oil_lantern', 'Lanterna a óleo', 100, 1, 'item_standard', 1, 1672, 1, '{}', '', 0.25, 0),
	('oldwatch', 'Relogio Antigo', 100, 1, 'item_standard', 1, 215661, 1, '{}', 'nice item', 0.25, 0),
	('Oleander_Sage', 'Sálvia Oleandro', 100, 1, 'item_standard', 1, 222, 1, '{}', '', 0.25, 0),
	('Oleander_Sage_Seed', 'Semente de Sálvia Oleandro', 100, 1, 'item_standard', 1, 223, 1, '{}', '', 0.25, 0),
	('oleo', 'azeite ', 100, 1, 'item_standard', 1, 16799, 1, '{}', '', 0.25, 0),
	('oliva', 'oliva', 100, 1, 'item_standard', 1, 16798, 1, '{}', '', 0.25, 0),
	('oliveira', 'oliveira ', 100, 1, 'item_standard', 1, 16797, 1, '{}', '', 0.25, 0),
	('oliveira_seed', 'semente de oliva ', 100, 1, 'item_standard', 1, 17110, 1, '{}', '', 0.25, 0),
	('Onion', 'Oregano', 100, 1, 'item_standard', 1, 215817, 1, '{}', 'nice item', 0.25, 0),
	('Onion_Seed', 'Semente de Oregano', 100, 1, 'item_standard', 1, 215803, 1, '{}', 'nice item', 0.25, 0),
	('opium', 'Opium', 100, 1, 'item_standard', 1, 170518, 1, '{}', 'nice item', 0.25, 0),
	('opiumseed', 'Semente de Opium', 100, 1, 'item_standard', 1, 215799, 1, '{}', 'nice item', 0.25, 0),
	('opossumc', 'Gambá Morto', 100, 1, 'item_standard', 1, 515, 1, '{}', '', 1.80, 0),
	('opossums', 'Gambá', 100, 1, 'item_standard', 1, 514, 1, '{}', '', 1.80, 0),
	('orange', 'Laranja', 100, 1, 'item_standard', 1, 216340, 1, '{}', 'nice item', 0.50, 0),
	('orden_presidente', 'ordem do presidente', 100, 1, 'item_standard', 1, 224, 1, '{}', '', 0.25, 0),
	('Oregano', 'Orégano', 100, 1, 'item_standard', 1, 225, 1, '{}', '', 0.50, 0),
	('Oregano_Seed', 'semente de orégano', 100, 1, 'item_standard', 1, 226, 1, '{}', '', 0.25, 0),
	('oriole2_c', 'papa-figo encapuzado', 100, 1, 'item_standard', 1, 430, 1, '{}', '', 0.25, 0),
	('oriole_c', 'Oriole', 100, 1, 'item_standard', 1, 429, 1, '{}', '', 0.25, 0),
	('orleanderseed', 'Orleander seed', 50, 1, 'item_standard', 1, 17693, 1, '{}', 'an item', 0.25, 0),
	('orquidea_boca_dragao', 'Orquídea Boca-de-Dragão', 100, 1, 'item_standard', 1, 216148, 1, '{}', 'nice item', 0.50, 0),
	('orquidea_cauda_rato', 'Orquídea Cauda-de-Rato', 100, 1, 'item_standard', 1, 216134, 1, '{}', 'nice item', 0.50, 0),
	('orquidea_cheiro_noite', 'Orquídea Cheiro-da-Noite', 100, 1, 'item_standard', 1, 216128, 1, '{}', 'nice item', 0.50, 0),
	('orquidea_cometa', 'Orquídea Cometa', 100, 1, 'item_standard', 1, 216136, 1, '{}', 'nice item', 0.50, 0),
	('orquidea_dama_noite', 'Orquídea Dama-da-Noite', 100, 1, 'item_standard', 1, 216131, 1, '{}', 'nice item', 0.50, 0),
	('orquidea_fantasma', 'Orquídea Fantasma', 100, 1, 'item_standard', 1, 216129, 1, '{}', 'nice item', 0.50, 0),
	('orquidea_ovo_pardal', 'Orquídea Ovo-de-Pardal', 100, 1, 'item_standard', 1, 216143, 1, '{}', 'nice item', 0.50, 0),
	('orquidea_polvo', 'Orquídea-Polvo', 100, 1, 'item_standard', 1, 216130, 1, '{}', 'nice item', 0.50, 0),
	('orquidea_rainha', 'Orquídea Rainha', 100, 1, 'item_standard', 1, 216135, 1, '{}', 'nice item', 0.50, 0),
	('orquidea_sapatinho', 'Orquídea Sapatinho', 100, 1, 'item_standard', 1, 216141, 1, '{}', 'nice item', 0.50, 0),
	('orquidea_sapatos_venus', 'Orquídea Sapatinhos-de-Vênus', 100, 1, 'item_standard', 1, 216138, 1, '{}', 'nice item', 0.50, 0),
	('ossos_comun', 'osso comum', 100, 1, 'item_standard', 1, 17288, 1, '{}', 'nice item', 0.25, 0),
	('ossos_horse', 'osso de cavalo', 100, 1, 'item_standard', 1, 17287, 1, '{}', 'nice item', 0.25, 0),
	('ouro100', 'Vale 100 Gold', 5, 1, 'item_standard', 1, 1033, 1, '{}', 'nice item', 0.25, 0),
	('ouro200', 'Vale 200 Gold', 5, 1, 'item_standard', 1, 1034, 1, '{}', 'nice item', 0.25, 0),
	('ouro50', 'Vale 50 Gold', 5, 1, 'item_standard', 1, 1032, 1, '{}', 'nice item', 0.25, 0),
	('ouro500', 'Vale 500 Gold', 5, 1, 'item_standard', 1, 1035, 1, '{}', 'nice item', 0.25, 0),
	('ouromil', 'Vale 1000 Gold', 5, 1, 'item_standard', 1, 1036, 1, '{}', 'nice item', 0.25, 0),
	('outfit', 'outfit', 100, 1, 'item_standard', 1, 216033, 1, '{}', 'nice item', 0.25, 0),
	('ovelhafood', 'Ração para Ovelhas', 100, 1, 'item_standard', 1, 98354, 1, '{}', 'nice item', 0.25, 0),
	('Ovelhapronta', 'Carne de ovelha', 100, 1, 'item_standard', 1, 216619, 1, '{}', 'nice item', 0.25, 0),
	('owlf', 'pena de coruja', 100, 1, 'item_standard', 1, 539, 1, '{}', '', 0.25, 0),
	('owlt', 'garras de coruja', 100, 1, 'item_standard', 1, 540, 1, '{}', '', 0.25, 0),
	('oxhorn', 'chifre de touro angus', 100, 1, 'item_standard', 1, 545, 1, '{}', '', 0.25, 0),
	('oxs', 'pele de touro angus', 100, 1, 'item_standard', 1, 546, 1, '{}', '', 0.25, 0),
	('pac_eau', 'pac_eau', 100, 1, 'item_standard', 1, 215771, 1, '{}', 'nice item', 0.25, 0),
	('panela', 'panela', 1, 1, 'item_standard', 1, 17256, 1, '{}', 'nice item', 0.25, 0),
	('panfleto', 'Panfletos', 100, 1, 'item_standard', 1, 216624, 1, '{}', 'nice item', 0.25, 0),
	('panquecas', 'panquecas', 100, 1, 'item_standard', 1, 216418, 1, '{}', 'nice item', 0.10, 0),
	('panther', 'Pantera', 100, 1, 'item_standard', 1, 215961, 1, '{}', 'nice item', 0.25, 0),
	('panthere', 'Pantera', 100, 1, 'item_standard', 1, 564, 1, '{}', '', 5.00, 0),
	('panthers', 'pele de pantera', 100, 1, 'item_standard', 1, 563, 1, '{}', '', 0.25, 0),
	('pants', 'Pants', 20, 1, 'item_standard', 1, 17604, 1, '{}', 'nice item', 0.25, 0),
	('paobatata', 'Pao de Batata', 100, 1, 'item_standard', 1, 170478, 1, '{}', 'nice item', 0.25, 0),
	('paomel', 'Pao de Mel', 100, 1, 'item_standard', 1, 170483, 1, '{}', 'nice item', 0.25, 0),
	('paomilhomel', 'Pão de Milho com Mel', 100, 1, 'item_standard', 1, 170476, 1, '{}', 'nice item', 0.25, 0),
	('paoquebacon', 'Pao de milho queijo e bacon', 100, 1, 'item_standard', 1, 170479, 1, '{}', 'nice item', 0.25, 0),
	('paper', 'Papel', 100, 1, 'item_standard', 1, 227, 1, '{}', '', 0.25, 0),
	('papersign', 'Papel Assinado', 100, 1, 'item_standard', 1, 215811, 1, '{}', 'nice item', 0.25, 0),
	('papoula', 'Papoula', 100, 1, 'item_standard', 1, 215827, 1, '{}', 'nice item', 0.25, 0),
	('papoula_pradaria', 'Papoila da Pradaria', 100, 1, 'item_standard', 1, 216149, 1, '{}', 'nice item', 0.50, 0),
	('paquet_biscuit', 'paquet_biscuit', 100, 1, 'item_standard', 1, 215773, 1, '{}', 'nice item', 0.25, 0),
	('paquet_cigarette', 'paquet_cigarette', 100, 1, 'item_standard', 1, 215774, 1, '{}', 'nice item', 0.25, 0),
	('paquet_clou', 'paquet_clou', 100, 1, 'item_standard', 1, 215772, 1, '{}', 'nice item', 0.25, 0),
	('parasol', 'sombrinha', 100, 1, 'item_standard', 1, 343, 1, '{}', '', 0.25, 0),
	('Parasol_Mushroom', 'cogumelo guarda-sol', 100, 1, 'item_standard', 1, 228, 1, '{}', '', 0.25, 0),
	('Parasol_Mushroom_Seed', 'Semente de Cogumelo Parasol', 100, 1, 'item_standard', 1, 229, 1, '{}', '', 0.25, 0),
	('peach', 'Pêssego', 100, 1, 'item_standard', 1, 216356, 1, '{}', 'nice item', 0.50, 0),
	('peachseeds', 'semente de pera', 100, 1, 'item_standard', 1, 735, 1, '{}', '', 0.25, 0),
	('pear', 'Pera', 100, 1, 'item_standard', 1, 216345, 1, '{}', 'nice item', 0.50, 0),
	('pearl', 'Pérola', 100, 1, 'item_standard', 1, 1670, 1, '{}', '', 0.25, 0),
	('peasantb', 'bico de camponês', 100, 1, 'item_standard', 1, 518, 1, '{}', '', 0.25, 0),
	('peasantf', 'pena camponesa', 100, 1, 'item_standard', 1, 517, 1, '{}', '', 0.25, 0),
	('pecaris', 'pecaris', 100, 1, 'item_standard', 1, 550, 1, '{}', '', 0.25, 0),
	('pelicanb', 'bico de pelicano', 100, 1, 'item_standard', 1, 520, 1, '{}', '', 0.25, 0),
	('pelicanf', 'pena de pelicano', 100, 1, 'item_standard', 1, 519, 1, '{}', '', 0.25, 0),
	('pelle', 'pá de corte', 100, 1, 'item_standard', 1, 16733, 1, '{}', '', 0.25, 0),
	('pen', 'Caneta', 100, 1, 'item_standard', 1, 896, 1, '{}', '', 0.25, 0),
	('Pepper', 'Pimenta', 100, 1, 'item_standard', 1, 215818, 1, '{}', 'nice item', 0.25, 0),
	('Pepper_Seed', 'Semente de Pimentão', 100, 1, 'item_standard', 1, 215798, 1, '{}', 'nice item', 0.25, 0),
	('pequenino', 'Formula para encolher', 5, 1, 'item_standard', 1, 215671, 1, '{}', 'nice item', 0.25, 0),
	('pera', 'pera', 100, 1, 'item_standard', 1, 17116, 1, '{}', '', 0.25, 0),
	('pera_seed', 'semente de pera ', 100, 1, 'item_standard', 1, 17111, 1, '{}', '', 0.25, 0),
	('peyote', 'algo estranho', 100, 1, 'item_standard', 1, 16889, 1, '{}', '', 0.25, 0),
	('pheasant_taxidermy', 'Faisão Taxidermia', 100, 1, 'item_standard', 1, 641, 1, '{}', '', 0.25, 0),
	('phestaxi', 'Faisão Taxidermia', 100, 1, 'item_standard', 1, 769, 1, '{}', '', 0.25, 0),
	('phonograph', 'phonograph', 100, 1, 'item_standard', 1, 216611, 1, '{}', 'nice item', 0.25, 0),
	('pickaxe', 'picareta', 100, 1, 'item_standard', 1, 230, 1, '{}', '', 0.25, 0),
	('pigcrap', 'Pig Crap', 50, 1, 'item_standard', 1, 17685, 1, '{}', 'an item', 0.25, 0),
	('pigeon_c', 'Pombo', 100, 1, 'item_standard', 1, 431, 1, '{}', '', 0.25, 0),
	('pigs', 'pele de porco', 100, 1, 'item_standard', 1, 516, 1, '{}', '', 0.25, 0),
	('pigs_feet', 'Pé de Porco', 100, 1, 'item_standard', 1, 216361, 1, '{}', 'nice item', 1.20, 0),
	('pimenta', 'Pimenta', 100, 1, 'item_standard', 1, 215821, 1, '{}', 'nice item', 0.30, 0),
	('pimentao', 'Pimentão', 100, 1, 'item_standard', 1, 215819, 1, '{}', 'nice item', 0.25, 0),
	('pimentao_Seed', 'Semente de Pimentão', 100, 1, 'item_standard', 1, 215807, 1, '{}', 'nice item', 0.25, 0),
	('pimenta_Seed', 'Semente de Pimenta', 100, 1, 'item_standard', 1, 215794, 1, '{}', 'nice item', 0.25, 0),
	('pipe', 'Cachimbo', 1, 1, 'item_standard', 1, 231, 1, '{}', '', 0.25, 0),
	('pipecopper', 'Tubo de cobre', 100, 1, 'item_standard', 1, 835, 1, '{}', '', 0.25, 0),
	('pipe_smoker', 'Cachimbo', 100, 1, 'item_standard', 1, 215626, 1, '{}', 'To smoke with class', 0.25, 0),
	('piratecoin', 'Moeda de Pirata', 100, 1, 'item_standard', 1, 215662, 1, '{}', 'nice item', 0.25, 0),
	('pistolbarrel', 'cano de pistola', 100, 1, 'item_standard', 1, 17157, 1, '{}', '', 0.25, 0),
	('pistolgrip', 'cabo de pistola', 100, 1, 'item_standard', 1, 17158, 1, '{}', '', 0.25, 0),
	('pistolmold', 'molde de pistola', 100, 1, 'item_standard', 1, 17159, 1, '{}', '', 0.25, 0),
	('pistolreceiver', 'carregador de pistola', 100, 1, 'item_standard', 1, 17160, 1, '{}', '', 0.25, 0),
	('planttrimmer', 'tesoura de poda', 100, 1, 'item_standard', 1, 678, 1, '{}', '', 0.25, 0),
	('planttrimmer2', 'Aparador de plantas', 100, 1, 'item_standard', 1, 16710, 1, '{}', '', 0.25, 0),
	('plastico', 'plastico', 100, 1, 'item_standard', 1, 170500, 1, '{}', 'nice item', 0.10, 0),
	('pocket_compass', 'Bussula', 100, 1, 'item_standard', 1, 17292, 1, '{}', 'nice item', 0.25, 0),
	('pocket_watch', 'relogio de bolso', 2, 1, 'item_standard', 1, 232, 1, '{}', '', 0.25, 0),
	('poisonheal', 'Poção da vida', 100, 1, 'item_standard', 1, 215833, 1, '{}', 'nice item', 0.25, 0),
	('poisonItem', 'poisonItem', 100, 1, 'item_standard', 1, 216001, 1, '{}', 'nice item', 0.10, 0),
	('pokerset', 'Conjunto de mesa de pôquer', 100, 1, 'item_standard', 1, 579, 1, '{}', '', 0.25, 0),
	('polvora', 'polvora', 100, 1, 'item_standard', 1, 17162, 1, '{}', '', 0.25, 0),
	('pomade', 'pomada para cabelo', 100, 1, 'item_standard', 1, 16980, 1, '{}', '', 0.25, 0),
	('ponchos', 'Poncho', 20, 1, 'item_standard', 1, 17626, 1, '{}', 'nice item', 0.25, 0),
	('porcofood', 'Ração para Porcos', 100, 1, 'item_standard', 1, 98352, 1, '{}', 'nice item', 0.25, 0),
	('Porcopronta', 'Carne de porco', 100, 1, 'item_standard', 1, 216617, 1, '{}', 'nice item', 0.25, 0),
	('pork', 'Carne de porco', 100, 1, 'item_standard', 1, 571, 1, '{}', '', 0.25, 0),
	('porkfat', 'gordura de porco', 100, 1, 'item_standard', 1, 458, 1, '{}', '', 0.25, 0),
	('portable_canoe', 'Canoa Portátil', 100, 1, 'item_standard', 1, 16878, 1, '{}', '', 0.25, 0),
	('pot', 'pote de destilaria', 100, 1, 'item_standard', 1, 836, 1, '{}', '', 0.25, 0),
	('pota', 'panela de casa', 100, 1, 'item_standard', 1, 626, 1, '{}', '', 0.25, 0),
	('potato', 'Batata', 100, 1, 'item_standard', 1, 233, 1, '{}', '', 0.30, 0),
	('potatoseed', 'Batata Seed', 100, 1, 'item_standard', 1, 731, 1, '{}', '', 0.25, 0),
	('Potato_Seed', 'Semente de Batata', 100, 1, 'item_standard', 1, 215806, 1, '{}', 'nice item', 0.25, 0),
	('potion', 'potion', 100, 1, 'item_standard', 1, 216037, 1, '{}', 'nice item', 0.25, 0),
	('potion1', 'Poção do Lobo', 100, 1, 'item_standard', 1, 215764, 1, '{}', 'nice item', 0.25, 0),
	('potion10', 'Poção do Rato', 100, 1, 'item_standard', 1, 215778, 1, '{}', 'nice item', 0.25, 0),
	('potion2', 'Poção da Pantera', 100, 1, 'item_standard', 1, 215783, 1, '{}', 'nice item', 0.25, 0),
	('potion3', 'Poção do Pato', 100, 1, 'item_standard', 1, 215782, 1, '{}', 'nice item', 0.25, 0),
	('potion4', 'Poção da Rapoza', 100, 1, 'item_standard', 1, 215781, 1, '{}', 'nice item', 0.25, 0),
	('potion5', 'Poção da Coruja', 100, 1, 'item_standard', 1, 215780, 1, '{}', 'nice item', 0.25, 0),
	('potion55', 'Poção de Vampiro', 100, 1, 'item_standard', 1, 215834, 1, '{}', 'nice item', 0.25, 0),
	('potion6', 'Poção do Urso', 100, 1, 'item_standard', 1, 215779, 1, '{}', 'nice item', 0.25, 0),
	('potiontransformation', 'Poção de transformação', 100, 1, 'item_standard', 1, 17176, 1, '{}', '', 0.25, 0),
	('po_de_cafe', 'po de cafe ', 100, 1, 'item_standard', 1, 17221, 1, '{}', '', 0.25, 0),
	('prairib', 'Bico De Frango Da Pradaria', 100, 1, 'item_standard', 1, 509, 1, '{}', '', 0.25, 0),
	('Prairie_Poppy', 'oliva', 100, 1, 'item_standard', 1, 234, 1, '{}', '', 0.25, 0),
	('Prairie_Poppy_Seed', 'semente de papoula da pradaria', 100, 1, 'item_standard', 1, 235, 1, '{}', '', 0.25, 0),
	('prairif', 'Pena de Frango da Pradaria', 100, 1, 'item_standard', 1, 508, 1, '{}', '', 0.25, 0),
	('prancheta', 'Prancheta', 100, 1, 'item_standard', 1, 216654, 1, '{}', 'nice item', 0.25, 0),
	('printphoto', 'Foto de Bolso', 10, 1, 'item_standard', 1, 215655, 1, '{}', 'Identity photo', 0.25, 0),
	('Pripronta', 'Carne pronta', 100, 1, 'item_standard', 1, 216618, 1, '{}', 'nice item', 0.25, 0),
	('prison_clothes', 'roupa de prisão', 100, 1, 'item_standard', 1, 17294, 1, '{}', 'nice item', 0.25, 0),
	('pronghornh', 'Chifre Pronghorn', 100, 1, 'item_standard', 1, 511, 1, '{}', '', 0.25, 0),
	('prongs', 'Pele Pronghorn', 100, 1, 'item_standard', 1, 510, 1, '{}', '', 0.25, 0),
	('provision_arrowhead_agate', 'ponta de flecha ágata', 100, 1, 'item_standard', 1, 16720, 1, '{}', '', 0.25, 0),
	('provision_arrowhead_crude', 'ponta de flecha bruta', 100, 1, 'item_standard', 1, 1675, 1, '{}', '', 0.25, 0),
	('provision_arrowhead_feldspar', 'ponta de flecha de feldspato', 100, 1, 'item_standard', 1, 1676, 1, '{}', '', 0.25, 0),
	('provision_boar_skin', 'pele de javali', 100, 1, 'item_standard', 1, 17193, 1, '{}', '', 0.25, 0),
	('provision_bracelet_gold', 'Pulseira de ouro', 100, 1, 'item_standard', 1, 1685, 1, '{}', '', 0.25, 0),
	('provision_bracelet_platinum', 'pulseira de platina', 100, 1, 'item_standard', 1, 1686, 1, '{}', '', 0.25, 0),
	('provision_bracelet_silver', 'Bracelete de prata', 100, 1, 'item_standard', 1, 1687, 1, '{}', '', 0.25, 0),
	('provision_bra_shield', 'escudo de latão', 100, 1, 'item_standard', 1, 1688, 1, '{}', '', 0.25, 0),
	('provision_buckle_gold', 'fivela de ouro', 100, 1, 'item_standard', 1, 1689, 1, '{}', '', 0.25, 0),
	('provision_buckle_platinum', 'fivela de platina', 100, 1, 'item_standard', 1, 1690, 1, '{}', '', 0.25, 0),
	('provision_buckle_silver', 'fivela de prata', 100, 1, 'item_standard', 1, 1691, 1, '{}', '', 0.25, 0),
	('provision_calderon_cross', 'Cruz de madeira', 100, 1, 'item_standard', 1, 1692, 1, '{}', '', 0.25, 0),
	('provision_capitale', 'Capital', 100, 1, 'item_standard', 1, 1693, 1, '{}', '', 0.25, 0),
	('provision_coal', 'minerio de carvão', 100, 1, 'item_standard', 1, 16996, 1, '{}', '', 0.25, 0),
	('provision_coin_1700_ny_tkn', '1700 Token de Nova York', 100, 1, 'item_standard', 1, 1694, 1, '{}', '', 0.25, 0),
	('provision_coin_1787_cent_tkn', '1787 Token de um centavo', 100, 1, 'item_standard', 1, 1695, 1, '{}', '', 0.25, 0),
	('provision_coin_1789_pny', '1789 Penny', 100, 1, 'item_standard', 1, 1696, 1, '{}', '', 0.25, 0),
	('provision_coin_1792_lib_qtr', 'Bairro da Liberdade de 1792', 100, 1, 'item_standard', 1, 1697, 1, '{}', '', 0.25, 0),
	('provision_coin_1792_nickel', '1792 níquel', 100, 1, 'item_standard', 1, 1698, 1, '{}', '', 0.25, 0),
	('provision_coin_1792_qtr', '1792 trimestre', 100, 1, 'item_standard', 1, 1699, 1, '{}', '', 0.25, 0),
	('provision_coin_1794_slv_dlr', 'Dólar de Prata de 1794', 100, 1, 'item_standard', 1, 1700, 1, '{}', '', 0.25, 0),
	('provision_coin_1795_hlf_eag', '1795 meia águia', 100, 1, 'item_standard', 1, 1701, 1, '{}', '', 0.25, 0),
	('provision_coin_1796_hlf_pny', '1796 meio centavo', 100, 1, 'item_standard', 1, 1702, 1, '{}', '', 0.25, 0),
	('provision_coin_1797_gld_eag', '1797 Águia Dourada', 100, 1, 'item_standard', 1, 1703, 1, '{}', '', 0.25, 0),
	('provision_coin_1798_slv_dlr', 'Dólar de Prata de 1798', 100, 1, 'item_standard', 1, 1704, 1, '{}', '', 0.25, 0),
	('provision_coin_1800_five_dlr', '1800 cinco dólares', 100, 1, 'item_standard', 1, 1705, 1, '{}', '', 0.25, 0),
	('provision_coin_1800_gld_dlr', '1800 dólares de ouro', 100, 1, 'item_standard', 1, 1706, 1, '{}', '', 0.25, 0),
	('provision_coin_1800_gld_qtr', 'Quarto de ouro de 1800', 100, 1, 'item_standard', 1, 1707, 1, '{}', '', 0.25, 0),
	('provision_coin_1800_hlf_dime', '1800 Meia Moeda', 100, 1, 'item_standard', 1, 1708, 1, '{}', '', 0.25, 0),
	('provision_db_finger_bone', 'Osso', 100, 1, 'item_standard', 1, 1709, 1, '{}', '', 0.25, 0),
	('provision_diamond_ring', 'Anel de diamante', 100, 1, 'item_standard', 1, 1710, 1, '{}', '', 0.25, 0),
	('provision_disco_ammolite', 'amolita', 100, 1, 'item_standard', 1, 1711, 1, '{}', '', 0.25, 0),
	('provision_disco_ancient_eagle', 'Águia Antiga', 100, 1, 'item_standard', 1, 1712, 1, '{}', '', 0.25, 0),
	('provision_disco_ancient_necklace', 'colar antigo', 100, 1, 'item_standard', 1, 1713, 1, '{}', '', 0.25, 0),
	('provision_disco_fertility_statue', 'Estátua da Fertilidade', 100, 1, 'item_standard', 1, 1714, 1, '{}', '', 0.25, 0),
	('provision_disco_fluorite', 'fluorita', 100, 1, 'item_standard', 1, 1715, 1, '{}', '', 0.25, 0),
	('provision_disco_shrunken_head', 'Cabeça encolhida', 100, 1, 'item_standard', 1, 1716, 1, '{}', '', 0.25, 0),
	('provision_disco_urn', 'Urn', 100, 1, 'item_standard', 1, 1717, 1, '{}', '', 0.25, 0),
	('provision_disco_viking_comb', 'pente viking', 100, 1, 'item_standard', 1, 1718, 1, '{}', '', 0.25, 0),
	('provision_dog_tag', 'Dog Tag', 100, 1, 'item_standard', 1, 1719, 1, '{}', '', 0.25, 0),
	('provision_earring_gold', 'brinco de ouro', 100, 1, 'item_standard', 1, 1720, 1, '{}', '', 0.25, 0),
	('provision_earring_pearl', 'brinco de pérola', 100, 1, 'item_standard', 1, 1721, 1, '{}', '', 0.25, 0),
	('provision_earring_platinum', 'brinco de platina', 100, 1, 'item_standard', 1, 1722, 1, '{}', '', 0.25, 0),
	('provision_earring_silver', 'brinco de prata', 100, 1, 'item_standard', 1, 1723, 1, '{}', '', 0.25, 0),
	('provision_feather_owl', 'Pena de Coruja', 100, 1, 'item_standard', 1, 216369, 1, '{}', 'nice item', 0.20, 0),
	('provision_generic_key', 'Chave', 100, 1, 'item_standard', 1, 1724, 1, '{}', '', 0.25, 0),
	('provision_hrlm_brush_boar', 'escova de cerdas de javali', 100, 1, 'item_standard', 1, 1725, 1, '{}', '', 0.25, 0),
	('provision_hrlm_brush_ebony', 'escova de cabelo de ébano', 100, 1, 'item_standard', 1, 1726, 1, '{}', '', 0.25, 0),
	('provision_hrlm_brush_goathair', 'Escova de Pelo de Cabra', 100, 1, 'item_standard', 1, 1727, 1, '{}', '', 0.25, 0),
	('provision_hrlm_brush_horsehair', 'escova de cavalo', 100, 1, 'item_standard', 1, 1728, 1, '{}', '', 0.25, 0),
	('provision_hrlm_brush_rosewood', 'jacarandá', 100, 1, 'item_standard', 1, 1729, 1, '{}', '', 0.25, 0),
	('provision_hrlm_brush_rosewood_ng', 'Escova de cabelo de jacarandá da Nova Guiné', 100, 1, 'item_standard', 1, 1730, 1, '{}', '', 0.25, 0),
	('provision_hrlm_comb_boxwood', 'pente de buxo', 100, 1, 'item_standard', 1, 1731, 1, '{}', '', 0.25, 0),
	('provision_hrlm_comb_cherrywood', 'pente cerejeira', 100, 1, 'item_standard', 1, 1732, 1, '{}', '', 0.25, 0),
	('provision_hrlm_comb_ivory', 'pente de marfim', 100, 1, 'item_standard', 1, 1733, 1, '{}', '', 0.25, 0),
	('provision_hrlm_comb_tortoiseshell', 'pente de tartaruga', 100, 1, 'item_standard', 1, 1734, 1, '{}', '', 0.25, 0),
	('provision_hrlm_hairpin_ebony', 'grampo de cabelo de ébano', 100, 1, 'item_standard', 1, 1735, 1, '{}', '', 0.25, 0),
	('provision_hrlm_hairpin_ivory', 'grampo de marfim', 100, 1, 'item_standard', 1, 1736, 1, '{}', '', 0.25, 0),
	('provision_hrlm_hairpin_jade', 'Jade Hairpin', 100, 1, 'item_standard', 1, 1737, 1, '{}', '', 0.25, 0),
	('provision_hrlm_hairpin_metal', 'Gancho de metal', 100, 1, 'item_standard', 1, 1738, 1, '{}', '', 0.25, 0),
	('provision_hrlm_hairpin_wooden', 'Grampo de cabelo de madeira', 100, 1, 'item_standard', 1, 1739, 1, '{}', '', 0.25, 0),
	('provision_jail_keys', 'Chaves da Prisão', 100, 1, 'item_standard', 1, 236, 1, '{}', '', 0.25, 0),
	('provision_jewelry_amethyst_necklace', 'Colar Richelieu Ametista', 100, 1, 'item_standard', 1, 1740, 1, '{}', '', 0.25, 0),
	('provision_jewelry_blck_pearl_necklace', 'Colar de Pérolas Tuamotu', 100, 1, 'item_standard', 1, 1741, 1, '{}', '', 0.25, 0),
	('provision_jewelry_box', 'Caixa de jóias', 100, 1, 'item_standard', 1, 1742, 1, '{}', '', 0.25, 0),
	('provision_jewelry_carved_bracelet', 'Pulseira esculpida Elliston', 100, 1, 'item_standard', 1, 1743, 1, '{}', '', 0.25, 0),
	('provision_jewelry_coral_dngl_earring', 'Brincos Emmeline Coral', 100, 1, 'item_standard', 1, 1744, 1, '{}', '', 0.25, 0),
	('provision_jewelry_coral_ring', 'anel de coral Harland', 100, 1, 'item_standard', 1, 1745, 1, '{}', '', 0.25, 0),
	('provision_jewelry_dmnd_bngle_bracelet', 'Pulseira de rubi Abelló', 100, 1, 'item_standard', 1, 1746, 1, '{}', '', 0.25, 0),
	('provision_jewelry_dmnd_pendt_earring', 'Brincos de diamante Orchidée', 100, 1, 'item_standard', 1, 1747, 1, '{}', '', 0.25, 0),
	('provision_jewelry_elk_tooth_earring', 'Brincos de dente de lei', 100, 1, 'item_standard', 1, 1748, 1, '{}', '', 0.25, 0),
	('provision_jewelry_emerald_earring', 'Brincos Duquesa Esmeralda', 100, 1, 'item_standard', 1, 1749, 1, '{}', '', 0.25, 0),
	('provision_jewelry_emerald_ring', 'Bosque anel de esmeralda', 100, 1, 'item_standard', 1, 1750, 1, '{}', '', 0.25, 0),
	('provision_jewelry_french_dmnd_ring', 'Anel de Diamante Beaulieux', 100, 1, 'item_standard', 1, 1751, 1, '{}', '', 0.25, 0),
	('provision_jewelry_gld_bngle_bracelet', 'Pulseira Ojeda Ouro Rosa', 100, 1, 'item_standard', 1, 1752, 1, '{}', '', 0.25, 0),
	('provision_jewelry_gld_cross_necklace', 'Colar Cruz Ainsworth', 100, 1, 'item_standard', 1, 1753, 1, '{}', '', 0.25, 0),
	('provision_jewelry_gld_pearl_necklace', 'Colar de Pérolas Rou', 100, 1, 'item_standard', 1, 1754, 1, '{}', '', 0.25, 0),
	('provision_jewelry_gld_pendt_necklace', 'Colar Gosselin Ouro Branco', 100, 1, 'item_standard', 1, 1755, 1, '{}', '', 0.25, 0),
	('provision_jewelry_grnet_bracelet', 'Pulseira Dawn Garnet', 100, 1, 'item_standard', 1, 1756, 1, '{}', '', 0.25, 0),
	('provision_jewelry_grnet_post_earring', 'Brincos Harford Garnet', 100, 1, 'item_standard', 1, 1757, 1, '{}', '', 0.25, 0),
	('provision_jewelry_moon_ring', 'Anel de Pedra da Lua do Peregrino', 100, 1, 'item_standard', 1, 1758, 1, '{}', '', 0.25, 0),
	('provision_jewelry_mthr_pearl_necklace', 'Colar de Pérolas Pellé', 100, 1, 'item_standard', 1, 1759, 1, '{}', '', 0.25, 0),
	('provision_jewelry_onyx_ring', 'Anel de ônix Aubrey', 100, 1, 'item_standard', 1, 1760, 1, '{}', '', 0.25, 0),
	('provision_jewelry_pearl_bracelet', 'Pulseira Durant Pearl', 100, 1, 'item_standard', 1, 1761, 1, '{}', '', 0.25, 0),
	('provision_jewelry_pearl_earring', 'Brincos de pérola Josephine', 100, 1, 'item_standard', 1, 1762, 1, '{}', '', 0.25, 0),
	('provision_jewelry_pearl_ring', 'Anel de Pérola Bonnard', 100, 1, 'item_standard', 1, 1763, 1, '{}', '', 0.25, 0),
	('provision_jewelry_pers_turq_ring', 'Anel Turquesa Thorburn', 100, 1, 'item_standard', 1, 1764, 1, '{}', '', 0.25, 0),
	('provision_jewelry_porcelain_necklace', 'Colar de Ametista Braxton', 100, 1, 'item_standard', 1, 1765, 1, '{}', '', 0.25, 0),
	('provision_jewelry_qn_dmnd_earring', 'Brincos de diamante Royal Victoria', 100, 1, 'item_standard', 1, 1766, 1, '{}', '', 0.25, 0),
	('provision_jewelry_rudy_dngl_earring', 'Brincos de Rubi Beauchêne', 100, 1, 'item_standard', 1, 1767, 1, '{}', '', 0.25, 0),
	('provision_jewelry_slvr_pearl_necklace', 'colar de pérolas de prata', 100, 1, 'item_standard', 1, 1768, 1, '{}', '', 0.25, 0),
	('provision_jewelry_sphr_bngle_bracelet', 'Pulseira Greco Safira', 100, 1, 'item_standard', 1, 1769, 1, '{}', '', 0.25, 0),
	('provision_jewelry_sphr_bracelet', 'Helena Sapphire Bracelet', 100, 1, 'item_standard', 1, 1770, 1, '{}', '', 0.25, 0),
	('provision_jewelry_topaz_necklace', 'colar topázio dinamarquês', 100, 1, 'item_standard', 1, 1771, 1, '{}', '', 0.25, 0),
	('provision_jewelry_topaz_ring', 'Banais Topaz Ring', 100, 1, 'item_standard', 1, 1772, 1, '{}', '', 0.25, 0),
	('provision_jewelry_turquoise_bracelet', 'Infanta Turquoise Bracelet', 100, 1, 'item_standard', 1, 1773, 1, '{}', '', 0.25, 0),
	('provision_jewelry_turquoise_ring', 'Anel Magnata Turquesa', 100, 1, 'item_standard', 1, 1774, 1, '{}', '', 0.25, 0),
	('provision_jewelry_turq_stud_earring', 'Brincos Calumet Turquesa', 100, 1, 'item_standard', 1, 1775, 1, '{}', '', 0.25, 0),
	('provision_jewelry_whtgld_dmnd_ring', 'Sackville anel de diamante', 100, 1, 'item_standard', 1, 1776, 1, '{}', '', 0.25, 0),
	('provision_jewelry_wht_dmnd_earring', 'Brincos Endicott Diamante', 100, 1, 'item_standard', 1, 1777, 1, '{}', '', 0.25, 0),
	('provision_jewelry_ylwgld_dmnd_ring', 'anel de diamante Yates', 100, 1, 'item_standard', 1, 1778, 1, '{}', '', 0.25, 0),
	('provision_meat_prime_beef', 'carne ', 100, 1, 'item_standard', 1, 17142, 1, '{}', '', 0.25, 0),
	('provision_ring_platinum', 'anel de platina', 100, 1, 'item_standard', 1, 1779, 1, '{}', '', 0.25, 0),
	('provision_ro_flower_acunas_star', 'Orquídea Estrela Acunas', 100, 1, 'item_standard', 1, 1780, 1, '{}', '', 0.25, 0),
	('provision_ro_flower_cigar', 'orquídea charuto', 100, 1, 'item_standard', 1, 1781, 1, '{}', '', 0.25, 0),
	('provision_ro_flower_clamshell', 'Orquídea Clamshell', 100, 1, 'item_standard', 1, 1782, 1, '{}', '', 0.25, 0),
	('provision_ro_flower_dragons', 'dragão orquídea', 100, 1, 'item_standard', 1, 1783, 1, '{}', '', 0.25, 0),
	('provision_ro_flower_ghost', 'orquídea fantasma', 100, 1, 'item_standard', 1, 1784, 1, '{}', '', 0.25, 0),
	('provision_ro_flower_lady_of_night', 'Dama da Noite Orquídea', 100, 1, 'item_standard', 1, 1785, 1, '{}', '', 0.25, 0),
	('provision_ro_flower_lady_slipper', 'Senhora sapatinho orquídea', 100, 1, 'item_standard', 1, 1786, 1, '{}', '', 0.25, 0),
	('provision_ro_flower_moccasin', 'orquídea mocassim', 100, 1, 'item_standard', 1, 1787, 1, '{}', '', 0.25, 0),
	('provision_ro_flower_night_scented', 'Orquídea Perfumada Noturna', 100, 1, 'item_standard', 1, 1788, 1, '{}', '', 0.25, 0),
	('provision_ro_flower_queens', 'rainhas orquídea', 100, 1, 'item_standard', 1, 1789, 1, '{}', '', 0.25, 0),
	('provision_ro_flower_rat_tail', 'orquídea rabo de rato', 100, 1, 'item_standard', 1, 1790, 1, '{}', '', 0.25, 0),
	('provision_ro_flower_sparrows', 'Pardais Orquídea', 100, 1, 'item_standard', 1, 1791, 1, '{}', '', 0.25, 0),
	('provision_ro_flower_spider', 'orquídea aranha', 100, 1, 'item_standard', 1, 1792, 1, '{}', '', 0.25, 0),
	('provision_trinket_alligator_skin', 'pele de jacare', 100, 1, 'item_standard', 1, 16879, 1, '{}', '', 0.25, 0),
	('provision_wedding_ring_male', 'Anel de Ouro', 100, 1, 'item_standard', 1, 170520, 1, '{}', 'nice item', 0.25, 0),
	('pulp', 'Polpa', 100, 1, 'item_standard', 1, 237, 1, '{}', '', 0.25, 0),
	('pumpkin', 'Abóbora', 100, 1, 'item_standard', 1, 216352, 1, '{}', 'nice item', 0.70, 0),
	('punchitem', 'Mega soco', 100, 1, 'item_standard', 1, 215992, 1, '{}', 'nice item', 0.25, 0),
	('purse1', 'bolsa de mão 1', 10, 1, 'item_standard', 1, 909, 1, '{}', 'Pour rendre jalouse votre belle mère', 0.25, 0),
	('purse2', 'bolsa de mão 2', 10, 1, 'item_standard', 1, 910, 1, '{}', 'Vos copines vous', 0.25, 0),
	('purse3', 'bolsa de mão 3', 10, 1, 'item_standard', 1, 911, 1, '{}', 'Le tout dernier sac en vogue à StDenis', 0.25, 0),
	('purse4', 'bolsa de mão 4', 10, 1, 'item_standard', 1, 920, 1, '{}', 'Pour les soirées entre cowgirls', 0.25, 0),
	('p_baitBread01x', 'isca de pão', 100, 1, 'item_standard', 1, 838, 1, '{}', '', 0.25, 0),
	('p_baitCheese01x', 'isca de queijo', 100, 1, 'item_standard', 1, 16748, 1, '{}', '', 0.25, 0),
	('p_baitCorn01x', 'isca de milho', 100, 1, 'item_standard', 1, 16747, 1, '{}', '', 0.25, 0),
	('p_baitCricket01x', 'isca de críquete', 100, 1, 'item_standard', 1, 16750, 1, '{}', '', 0.25, 0),
	('p_baitWorm01x', 'isca de minhoca', 100, 1, 'item_standard', 1, 16749, 1, '{}', '', 0.25, 0),
	('p_barrelmoonshine', 'Barril', 100, 1, 'item_standard', 1, 238, 1, '{}', '', 0.25, 0),
	('p_copperpan02x', 'mesa cobre 2', 100, 1, 'item_standard', 1, 98692, 1, '{}', 'nice item', 0.25, 0),
	('p_crawdad01x', 'isca de lagostim', 100, 1, 'item_standard', 1, 16751, 1, '{}', '', 0.25, 0),
	('p_FinisdFishlure01x', 'isca de peixe', 100, 1, 'item_standard', 1, 16753, 1, '{}', '', 0.25, 0),
	('p_finisdfishlurelegendary01x', 'Isca de Peixe Lendária', 100, 1, 'item_standard', 1, 16756, 1, '{}', '', 0.25, 0),
	('p_finishdcrawd01x', 'isca lagosta', 100, 1, 'item_standard', 1, 16754, 1, '{}', '', 0.25, 0),
	('p_finishdcrawdlegendary01x', 'Isca Lendária de Lagostim', 100, 1, 'item_standard', 1, 16757, 1, '{}', '', 0.25, 0),
	('p_finishedragonfly01x', 'isca de libélula', 100, 1, 'item_standard', 1, 16752, 1, '{}', '', 0.25, 0),
	('p_finishedragonflylegendary01x', 'Isca Lendária de Libélula', 100, 1, 'item_standard', 1, 16755, 1, '{}', '', 0.25, 0),
	('p_goldcradlestand01x', 'mesa 1 ', 100, 1, 'item_standard', 1, 98691, 1, '{}', 'nice item', 0.25, 0),
	('p_lgoc_spinner_v4', 'Spinner V4', 100, 1, 'item_standard', 1, 16758, 1, '{}', '', 0.25, 0),
	('p_lgoc_spinner_v6', 'Spinner V6', 100, 1, 'item_standard', 1, 16759, 1, '{}', '', 0.25, 0),
	('p_parasol02x', 'sombrinha 2 ', 1, 1, 'item_standard', 1, 17675, 1, '{}', 'nice item', 0.25, 0),
	('p_pocketmirror01x', 'espelho de mão', 2, 1, 'item_standard', 1, 17298, 1, '{}', 'nice item', 0.25, 0),
	('quailb', 'bico de codorna', 100, 1, 'item_standard', 1, 471, 1, '{}', '', 0.25, 0),
	('quailf', 'pena de codorna', 100, 1, 'item_standard', 1, 470, 1, '{}', '', 0.25, 0),
	('quartz', 'Quartzo', 100, 1, 'item_standard', 1, 239, 1, '{}', '', 0.25, 0),
	('queijo', 'Queijo', 100, 1, 'item_standard', 1, 170511, 1, '{}', 'nice item', 0.25, 0),
	('quimicos', 'Quimicos', 100, 1, 'item_standard', 1, 16939, 1, '{}', '', 0.25, 0),
	('quinina_silvestre', 'Quinina Silvestre', 100, 1, 'item_standard', 1, 216150, 1, '{}', 'nice item', 0.50, 0),
	('rabbitpaw', 'Pata de Coelho', 100, 1, 'item_standard', 1, 507, 1, '{}', '', 0.50, 0),
	('rabbits', 'pele de coelho', 100, 1, 'item_standard', 1, 506, 1, '{}', '', 0.25, 0),
	('raccoons', 'Guaxinim', 100, 1, 'item_standard', 1, 504, 1, '{}', '', 2.00, 0),
	('raccoont', 'Guaxinim Morto', 100, 1, 'item_standard', 1, 505, 1, '{}', '', 2.00, 0),
	('raisin', 'passas', 100, 1, 'item_standard', 1, 1793, 1, '{}', '', 0.25, 0),
	('rajahdysoljy', 'óleo explosivo', 100, 1, 'item_standard', 1, 240, 1, '{}', '', 0.25, 0),
	('ramhorn', 'chifre de carneiro', 100, 1, 'item_standard', 1, 454, 1, '{}', '', 0.25, 0),
	('rams', 'Ram Pelt', 100, 1, 'item_standard', 1, 455, 1, '{}', '', 0.25, 0),
	('Rams_Head', 'cogumelo ostra', 100, 1, 'item_standard', 1, 241, 1, '{}', '', 0.25, 0),
	('Rams_Head_Seed', 'Rams Head Seed', 100, 1, 'item_standard', 1, 242, 1, '{}', '', 0.25, 0),
	('raspadinha', 'raspadinha', 5, 1, 'item_standard', 1, 17466, 1, '{}', 'nice item', 0.25, 0),
	('Raspberries Shrub', 'Arbusto De Framboesa', 100, 1, 'item_standard', 1, 16884, 1, '{}', '', 0.25, 0),
	('raspberryale', 'Framboesa', 100, 1, 'item_standard', 1, 243, 1, '{}', '', 0.25, 0),
	('rat_c', 'Rato Morto', 100, 1, 'item_standard', 1, 432, 1, '{}', '', 0.50, 0),
	('ravenc', 'garras de corvo', 100, 1, 'item_standard', 1, 502, 1, '{}', '', 0.25, 0),
	('ravenf', 'pena de corvo', 100, 1, 'item_standard', 1, 503, 1, '{}', '', 0.25, 0),
	('rawpetrol', 'oil barril', 100, 1, 'item_standard', 1, 17293, 1, '{}', 'nice item', 0.25, 0),
	('raw_bacon', 'bacon cru', 100, 1, 'item_standard', 1, 1794, 1, '{}', '', 0.25, 0),
	('raw_peanuts', 'Amendoim Cru', 100, 1, 'item_standard', 1, 216350, 1, '{}', 'nice item', 0.20, 0),
	('Receitas', 'Livro de Receitas', 100, 1, 'item_standard', 1, 17251, 1, '{}', 'nice item', 0.25, 0),
	('rectable', 'Mesa Retangular', 100, 1, 'item_standard', 1, 751, 1, '{}', '', 0.25, 0),
	('rectangle_table', 'Mesa Retangular', 100, 1, 'item_standard', 1, 623, 1, '{}', '', 0.25, 0),
	('Red_Raspberry', 'Framboesa Vermelha', 100, 1, 'item_standard', 1, 244, 1, '{}', '', 0.20, 0),
	('Red_Raspberry_Seed', 'semente de framboesa', 100, 1, 'item_standard', 1, 245, 1, '{}', '', 0.25, 0),
	('Red_Sage', 'Sálvia Vermelha', 100, 1, 'item_standard', 1, 246, 1, '{}', '', 0.25, 0),
	('Red_Sage_Seed', 'Semente de Sálvia Vermelha', 100, 1, 'item_standard', 1, 247, 1, '{}', '', 0.25, 0),
	('Relho', 'Relho para treino', 5, 1, 'item_standard', 1, 17097, 1, '{}', '', 0.25, 0),
	('remediopet', 'Remedio de Pet', 100, 1, 'item_standard', 1, 215809, 1, '{}', 'nice item', 0.25, 0),
	('Repair_Kit', 'Kit Reparo Carroça', 100, 1, 'item_standard', 1, 98686, 1, '{}', 'nice item', 0.25, 0),
	('repair_moonshine', 'Reparador de Moonshiner', 100, 1, 'item_standard', 1, 215974, 1, '{}', 'nice item', 0.25, 0),
	('repeaterbarrel', 'cano de repetidor', 100, 1, 'item_standard', 1, 248, 1, '{}', '', 0.25, 0),
	('repeatermold', 'Molde de Repetidor comum', 100, 1, 'item_standard', 1, 249, 1, '{}', '', 0.25, 0),
	('repeaterreceiver', 'Receptor Repetidor', 100, 1, 'item_standard', 1, 250, 1, '{}', '', 0.25, 0),
	('repeaterrecmold', 'Molde Receptor Repetidor ', 100, 1, 'item_standard', 1, 251, 1, '{}', '', 0.25, 0),
	('repeaterstock', 'cabo de repetidor', 100, 1, 'item_standard', 1, 252, 1, '{}', '', 0.25, 0),
	('Reseitas', 'livro de receitas', 100, 1, 'item_standard', 1, 17151, 1, '{}', '', 0.25, 0),
	('resource_antler_moose', 'Galhada de Alce', 100, 1, 'item_standard', 1, 215960, 1, '{}', 'nice item', 2.50, 0),
	('resource_claw_owl', 'Garra de Coruja', 100, 1, 'item_standard', 1, 216370, 1, '{}', 'nice item', 1.00, 0),
	('resource_claw_panther', 'Garra de Pantera', 100, 1, 'item_standard', 1, 215963, 1, '{}', 'nice item', 1.00, 0),
	('resource_coal', 'carvão', 100, 1, 'item_standard', 1, 216438, 1, '{}', 'nice item', 0.10, 0),
	('resource_empty_jar', 'Pote de Vidro', 100, 1, 'item_standard', 1, 216421, 1, '{}', 'nice item', 0.10, 0),
	('resource_head_goat', 'Cabeça de Cabra', 100, 1, 'item_standard', 1, 215936, 1, '{}', 'nice item', 3.00, 0),
	('resource_head_sheep', 'Cabeça de Ovelha', 100, 1, 'item_standard', 1, 216365, 1, '{}', 'nice item', 3.00, 0),
	('resource_hide_cow_bull', 'Couro de Touro', 100, 1, 'item_standard', 1, 215948, 1, '{}', 'nice item', 5.00, 0),
	('resource_horn_buffalo', 'Chifre de Búfalo', 100, 1, 'item_standard', 1, 215946, 1, '{}', 'nice item', 4.00, 0),
	('resource_iron', 'minerio de ferro ', 100, 1, 'item_standard', 1, 216437, 1, '{}', 'nice item', 0.10, 0),
	('resource_iron_bar', 'barra de ferro', 100, 1, 'item_standard', 1, 216436, 1, '{}', 'nice item', 0.10, 0),
	('resource_nails', 'pegos', 100, 1, 'item_standard', 1, 216432, 1, '{}', 'nice item', 0.10, 0),
	('resource_pelt_badger', 'Pele de Texugo', 100, 1, 'item_standard', 1, 215941, 1, '{}', 'nice item', 2.50, 0),
	('resource_pelt_beaver', 'Pele de Castor', 100, 1, 'item_standard', 1, 215943, 1, '{}', 'nice item', 2.50, 0),
	('resource_pelt_coyote', 'Pele de Coiote', 100, 1, 'item_standard', 1, 215950, 1, '{}', 'nice item', 2.40, 0),
	('resource_pelt_fox', 'Pele de Raposa', 100, 1, 'item_standard', 1, 215954, 1, '{}', 'nice item', 2.50, 0),
	('resource_pelt_rabbit', 'Pele de Coelho', 100, 1, 'item_standard', 1, 216363, 1, '{}', 'nice item', 1.50, 0),
	('resource_pelt_wolf', 'Pele de Lobo', 100, 1, NULL, NULL, 216623, 1, '{}', 'nice item', 0.25, 0),
	('resource_shell_turtle', 'Casco de Tartaruga', 100, 1, 'item_standard', 1, 216621, 1, '{}', 'nice item', 0.25, 0),
	('resource_skin_buffalo', 'Pele de Búfalo', 100, 1, 'item_standard', 1, 215947, 1, '{}', 'nice item', 6.00, 0),
	('resource_skin_desert_iguana', 'Pele de Iguana do Deserto', 100, 1, 'item_standard', 1, 215958, 1, '{}', 'nice item', 0.25, 0),
	('resource_skin_elk', 'Pele de Veado', 100, 1, 'item_standard', 1, 216620, 1, '{}', 'nice item', 0.25, 0),
	('resource_skin_goat', 'Pele de Cabra', 100, 1, 'item_standard', 1, 215935, 1, '{}', 'nice item', 2.00, 0),
	('resource_skin_iguana_green', 'Pele de Iguana Verde', 100, 1, 'item_standard', 1, 215957, 1, '{}', 'nice item', 0.25, 0),
	('resource_skin_javelina_boar', 'Pele de Javali', 100, 1, 'item_standard', 1, 215944, 1, '{}', 'nice item', 3.50, 0),
	('resource_skin_moose', 'Pele de Alce', 100, 1, 'item_standard', 1, 215959, 1, '{}', 'nice item', 3.50, 0),
	('resource_skin_panther', 'Pele de Pantera', 100, 1, 'item_standard', 1, 215962, 1, '{}', 'nice item', 3.00, 0),
	('resource_skin_pig', 'Pele de Porco', 100, 1, 'item_standard', 1, 216360, 1, '{}', 'nice item', 2.00, 0),
	('resource_skin_snake_blacktail_rattlesnake', 'Pele de Cascavel', 100, 1, 'item_standard', 1, 216368, 1, '{}', 'nice item', 1.50, 0),
	('resource_tail_beaver', 'Rabo de Castor', 100, 1, 'item_standard', 1, 215942, 1, '{}', 'nice item', 1.00, 0),
	('resource_tooth_alligator', 'Dente de Jacaré', 100, 1, 'item_standard', 1, 215940, 1, '{}', 'nice item', 0.50, 0),
	('resource_wool', 'Lã', 100, 1, 'item_standard', 1, 216364, 1, '{}', 'nice item', 2.00, 0),
	('revolverbarrel', 'cano do revólver', 100, 1, 'item_standard', 1, 253, 1, '{}', '', 0.25, 0),
	('revolvercylinder', 'cilindro do revólver', 100, 1, 'item_standard', 1, 254, 1, '{}', '', 0.25, 0),
	('revolverhandle', 'cabo de revólver', 100, 1, 'item_standard', 1, 255, 1, '{}', '', 0.25, 0),
	('revolvermold', 'molde de revólver', 100, 1, 'item_standard', 1, 256, 1, '{}', '', 0.25, 0),
	('rhum', 'rum', 100, 1, 'item_standard', 1, 17170, 1, '{}', '', 0.25, 0),
	('riflebarrel', 'cano da rifle', 100, 1, 'item_standard', 1, 257, 1, '{}', '', 0.25, 0),
	('riflemold', 'molde de rifle', 100, 1, 'item_standard', 1, 258, 1, '{}', '', 0.25, 0),
	('riflereceiver', 'Receptor de Rifle', 100, 1, 'item_standard', 1, 259, 1, '{}', '', 0.25, 0),
	('riflerecmold', 'Molde Receptor de Rifle', 100, 1, 'item_standard', 1, 260, 1, '{}', '', 0.25, 0),
	('riflestock', 'cabo de Rifle', 100, 1, 'item_standard', 1, 261, 1, '{}', '', 0.25, 0),
	('roach', 'Barata', 100, 1, 'item_standard', 1, 262, 1, '{}', '', 0.25, 0),
	('robberyplanning', 'Conjunto de Planejamento de Roubo', 100, 1, 'item_standard', 1, 604, 1, '{}', '', 0.25, 0),
	('robin_c', 'Robin', 100, 1, 'item_standard', 1, 433, 1, '{}', '', 0.25, 0),
	('rock', 'pedra', 100, 1, 'item_standard', 1, 263, 1, '{}', '', 0.25, 0),
	('rollingpaper', 'Papel de enrolar', 100, 1, 'item_standard', 1, 264, 1, '{}', '', 0.25, 0),
	('rope', 'corda', 100, 1, 'item_standard', 1, 16813, 1, '{}', '', 0.25, 0),
	('roundtable', 'Mesa redonda', 100, 1, 'item_standard', 1, 749, 1, '{}', '', 0.25, 0),
	('round_table', 'Mesa redonda', 100, 1, 'item_standard', 1, 621, 1, '{}', '', 0.25, 0),
	('rspoonb', 'Roseta Spoonbill beak', 100, 1, 'item_standard', 1, 497, 1, '{}', '', 0.25, 0),
	('rspoonf', 'Roseta Spoonbill feather', 100, 1, 'item_standard', 1, 496, 1, '{}', '', 0.25, 0),
	('rubber', 'borracha', 100, 1, 'item_standard', 1, 265, 1, '{}', '', 0.25, 0),
	('rubber.', 'borracha', 100, 1, 'item_standard', 1, 216435, 1, '{}', 'nice item', 0.10, 0),
	('rubbertube', 'Tubo de borracha', 100, 1, 'item_standard', 1, 841, 1, '{}', '', 0.25, 0),
	('rumbarrel', 'barril de rum', 1, 1, 'item_standard', 1, 17271, 1, '{}', 'nice item', 0.25, 0),
	('rumrecipe', 'Recipiente para rum', 1, 1, 'item_standard', 1, 17267, 1, '{}', 'nice item', 0.25, 0),
	('r_bracelet1', 'Gold Bracelet', 10, 1, 'item_standard', 1, 17543, 1, '{}', 'nice item', 0.25, 0),
	('r_bracelet2', 'Platinum Bracelet', 10, 1, 'item_standard', 1, 17544, 1, '{}', 'nice item', 0.25, 0),
	('r_bracelet3', 'Silver Bracelet', 10, 1, 'item_standard', 1, 17545, 1, '{}', 'nice item', 0.25, 0),
	('r_bracelet4', 'Penelope Bracelet', 10, 1, 'item_standard', 1, 17546, 1, '{}', 'nice item', 0.25, 0),
	('r_chest1', 'Chest 1', 10, 1, 'item_standard', 1, 98696, 1, '{}', 'nice item', 0.25, 0),
	('r_chest10', 'Chest 10', 10, 1, 'item_standard', 1, 98705, 1, '{}', 'nice item', 0.25, 0),
	('r_chest11', 'Chest 11', 10, 1, 'item_standard', 1, 98706, 1, '{}', 'nice item', 0.25, 0),
	('r_chest12', 'Chest 12', 10, 1, 'item_standard', 1, 98707, 1, '{}', 'nice item', 0.25, 0),
	('r_chest13', 'Chest 13', 10, 1, 'item_standard', 1, 98708, 1, '{}', 'nice item', 0.25, 0),
	('r_chest14', 'Chest 14', 10, 1, 'item_standard', 1, 98709, 1, '{}', 'nice item', 0.25, 0),
	('r_chest15', 'Chest 15', 10, 1, 'item_standard', 1, 98710, 1, '{}', 'nice item', 0.25, 0),
	('r_chest2', 'Chest 2', 10, 1, 'item_standard', 1, 98697, 1, '{}', 'nice item', 0.25, 0),
	('r_chest3', 'Chest 3', 10, 1, 'item_standard', 1, 98698, 1, '{}', 'nice item', 0.25, 0),
	('r_chest4', 'Chest 4', 10, 1, 'item_standard', 1, 98699, 1, '{}', 'nice item', 0.25, 0),
	('r_chest5', 'Chest 5', 10, 1, 'item_standard', 1, 98700, 1, '{}', 'nice item', 0.25, 0),
	('r_chest6', 'Chest 6', 10, 1, 'item_standard', 1, 98701, 1, '{}', 'nice item', 0.25, 0),
	('r_chest7', 'Chest 7', 10, 1, 'item_standard', 1, 98702, 1, '{}', 'nice item', 0.25, 0),
	('r_chest8', 'Chest 8', 10, 1, 'item_standard', 1, 98703, 1, '{}', 'nice item', 0.25, 0),
	('r_chest9', 'Chest 9', 10, 1, 'item_standard', 1, 98704, 1, '{}', 'nice item', 0.25, 0),
	('r_compass1', 'Brass Compass', 10, 1, 'item_standard', 1, 17523, 1, '{}', 'nice item', 0.25, 0),
	('r_compass2', 'Naval Compass', 10, 1, 'item_standard', 1, 17524, 1, '{}', 'nice item', 0.25, 0),
	('r_earring1', 'Silver Earring', 10, 1, 'item_standard', 1, 17553, 1, '{}', 'nice item', 0.25, 0),
	('r_earring2', 'Platinum Earring', 10, 1, 'item_standard', 1, 17554, 1, '{}', 'nice item', 0.25, 0),
	('r_earring3', 'Pearl Earring', 10, 1, 'item_standard', 1, 17555, 1, '{}', 'nice item', 0.25, 0),
	('r_earring4', 'Gold Earring', 10, 1, 'item_standard', 1, 17556, 1, '{}', 'nice item', 0.25, 0),
	('r_necklace1', 'Penelope Necklace', 10, 1, 'item_standard', 1, 17547, 1, '{}', 'nice item', 0.25, 0),
	('r_necklace2', 'Silver Necklace', 10, 1, 'item_standard', 1, 17548, 1, '{}', 'nice item', 0.25, 0),
	('r_necklace3', 'Platinum Necklace', 10, 1, 'item_standard', 1, 17549, 1, '{}', 'nice item', 0.25, 0),
	('r_necklace4', 'Pearl Necklace', 10, 1, 'item_standard', 1, 17550, 1, '{}', 'nice item', 0.25, 0),
	('r_necklace5', 'Gold Necklace', 10, 1, 'item_standard', 1, 17551, 1, '{}', 'nice item', 0.25, 0),
	('r_necklace6', 'Necklace', 10, 1, 'item_standard', 1, 17552, 1, '{}', 'nice item', 0.25, 0),
	('r_other1', 'Thimbleab', 10, 1, 'item_standard', 1, 17532, 1, '{}', 'nice item', 0.25, 0),
	('r_other2', 'Silver Tooth', 10, 1, 'item_standard', 1, 17533, 1, '{}', 'nice item', 0.25, 0),
	('r_other3', 'Reading Glasses', 10, 1, 'item_standard', 1, 17534, 1, '{}', 'nice item', 0.25, 0),
	('r_other4', 'Marys Brooch', 10, 1, 'item_standard', 1, 17535, 1, '{}', 'nice item', 0.25, 0),
	('r_other5', 'Silver Locket', 10, 1, 'item_standard', 1, 17536, 1, '{}', 'nice item', 0.25, 0),
	('r_other6', 'Emerald Locket', 10, 1, 'item_standard', 1, 17537, 1, '{}', 'nice item', 0.25, 0),
	('r_other7', 'Bra Shield', 10, 1, 'item_standard', 1, 17538, 1, '{}', 'nice item', 0.25, 0),
	('r_other8', 'Beaus Gift', 10, 1, 'item_standard', 1, 17539, 1, '{}', 'nice item', 0.25, 0),
	('r_other9', 'Asteroid Chunk', 10, 1, 'item_standard', 1, 17540, 1, '{}', 'nice item', 0.25, 0),
	('r_ring1', 'Diamond Ring', 10, 1, 'item_standard', 1, 17541, 1, '{}', 'nice item', 0.25, 0),
	('r_ring2', 'Marys Ring', 10, 1, 'item_standard', 1, 17542, 1, '{}', 'nice item', 0.25, 0),
	('r_watch1', 'Pocket Watch 1', 10, 1, 'item_standard', 1, 17525, 1, '{}', 'nice item', 0.25, 0),
	('r_watch2', 'Catcher Pocket Watch', 10, 1, 'item_standard', 1, 17526, 1, '{}', 'nice item', 0.25, 0),
	('r_watch3', 'Silver Pocket Watch', 10, 1, 'item_standard', 1, 17527, 1, '{}', 'nice item', 0.25, 0),
	('r_watch4', 'Reutlinge Pocket Watch', 10, 1, 'item_standard', 1, 17528, 1, '{}', 'nice item', 0.25, 0),
	('r_watch5', 'Platinum Pocket Watch', 10, 1, 'item_standard', 1, 17529, 1, '{}', 'nice item', 0.25, 0),
	('r_watch6', 'Gold Pocket Watch', 10, 1, 'item_standard', 1, 17530, 1, '{}', 'nice item', 0.25, 0),
	('r_watch7', 'Gleaming Brass Pocket Watch', 10, 1, 'item_standard', 1, 17531, 1, '{}', 'nice item', 0.25, 0),
	('sacclasse', 'Bolsa 1', 10, 1, 'item_standard', 1, 914, 1, '{}', 'Inspiré par un sac ayant appartenu à quelqu\'un d\'important...', 0.25, 0),
	('sacodedinheio', 'Saco de Dinheiro Sujo', 100, 1, 'item_standard', 1, 170515, 1, '{}', 'nice item', 0.25, 0),
	('saco_vazio', 'saco vazio', 100, 1, 'item_standard', 1, 16800, 1, '{}', '', 0.25, 0),
	('sactravail', 'Bolsa de Trabalho', 10, 1, 'item_standard', 1, 913, 1, '{}', 'Un sac parfait pour partir au bureau de bonne heure.', 0.25, 0),
	('sac_tabac', 'saco de tabaco', 100, 1, 'item_standard', 1, 16893, 1, '{}', '', 0.25, 0),
	('saddlebag', 'bolsa ', 100, 1, 'item_standard', 1, 16943, 1, '{}', '', 0.25, 0),
	('saintdeniskey', 'Chave de Saint Denis', 100, 1, 'item_standard', 1, 215663, 1, '{}', 'nice item', 0.25, 0),
	('salamelle', 'carne de porco fresca', 100, 1, 'item_standard', 1, 266, 1, '{}', '', 0.25, 0),
	('salitre', 'salitre', 100, 1, 'item_standard', 1, 219, 1, '{}', '', 0.25, 0),
	('salmon', 'Salmão', 100, 1, 'item_standard', 1, 267, 1, '{}', '', 0.25, 0),
	('salt', 'sal', 100, 1, 'item_standard', 1, 268, 1, '{}', '', 0.10, 0),
	('Saltbush', 'erva-sal', 100, 1, 'item_standard', 1, 269, 1, '{}', '', 0.25, 0),
	('Saltbush_Seed', 'semente de erva-sal', 100, 1, 'item_standard', 1, 270, 1, '{}', '', 0.25, 0),
	('salvia', 'Sálvia', 100, 1, 'item_standard', 1, 216125, 1, '{}', 'nice item', 0.50, 0),
	('salvia_deserto', 'Sálvia do Deserto', 100, 1, 'item_standard', 1, 216153, 1, '{}', 'nice item', 0.50, 0),
	('salvia_oleandro', 'Sálvia Oleandro', 100, 1, 'item_standard', 1, 216126, 1, '{}', 'nice item', 0.50, 0),
	('salvia_vermelha', 'Sálvia Vermelha', 100, 1, 'item_standard', 1, 216151, 1, '{}', 'nice item', 0.50, 0),
	('sandbag', 'Saco de areia', 100, 1, 'item_standard', 1, 1795, 1, '{}', '', 0.25, 0),
	('sandpaper', 'Lixa', 100, 1, 'item_standard', 1, 1796, 1, '{}', '', 0.25, 0),
	('sangue', 'Sangue', 100, 1, 'item_standard', 1, 216000, 1, '{}', 'nice item', 0.20, 0),
	('sap', 'Seiva', 100, 1, 'item_standard', 1, 271, 1, '{}', '', 1.00, 0),
	('sarsaparilla', 'Cerveja artesanal', 100, 1, 'item_standard', 1, 272, 1, '{}', '', 0.25, 0),
	('satchels', 'Satchel', 20, 1, 'item_standard', 1, 17617, 1, '{}', 'nice item', 0.25, 0),
	('scale', 'Escala', 100, 1, 'item_standard', 1, 273, 1, '{}', '', 0.25, 0),
	('Scalp1', 'Scalp1', 100, 1, 'item_standard', 1, 215707, 1, '{}', 'nice item', 0.25, 0),
	('Scalp2', 'Scalp2', 100, 1, 'item_standard', 1, 215708, 1, '{}', 'nice item', 0.25, 0),
	('Scalp3', 'Scalp3', 100, 1, 'item_standard', 1, 215709, 1, '{}', 'nice item', 0.25, 0),
	('Scalp4', 'Scalp4', 100, 1, 'item_standard', 1, 215710, 1, '{}', 'nice item', 0.25, 0),
	('Scalp5', 'Scalp5', 100, 1, 'item_standard', 1, 215711, 1, '{}', 'nice item', 0.25, 0),
	('Scalp6', 'Scalp6', 100, 1, 'item_standard', 1, 215712, 1, '{}', 'nice item', 0.25, 0),
	('Scalp7', 'Scalp7', 100, 1, 'item_standard', 1, 215713, 1, '{}', 'nice item', 0.25, 0),
	('Scalp8', 'Scalp8', 100, 1, 'item_standard', 1, 215714, 1, '{}', 'nice item', 0.25, 0),
	('scentg', 'glândula de cheiro', 100, 1, 'item_standard', 1, 492, 1, '{}', '', 0.25, 0),
	('scratchcard', 'raspadinha', 10, 1, 'item_standard', 1, 16984, 1, '{}', '', 0.25, 0),
	('scr_adv_sok_torchsmoke', 'scr_adv_sok_torchsmoke', 100, 1, 'item_standard', 1, 16898, 1, '{}', '', 0.25, 0),
	('seagullb', 'bico de gaivota', 100, 1, 'item_standard', 1, 495, 1, '{}', '', 0.25, 0),
	('seagullf', 'pena de gaivota', 100, 1, 'item_standard', 1, 494, 1, '{}', '', 0.25, 0),
	('secondchance', 'Segunda chance', 100, 1, 'item_standard', 1, 274, 1, '{}', '', 0.25, 0),
	('segundachanse', 'Sua segunda chanse', 100, 1, 'item_standard', 1, 215770, 1, '{}', 'nice item', 0.25, 0),
	('semente_abobora', 'Semente de Abóbora', 100, 1, 'item_standard', 1, 216332, 1, '{}', 'nice item', 0.10, 0),
	('semente_agarita', 'Semente de Agarita', 100, 1, 'item_standard', 1, 216235, 1, '{}', 'nice item', 0.10, 0),
	('semente_alaska_ginseng', 'Semente de Ginseng do Alasca', 100, 1, 'item_standard', 1, 216253, 1, '{}', 'nice item', 0.10, 0),
	('semente_alface', 'Semente de Alface', 100, 1, 'item_standard', 1, 216335, 1, '{}', 'nice item', 0.10, 0),
	('semente_algodao', 'Semente de Algodão', 100, 1, 'item_standard', 1, 216327, 1, '{}', 'nice item', 0.10, 0),
	('semente_alho_corvo', 'Semente de Alho do Corvo', 100, 1, 'item_standard', 1, 216331, 1, '{}', 'nice item', 0.10, 0),
	('semente_ameixa', 'Semente de Ameixa', 100, 1, 'item_standard', 1, 216318, 1, '{}', 'nice item', 0.10, 0),
	('semente_amendoin', 'Semente de Amendoim', 100, 1, 'item_standard', 1, 216330, 1, '{}', 'nice item', 0.10, 0),
	('semente_batata', 'Semente de Batata', 100, 1, 'item_standard', 1, 216258, 1, '{}', 'nice item', 0.10, 0),
	('semente_cabeca_carneiro', 'Semente de Cabeça de Carneiro', 100, 1, 'item_standard', 1, 216245, 1, '{}', 'nice item', 0.10, 0),
	('semente_camomila', 'Semente de Camomila', 100, 1, 'item_standard', 1, 216264, 1, '{}', 'nice item', 0.10, 0),
	('semente_cana_acucar', 'Semente de Cana-de-Açúcar', 100, 1, 'item_standard', 1, 216255, 1, '{}', 'nice item', 0.10, 0),
	('semente_cebola', 'Semente de Cebola', 100, 1, 'item_standard', 1, 216260, 1, '{}', 'nice item', 0.10, 0),
	('semente_cenoura', 'Semente de Cenoura', 100, 1, 'item_standard', 1, 216337, 1, '{}', 'nice item', 0.10, 0),
	('semente_cenoura_selvagem', 'Semente de Cenoura Selvagem', 100, 1, 'item_standard', 1, 216237, 1, '{}', 'nice item', 0.10, 0),
	('semente_coffee', 'Semente de Café', 100, 1, 'item_standard', 1, 216326, 1, '{}', 'nice item', 0.10, 0),
	('semente_cogumelo', 'Semente de Cogumelo', 100, 1, 'item_standard', 1, 216329, 1, '{}', 'nice item', 0.10, 0),
	('semente_cogumelo_guarda_sol', 'Semente de Cogumelo Guarda-sol', 100, 1, 'item_standard', 1, 216247, 1, '{}', 'nice item', 0.10, 0),
	('semente_de_arroz', 'semente de arroz', 100, 1, 'item_standard', 1, 16794, 1, '{}', '', 0.25, 0),
	('semente_de_feijao', 'semente de feijao', 100, 1, 'item_standard', 1, 16796, 1, '{}', '', 0.25, 0),
	('semente_de_tomate', 'semente de tomate', 100, 1, 'item_standard', 1, 16792, 1, '{}', '', 0.25, 0),
	('semente_de_trigo', 'semente de trigo', 100, 1, 'item_standard', 1, 16801, 1, '{}', 'nice item', 0.25, 0),
	('semente_framboesa_vermelha', 'Semente de Framboesa Vermelha', 100, 1, 'item_standard', 1, 216328, 1, '{}', 'nice item', 0.10, 0),
	('semente_groselha_preta', 'Semente de Groselha Preta', 100, 1, 'item_standard', 1, 216338, 1, '{}', 'nice item', 0.10, 0),
	('semente_guarma_tabaco', 'Semente de Tabaco Guarma', 100, 1, 'item_standard', 1, 216241, 1, '{}', 'nice item', 0.10, 0),
	('semente_laranja', 'Semente de Laranja', 100, 1, 'item_standard', 1, 216319, 1, '{}', 'nice item', 0.10, 0),
	('semente_limao', 'Semente de Limão', 100, 1, 'item_standard', 1, 216322, 1, '{}', 'nice item', 0.10, 0),
	('semente_maca', 'Semente de Maçã', 100, 1, 'item_standard', 1, 216262, 1, '{}', 'nice item', 0.10, 0),
	('semente_menta_selvagem', 'Semente de Menta Selvagem', 100, 1, 'item_standard', 1, 216243, 1, '{}', 'nice item', 0.10, 0),
	('semente_milho', 'Semente de Milho', 100, 1, 'item_standard', 1, 216242, 1, '{}', 'nice item', 0.10, 0),
	('semente_mirtilo_perene', 'Semente de Mirtilo Perene', 100, 1, 'item_standard', 1, 216251, 1, '{}', 'nice item', 0.10, 0),
	('semente_morango', 'Semente de Morango', 100, 1, 'item_standard', 1, 216320, 1, '{}', 'nice item', 0.10, 0),
	('semente_papoula', 'Semente de Papoula', 100, 1, 'item_standard', 1, 216334, 1, '{}', 'nice item', 0.10, 0),
	('semente_pecego', 'Semente de Pêssego', 100, 1, 'item_standard', 1, 216336, 1, '{}', 'nice item', 0.10, 0),
	('semente_pera', 'Semente de Pera', 100, 1, 'item_standard', 1, 216324, 1, '{}', 'nice item', 0.10, 0),
	('semente_pimenta', 'Semente de Pimenta', 100, 1, 'item_standard', 1, 216261, 1, '{}', 'nice item', 0.10, 0),
	('semente_pimentao_misto', 'Semente de Pimentão Misto', 100, 1, 'item_standard', 1, 216321, 1, '{}', 'nice item', 0.10, 0),
	('semente_pimentao_verde', 'Semente de Pimentão Verde', 100, 1, 'item_standard', 1, 216333, 1, '{}', 'nice item', 0.10, 0),
	('semente_selvia_beija_flor', 'Semente de Sálvia Beija-flor', 100, 1, 'item_standard', 1, 216249, 1, '{}', 'nice item', 0.10, 0),
	('semente_tabaco', 'Semente de Tabaco', 100, 1, 'item_standard', 1, 216325, 1, '{}', 'nice item', 0.10, 0),
	('semente_tabaco_indiano', 'Semente de Tabaco Indiano', 100, 1, 'item_standard', 1, 216239, 1, '{}', 'nice item', 0.10, 0),
	('semente_tomate', 'Semente de Tomate', 100, 1, 'item_standard', 1, 216259, 1, '{}', 'nice item', 0.10, 0),
	('semente_trigo', 'Semente de Trigo', 100, 1, 'item_standard', 1, 216323, 1, '{}', 'nice item', 0.10, 0),
	('semente_uva', 'Semente de Uva', 100, 1, 'item_standard', 1, 216257, 1, '{}', 'nice item', 0.10, 0),
	('semillacocaina', 'Semilla Cocaina', 100, 1, 'item_standard', 1, 16935, 1, '{}', 'nice item', 0.25, 0),
	('semillaepi', 'Semilla Epi (Methanfetamina)', 100, 1, 'item_standard', 1, 16937, 1, '{}', 'nice item', 0.25, 0),
	('seringa_vazia', 'seringa vazia', 100, 1, 'item_standard', 1, 16807, 1, '{}', 'nice item', 0.25, 0),
	('SerrariaBW', 'Livro da Serraria', 100, 1, 'item_standard', 1, 170471, 1, '{}', 'nice item', 0.25, 0),
	('sheephead', 'cabeça de ovelha', 100, 1, 'item_standard', 1, 493, 1, '{}', 'Head of a sheep', 0.25, 0),
	('shellcasing', 'Capsula', 100, 1, 'item_standard', 1, 275, 1, '{}', 'Empty shell casing', 0.10, 0),
	('shellspistol', 'Capsula revolver/pistola', 100, 1, 'item_standard', 1, 215695, 1, '{}', 'nice item', 0.25, 0),
	('shirts_full', 'Shirt', 20, 1, 'item_standard', 1, 17630, 1, '{}', 'nice item', 0.25, 0),
	('shootingtarget', 'tiro ao alvo', 100, 1, 'item_standard', 1, 613, 1, '{}', 'Target for shooting practice', 0.25, 0),
	('shoptoken', 'Licença de Criação de Loja', 5, 1, 'item_standard', 1, 17049, 1, '{}', 'nice item', 0.25, 0),
	('shotgunbarrel', 'cano da espingarda', 100, 1, 'item_standard', 1, 276, 1, '{}', 'Barrel for a shotgun', 0.25, 0),
	('shotgunmold', 'molde de espingarda', 100, 1, 'item_standard', 1, 277, 1, '{}', 'Mold for a shotgun', 0.25, 0),
	('shotgunstock', 'cabo de espingarda', 100, 1, 'item_standard', 1, 278, 1, '{}', 'Stock for a shotgun', 0.25, 0),
	('shovel', 'pa', 1, 1, 'item_standard', 1, 17235, 1, '{}', 'nice item', 0.25, 0),
	('shrimps', 'Moqueca de camarão', 100, 1, 'item_standard', 1, 279, 1, '{}', 'Delicious shrimp stew', 0.25, 0),
	('sidetable', 'mesa lateral 1', 100, 1, 'item_standard', 1, 782, 1, '{}', 'Functional side table', 0.25, 0),
	('sidetablea', 'mesa lateral 2', 100, 1, 'item_standard', 1, 783, 1, '{}', 'Stylish side table', 0.25, 0),
	('sidetableb', 'mesa lateral 3', 100, 1, 'item_standard', 1, 784, 1, '{}', 'A beautiful side table', 0.25, 0),
	('side_table', 'mesa lateral 1', 100, 1, 'item_standard', 1, 654, 1, '{}', 'A stylish side table', 0.25, 0),
	('side_tablea', 'mesa lateral 2', 100, 1, 'item_standard', 1, 655, 1, '{}', 'An elegant side table', 0.25, 0),
	('side_tableb', 'mesa lateral 3', 100, 1, 'item_standard', 1, 656, 1, '{}', 'A modern side table', 0.25, 0),
	('silverhorseshoe', 'ferradura de prata ', 100, 1, 'item_standard', 1, 16908, 1, '{}', 'nice item', 0.25, 0),
	('silverticket', 'bilhete 2', 100, 1, 'item_standard', 1, 16912, 1, '{}', 'nice item', 0.25, 0),
	('simplenativetent', 'Simple Native Tent', 100, 1, 'item_standard', 1, 216028, 1, '{}', 'nice item', 1.00, 0),
	('singlebed', 'cama de solteiro', 100, 1, 'item_standard', 1, 666, 1, '{}', 'A comfortable single bed', 0.25, 0),
	('skirts', 'Skirt', 20, 1, 'item_standard', 1, 17613, 1, '{}', 'nice item', 0.25, 0),
	('skullpost', 'poste de caveira', 100, 1, 'item_standard', 1, 597, 1, '{}', 'A decorative skull post', 0.25, 0),
	('smallchest', 'Baú Pequeno', 100, 1, 'item_standard', 1, 657, 1, '{}', 'A small storage chest', 0.25, 0),
	('smallmcandle', 'Vela pequena derretida', 100, 1, 'item_standard', 1, 662, 1, '{}', 'A small melted candle', 0.25, 0),
	('small_firecracker', 'foguete', 100, 1, 'item_standard', 1, 16896, 1, '{}', 'nice item', 0.25, 0),
	('small_fireworks', 'fogos', 100, 1, 'item_standard', 1, 16992, 1, '{}', 'nice item', 0.25, 0),
	('Small_Leather', 'couro pequeno', 100, 1, 'item_standard', 1, 280, 1, '{}', 'A small piece of leather', 0.25, 0),
	('smoke_campfire', 'foguete', 100, 1, 'item_standard', 1, 16895, 1, '{}', 'nice item', 0.25, 0),
	('SnakeSkin', 'pele de cobra', 100, 1, 'item_standard', 1, 281, 1, '{}', 'A snake skin', 0.25, 0),
	('snaket', 'Cobra Morta', 100, 1, 'item_standard', 1, 490, 1, '{}', 'A tooth from a snake', 1.50, 0),
	('Snake_Poison', 'Veneno de Cobra', 100, 1, 'item_standard', 1, 282, 1, '{}', 'Poison extracted from a snake', 0.50, 0),
	('soap', 'sabão', 100, 1, 'item_standard', 1, 215784, 1, '{}', 'nice item', 0.25, 0),
	('soborno', 'Suborno Álcool', 100, 1, 'item_standard', 1, 283, 1, '{}', 'A bottle of Soborno alcohol', 0.25, 0),
	('societytoken', 'Licença de criação de loja de sociedade', 5, 1, 'item_standard', 1, 17050, 1, '{}', 'nice item', 0.25, 0),
	('songbird2_c', 'pássaro canoro escarlate', 100, 1, 'item_standard', 1, 435, 1, '{}', 'A beautiful scarlet songbird', 0.25, 0),
	('songbird_c', 'pássaro canoro', 100, 1, 'item_standard', 1, 434, 1, '{}', 'A lovely songbird', 0.25, 0),
	('sopamilho', 'Sopa de Milho', 100, 1, 'item_standard', 1, 170477, 1, '{}', 'nice item', 0.25, 0),
	('soparustica', 'Sopa de Batata Rustica', 100, 1, 'item_standard', 1, 170480, 1, '{}', 'nice item', 0.25, 0),
	('sparrow0_c', 'pardal comum', 100, 1, 'item_standard', 1, 436, 1, '{}', 'A common sparrow', 0.25, 0),
	('sparrow1_c', 'Pardal', 100, 1, 'item_standard', 1, 437, 1, '{}', 'A sparrow', 0.25, 0),
	('sparrow2_c', 'pardal dourado', 100, 1, 'item_standard', 1, 438, 1, '{}', 'A golden sparrow', 0.25, 0),
	('spats', 'Spats', 20, 1, 'item_standard', 1, 17620, 1, '{}', 'nice item', 0.25, 0),
	('speeditem', 'Super corrida', 100, 1, 'item_standard', 1, 215998, 1, '{}', 'nice item', 0.25, 0),
	('spool', 'carretel', 100, 1, 'item_standard', 1, 1797, 1, '{}', 'A empty spool. often used to wrap wire around.', 0.25, 0),
	('squirrel_black_c', 'esquilo preto', 100, 1, 'item_standard', 1, 441, 1, '{}', 'A black squirrel', 0.25, 0),
	('squirrel_grey_c', 'Esquilo Cinza', 100, 1, 'item_standard', 1, 439, 1, '{}', 'A gray squirrel', 0.80, 0),
	('squirrel_red_c', 'Esquilo vermelho', 100, 1, 'item_standard', 1, 440, 1, '{}', 'A Red squirrel', 0.25, 0),
	('standard_table', 'Mesa', 100, 1, 'item_standard', 1, 622, 1, '{}', 'A standard table for various uses.', 0.25, 0),
	('standingtorch', 'Tocha Permanente', 100, 1, 'item_standard', 1, 612, 1, '{}', 'A standing torch to provide light.', 0.25, 0),
	('statue13', 'estatua de jesus', 100, 1, 'item_standard', 1, 17199, 1, '{}', 'nice item', 0.25, 0),
	('statue17', 'estatua antiga', 100, 1, 'item_standard', 1, 17204, 1, '{}', 'nice item', 0.25, 0),
	('steak', 'Bife', 100, 1, 'item_standard', 1, 284, 1, '{}', 'A delicious steak for a hearty meal.', 0.25, 0),
	('steakveg', 'bife com legumes', 100, 1, 'item_standard', 1, 285, 1, '{}', 'A balanced meal with steak and vegetables.', 0.25, 0),
	('stillkit', 'Kit de destilação', 100, 1, 'item_standard', 1, 843, 1, '{}', 'A kit for setting up a still to make distilled spirits.', 0.25, 0),
	('stim', 'Estimulante para cavalos', 100, 1, 'item_standard', 1, 286, 1, '{}', 'A stimulant to boost a horses performance.', 0.25, 0),
	('stolenmerch', 'Mercadoria Roubada', 100, 1, 'item_standard', 1, 287, 1, '{}', 'Various stolen items of questionable origin.', 0.25, 0),
	('stonehammer', 'martelo de pedra', 100, 1, 'item_standard', 1, 288, 1, '{}', 'A durable hammer made of stone.', 0.25, 0),
	('strawberry', 'Morango', 100, 1, 'item_standard', 1, 216341, 1, '{}', 'nice item', 0.20, 0),
	('string', 'Corda', 100, 1, 'item_standard', 1, 1798, 1, '{}', 'A bundle of string with many uses.', 0.25, 0),
	('stringedmeat', 'Stringed meat', 30, 1, 'item_standard', 1, 17564, 1, '{}', 'nice item', 0.25, 0),
	('stringy', 'carne fibrosa', 100, 1, 'item_standard', 1, 574, 1, '{}', 'Tough and chewy meat that requires thorough cooking.', 0.25, 0),
	('suco_laranja', 'suco de laranja', 20, 1, 'item_standard', 1, 17075, 1, '{}', '', 0.25, 0),
	('suco_limao', 'suco de limão', 20, 1, 'item_standard', 1, 17076, 1, '{}', 'nice item', 0.25, 0),
	('suco_maca', 'suco de maça', 20, 1, 'item_standard', 1, 17077, 1, '{}', 'nice item', 0.25, 0),
	('suco_pera', 'suco de pera', 20, 1, 'item_standard', 1, 17078, 1, '{}', 'nice item', 0.25, 0),
	('sugar', 'Açúcar', 100, 1, 'item_standard', 1, 289, 1, '{}', 'A sweet and granulated substance used for sweetening.', 0.25, 0),
	('Sugarcane', 'Cana de açúcar', 100, 1, 'item_standard', 1, 1682, 1, '{}', 'nice item', 0.25, 0),
	('sugarcaneseed', 'semente de cana', 100, 1, 'item_standard', 1, 290, 1, '{}', 'Seeds for growing sugarcane.', 0.25, 0),
	('Sugarcane_Seed', 'Semente de Cana', 100, 1, 'item_standard', 1, 215796, 1, '{}', 'nice item', 0.25, 0),
	('sugarcube', 'Cubo de açúcar', 100, 1, 'item_standard', 1, 347, 1, '{}', 'A compact form of sugar for easy use.', 0.25, 0),
	('sulfur', 'enxofre', 100, 1, 'item_standard', 1, 291, 1, '{}', 'A yellow chemical element often used in manufacturing.', 0.25, 0),
	('Supply_Manure', 'esterco ', 100, 1, 'item_standard', 1, 16967, 1, '{}', 'nice item', 0.25, 0),
	('suspenders', 'Suspenders', 20, 1, 'item_standard', 1, 17629, 1, '{}', 'nice item', 0.25, 0),
	('syn', 'bebida simples', 100, 1, 'item_standard', 1, 292, 1, '{}', 'A synthetic substance used for various purposes.', 0.25, 0),
	('synpackage', 'Pacote Syn', 100, 1, 'item_standard', 1, 293, 1, '{}', 'A package containing synthetic substances.', 0.25, 0),
	('syringe', 'Seringa', 100, 1, 'item_standard', 1, 294, 1, '{}', 'A medical instrument used for injecting fluids.', 0.25, 0),
	('syringecert', 'certificado de seringa', 100, 1, 'item_standard', 1, 295, 1, '{}', 'A certification for the proper use of syringes.', 0.25, 0),
	('syringe_adrenalin', 'Syringe of Adrenalin', 5, 1, 'item_standard', 1, 17281, 1, '{}', 'A syringe filled with adrenalin.', 0.25, 0),
	('syringe_steroids', 'Syringe of Steroids', 5, 1, 'item_standard', 1, 17280, 1, '{}', 'A syringe containing steroids.', 0.25, 0),
	('tabac', 'tabaco louro', 100, 1, 'item_standard', 1, 16892, 1, '{}', 'nice item', 0.25, 0),
	('tabacodemascar', 'Tabacco de Mascar', 100, 1, 'item_standard', 1, 215649, 1, '{}', 'nice item', 0.25, 0),
	('tabaco_indiano', 'Tabaco Indiano', 100, 1, 'item_standard', 1, 216114, 1, '{}', 'nice item', 0.50, 0),
	('taboa_comum', 'Taboa Comum', 100, 1, 'item_standard', 1, 216117, 1, '{}', 'nice item', 0.50, 0),
	('tea', 'planta para cha ', 100, 1, 'item_standard', 1, 17225, 1, '{}', 'nice item', 0.25, 0),
	('teabag', 'sarsaparilla', 100, 1, 'item_standard', 1, 1799, 1, '{}', 'A teabag for making that perfect cup.', 0.25, 0),
	('tealeaf', 'Folha de chá', 100, 1, 'item_standard', 1, 1800, 1, '{}', 'Used to make tea or teabags.', 0.25, 0),
	('Teapot_Can', 'Regador', 100, 1, 'item_standard', 1, 27532, 1, '{}', 'nice item', 0.25, 0),
	('teaseeds', 'semente de cha', 100, 1, 'item_standard', 1, 17070, 1, '{}', 'nice item', 0.25, 0),
	('tecido', 'Tecido', 100, 1, 'item_standard', 1, 170469, 1, '{}', 'nice item', 0.25, 0),
	('telegram', 'telegrama ', 5, 1, 'item_standard', 1, 17156, 1, '{}', 'nice item', 0.25, 0),
	('teleitem', 'Telesinese', 100, 1, 'item_standard', 1, 215990, 1, '{}', 'nice item', 0.25, 0),
	('tellapple1', 'William Tell Apple', 5, 1, 'item_standard', 1, 17240, 1, '{}', 'nice item', 0.25, 0),
	('tent', 'Barraca', 100, 1, 'item_standard', 1, 296, 1, '{}', 'A portable shelter for camping or temporary use.', 0.25, 0),
	('tent2', 'Barraca do Comerciante', 100, 1, 'item_standard', 1, 588, 1, '{}', 'A tent specifically designed for trading purposes.', 0.25, 0),
	('tent3', 'Tenda Simples', 100, 1, 'item_standard', 1, 589, 1, '{}', 'A basic tent for camping.', 0.25, 0),
	('tent4', 'Sombra de tela', 100, 1, 'item_standard', 1, 590, 1, '{}', 'A canvas shade for shelter.', 0.25, 0),
	('tentdroga', 'NarcoRefugio', 100, 1, 'item_standard', 1, 16941, 1, '{}', 'nice item', 0.25, 0),
	('tequila', 'tequila', 100, 1, 'item_standard', 1, 297, 1, '{}', 'A bottle of tequila.', 0.25, 0),
	('tequilabarrel', 'barril de tequila', 1, 1, 'item_standard', 1, 17272, 1, '{}', 'nice item', 0.25, 0),
	('tequilarecipe', 'Recipiente para vinho', 1, 1, 'item_standard', 1, 17266, 1, '{}', 'nice item', 0.25, 0),
	('texasbon', 'Texas Blue Bonnet', 50, 1, 'item_standard', 1, 17691, 1, '{}', 'an item', 0.25, 0),
	('Texas_Bonnet', 'Boné do Texas', 100, 1, 'item_standard', 1, 298, 1, '{}', 'A traditional Texas bonnet.', 0.25, 0),
	('Texas_Bonnet_Seed', 'Semente de gorro do Texas', 100, 1, 'item_standard', 1, 299, 1, '{}', 'Seeds to grow Texas Bonnet flowers.', 0.25, 0),
	('ticket', 'bilhete', 100, 1, 'item_standard', 1, 16994, 1, '{}', 'nice item', 0.25, 0),
	('timber', 'Madeira', 100, 1, 'item_standard', 1, 1801, 1, '{}', 'A sturdy chunck of timber.', 0.25, 0),
	('timbertable', 'mesa de madeira', 100, 1, 'item_standard', 1, 752, 1, '{}', 'A sturdy table made of timber.', 0.25, 0),
	('timber_table', 'mesa de madeira', 100, 1, 'item_standard', 1, 624, 1, '{}', 'A table made of timber.', 0.25, 0),
	('tipi', 'Tipo nativo', 100, 1, 'item_standard', 1, 596, 1, '{}', 'A traditional Native American tipi.', 0.25, 0),
	('toaddesert_c', 'sapo do deserto', 100, 1, 'item_standard', 1, 444, 1, '{}', 'A toad found in the desert.', 0.25, 0),
	('toadpoison_c', 'sapo envenenado', 100, 1, 'item_standard', 1, 443, 1, '{}', 'A toad that carries poison.', 0.25, 0),
	('toad_c', 'Sapo', 100, 1, 'item_standard', 1, 442, 1, '{}', 'A common toad.', 0.25, 0),
	('toalha', 'Toalha de Banho', 100, 1, 'item_standard', 1, 215675, 1, '{}', 'nice item', 0.25, 0),
	('tobacco', 'tabaco', 100, 1, 'item_standard', 1, 1683, 1, '{}', 'nice item', 0.25, 0),
	('tobaccopipe', 'Tabaco seco', 100, 1, 'item_standard', 1, 215627, 1, '{}', 'Quality tobacco', 0.25, 0),
	('tobacco_leaf', 'Folha de Tabaco', 100, 1, 'item_standard', 1, 216346, 1, '{}', 'nice item', 0.20, 0),
	('tobacco_seed', 'semente de tabaco', 100, 1, 'item_standard', 1, 1684, 1, '{}', 'nice item', 0.25, 0),
	('token', 'Licença de acampamento', 100, 1, 'item_standard', 1, 300, 1, '{}', 'A license for setting up a camp.', 0.25, 0),
	('tomate', 'tomate', 100, 1, 'item_standard', 1, 16791, 1, '{}', 'nice item', 0.25, 0),
	('Tomato', 'Tomate', 100, 1, 'item_standard', 1, 215823, 1, '{}', 'nice item', 0.40, 0),
	('Tomato_Seed', 'Semente de Tomate', 100, 1, 'item_standard', 1, 215801, 1, '{}', 'nice item', 0.25, 0),
	('tomilho', 'Tomilho', 100, 1, 'item_standard', 1, 216118, 1, '{}', 'nice item', 0.50, 0),
	('toolbarrel', 'Cano de ferramentas', 100, 1, 'item_standard', 1, 767, 1, '{}', 'A barrel for storing tools.', 0.25, 0),
	('tool_barrel', 'Cano de ferramentas', 100, 1, 'item_standard', 1, 639, 1, '{}', 'A barrel used for storing tools.', 0.25, 0),
	('tortadebanana', 'Torta de Banana', 100, 1, 'item_standard', 1, 215777, 1, '{}', 'nice item', 0.25, 0),
	('tortadecarne', 'Torta de Carne', 100, 1, 'item_standard', 1, 215776, 1, '{}', 'nice item', 0.25, 0),
	('trainkey', 'Chave do Trem', 100, 1, 'item_standard', 1, 301, 1, '{}', 'A key to unlock a train.', 0.25, 0),
	('trainoil', 'óleo de trem', 100, 1, 'item_standard', 1, 16931, 1, '{}', 'nice item', 0.25, 0),
	('trayoffood', 'Mesa de Servir', 100, 1, 'item_standard', 1, 614, 1, '{}', 'A table used for serving food.', 0.25, 0),
	('treat_dog_small', 'Dog Food', 50, 1, 'item_standard', 1, 17567, 1, '{}', 'nice item', 0.25, 0),
	('trigo', 'trigo', 100, 1, 'item_standard', 1, 17114, 1, '{}', 'nice item', 0.25, 0),
	('trigo2', 'trigo', 100, 1, 'item_standard', 1, 16802, 1, '{}', 'nice item', 0.25, 0),
	('trigo_Seed', 'semente de trigo', 100, 1, 'item_standard', 1, 17109, 1, '{}', 'nice item', 0.25, 0),
	('tronco1', 'Tronco de Cedro', 100, 1, 'item_standard', 1, 170466, 1, '{}', 'nice item', 0.25, 0),
	('tronco2', 'Tronco de Pinheiro', 100, 1, 'item_standard', 1, 170467, 1, '{}', 'nice item', 0.25, 0),
	('tronco3', 'Tronco de Eucalipto', 100, 1, 'item_standard', 1, 170468, 1, '{}', 'nice item', 0.25, 0),
	('tropicalPunchMash', 'purê de ginseng', 100, 1, 'item_standard', 1, 302, 1, '{}', 'A mash made from ginseng.', 0.25, 0),
	('tropicalPunchMoonshine', 'aguardente de ginseng', 100, 1, 'item_standard', 1, 303, 1, '{}', 'Moonshine infused with ginseng.', 0.25, 0),
	('trout', 'Truta', 100, 1, 'item_standard', 1, 304, 1, '{}', 'A fish of the trout family.', 0.25, 0),
	('tuicabar', 'tuica barril', 1, 1, 'item_standard', 1, 17270, 1, '{}', 'nice item', 0.25, 0),
	('tuicarecipe', 'recipiente para tuica', 1, 1, 'item_standard', 1, 17268, 1, '{}', 'nice item', 0.25, 0),
	('turkeyb', 'bico de peru', 100, 1, 'item_standard', 1, 484, 1, '{}', 'The beak of a turkey.', 0.25, 0),
	('turkeyf', 'pena de peru', 100, 1, 'item_standard', 1, 483, 1, '{}', 'A feather from a turkey.', 0.25, 0),
	('TurtleShell', 'casco de tartaruga', 100, 1, 'item_standard', 1, 305, 1, '{}', 'The shell of a turtle.', 0.25, 0),
	('turtlet', 'Tartaruga Morta', 100, 1, 'item_standard', 1, 482, 1, '{}', 'A tooth extracted from a turtle.', 3.00, 0),
	('twice', 'roupa', 100, 1, 'item_standard', 1, 17472, 1, '{}', 'nice item', 0.25, 0),
	('tylenol', 'Tylenol', 100, 1, 'item_standard', 1, 306, 1, '{}', 'A medication called Tylenol.', 0.25, 0),
	('uccelloarrosto', 'Prato de Fitness', 100, 1, 'item_standard', 1, 98675, 1, '{}', 'nice item', 0.25, 0),
	('ufoitem', 'Ufo', 100, 1, 'item_standard', 1, 215857, 1, '{}', 'nice item', 0.25, 0),
	('undertaker1', 'Caixão', 100, 1, 'item_standard', 1, 609, 1, '{}', 'A wooden coffin.', 0.25, 0),
	('undertaker2', 'flor caixão', 100, 1, 'item_standard', 1, 610, 1, '{}', 'A coffin decorated with flowers.', 0.25, 0),
	('unique_brad_horsesugar', 'Açúcar Cavalo Brad', 100, 1, 'item_standard', 1, 350, 1, '{}', 'Sugar used for horses owned by Brad.', 0.25, 0),
	('unique_helper', 'Unico Ajudante', 100, 1, 'item_standard', 1, 215787, 1, '{}', 'nice item', 0.25, 0),
	('unique_horse_feed', 'Ração para cavalos', 100, 1, 'item_standard', 1, 349, 1, '{}', 'Feed for horses.', 0.25, 0),
	('upgrade_fsh_bait_cheese', 'fatia de queijo', 100, 1, 'item_standard', 1, 16722, 1, '{}', 'nice item', 0.25, 0),
	('upgrade_fsh_bait_cricket', 'isca', 10, 1, 'item_standard', 1, 17068, 1, '{}', 'nice item', 0.25, 0),
	('upgrade_fsh_bait_leg_lure_river', 'isca', 100, 1, 'item_standard', 1, 17053, 1, '{}', 'nice item', 0.25, 0),
	('upgrade_fsh_bait_worm', 'isca', 10, 1, 'item_standard', 1, 17069, 1, '{}', 'nice item', 0.25, 0),
	('upperclassclothes', 'Roupas de classe alta', 100, 1, 'item_standard', 1, 215989, 1, '{}', 'nice item', 0.25, 0),
	('uva', 'uva', 100, 1, 'item_standard', 1, 17192, 1, '{}', 'nice item', 0.25, 0),
	('valc', '500 Gold', 10, 1, 'item_standard', 1, 1017, 1, '{}', '011', 0.25, 0),
	('vald', '200 Gold', 10, 1, 'item_standard', 1, 1019, 1, '{}', '013', 0.25, 0),
	('valm', '1000 Gold', 10, 1, 'item_standard', 1, 1020, 1, '{}', '014', 0.25, 0),
	('vals', '50 Gold', 10, 1, 'item_standard', 1, 1018, 1, '{}', '012', 0.25, 0),
	('valu', '100 Gold', 10, 1, 'item_standard', 1, 1021, 1, '{}', '015', 0.25, 0),
	('vampire', 'Vampiro Dreno', 100, 1, 'item_standard', 1, 215999, 1, '{}', 'nice item', 0.10, 0),
	('vanillacake', 'Bolo de baunilha', 100, 1, 'item_standard', 1, 1802, 1, '{}', 'A tasty vanilla flavored cake.', 0.25, 0),
	('vanillaFlower', 'flor de baunilha', 100, 1, 'item_standard', 1, 307, 1, '{}', 'A flower known as Vanille.', 0.25, 0),
	('varnish', 'Verniz', 100, 1, 'item_standard', 1, 1803, 1, '{}', 'A typical wood finish made from oils and resins.', 0.25, 0),
	('venison', 'Carne de veado', 100, 1, 'item_standard', 1, 566, 1, '{}', 'Lean meat obtained from deer.', 0.25, 0),
	('vests', 'Vest', 20, 1, 'item_standard', 1, 17628, 1, '{}', 'nice item', 0.25, 0),
	('vinagre', 'Vinagre', 100, 1, 'item_standard', 1, 215689, 1, '{}', 'nice item', 0.25, 0),
	('Violet_Snowdrop', 'Floco de Neve Violeta', 100, 1, 'item_standard', 1, 308, 1, '{}', 'A delicate flower called Violet Snowdrop.', 0.25, 0),
	('Violet_Snowdrop_Seed', 'Semente Violet Snowdrop', 100, 1, 'item_standard', 1, 309, 1, '{}', 'Seeds to grow Violet Snowdrop flowers.', 0.25, 0),
	('vip1', 'Vip Bronze', 10, 1, 'item_standard', 1, 1004, 1, '{}', '017', 0.25, 0),
	('vip2', 'Vip Prata', 10, 1, 'item_standard', 1, 1000, 1, '{}', '013', 0.25, 0),
	('vip3', 'Vip Ouro', 10, 1, 'item_standard', 1, 1002, 1, '{}', '015', 0.25, 0),
	('vip4', 'Vip Platina', 10, 1, 'item_standard', 1, 1001, 1, '{}', '014', 0.25, 0),
	('vip5', 'Vip Diamante ', 10, 1, 'item_standard', 1, 1003, 1, '{}', '016', 0.25, 0),
	('vodka', 'Vodka', 100, 1, 'item_standard', 1, 310, 1, '{}', 'A strong alcoholic beverage known as Vodka.', 0.25, 0),
	('Volture_Egg', 'ovo de volture', 100, 1, 'item_standard', 1, 311, 1, '{}', 'An egg laid by a Volture bird.', 0.25, 0),
	('vulturetaxi', 'Taxidermia de Abutre', 100, 1, 'item_standard', 1, 772, 1, '{}', 'A taxidermy of a vulture bird.', 0.25, 0),
	('vulture_taxidermy', 'Taxidermia de Abutre', 100, 1, 'item_standard', 1, 644, 1, '{}', 'A preserved vulture bird for display.', 0.25, 0),
	('washcloth', 'Toalha', 100, 1, 'item_standard', 1, 215785, 1, '{}', 'nice item', 0.25, 0),
	('washtub', 'Lavatório', 100, 1, 'item_standard', 1, 637, 1, '{}', 'A tub used for washing clothes or other items.', 0.25, 0),
	('water', 'agua', 20, 1, 'item_standard', 1, 312, 1, '{}', 'Clean drinking water.', 0.25, 0),
	('waterbarrel', 'Barril de água', 100, 1, 'item_standard', 1, 587, 1, '{}', 'A large barrel used for storing water.', 0.25, 0),
	('waterhose', 'Water Hose', 50, 1, 'item_standard', 1, 17687, 1, '{}', 'an item', 0.25, 0),
	('wateringcan', 'Balde de Agua', 100, 1, 'item_standard', 1, 313, 1, '{}', 'A jug-shaped container used for watering plants.', 0.25, 0),
	('wateringcan_dirtywater', 'Jarro de rega sujo', 100, 1, 'item_standard', 1, 314, 1, '{}', 'A watering jug filled with dirty water.', 0.25, 0),
	('wateringcan_empty', 'Balde Vazio', 100, 1, 'item_standard', 1, 315, 1, '{}', 'An empty watering jug.', 0.25, 0),
	('waterpump', 'Bomba de água', 100, 1, 'item_standard', 1, 755, 1, '{}', 'A device used for pumping water.', 0.25, 0),
	('water_clean', 'Agua Fervida', 100, 1, 'item_standard', 1, 215862, 1, '{}', 'agua fervida', 0.25, 0),
	('water_pump', 'Bomba de água', 100, 1, 'item_standard', 1, 627, 1, '{}', 'A pump designed to move water.', 0.25, 0),
	('weapon_bow', 'arco ', 100, 1, 'item_Weapon', 1, 16815, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_FISHINGROD', 'vara de pesca', 100, 1, 'item_Weapon', 1, 17218, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_kIT_BINOCULARS', 'binoculos ', 100, 1, 'item_Weapon', 1, 17183, 1, '{}', 'nice item', 0.25, 0),
	('weapon_kit_binoculars_improved', 'binoculos', 100, 1, 'item_Weapon', 1, 16737, 1, '{}', 'nice item', 0.25, 0),
	('weapon_kit_metal_detector', 'Detector de metal', 100, 1, 'item_Weapon', 1, 17263, 1, '{}', 'Detector de metal', 0.25, 0),
	('WEAPON_LASSO', 'lasso', 100, 1, 'item_Weapon', 1, 17096, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_LASSO_REINFORCED', 'lasso reforçado', 100, 1, 'item_Weapon', 1, 17181, 1, '{}', 'nice item', 0.25, 0),
	('weapon_melee_hammer', 'martelo', 100, 1, 'item_Weapon', 1, 16731, 1, '{}', 'nice item', 0.25, 0),
	('weapon_melee_hatchet', 'machado', 100, 1, 'item_Weapon', 1, 16730, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_MELEE_KNIFE', 'faca', 100, 1, 'item_Weapon', 1, 16741, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_MELEE_LANTERN_HALOWEEN', 'lanterna de walow', 100, 1, 'item_Weapon', 1, 16964, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_MELEE_MACHETE_COLLECTOR', 'espada facão', 100, 1, 'item_Weapon', 1, 17178, 1, '{}', 'nice item', 0.25, 0),
	('weapon_melee_torch', 'tocha', 100, 1, 'item_Weapon', 1, 16732, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_PISTOL_M1899', 'pistola', 100, 1, 'item_Weapon', 1, 17143, 1, '{}', 'nice item', 0.25, 0),
	('weapon_reinforced_lasso', 'chicote de treino', 100, 1, 'item_Weapon', 1, 16910, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_REPEATER_HENRY', 'repetidora henry', 100, 1, 'item_Weapon', 1, 17153, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_REPEATER_WINCHESTER', 'repetidora winchester', 100, 1, 'item_Weapon', 1, 17154, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_REVOLVER_CATTLEMAN', 'revolver cattleman', 100, 1, 'item_weapon', 1, 17152, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_REVOLVER_DOUBLEACTION', 'Revolver Dupla Ação', 100, 1, 'item_Weapon', 1, 98669, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_REVOLVER_LEMAT', 'Revolver Lemat', 100, 1, 'item_Weapon', 1, 17187, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_REVOLVER_NAVY', 'nevy', 100, 1, 'item_Weapon', 1, 17144, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_RIFLE_SPRINGFIELD', 'Rifle Springfield', 100, 1, 'item_Weapon', 1, 98672, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_SHOTGUN_DOUBLEBARREL', 'Escopeta Cano Duplo', 100, 1, 'item_Weapon', 1, 98673, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_SNIPERRIFLE_ROLLINGBLOCK', 'ROLLINGBLOCK', 100, 1, 'item_Weapon', 1, 17179, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_THROWN_BOLAS', 'bolas', 100, 1, 'item_Weapon', 1, 17103, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_THROWN_MOLOTOV', 'molotov', 100, 1, 'item_Weapon', 1, 16965, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_THROWN_POISONBOTTLE', 'poção', 100, 1, 'item_Weapon', 1, 17344, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_THROWN_THROWING_KNIVES', 'faca de arremeço', 100, 1, 'item_Weapon', 1, 17343, 1, '{}', 'nice item', 0.25, 0),
	('WEAPON_THROWN_TOMAHAWK', 'machado de arremeço', 100, 1, 'item_Weapon', 1, 17102, 1, '{}', 'nice item', 0.25, 0),
	('weapon_thrown_tomahawk2', 'machado de arremeço', 100, 1, 'item_Weapon', 1, 16812, 1, '{}', 'nice item', 0.25, 0),
	('wedding_chain_ring', 'Anel de casamento na cadeia', 100, 1, 'item_standard', 1, 1804, 1, '{}', 'A wedding ring on chain. usally worn this way so they dont get lost.', 0.25, 0),
	('wedding_ring', 'Anel de noivado', 100, 1, 'item_standard', 1, 1805, 1, '{}', 'A beautiful wedding ring.', 0.25, 0),
	('weed', 'Maconha', 100, 1, 'item_standard', 1, 17119, 1, '{}', 'nice item', 0.20, 0),
	('weedbuds', 'cannabis flor', 100, 1, 'item_standard', 1, 17057, 1, '{}', 'nice item', 0.25, 0),
	('weedpack', 'Pote de Marijuana', 100, 1, 'item_standard', 1, 215650, 1, '{}', 'nice item', 0.25, 0),
	('weedseed', 'Semente de Maconha', 100, 1, 'item_standard', 1, 17058, 1, '{}', 'nice item', 0.10, 0),
	('weed_leaves', 'folha de cannabis', 100, 1, 'item_standard', 1, 17165, 1, '{}', 'nice item', 0.25, 0),
	('weed_pooch', 'flor de cannabis', 100, 1, 'item_standard', 1, 17166, 1, '{}', 'nice item', 0.25, 0),
	('weed_seed', 'semente de cannabis', 100, 1, 'item_standard', 1, 17167, 1, '{}', 'nice item', 0.25, 0),
	('wheat', 'Trigo', 100, 1, 'item_standard', 1, 1806, 1, '{}', 'Often ground up into flour to used in cooking and baking', 0.25, 0),
	('wheatseed', 'semente de trigo', 100, 1, 'item_standard', 1, 1807, 1, '{}', 'When planted will grow into wheat.', 0.25, 0),
	('Whiskey', 'Garrafa de Whiskey', 100, 1, 'item_standard', 1, 98674, 1, '{}', 'nice item', 0.25, 0),
	('whisky', 'whisky', 100, 1, 'item_standard', 1, 316, 1, '{}', 'An alcoholic beverage known as whisky.', 0.10, 0),
	('whiskybarrel', 'barril de whisky', 1, 1, 'item_standard', 1, 17274, 1, '{}', 'nice item', 0.25, 0),
	('whiskyrecipe', 'Recipiente para whisky', 1, 1, 'item_standard', 1, 17264, 1, '{}', 'nice item', 0.25, 0),
	('wicker', 'vime', 100, 1, 'item_standard', 1, 1808, 1, '{}', 'A natural material made from woven branches or reeds', 0.25, 0),
	('wickerbench', 'banco de vime', 100, 1, 'item_standard', 1, 778, 1, '{}', 'A bench made from wicker material.', 0.25, 0),
	('wicker_bench', 'banco de vime', 100, 1, 'item_standard', 1, 650, 1, '{}', 'A bench constructed with wicker material.', 0.25, 0),
	('wildCiderMash', 'Purê de Bagas Pretas', 100, 1, 'item_standard', 1, 317, 1, '{}', 'Mashed blackberries used for making cider.', 0.25, 0),
	('wildCiderMoonshine', 'Moonshine de Black Berry', 100, 1, 'item_standard', 1, 318, 1, '{}', 'Homemade moonshine crafted from blackberries.', 0.25, 0),
	('Wild_Carrot', 'Cenoura Silvestre', 100, 1, 'item_standard', 1, 319, 1, '{}', 'A type of carrot that grows in the wild.', 0.25, 0),
	('Wild_Carrot_Seed', 'Semente de Cenoura Selvagem', 100, 1, 'item_standard', 1, 320, 1, '{}', 'Seeds to cultivate wild carrots.', 0.25, 0),
	('Wild_Feverfew', 'matricária selvagem', 100, 1, 'item_standard', 1, 321, 1, '{}', 'A wild plant known as Feverfew.', 0.25, 0),
	('Wild_Feverfew_Seed', 'Semente de Matricária Selvagem', 100, 1, 'item_standard', 1, 322, 1, '{}', 'Seeds to grow Feverfew plants.', 0.25, 0),
	('Wild_Mint', 'Menta selvagem', 100, 1, 'item_standard', 1, 323, 1, '{}', 'A type of mint that grows in the wild.', 0.25, 0),
	('Wild_Mint_Seed', 'Semente de Hortelã Selvagem', 100, 1, 'item_standard', 1, 324, 1, '{}', 'Seeds to cultivate wild mint.', 0.25, 0),
	('Wild_Rhubarb', 'ruibarbo selvagem', 100, 1, 'item_standard', 1, 325, 1, '{}', 'A rhubarb plant that grows in the wild.', 0.25, 0),
	('Wild_Rhubarb_Seed', 'Semente de Ruibarbo Selvagem', 100, 1, 'item_standard', 1, 326, 1, '{}', 'Seeds to grow wild rhubarb.', 0.25, 0),
	('wine', 'vinho', 20, 1, 'item_standard', 1, 17182, 1, '{}', 'nice item', 0.25, 0),
	('winebarrel', 'barril de vinho', 1, 1, 'item_standard', 1, 17273, 1, '{}', 'nice item', 0.25, 0),
	('winerecipe', 'Recipiente para vinho', 1, 1, 'item_standard', 1, 17265, 1, '{}', 'nice item', 0.25, 0),
	('Wintergreen_Berry', 'Wintergreen Berry', 100, 1, 'item_standard', 1, 328, 1, '{}', 'Berries from the wintergreen plant.', 0.25, 0),
	('Wintergreen_Berry_Seed', 'Semente de Gualtéria', 100, 1, 'item_standard', 1, 329, 1, '{}', 'Seeds to cultivate wintergreen berries.', 0.25, 0),
	('Wisteria', 'glicínias', 100, 1, 'item_standard', 1, 330, 1, '{}', 'A flowering plant called Wisteria.', 0.25, 0),
	('Wisteria_Seed', 'semente de wisteria', 100, 1, 'item_standard', 1, 331, 1, '{}', 'Seeds to grow Wisteria plants.', 0.25, 0),
	('wojape', 'viagem', 100, 1, 'item_standard', 1, 332, 1, '{}', 'A traditional Native American sauce made from berries.', 0.25, 0),
	('wolfheart', 'coração de lobo', 100, 1, 'item_standard', 1, 476, 1, '{}', 'The heart of a wolf.', 0.25, 0),
	('wolfnativetent', 'Wolf Native Tent', 100, 1, 'item_standard', 1, 216031, 1, '{}', 'nice item', 1.00, 0),
	('wolfpelt', 'pele de lobo', 100, 1, 'item_standard', 1, 477, 1, '{}', 'The skin of a wolf.', 0.25, 0),
	('wolftooth', 'Dente de Lobo', 100, 1, 'item_standard', 1, 478, 1, '{}', 'A tooth extracted from a wolf.', 0.80, 0),
	('wolf_alfa', 'Poção do lobisomen alfa', 100, 1, 'item_standard', 1, 215853, 1, '{}', 'nice item', 0.25, 0),
	('wolf_beta', 'Poção do lobisomen beta', 100, 1, 'item_standard', 1, 215852, 1, '{}', 'nice item', 0.25, 0),
	('wolf_comum', 'Poção do lobisomen comum', 100, 1, 'item_standard', 1, 215851, 1, '{}', 'nice item', 0.25, 0),
	('woman_idcard', 'Identificação', 1, 1, 'item_standard', 1, 215654, 1, '{}', 'Identity card with information written on it', 0.25, 0),
	('wood', 'madeira macia', 100, 1, 'item_standard', 1, 333, 1, '{}', 'A type of wood that is soft and easy to work with.', 0.25, 0),
	('woodbench', 'Banco de madeira', 100, 1, 'item_standard', 1, 777, 1, '{}', 'A bench made from wood material.', 0.25, 0),
	('woodchair', 'cadeira de madeira', 100, 1, 'item_standard', 1, 747, 1, '{}', 'A chair made from wood material.', 0.25, 0),
	('wooden_bench', 'Banco de madeira', 100, 1, 'item_standard', 1, 649, 1, '{}', 'A bench constructed with wooden material.', 0.25, 0),
	('wooden_boards', 'Pranchas de madeira', 100, 1, 'item_standard', 1, 334, 1, '{}', 'Boards made from wood material.', 0.25, 0),
	('woodfence', 'Wood Fence', 100, 1, 'item_standard', 1, 216008, 1, '{}', 'nice item', 1.00, 0),
	('woodpeck01_c', 'pica-pau', 100, 1, 'item_standard', 1, 445, 1, '{}', 'The skin and feathers of a woodpecker.', 0.25, 0),
	('woodpeck02_c', 'pica-pau 2', 100, 1, 'item_standard', 1, 446, 1, '{}', 'The skin and feathers of a woodpecker.', 0.25, 0),
	('woodsaw', 'Serra de madeira', 100, 1, 'item_standard', 1, 1809, 1, '{}', 'Used to cut wood.', 0.25, 0),
	('wood_chair', 'cadeira de madeira', 100, 1, 'item_standard', 1, 619, 1, '{}', 'A chair made from wood material.', 0.25, 0),
	('wood_plane', 'avião de madeira', 100, 1, 'item_standard', 1, 1810, 1, '{}', 'A wood plane used for shaping wood.', 0.25, 0),
	('wood_vieja', 'Madeira para entrega', 100, 1, 'item_standard', 1, 17275, 1, '{}', 'nice item', 0.25, 0),
	('wool', 'Lã', 100, 1, 'item_standard', 1, 335, 1, '{}', 'Fiber obtained from the fleece of sheep.', 0.25, 0),
	('wrench', 'chave inglesa', 100, 1, 'item_standard', 1, 1811, 1, '{}', 'A wrech used to tighten bolts and other things.', 0.25, 0),
	('wsnakes', 'pele de cascavel ocidental', 100, 1, 'item_standard', 1, 489, 1, '{}', 'The skin of a western rattlesnake.', 0.25, 0),
	('wsnakeskin', 'pele de cobra dágua', 100, 1, 'item_standard', 1, 485, 1, '{}', 'The skin of a watersnake.', 0.25, 0),
	('xmaspole', 'Christmas Pole', 100, 1, 'item_standard', 1, 216013, 1, '{}', 'nice item', 1.00, 0),
	('xmastree', 'Christmas Tree', 100, 1, 'item_standard', 1, 216025, 1, '{}', 'nice item', 1.00, 0),
	('Yarrow', 'Yarrow', 30, 1, 'item_standard', 1, 336, 1, '{}', 'A flowering plant known as Yarrow.', 0.25, 0),
	('Yarrow_Seed', 'semente de milefólio', 100, 1, 'item_standard', 1, 337, 1, '{}', 'Seeds to grow Yarrow plants.', 0.25, 0),
	('yuccaleaf', 'Yucca Leaf', 50, 1, 'item_standard', 1, 17689, 1, '{}', 'an item', 0.25, 0);

-- Copiando estrutura para tabela mdg_ultimate.items_crafted
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

-- Copiando dados para a tabela mdg_ultimate.items_crafted: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.item_group
CREATE TABLE IF NOT EXISTS `item_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL COMMENT 'Description of Item Group',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.item_group: ~11 rows (aproximadamente)
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

-- Copiando estrutura para tabela mdg_ultimate.jail
CREATE TABLE IF NOT EXISTS `jail` (
  `identifier` varchar(100) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '0',
  `characterid` varchar(5) NOT NULL DEFAULT '0',
  `time` varchar(100) NOT NULL DEFAULT '0',
  `time_s` varchar(100) NOT NULL DEFAULT '0',
  `jaillocation` varchar(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela mdg_ultimate.jail: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.loadout
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

-- Copiando dados para a tabela mdg_ultimate.loadout: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mail
CREATE TABLE IF NOT EXISTS `mail` (
  `address` int(11) NOT NULL AUTO_INCREMENT,
  `charidentifier` int(11) DEFAULT NULL,
  PRIMARY KEY (`address`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mail: ~1 rows (aproximadamente)
INSERT IGNORE INTO `mail` (`address`, `charidentifier`) VALUES
	(1, 1);

-- Copiando estrutura para tabela mdg_ultimate.mailbox_mails
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

-- Copiando dados para a tabela mdg_ultimate.mailbox_mails: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mails
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

-- Copiando dados para a tabela mdg_ultimate.mails: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mail_addressbook
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

-- Copiando dados para a tabela mdg_ultimate.mail_addressbook: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mail_editablefolders
CREATE TABLE IF NOT EXISTS `mail_editablefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` int(11) DEFAULT NULL,
  `folderName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `address` (`address`),
  CONSTRAINT `mail_editablefolders_ibfk_1` FOREIGN KEY (`address`) REFERENCES `mail` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mail_editablefolders: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdgfarmsdex
CREATE TABLE IF NOT EXISTS `mdgfarmsdex` (
  `dex` longtext DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdgfarmsdex: ~0 rows (aproximadamente)
INSERT IGNORE INTO `mdgfarmsdex` (`dex`) VALUES
	('3');

-- Copiando estrutura para tabela mdg_ultimate.mdg_bank
CREATE TABLE IF NOT EXISTS `mdg_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `money` double(22,2) DEFAULT 0.00,
  `gold` double(22,2) DEFAULT 0.00,
  `items` longtext DEFAULT '[]',
  `invspace` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_bank: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_barber
CREATE TABLE IF NOT EXISTS `mdg_barber` (
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

-- Copiando dados para a tabela mdg_ultimate.mdg_barber: ~3 rows (aproximadamente)
INSERT IGNORE INTO `mdg_barber` (`id`, `identifier`, `charid`, `ownername`, `money`, `name`, `price`, `blipsprite`, `blipmodif`) VALUES
	(1, '0', 0, '', 4, 'Blackwater Barber', 2500, -2090472724, 0),
	(2, '0', 0, '', 3, 'Valentine Barber', 2000, -2090472724, 0),
	(3, '0', 0, '', 4, 'Saint Denis Barber', 3000, -2090472724, 0);

-- Copiando estrutura para tabela mdg_ultimate.mdg_clothes_state
CREATE TABLE IF NOT EXISTS `mdg_clothes_state` (
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `category` varchar(20) NOT NULL,
  `state` int(11) NOT NULL,
  PRIMARY KEY (`identifier`,`charid`,`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_clothes_state: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_coaches_system
CREATE TABLE IF NOT EXISTS `mdg_coaches_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `charid` int(5) NOT NULL,
  `model` int(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `components` varchar(5000) NOT NULL,
  `price` int(8) NOT NULL DEFAULT 0,
  `coach_condition` int(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_coaches_system: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_collect_quests
CREATE TABLE IF NOT EXISTS `mdg_collect_quests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `questtype` int(2) NOT NULL,
  `questid` int(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_collect_quests: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_farms
CREATE TABLE IF NOT EXISTS `mdg_farms` (
  `charid` int(11) NOT NULL,
  `farm` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_farms: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_gang_members
CREATE TABLE IF NOT EXISTS `mdg_gang_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `gang_name` varchar(255) NOT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_gang_members: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_gang_props
CREATE TABLE IF NOT EXISTS `mdg_gang_props` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_name` varchar(50) DEFAULT NULL,
  `gang_name` varchar(50) DEFAULT NULL,
  `prop_name` varchar(50) DEFAULT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `area_name` (`area_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_gang_props: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_gang_territories
CREATE TABLE IF NOT EXISTS `mdg_gang_territories` (
  `area_name` varchar(50) NOT NULL,
  `gang_name` varchar(50) NOT NULL,
  PRIMARY KEY (`area_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_gang_territories: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_horses
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_horses: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_horses_stats
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

-- Copiando dados para a tabela mdg_ultimate.mdg_horses_stats: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_identidade_advanced
CREATE TABLE IF NOT EXISTS `mdg_identidade_advanced` (
  `identifier` varchar(60) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `birthdate` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_identidade_advanced: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_jornalista
CREATE TABLE IF NOT EXISTS `mdg_jornalista` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news` longtext DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_jornalista: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_madame_nazar
CREATE TABLE IF NOT EXISTS `mdg_madame_nazar` (
  `charid` int(11) DEFAULT NULL,
  `identifier` varchar(100) DEFAULT NULL,
  `mdg_madame_nazar` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_madame_nazar: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_matabolism_v2
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

-- Copiando dados para a tabela mdg_ultimate.mdg_matabolism_v2: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_outfits
CREATE TABLE IF NOT EXISTS `mdg_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL,
  `charid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `outfit` varchar(5000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`,`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_outfits: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_ped_system
CREATE TABLE IF NOT EXISTS `mdg_ped_system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `steamname` varchar(50) DEFAULT NULL,
  `charidentifier` varchar(50) DEFAULT NULL,
  `ped` varchar(50) DEFAULT NULL,
  `outfit` int(11) DEFAULT NULL,
  `scale` float DEFAULT 0,
  `pedDate` timestamp NULL DEFAULT NULL,
  `pedUseOutfit` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_ped_system: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_quests
CREATE TABLE IF NOT EXISTS `mdg_quests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `questtype` int(2) NOT NULL,
  `questid` int(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_quests: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_stable_bought
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

-- Copiando dados para a tabela mdg_ultimate.mdg_stable_bought: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_stable_color
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

-- Copiando dados para a tabela mdg_ultimate.mdg_stable_color: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_traficante_drogas
CREATE TABLE IF NOT EXISTS `mdg_traficante_drogas` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL DEFAULT '0',
  `charid` varchar(50) NOT NULL,
  `reputation` varchar(5000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_traficante_drogas: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_vip
CREATE TABLE IF NOT EXISTS `mdg_vip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` text DEFAULT NULL,
  `charid` int(11) DEFAULT NULL,
  `vip` text DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `charid` (`charid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mdg_vip: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.mdg_wagons
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

-- Copiando dados para a tabela mdg_ultimate.mdg_wagons: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.outfits
CREATE TABLE IF NOT EXISTS `outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(45) NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `comps` longtext DEFAULT NULL,
  `compTints` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela mdg_ultimate.outfits: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.pets
CREATE TABLE IF NOT EXISTS `pets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(500) DEFAULT NULL,
  `charid` int(11) DEFAULT 0,
  `selected` int(11) DEFAULT 0,
  `pets_info` varchar(3000) DEFAULT NULL,
  `is_dead` int(11) DEFAULT 0,
  `favorite` longtext NOT NULL DEFAULT '{}',
  `called` longtext NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela mdg_ultimate.pets: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.playerhousing
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

-- Copiando dados para a tabela mdg_ultimate.playerhousing: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.playerhousing_sold_home_ledger
CREATE TABLE IF NOT EXISTS `playerhousing_sold_home_ledger` (
  `id` int(11) NOT NULL DEFAULT 0,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.playerhousing_sold_home_ledger: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.playershops
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.playershops: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.playershops2
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

-- Copiando dados para a tabela mdg_ultimate.playershops2: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.player_trains
CREATE TABLE IF NOT EXISTS `player_trains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `contid` int(11) DEFAULT NULL,
  `maint` float DEFAULT 100,
  `coal` int(11) DEFAULT 0,
  `coalcap` int(11) DEFAULT NULL,
  `speed` float DEFAULT NULL,
  `hash` varchar(50) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `coalcon` int(11) DEFAULT NULL,
  `img` varchar(50) DEFAULT NULL,
  `coalup` int(11) DEFAULT 0,
  `speedup` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.player_trains: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.player_transformations
CREATE TABLE IF NOT EXISTS `player_transformations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `charid` int(11) NOT NULL,
  `transform_end` datetime NOT NULL,
  `animal_model` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_transformation` (`identifier`,`charid`),
  KEY `idx_identifier` (`identifier`),
  KEY `idx_charid` (`charid`),
  KEY `idx_transform_end` (`transform_end`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.player_transformations: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.posters
CREATE TABLE IF NOT EXISTS `posters` (
  `poster_link` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT '',
  `date` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `icName` varchar(500) DEFAULT NULL,
  KEY `poster_link` (`poster_link`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.posters: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.ranch
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

-- Copiando dados para a tabela mdg_ultimate.ranch: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.real_logic_horses
CREATE TABLE IF NOT EXISTS `real_logic_horses` (
  `update_time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.real_logic_horses: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.real_logic_pets
CREATE TABLE IF NOT EXISTS `real_logic_pets` (
  `update_time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.real_logic_pets: ~0 rows (aproximadamente)
INSERT IGNORE INTO `real_logic_pets` (`update_time`) VALUES
	(9);

-- Copiando estrutura para tabela mdg_ultimate.real_logic_ranch
CREATE TABLE IF NOT EXISTS `real_logic_ranch` (
  `update_time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.real_logic_ranch: ~0 rows (aproximadamente)
INSERT IGNORE INTO `real_logic_ranch` (`update_time`) VALUES
	(0);

-- Copiando estrutura para tabela mdg_ultimate.rooms
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `key` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela mdg_ultimate.rooms: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.society
CREATE TABLE IF NOT EXISTS `society` (
  `job` longtext DEFAULT NULL,
  `jobgrade` int(11) DEFAULT NULL,
  `salary` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.society: ~42 rows (aproximadamente)
INSERT IGNORE INTO `society` (`job`, `jobgrade`, `salary`) VALUES
	('police', 0, 0),
	('police', 1, 0),
	('police', 2, 0),
	('police', 3, 0),
	('police', 4, 0),
	('police', 5, 0),
	('police', 6, 30),
	('miner', 1, 0),
	('miner', 2, 0),
	('miner', 3, 0),
	('miner', 4, 0),
	('miner', 0, 0),
	('doctor', 0, 0),
	('doctor', 1, 0),
	('doctor', 2, 0),
	('doctor', 3, 0),
	('horsetrainer', 0, 0),
	('horsetrainer', 1, 0),
	('horsetrainer', 2, 0),
	('horsetrainer', 3, 0),
	('SaloonRH', 3, 0),
	('police', 0, 0),
	('police', 1, 0),
	('police', 2, 0),
	('police', 3, 0),
	('police', 4, 0),
	('police', 5, 0),
	('police', 6, 30),
	('miner', 1, 0),
	('miner', 2, 0),
	('miner', 3, 0),
	('miner', 4, 0),
	('miner', 0, 0),
	('doctor', 0, 0),
	('doctor', 1, 0),
	('doctor', 2, 0),
	('doctor', 3, 0),
	('horsetrainer', 0, 0),
	('horsetrainer', 1, 0),
	('horsetrainer', 2, 0),
	('horsetrainer', 3, 0),
	('horsetrainer', 4, 0);

-- Copiando estrutura para tabela mdg_ultimate.society_ledger
CREATE TABLE IF NOT EXISTS `society_ledger` (
  `job` longtext DEFAULT NULL,
  `ledger` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.society_ledger: ~91 rows (aproximadamente)
INSERT IGNORE INTO `society_ledger` (`job`, `ledger`) VALUES
	('police', 150),
	('miner', 0),
	('doctor', 50),
	('horsetrainer', 0),
	('Fazenda08', 0),
	('doctor', 0),
	('ArmariaAN', 0),
	('ArmariaVL', 50),
	('ArmariaRH', 0),
	('ArmariaTW', 0),
	('ArmariaSD', 0),
	('SaloonARM', 0),
	('saloonVL', 0),
	('SaloonRH', 0),
	('SaloonBW', 0),
	('FerrariaSB', 0),
	('FerrariaVL', 0),
	('FerrariaSD', 0),
	('Fazenda01', 0),
	('FerrariaRH', 0),
	('Fazenda02', 0),
	('Fazenda03', 0),
	('Fazenda04', 0),
	('Fazenda05', 0),
	('Fazenda06', 0),
	('PadariaBW', 0),
	('PadariaESM', 0),
	('MoonshinerSD', 0),
	('MoonshinerVL', 0),
	('MoonshinerBW', 0),
	('Aldeia01', 0),
	('Aldeia02', 0),
	('Aldeia03', 0),
	('TreinadorRH', 0),
	('TreinadorVL', 0),
	('TreinadorMFR', 0),
	('TreinadorBW', 0),
	('FerrariaBW', 0),
	('ArtesanatoRH', 0),
	('ArtesanatoBW', 0),
	('SaloonESM', 0),
	('SaloonVH', 0),
	('TabacariaVL', 0),
	('Petrolifera', 0),
	('Papelaria', 0),
	('Fazenda07', 0),
	('police', 0),
	('Fazenda09', 0),
	('miner', 0),
	('Fazenda11', 0),
	('Fazenda38', 0),
	('Fazenda39', 0),
	('Fazenda40', 0),
	('Fazenda41', 0),
	('Fazenda42', 0),
	('Fazenda43', 0),
	('fazenda10', 0),
	('fazenda12', 0),
	('fazenda13', 0),
	('fazenda14', 0),
	('fazenda15', 0),
	('fazenda16', 0),
	('fazenda17', 0),
	('fazenda18', 0),
	('fazenda19', 0),
	('fazenda20', 0),
	('fazenda21', 0),
	('fazenda22', 0),
	('fazenda23', 0),
	('fazenda24', 0),
	('fazenda25', 0),
	('fazenda26', 0),
	('fazenda27', 0),
	('fazenda28', 0),
	('fazenda29', 0),
	('fazenda30', 0),
	('fazenda31', 0),
	('fazenda32', 0),
	('fazenda33', 0),
	('fazenda34', 0),
	('fazenda35', 0),
	('fazenda36', 0),
	('fazenda37', 0),
	('SerrariaBW', 0),
	('FerrariaSB', 0),
	('SaloonSD', 0),
	('TabacariaBW', 0),
	('ArmariaBW', 0),
	('police', 0),
	('police', 0),
	('police', 0);

-- Copiando estrutura para tabela mdg_ultimate.society_shops
CREATE TABLE IF NOT EXISTS `society_shops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `society` varchar(50) NOT NULL DEFAULT '0',
  `items` longtext NOT NULL DEFAULT '[]',
  `weapons` longtext NOT NULL DEFAULT '[]',
  `slots` int(11) NOT NULL DEFAULT 50,
  `level` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.society_shops: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.stables
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

-- Copiando dados para a tabela mdg_ultimate.stables: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.stagecoaches
CREATE TABLE IF NOT EXISTS `stagecoaches` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `stagecoach` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.stagecoaches: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.underground
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

-- Copiando dados para a tabela mdg_ultimate.underground: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `group` varchar(50) DEFAULT 'user',
  `warnings` int(11) DEFAULT 0,
  `banned` tinyint(1) DEFAULT NULL,
  `banneduntil` int(10) DEFAULT 0,
  `char` int(11) DEFAULT 5,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.users: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vltfarmsdex
CREATE TABLE IF NOT EXISTS `vltfarmsdex` (
  `dex` longtext DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vltfarmsdex: ~0 rows (aproximadamente)
INSERT IGNORE INTO `vltfarmsdex` (`dex`) VALUES
	('0');

-- Copiando estrutura para tabela mdg_ultimate.vlt_admin_adv
CREATE TABLE IF NOT EXISTS `vlt_admin_adv` (
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `discord` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `warnings` int(11) DEFAULT 0,
  `banned` int(11) NOT NULL DEFAULT 0,
  `playTime` int(11) DEFAULT 0,
  `lastJoin` int(11) DEFAULT 0,
  `lastLeave` int(11) DEFAULT NULL,
  `banTime` int(50) DEFAULT NULL,
  `banReason` varchar(200) DEFAULT NULL,
  `banId` varchar(50) DEFAULT NULL,
  `ajail` int(11) DEFAULT 0,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_admin_adv: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_bank
CREATE TABLE IF NOT EXISTS `vlt_bank` (
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_bank: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_barber_system
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

-- Copiando dados para a tabela mdg_ultimate.vlt_barber_system: ~3 rows (aproximadamente)
INSERT IGNORE INTO `vlt_barber_system` (`id`, `identifier`, `charid`, `ownername`, `money`, `name`, `price`, `blipsprite`, `blipmodif`) VALUES
	(1, '0', 0, '', 0, 'Blackwater Barber', 2500, -2090472724, 0),
	(2, '0', 0, '', 0, 'Valentine Barber', 2000, -2090472724, 0),
	(3, '0', 0, '', 0, 'Saint Denis Barber', 3000, -2090472724, 0);

-- Copiando estrutura para tabela mdg_ultimate.vlt_boats_system
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

-- Copiando dados para a tabela mdg_ultimate.vlt_boats_system: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_domination_members
CREATE TABLE IF NOT EXISTS `vlt_domination_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `gang_name` varchar(255) NOT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_domination_members: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_domination_props
CREATE TABLE IF NOT EXISTS `vlt_domination_props` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area_name` varchar(50) DEFAULT NULL,
  `gang_name` varchar(50) DEFAULT NULL,
  `prop_name` varchar(50) DEFAULT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `area_name` (`area_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=508 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_domination_props: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_domination_territories
CREATE TABLE IF NOT EXISTS `vlt_domination_territories` (
  `area_name` varchar(50) NOT NULL,
  `gang_name` varchar(50) NOT NULL,
  PRIMARY KEY (`area_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_domination_territories: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_horses
CREATE TABLE IF NOT EXISTS `vlt_horses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `stable` varchar(50) NOT NULL,
  `model` varchar(100) NOT NULL,
  `isFemale` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL,
  `speed` tinyint(4) NOT NULL,
  `acceleration` tinyint(4) NOT NULL,
  `handling` tinyint(4) NOT NULL,
  `favourite` tinyint(1) NOT NULL DEFAULT 0,
  `isDead` tinyint(1) NOT NULL DEFAULT 0,
  `isOut` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_horses: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_horses_stats
CREATE TABLE IF NOT EXISTS `vlt_horses_stats` (
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

-- Copiando dados para a tabela mdg_ultimate.vlt_horses_stats: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_identity
CREATE TABLE IF NOT EXISTS `vlt_identity` (
  `identifier` varchar(60) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `birthdate` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_identity: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_journalist
CREATE TABLE IF NOT EXISTS `vlt_journalist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news` longtext DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_journalist: ~0 rows (aproximadamente)
INSERT IGNORE INTO `vlt_journalist` (`id`, `news`) VALUES
	(1, '[]');

-- Copiando estrutura para tabela mdg_ultimate.vlt_madame_nazar
CREATE TABLE IF NOT EXISTS `vlt_madame_nazar` (
  `charid` int(11) DEFAULT NULL,
  `identifier` varchar(100) DEFAULT NULL,
  `VLT_madame_nazar` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_madame_nazar: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_matabolism
CREATE TABLE IF NOT EXISTS `vlt_matabolism` (
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

-- Copiando dados para a tabela mdg_ultimate.vlt_matabolism: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_ped_menu
CREATE TABLE IF NOT EXISTS `vlt_ped_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `steamname` varchar(50) DEFAULT NULL,
  `charidentifier` varchar(50) DEFAULT NULL,
  `ped` varchar(50) DEFAULT NULL,
  `outfit` int(11) DEFAULT NULL,
  `scale` float DEFAULT 0,
  `pedDate` timestamp NULL DEFAULT NULL,
  `pedUseOutfit` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_ped_menu: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_plantation
CREATE TABLE IF NOT EXISTS `vlt_plantation` (
  `charid` int(11) NOT NULL,
  `farm` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_plantation: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_posters
CREATE TABLE IF NOT EXISTS `vlt_posters` (
  `id` varchar(50) NOT NULL DEFAULT '0',
  `identifier` varchar(50) DEFAULT NULL,
  `charid` varchar(50) DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  `link` varchar(500) DEFAULT NULL,
  `pos` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_posters: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_stable_bought
CREATE TABLE IF NOT EXISTS `vlt_stable_bought` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `hash` bigint(20) NOT NULL,
  `equiped_on` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`,`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_stable_bought: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_stable_color
CREATE TABLE IF NOT EXISTS `vlt_stable_color` (
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

-- Copiando dados para a tabela mdg_ultimate.vlt_stable_color: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vlt_wagons
CREATE TABLE IF NOT EXISTS `vlt_wagons` (
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

-- Copiando dados para a tabela mdg_ultimate.vlt_wagons: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.wagons
CREATE TABLE IF NOT EXISTS `wagons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(600) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `comp_extras` varchar(500) DEFAULT '{"1":"1","10":"1","20":"1","8":"1","6":"1","11":"1","7":"1","15":"1","18":"1","19":"1","16":"1","17":"1","3":"1","2":"1","5":"1","4":"1","13":"1","12":"1","9":"1","14":"1"}',
  `comp_lantern` varchar(255) DEFAULT 'none',
  `comp_liveries` varchar(255) DEFAULT '-1',
  `cityPosition` int(11) NOT NULL DEFAULT 0,
  `spotPosition` int(11) NOT NULL DEFAULT 0,
  `interiorPosition` int(11) NOT NULL DEFAULT 0,
  `housePosition` int(11) NOT NULL DEFAULT 0,
  `comp_tints` varchar(255) DEFAULT '-1',
  `comp_propset` varchar(200) NOT NULL DEFAULT 'none',
  `addonArray` longtext DEFAULT NULL,
  `addon_ability` bigint(20) DEFAULT 0,
  `damage_wheel` longtext DEFAULT '[]',
  `horses` varchar(200) NOT NULL DEFAULT '0',
  `health_cart` int(11) NOT NULL DEFAULT 1000,
  `animals` longtext DEFAULT NULL,
  `buildState` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_horses_characters` (`charid`),
  KEY `model` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.wagons: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `firstconnection` tinyint(1) DEFAULT 1,
  `discordid` varchar(255) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela mdg_ultimate.whitelist: ~0 rows (aproximadamente)

-- Copiando estrutura para trigger mdg_ultimate.add_mdg_horses_stats
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `add_mdg_horses_stats` AFTER INSERT ON `mdg_horses` FOR EACH ROW INSERT INTO mdg_horses_stats (horseid) VALUES (NEW.id)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger mdg_ultimate.add_VLT_horses_stats
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `add_VLT_horses_stats` AFTER INSERT ON `VLT_horses` FOR EACH ROW INSERT INTO VLT_horses_stats (horseid) VALUES (NEW.id)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger mdg_ultimate.delete_mdg_horses_stats
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `delete_mdg_horses_stats` AFTER DELETE ON `mdg_horses` FOR EACH ROW DELETE FROM mdg_horses_stats WHERE horseid = OLD.id//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger mdg_ultimate.delete_mdg_stable_color
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `delete_mdg_stable_color` AFTER DELETE ON `mdg_stable_bought` FOR EACH ROW DELETE FROM `mdg_stable_color` WHERE id = OLD.id//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger mdg_ultimate.delete_VLT_horses_stats
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `delete_VLT_horses_stats` AFTER DELETE ON `VLT_horses` FOR EACH ROW DELETE FROM VLT_horses_stats WHERE horseid = OLD.id//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger mdg_ultimate.delete_VLT_stable_color
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `delete_VLT_stable_color` AFTER DELETE ON `VLT_stable_bought` FOR EACH ROW DELETE FROM `VLT_stable_color` WHERE id = OLD.id//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger mdg_ultimate.update_mdg_stable_equiped_component
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `update_mdg_stable_equiped_component` AFTER DELETE ON `mdg_horses` FOR EACH ROW UPDATE `mdg_stable_bought` SET equiped_on = 0 WHERE equiped_on = OLD.id//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger mdg_ultimate.update_VLT_stable_equiped_component
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `update_VLT_stable_equiped_component` AFTER DELETE ON `VLT_horses` FOR EACH ROW UPDATE `VLT_stable_bought` SET equiped_on = 0 WHERE equiped_on = OLD.id//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
