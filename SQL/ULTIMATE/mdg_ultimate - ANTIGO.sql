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

-- Copiando estrutura para tabela mdg_ultimate.centralcart_scheduler
CREATE TABLE IF NOT EXISTS `centralcart_scheduler` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `command` varchar(255) NOT NULL,
  `params` text DEFAULT NULL,
  `execute_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.centralcart_scheduler: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.container: ~86 rows (aproximadamente)
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
	(84, 'TabacariaBW', '[]', 5000),
	(85, 'TreinadorSW', '{}', 5000),
	(86, 'TreinadorSD', '{}', 5000);

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
  PRIMARY KEY (`item`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `FK_items_item_group` (`groupId`) USING BTREE,
  CONSTRAINT `FK_items_item_group` FOREIGN KEY (`groupId`) REFERENCES `item_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `metadata` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB AUTO_INCREMENT=1567 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela mdg_ultimate.items: ~819 rows (aproximadamente)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `id`, `groupId`, `metadata`, `desc`, `weight`) VALUES
	('accessories', 'Acessórios', 100, 1, 'item_standard', 1, 252, 1, '{}', 'nice item', 0.20),
	('Alaskan_Ginseng', 'Ginseng do Alaska', 100, 1, 'item_standard', 1, 586, 1, '{}', 'nice item', 0.20),
	('alcohol', 'Álcool', 100, 1, 'item_standard', 1, 588, 1, '{}', 'nice item', 0.50),
	('alcool', 'Álcool', 100, 1, 'item_standard', 1, 361, 1, '{}', 'nice item', 0.50),
	('aligators', 'Pele de Jacare', 100, 1, 'item_standard', 1, 1451, 1, '{}', 'nice item', 1.00),
	('aligatorto', 'Cabeça de Jacare', 100, 1, 'item_standard', 1, 1479, 1, '{}', 'nice item', 2.00),
	('American_Ginseng', 'Ginseng Americano', 100, 1, 'item_standard', 1, 587, 1, '{}', 'nice item', 0.20),
	('ammoarrmownormal', 'Munição Flecha Normal', 1000, 1, 'item_standard', 1, 576, 1, '{}', 'nice item', 0.02),
	('ammoarrowdynamite', 'Flecha Dinamite', 1000, 1, 'item_standard', 1, 634, 1, '{}', 'nice item', 0.03),
	('ammoarrowfire', 'Flecha de Fogo', 1000, 1, 'item_standard', 1, 635, 1, '{}', 'nice item', 0.02),
	('ammoarrowimproved', 'Flecha Melhorada', 1000, 1, 'item_standard', 1, 636, 1, '{}', 'nice item', 0.02),
	('ammoarrowpoison', 'Flecha Envenenada', 1000, 1, 'item_standard', 1, 637, 1, '{}', 'nice item', 0.02),
	('ammoarrowsmallgame', 'Munição Flecha Pequena', 1000, 1, 'item_standard', 1, 577, 1, '{}', 'nice item', 0.02),
	('ammobolahawk', 'Bola Falcão', 1000, 1, 'item_standard', 1, 642, 1, '{}', 'nice item', 0.02),
	('ammobolainterwired', 'Bola Entrelaçada', 1000, 1, 'item_standard', 1, 643, 1, '{}', 'nice item', 0.02),
	('ammobolaironspiked', 'Bola Ferro com Espinhos', 1000, 1, 'item_standard', 1, 644, 1, '{}', 'nice item', 0.02),
	('ammobolla', 'Munição Bola', 1000, 1, 'item_standard', 1, 641, 1, '{}', 'nice item', 0.02),
	('ammodynamite', 'Dinamite', 1000, 1, 'item_standard', 1, 645, 1, '{}', 'nice item', 0.05),
	('ammoelephant', 'Munição Elefante', 1000, 1, 'item_standard', 1, 374, 1, '{}', 'nice item', 0.05),
	('ammoknives', 'Munição Facas', 1000, 1, 'item_standard', 1, 639, 1, '{}', 'nice item', 0.02),
	('ammomolotov', 'Coquetel Molotov', 1000, 1, 'item_standard', 1, 647, 1, '{}', 'nice item', 0.50),
	('ammopistolexplosive', 'Munição Pistola Explosiva', 1000, 1, 'item_standard', 1, 631, 1, '{}', 'nice item', 0.03),
	('ammopistolexpress', 'Munição Pistola Express', 1000, 1, 'item_standard', 1, 370, 1, '{}', 'nice item', 0.02),
	('ammopistolnormal', 'Munição Pistola Normal', 1000, 1, 'item_standard', 1, 311, 1, '{}', 'nice item', 0.02),
	('ammopistolsplitpoint', 'Munição Pistola Ponta Dividida', 1000, 1, 'item_standard', 1, 633, 1, '{}', 'nice item', 0.02),
	('ammopistolvelocity', 'Munição Pistola Velocidade', 1000, 1, 'item_standard', 1, 632, 1, '{}', 'nice item', 0.02),
	('ammopoisonbottle', 'Garrafa de Veneno', 1000, 1, 'item_standard', 1, 640, 1, '{}', 'nice item', 0.30),
	('ammorepeaterexplosive', 'Munição Repetidora Explosiva', 1000, 1, 'item_standard', 1, 620, 1, '{}', 'nice item', 0.03),
	('ammorepeaterexpress', 'Munição Repetidora Express', 1000, 1, 'item_standard', 1, 372, 1, '{}', 'nice item', 0.02),
	('ammorepeaternormal', 'Munição Repetidora Normal', 1000, 1, 'item_standard', 1, 313, 1, '{}', 'nice item', 0.02),
	('ammorepeatersplitpoint', 'Munição Repetidora Ponta Dividida', 1000, 1, 'item_standard', 1, 621, 1, '{}', 'nice item', 0.02),
	('ammorepeatervelocity', 'Munição Repetidora Velocidade', 1000, 1, 'item_standard', 1, 373, 1, '{}', 'nice item', 0.02),
	('ammorevolverexplosive', 'Munição Revólver Explosiva', 1000, 1, 'item_standard', 1, 622, 1, '{}', 'nice item', 0.03),
	('ammorevolverexpress', 'Munição Revólver Express', 1000, 1, 'item_standard', 1, 371, 1, '{}', 'nice item', 0.02),
	('ammorevolvernormal', 'Munição Revólver Normal', 1000, 1, 'item_standard', 1, 312, 1, '{}', 'nice item', 0.02),
	('ammorevolversplitpoint', 'Munição Revólver Ponta Dividida', 1000, 1, 'item_standard', 1, 624, 1, '{}', 'nice item', 0.02),
	('ammorevolvervelocity', 'Munição Revólver Velocidade', 1000, 1, 'item_standard', 1, 623, 1, '{}', 'nice item', 0.02),
	('ammorifleexplosive', 'Munição Rifle Explosiva', 1000, 1, 'item_standard', 1, 626, 1, '{}', 'nice item', 0.03),
	('ammorifleexpress', 'Munição Rifle Express', 1000, 1, 'item_standard', 1, 625, 1, '{}', 'nice item', 0.02),
	('ammoriflenormal', 'Munição Rifle Normal', 1000, 1, 'item_standard', 1, 314, 1, '{}', 'nice item', 0.02),
	('ammoriflesplitpoint', 'Munição Rifle Ponta Dividida', 1000, 1, 'item_standard', 1, 375, 1, '{}', 'nice item', 0.02),
	('ammoriflevelocity', 'Munição Rifle Velocidade', 1000, 1, 'item_standard', 1, 627, 1, '{}', 'nice item', 0.02),
	('ammoshotgunexplosive', 'Munição Espingarda Explosiva', 1000, 1, 'item_standard', 1, 629, 1, '{}', 'nice item', 0.03),
	('ammoshotgunincendiary', 'Munição Espingarda Incendiária', 1000, 1, 'item_standard', 1, 628, 1, '{}', 'nice item', 0.03),
	('ammoshotgunnormal', 'Munição Espingarda Normal', 1000, 1, 'item_standard', 1, 315, 1, '{}', 'nice item', 0.03),
	('ammoshotgunslug', 'Munição Espingarda Slug', 1000, 1, 'item_standard', 1, 630, 1, '{}', 'nice item', 0.03),
	('ammotomahawk', 'Munição Tomahawk', 1000, 1, 'item_standard', 1, 579, 1, '{}', 'nice item', 0.03),
	('ammovarmint', 'Munição Varmint', 1000, 1, 'item_standard', 1, 578, 1, '{}', 'nice item', 0.02),
	('ammovarminttranq', 'Munição Varmint Tranquilizante', 1000, 1, 'item_standard', 1, 638, 1, '{}', 'nice item', 0.02),
	('ammovoldynamite', 'Dinamite Volátil', 1000, 1, 'item_standard', 1, 646, 1, '{}', 'nice item', 0.05),
	('ammovolmolotov', 'Molotov Volátil', 1000, 1, 'item_standard', 1, 648, 1, '{}', 'nice item', 0.50),
	('animal_crab', 'Caranguejo', 100, 1, 'item_standard', 1, 1511, 1, '{}', 'nice item', 0.30),
	('animal_crawfish', 'Carangueijo', 100, 1, 'item_standard', 1, 718, 1, '{}', 'nice item', 0.50),
	('Antilopepronta', 'Carne de Antílope Pronta', 100, 1, 'item_standard', 1, 97, 1, '{}', 'nice item', 0.50),
	('antipoison', 'Antiveneno', 100, 1, 'item_standard', 1, 289, 1, '{}', 'nice item', 0.30),
	('antipoison2', 'Antídoto Forte', 30, 1, 'item_standard', 1, 112, 1, '{}', 'nice item', 0.20),
	('apito', 'Apito de Passaros', 100, 1, 'item_standard', 1, 725, 1, '{}', 'nice item', 0.50),
	('apple', 'Maçã', 100, 1, 'item_standard', 1, 524, 1, '{}', 'nice item', 0.20),
	('apple_barrel', 'Barril de Maçãs', 100, 1, 'item_standard', 1, 176, 1, '{}', 'nice item', 5.00),
	('apple_basket', 'Cesta de Maçãs', 100, 1, 'item_standard', 1, 177, 1, '{}', 'nice item', 2.00),
	('aprons', 'Aventais', 100, 1, 'item_standard', 1, 258, 1, '{}', 'nice item', 0.50),
	('armadilloc', 'Garras de Tatu', 100, 1, 'item_standard', 1, 1486, 1, '{}', 'nice item', 0.20),
	('armadillos', 'Casco de Tatu', 100, 1, 'item_standard', 1, 1498, 1, '{}', 'nice item', 0.50),
	('armor', 'Armadura', 100, 1, 'item_standard', 1, 239, 1, '{}', 'nice item', 3.00),
	('a_c_frogbull_01', 'Sapo', 100, 1, 'item_standard', 1, 1510, 1, '{}', 'nice item', 0.20),
	('backpack1', 'Mochila Básica', 100, 1, 'item_standard', 1, 296, 1, '{}', 'nice item', 2.00),
	('backpack_10', 'Mochila +10 Slots', 1, 1, 'item_standard', 1, 60, 1, '{}', 'nice item', 2.00),
	('backpack_100', 'Mochila +100 Slots', 1, 1, 'item_standard', 1, 70, 1, '{}', 'nice item', 2.00),
	('backpack_15', 'Mochila +15 Slots', 1, 1, 'item_standard', 1, 61, 1, '{}', 'nice item', 2.00),
	('backpack_20', 'Mochila +20 Slots', 1, 1, 'item_standard', 1, 62, 1, '{}', 'nice item', 2.00),
	('backpack_200', 'Mochila +200 Slots', 1, 1, 'item_standard', 1, 71, 1, '{}', 'nice item', 2.00),
	('backpack_25', 'Mochila +25 Slots', 1, 1, 'item_standard', 1, 63, 1, '{}', 'nice item', 2.00),
	('backpack_30', 'Mochila +30 Slots', 1, 1, 'item_standard', 1, 64, 1, '{}', 'nice item', 2.00),
	('backpack_300', 'Mochila +300 Slots', 1, 1, 'item_standard', 1, 72, 1, '{}', 'nice item', 2.00),
	('backpack_35', 'Mochila +35 Slots', 1, 1, 'item_standard', 1, 65, 1, '{}', 'nice item', 2.00),
	('backpack_40', 'Mochila +40 Slots', 1, 1, 'item_standard', 1, 66, 1, '{}', 'nice item', 2.00),
	('backpack_400', 'Mochila +400 Slots', 1, 1, 'item_standard', 1, 73, 1, '{}', 'nice item', 2.00),
	('backpack_45', 'Mochila +45 Slots', 1, 1, 'item_standard', 1, 67, 1, '{}', 'nice item', 2.00),
	('backpack_5', 'Mochila +5 Slots', 1, 1, 'item_standard', 1, 59, 1, '{}', 'nice item', 2.00),
	('backpack_50', 'Mochila +50 Slots', 1, 1, 'item_standard', 1, 68, 1, '{}', 'nice item', 2.00),
	('backpack_500', 'Mochila +500 Slots', 1, 1, 'item_standard', 1, 74, 1, '{}', 'nice item', 2.00),
	('backpack_60', 'Mochila +60 Slots', 1, 1, 'item_standard', 1, 69, 1, '{}', 'nice item', 2.00),
	('backpack_600', 'Mochila +600 Slots', 1, 1, 'item_standard', 1, 75, 1, '{}', 'nice item', 2.00),
	('backpack_700', 'Mochila +700 Slots', 1, 1, 'item_standard', 1, 76, 1, '{}', 'nice item', 2.00),
	('bacon', 'Bacon', 100, 1, 'item_standard', 1, 273, 1, '{}', 'nice item', 0.30),
	('badge', 'Distintivo', 100, 1, 'item_standard', 1, 676, 1, '{}', 'nice item', 0.20),
	('badges', 'Distintivos', 100, 1, 'item_standard', 1, 269, 1, '{}', 'nice item', 0.20),
	('badge_deputy', 'Distintivo de Delegado Adjunto', 1, 1, 'item_standard', 1, 77, 1, '{}', 'nice item', 0.10),
	('badge_deputyy', 'Distintivo de Deputado', 1, 1, 'item_standard', 1, 83, 1, '{}', 'nice item', 0.10),
	('badge_marshal', 'Distintivo de Marshal', 1, 1, 'item_standard', 1, 82, 1, '{}', 'nice item', 0.10),
	('badge_officer', 'Distintivo de Oficial', 1, 1, 'item_standard', 1, 78, 1, '{}', 'nice item', 0.10),
	('badge_police', 'Distintivo de Polícia', 1, 1, 'item_standard', 1, 80, 1, '{}', 'nice item', 0.10),
	('badge_sheriff', 'Distintivo de Xerife', 1, 1, 'item_standard', 1, 79, 1, '{}', 'nice item', 0.10),
	('badge_texas_ranger', 'Distintivo de Texas Ranger', 1, 1, 'item_standard', 1, 81, 1, '{}', 'nice item', 0.10),
	('bandage', 'Bandagem', 100, 1, 'item_standard', 1, 288, 1, '{}', 'nice item', 0.20),
	('bandage_medic', 'Bandagem Médica', 100, 1, 'item_standard', 1, 290, 1, '{}', 'nice item', 0.20),
	('barrel', 'Barril', 100, 1, 'item_standard', 1, 562, 1, '{}', 'nice item', 5.00),
	('bat_c', 'Morcego', 100, 1, 'item_standard', 1, 1509, 1, '{}', 'nice item', 0.20),
	('bcandle', 'Vela Grande', 100, 1, 'item_standard', 1, 203, 1, '{}', 'nice item', 0.30),
	('bearc', 'Garras de Urso', 100, 1, 'item_standard', 1, 1487, 1, '{}', 'nice item', 0.30),
	('bear_bench', 'Banco de Urso', 100, 1, 'item_standard', 1, 187, 1, '{}', 'nice item', 8.00),
	('beer', 'Cerveja', 100, 1, 'item_standard', 1, 391, 1, '{}', 'nice item', 0.60),
	('beerbox', 'Caixa de Cerveja', 100, 1, 'item_standard', 1, 159, 1, '{}', 'nice item', 5.00),
	('bee_house_gk_1', 'Casa de Abelha 1', 100, 1, 'item_standard', 1, 557, 1, '{}', 'nice item', 5.00),
	('bee_house_gk_2', 'Casa de Abelha 2', 100, 1, 'item_standard', 1, 558, 1, '{}', 'nice item', 5.00),
	('bee_house_gk_3', 'Casa de Abelha 3', 100, 1, 'item_standard', 1, 559, 1, '{}', 'nice item', 5.00),
	('bee_house_gk_4', 'Casa de Abelha 4', 100, 1, 'item_standard', 1, 560, 1, '{}', 'nice item', 5.00),
	('bee_house_gk_6', 'Casa de Abelha 6', 100, 1, 'item_standard', 1, 561, 1, '{}', 'nice item', 5.00),
	('beggarhat', 'Chapéu de Mendigo', 5, 1, 'item_standard', 1, 698, 1, '{}', 'nice item', 0.20),
	('bell_pepper_assorted', 'Pimentão Sortido', 100, 1, 'item_standard', 1, 483, 1, '{}', 'nice item', 0.20),
	('bell_pepper_green', 'Pimentão Verde', 100, 1, 'item_standard', 1, 482, 1, '{}', 'nice item', 0.20),
	('belts', 'Cintos', 100, 1, 'item_standard', 1, 261, 1, '{}', 'nice item', 0.30),
	('belt_buckles', 'Fivelas de Cinto', 100, 1, 'item_standard', 1, 262, 1, '{}', 'nice item', 0.20),
	('Bicabornato', 'Bicarbonato', 100, 1, 'item_standard', 1, 363, 1, '{}', 'nice item', 0.30),
	('big_firecracker', 'grande foguete', 100, 1, 'item_standard', 1, 723, 1, '{}', 'nice item', 0.50),
	('big_fireworks', 'grandes fogos de artifício', 100, 1, 'item_standard', 1, 720, 1, '{}', 'nice item', 0.50),
	('bird', 'Carne de Ave', 100, 1, 'item_standard', 1, 1449, 1, '{}', 'nice item', 0.50),
	('Black_Berry', 'Amora Preta', 100, 1, 'item_standard', 1, 583, 1, '{}', 'nice item', 0.20),
	('black_currant', 'Groselha Preta', 100, 1, 'item_standard', 1, 470, 1, '{}', 'nice item', 0.20),
	('blanket_box', 'Caixa de Cobertores', 100, 1, 'item_standard', 1, 174, 1, '{}', 'nice item', 3.00),
	('blooditem', 'Item de Sangue', 100, 1, 'item_standard', 1, 678, 1, '{}', 'nice item', 0.30),
	('bmdresser', 'Cômoda Marrom', 100, 1, 'item_standard', 1, 194, 1, '{}', 'nice item', 10.00),
	('boarmusk', 'Presa de Javali', 100, 1, 'item_standard', 1, 1492, 1, '{}', 'nice item', 0.20),
	('bookcase', 'Estante de Livros', 100, 1, 'item_standard', 1, 115, 1, '{}', 'nice item', 10.00),
	('bookferr', 'Livro Ferraria', 100, 1, 'item_standard', 1, 713, 1, '{}', 'nice item', 0.50),
	('boots', 'Botas', 100, 1, 'item_standard', 1, 265, 1, '{}', 'nice item', 1.00),
	('boot_accessories', 'Acessórios de Bota', 100, 1, 'item_standard', 1, 266, 1, '{}', 'nice item', 0.20),
	('bread', 'Pão', 100, 1, 'item_standard', 1, 86, 1, '{}', 'nice item', 0.20),
	('breedpills', 'Pílulas de Reprodução', 100, 1, 'item_standard', 1, 90, 1, '{}', 'nice item', 0.10),
	('buckantler', 'Chifres de Cervo', 100, 1, 'item_standard', 1, 1482, 1, '{}', 'nice item', 0.50),
	('bunkbed', 'Beliche', 100, 1, 'item_standard', 1, 205, 1, '{}', 'nice item', 20.00),
	('butchertable1', 'Mesa de Açougueiro 1', 100, 1, 'item_standard', 1, 156, 1, '{}', 'nice item', 15.00),
	('butchertable2', 'Mesa de Açougueiro 2', 100, 1, 'item_standard', 1, 155, 1, '{}', 'nice item', 15.00),
	('butchertable3', 'Mesa de Açougueiro 3', 100, 1, 'item_standard', 1, 154, 1, '{}', 'nice item', 15.00),
	('bwdresser', 'Cômoda Branca', 100, 1, 'item_standard', 1, 193, 1, '{}', 'nice item', 10.00),
	('C1', 'Componente C1', 100, 1, 'item_standard', 1, 1, 1, '{}', 'nice item', 0.50),
	('C2', 'Componente C2', 100, 1, 'item_standard', 1, 2, 1, '{}', 'nice item', 0.50),
	('cabomadeira', 'Cabo de Madeira', 100, 1, 'item_standard', 1, 298, 1, '{}', 'nice item', 0.50),
	('cage', 'Gaiola', 100, 1, 'item_standard', 1, 119, 1, '{}', 'nice item', 5.00),
	('campfire', 'Fogueira', 100, 1, 'item_standard', 1, 91, 1, '{}', 'nice item', 2.00),
	('Camp_Book', 'Livro de Acampamento', 100, 1, 'item_standard', 1, 93, 1, '{}', 'nice item', 0.50),
	('candlea', 'Vela A', 100, 1, 'item_standard', 1, 201, 1, '{}', 'nice item', 0.20),
	('cannedevieux', 'Enlatado Velho', 100, 1, 'item_standard', 1, 530, 1, '{}', 'nice item', 0.50),
	('canteen', 'Cantil', 100, 1, 'item_standard', 1, 507, 1, '{}', 'nice item', 0.50),
	('canteenempty', 'Cantil Vazio', 100, 1, 'item_standard', 1, 506, 1, '{}', 'nice item', 0.50),
	('carne', 'Carne de caça', 100, 1, 'item_standard', 1, 1439, 1, '{}', 'nice item', 0.50),
	('carnepronta', 'Carne Pronta', 100, 1, 'item_standard', 1, 98, 1, '{}', 'nice item', 0.50),
	('carne_carneiro', 'Carne de Carneiro', 100, 1, 'item_standard', 1, 1444, 1, '{}', 'nice item', 0.50),
	('carriage_parts', 'Peças de Carruagem', 100, 1, 'item_standard', 1, 350, 1, '{}', 'nice item', 3.00),
	('carrots', 'Cenouras', 100, 1, 'item_standard', 1, 471, 1, '{}', 'nice item', 0.30),
	('cebola', 'Cebola', 100, 1, 'item_standard', 1, 465, 1, '{}', 'nice item', 0.20),
	('changer', 'Trocador', 100, 1, 'item_standard', 1, 114, 1, '{}', 'nice item', 2.00),
	('chaps', 'Perneiras', 100, 1, 'item_standard', 1, 268, 1, '{}', 'nice item', 0.80),
	('chesta', 'Baú A', 100, 1, 'item_standard', 1, 149, 1, '{}', 'nice item', 10.00),
	('chestb', 'Baú B', 100, 1, 'item_standard', 1, 150, 1, '{}', 'nice item', 10.00),
	('chestc', 'Baú C', 100, 1, 'item_standard', 1, 151, 1, '{}', 'nice item', 10.00),
	('chewingtobacco', 'Tabaco de Mascar', 50, 1, 'item_standard', 1, 109, 1, '{}', 'nice item', 0.10),
	('chewingtobacco2', 'Tabaco de Mascar Suave', 50, 1, 'item_standard', 1, 708, 1, '{}', 'nice item', 0.10),
	('chewingtobacco3', 'Tabaco de Mascar Forte', 50, 1, 'item_standard', 1, 709, 1, '{}', 'nice item', 0.10),
	('chewingtobacco4', 'Tabaco de Mascar Premium', 50, 1, 'item_standard', 1, 710, 1, '{}', 'nice item', 0.10),
	('chewingtobacco5', 'Tabaco de Mascar Especial', 50, 1, 'item_standard', 1, 711, 1, '{}', 'nice item', 0.10),
	('cigar', 'Charuto', 50, 1, 'item_standard', 1, 548, 1, '{}', 'nice item', 0.10),
	('cigarcard1', 'Card de Cigarro Vol.1', 100, 1, 'item_standard', 1, 547, 1, '{}', 'nice item', 0.05),
	('cigarcard2', 'Card de Cigarro Vol.2', 100, 1, 'item_standard', 1, 107, 1, '{}', 'nice item', 0.05),
	('cigarcard3', 'Carta de Cigarro 3', 100, 1, 'item_standard', 1, 108, 1, '{}', 'nice item', 0.10),
	('cigaret', 'Cigarro Premium', 100, 1, 'item_standard', 1, 106, 1, '{}', 'nice item', 0.10),
	('cigaret10', 'Cigarro Forte', 100, 1, 'item_standard', 1, 707, 1, '{}', 'nice item', 0.10),
	('cigaret2', 'Cigarro Comum', 100, 1, 'item_standard', 1, 699, 1, '{}', 'nice item', 0.10),
	('cigaret3', 'Cigarro Importado', 100, 1, 'item_standard', 1, 700, 1, '{}', 'nice item', 0.10),
	('cigaret4', 'Cigarro de Palha', 100, 1, 'item_standard', 1, 701, 1, '{}', 'nice item', 0.10),
	('cigaret5', 'Cigarro Artesanal', 100, 1, 'item_standard', 1, 702, 1, '{}', 'nice item', 0.10),
	('cigaret6', 'Cigarro Fino', 100, 1, 'item_standard', 1, 703, 1, '{}', 'nice item', 0.10),
	('cigaret7', 'Cigarro Grosso', 100, 1, 'item_standard', 1, 704, 1, '{}', 'nice item', 0.10),
	('cigaret8', 'Cigarro Mentolado', 100, 1, 'item_standard', 1, 705, 1, '{}', 'nice item', 0.10),
	('cigaret9', 'Cigarro Suave', 100, 1, 'item_standard', 1, 706, 1, '{}', 'nice item', 0.10),
	('cigarette', 'Cigarro', 100, 1, 'item_standard', 1, 392, 1, '{}', 'nice item', 0.10),
	('clean_water', 'Água Limpa', 100, 1, 'item_standard', 1, 394, 1, '{}', 'nice item', 0.50),
	('cloaks', 'Capas', 100, 1, 'item_standard', 1, 247, 1, '{}', 'nice item', 1.00),
	('clothepolice1', 'Uniforme Policial 1', 5, 1, 'item_standard', 1, 228, 1, '{}', 'nice item', 1.50),
	('clothepolice2', 'Uniforme Policial 2', 5, 1, 'item_standard', 1, 229, 1, '{}', 'nice item', 1.50),
	('clothepolice3', 'Uniforme Policial 3', 5, 1, 'item_standard', 1, 230, 1, '{}', 'nice item', 1.50),
	('clothepolice4', 'Uniforme Policial 4', 5, 1, 'item_standard', 1, 231, 1, '{}', 'nice item', 1.50),
	('clothepolice5', 'Uniforme Policial 5', 5, 1, 'item_standard', 1, 232, 1, '{}', 'nice item', 1.50),
	('clothepolice6', 'Uniforme Policial 6', 5, 1, 'item_standard', 1, 233, 1, '{}', 'nice item', 1.50),
	('clothepolice7', 'Uniforme Policial 7', 5, 1, 'item_standard', 1, 234, 1, '{}', 'nice item', 1.50),
	('clothes_line', 'Varal de Roupas', 100, 1, 'item_standard', 1, 180, 1, '{}', 'nice item', 2.00),
	('cloth_bench', 'Banco de Tecido', 100, 1, 'item_standard', 1, 190, 1, '{}', 'nice item', 4.00),
	('coats', 'Casacos', 100, 1, 'item_standard', 1, 245, 1, '{}', 'nice item', 1.00),
	('coats_closed', 'Casacos Fechados', 100, 1, 'item_standard', 1, 246, 1, '{}', 'nice item', 1.00),
	('cocaina', 'Cocaína', 100, 1, 'item_standard', 1, 382, 1, '{}', 'nice item', 0.30),
	('coffee_beans', 'Grãos de Café', 100, 1, 'item_standard', 1, 472, 1, '{}', 'nice item', 0.30),
	('commomclothes', 'Roupas Comuns', 100, 1, 'item_standard', 1, 225, 1, '{}', 'nice item', 1.00),
	('condenser', 'Condensador', 100, 1, 'item_standard', 1, 356, 1, '{}', 'nice item', 3.00),
	('consumable_apple_candy', 'Doce de Maçã', 100, 1, 'item_standard', 1, 277, 1, '{}', 'nice item', 0.20),
	('consumable_asian_soda_grape', 'Refrigerante de Uva', 100, 1, 'item_standard', 1, 284, 1, '{}', 'nice item', 0.50),
	('consumable_asian_soda_lime', 'Refrigerante de Limão', 100, 1, 'item_standard', 1, 104, 1, '{}', 'nice item', 0.50),
	('consumable_asian_soda_strawberry', 'Refrigerante de Morango', 100, 1, 'item_standard', 1, 275, 1, '{}', 'nice item', 0.50),
	('consumable_bagel_egg_bacon', 'Bagel com Ovo e Bacon', 100, 1, 'item_standard', 1, 274, 1, '{}', 'nice item', 0.50),
	('consumable_boiled_egg', 'Ovo Cozido', 100, 1, 'item_standard', 1, 280, 1, '{}', 'nice item', 0.20),
	('consumable_breakfast', 'Café da Manhã', 100, 1, 'item_standard', 1, 389, 1, '{}', 'nice item', 0.60),
	('consumable_canned_corn', 'Milho Enlatado', 100, 1, 'item_standard', 1, 278, 1, '{}', 'nice item', 0.50),
	('consumable_chickenpie', 'Torta de Frango', 100, 1, 'item_standard', 1, 388, 1, '{}', 'nice item', 0.50),
	('consumable_coffee', 'Café', 100, 1, 'item_standard', 1, 279, 1, '{}', 'nice item', 0.30),
	('consumable_coffee_filter', 'Filtro de Café', 100, 1, 'item_standard', 1, 310, 1, '{}', 'nice item', 0.10),
	('consumable_haycube', 'Cubo de Feno', 100, 1, 'item_standard', 1, 523, 1, '{}', 'nice item', 1.00),
	('consumable_horse_meal', 'Ração de Cavalo', 100, 1, 'item_standard', 1, 294, 1, '{}', 'nice item', 1.00),
	('consumable_meat_alligator', 'Carne de Jacare', 100, 1, 'item_standard', 1, 1445, 1, '{}', 'nice item', 0.50),
	('consumable_meat_fish_flakey', 'Carne de Peixe', 100, 1, 'item_standard', 1, 1448, 1, '{}', 'nice item', 0.50),
	('consumable_meat_mutton_cooked', 'Carne de Carneiro Cozida', 100, 1, 'item_standard', 1, 286, 1, '{}', 'nice item', 0.50),
	('consumable_meat_rabbit', 'Carne de Coelho', 100, 1, 'item_standard', 1, 1446, 1, '{}', 'nice item', 0.50),
	('consumable_meat_snake', 'Carne de Cobra', 100, 1, 'item_standard', 1, 1447, 1, '{}', 'nice item', 0.50),
	('consumable_medicine', 'Remédio', 100, 1, 'item_standard', 1, 674, 1, '{}', 'nice item', 0.30),
	('consumable_milk_bucket', 'Balde de Leite', 100, 1, 'item_standard', 1, 528, 1, '{}', 'nice item', 1.50),
	('consumable_orange_chicken', 'Frango Laranja', 100, 1, 'item_standard', 1, 282, 1, '{}', 'nice item', 0.50),
	('consumable_peach', 'Pêssego', 100, 1, 'item_standard', 1, 584, 1, '{}', 'nice item', 0.20),
	('consumable_peanuts_roasted', 'Amendoins Torrados', 100, 1, 'item_standard', 1, 287, 1, '{}', 'nice item', 0.30),
	('consumable_steakpie', 'Torta de Carne', 100, 1, 'item_standard', 1, 390, 1, '{}', 'nice item', 0.50),
	('consumable_stew_reptile', 'Ensopado de Réptil', 100, 1, 'item_standard', 1, 283, 1, '{}', 'nice item', 0.60),
	('consumable_tea_chamomile', 'Chá de Camomila', 100, 1, 'item_standard', 1, 281, 1, '{}', 'nice item', 0.30),
	('copper', 'Cobre', 100, 1, 'item_standard', 1, 353, 1, '{}', 'nice item', 1.00),
	('corn', 'Milho', 100, 1, 'item_standard', 1, 454, 1, '{}', 'nice item', 0.30),
	('cougars', 'Pele de Puma', 100, 1, 'item_standard', 1, 1458, 1, '{}', 'nice item', 1.00),
	('cougar_taxidermy', 'Taxidermia de Puma', 100, 1, 'item_standard', 1, 185, 1, '{}', 'nice item', 10.00),
	('coverbook', 'Livro de Capa', 100, 1, 'item_standard', 1, 92, 1, '{}', 'nice item', 0.50),
	('coyotef', 'Dente de Coiote', 100, 1, 'item_standard', 1, 1493, 1, '{}', 'nice item', 0.10),
	('coyote_pelt', 'Pele de Coiote', 100, 1, 'item_standard', 1, 173, 1, '{}', 'nice item', 1.50),
	('coyote_taxidermy', 'Taxidermia de Coiote', 100, 1, 'item_standard', 1, 182, 1, '{}', 'nice item', 5.00),
	('crablegs', 'Pernas de Caranguejo', 100, 1, 'item_standard', 1, 1503, 1, '{}', 'nice item', 0.20),
	('crafting_fire', 'Fogo de Crafting', 100, 1, 'item_standard', 1, 168, 1, '{}', 'nice item', 2.00),
	('Creekplum', 'Ameixa do Riacho', 100, 1, 'item_standard', 1, 585, 1, '{}', 'nice item', 0.20),
	('cure', 'Cura', 100, 1, 'item_standard', 1, 681, 1, '{}', 'nice item', 0.30),
	('dbcandle', 'Vela Dupla', 100, 1, 'item_standard', 1, 200, 1, '{}', 'nice item', 0.30),
	('decortent1', 'Decoração Tenda 1', 100, 1, 'item_standard', 1, 134, 1, '{}', 'nice item', 2.00),
	('decortent2', 'Decoração Tenda 2', 100, 1, 'item_standard', 1, 135, 1, '{}', 'nice item', 2.00),
	('decortent3', 'Decoração Tenda 3', 100, 1, 'item_standard', 1, 136, 1, '{}', 'nice item', 2.00),
	('deerheart', 'Coração de Veado', 100, 1, 'item_standard', 1, 1473, 1, '{}', 'nice item', 0.30),
	('deernativetent', 'Tenda Cervo Nativa', 100, 1, 'item_standard', 1, 214, 1, '{}', 'nice item', 12.00),
	('deer_pelt', 'Pele de Veado', 100, 1, 'item_standard', 1, 172, 1, '{}', 'nice item', 1.00),
	('deer_taxidermy', 'Taxidermia de Cervo', 100, 1, 'item_standard', 1, 184, 1, '{}', 'nice item', 8.00),
	('desativado', 'Item desativado', 100, 1, 'item_standard', 1, 712, 1, '{}', 'nice item', 0.50),
	('detectiveverify', 'Credencial de Detetive', 1, 1, 'item_standard', 1, 673, 1, '{}', 'nice item', 0.10),
	('diamond', 'Diamante', 100, 1, 'item_standard', 1, 57, 1, '{}', 'nice item', 0.20),
	('diario', 'Diário', 100, 1, 'item_standard', 1, 404, 1, '{}', 'nice item', 0.30),
	('domination', 'Item dominação', 100, 1, 'item_standard', 1, 719, 1, '{}', 'nice item', 0.50),
	('dreamcatcher', 'Filtro dos Sonhos', 100, 1, 'item_standard', 1, 125, 1, '{}', 'nice item', 0.30),
	('dresses', 'Vestidos', 100, 1, 'item_standard', 1, 237, 1, '{}', 'nice item', 1.00),
	('dynamite', 'Dinamite', 100, 1, 'item_standard', 1, 379, 1, '{}', 'nice item', 0.50),
	('eggs', 'Ovos', 100, 1, 'item_standard', 1, 500, 1, '{}', 'nice item', 0.30),
	('elktrophy', 'Chifre de Alce', 100, 1, 'item_standard', 1, 1484, 1, '{}', 'nice item', 0.50),
	('embalagem', 'Embalagem', 100, 1, 'item_standard', 1, 307, 1, '{}', 'nice item', 0.20),
	('empty_can', 'Lata Vazia', 100, 1, 'item_standard', 1, 299, 1, '{}', 'nice item', 0.20),
	('enxofre', 'Enxofre', 100, 1, 'item_standard', 1, 399, 1, '{}', 'nice item', 0.50),
	('expensiveclothes', 'Roupas Caras', 100, 1, 'item_standard', 1, 226, 1, '{}', 'nice item', 1.00),
	('eyewear', 'Óculos', 100, 1, 'item_standard', 1, 236, 1, '{}', 'nice item', 0.20),
	('fancydouble', 'Cama de Casal Luxo', 100, 1, 'item_standard', 1, 207, 1, '{}', 'nice item', 25.00),
	('Fat', 'Gordura Animal', 100, 1, 'item_standard', 1, 101, 1, '{}', 'nice item', 0.50),
	('fazenda19', 'Livro Fazenda 19', 100, 1, 'item_standard', 1, 716, 1, '{}', 'nice item', 0.50),
	('fazenda20', 'Livro Fazenda 20', 100, 1, 'item_standard', 1, 714, 1, '{}', 'nice item', 0.50),
	('fazenda36', 'Livro Fazenda 36', 100, 1, 'item_standard', 1, 717, 1, '{}', 'nice item', 0.50),
	('feather', 'Pena', 100, 1, 'item_standard', 1, 1500, 1, '{}', 'nice item', 0.10),
	('Feather1', 'Pena 1', 100, 1, 'item_standard', 1, 3, 1, '{}', 'nice item', 0.10),
	('Feather2', 'Pena 2', 100, 1, 'item_standard', 1, 4, 1, '{}', 'nice item', 0.10),
	('Feather3', 'Pena 3', 100, 1, 'item_standard', 1, 5, 1, '{}', 'nice item', 0.10),
	('Feather4', 'Pena 4', 100, 1, 'item_standard', 1, 6, 1, '{}', 'nice item', 0.10),
	('Feather5', 'Pena 5', 100, 1, 'item_standard', 1, 7, 1, '{}', 'nice item', 0.10),
	('Feather6', 'Pena 6', 100, 1, 'item_standard', 1, 8, 1, '{}', 'nice item', 0.10),
	('Feather7', 'Pena 7', 100, 1, 'item_standard', 1, 9, 1, '{}', 'nice item', 0.10),
	('Feather8', 'Pena 8', 100, 1, 'item_standard', 1, 10, 1, '{}', 'nice item', 0.10),
	('ferradura', 'Ferradura', 100, 1, 'item_standard', 1, 349, 1, '{}', 'nice item', 0.50),
	('Fertilizer', 'Fertilizante', 100, 1, 'item_standard', 1, 409, 1, '{}', 'nice item', 1.00),
	('fiche', 'Ficha', 100, 1, 'item_standard', 1, 516, 1, '{}', 'nice item', 0.10),
	('fireitem', 'Item de Fogo', 100, 1, 'item_standard', 1, 682, 1, '{}', 'nice item', 0.50),
	('fireportal', 'Portal de Fogo', 100, 1, 'item_standard', 1, 683, 1, '{}', 'nice item', 1.00),
	('fivela', 'Fivela', 100, 1, 'item_standard', 1, 508, 1, '{}', 'nice item', 0.20),
	('flag', 'Bandeira', 10, 1, 'item_standard', 1, 110, 1, '{}', 'nice item', 0.50),
	('flowerboxes', 'Caixas de Flores', 100, 1, 'item_standard', 1, 171, 1, '{}', 'nice item', 2.00),
	('folha_cocain', 'Folha de Cocaína', 100, 1, 'item_standard', 1, 362, 1, '{}', 'nice item', 0.20),
	('food_barrel', 'Barril de Comida', 100, 1, 'item_standard', 1, 178, 1, '{}', 'nice item', 5.00),
	('formula_adolescente', 'Formula De Adolescente', 100, 1, 'item_standard', 1, 738, 1, '{}', 'nice item', 0.50),
	('formula_anao', 'Formula de Anão', 100, 1, 'item_standard', 1, 737, 1, '{}', 'nice item', 0.50),
	('formula_formiga', 'Formula de Formiga', 100, 1, 'item_standard', 1, 736, 1, '{}', 'nice item', 0.50),
	('formula_gigante', 'Formula de Gigante', 100, 1, 'item_standard', 1, 741, 1, '{}', 'nice item', 0.50),
	('formula_grande', 'Formula Grande', 100, 1, 'item_standard', 1, 740, 1, '{}', 'nice item', 0.50),
	('formula_normal', 'Formula Tamanho Normal', 100, 1, 'item_standard', 1, 739, 1, '{}', 'nice item', 0.50),
	('formula_titan', 'Formula de Titan', 100, 1, 'item_standard', 1, 742, 1, '{}', 'nice item', 0.50),
	('fosforo', 'Fósforo', 100, 1, 'item_standard', 1, 552, 1, '{}', 'nice item', 0.10),
	('foxtrophy', 'Cabeça de Raposa', 100, 1, 'item_standard', 1, 1480, 1, '{}', 'nice item', 1.50),
	('fox_meat', 'Carne de Raposa', 100, 1, 'item_standard', 1, 1441, 1, '{}', 'nice item', 0.50),
	('game', 'Caça', 100, 1, 'item_standard', 1, 100, 1, '{}', 'nice item', 1.00),
	('gauntlets', 'Manoplas', 100, 1, 'item_standard', 1, 240, 1, '{}', 'nice item', 0.50),
	('gbears', 'Pele de Urso', 100, 1, 'item_standard', 1, 1453, 1, '{}', 'nice item', 1.50),
	('glassbottle', 'Garrafa de Vidro', 50, 1, 'item_standard', 1, 89, 1, '{}', 'nice item', 0.30),
	('glasseye', 'Olho de Vidro', 100, 1, 'item_standard', 1, 517, 1, '{}', 'nice item', 0.10),
	('gloves', 'Luvas', 100, 1, 'item_standard', 1, 235, 1, '{}', 'nice item', 0.20),
	('goat_meat', 'Carne de Cabra', 100, 1, 'item_standard', 1, 1440, 1, '{}', 'nice item', 0.50),
	('Goat_Milk', 'Leite de Cabra', 100, 1, 'item_standard', 1, 502, 1, '{}', 'nice item', 0.50),
	('goldnugget', 'Pepita de Ouro', 100, 1, 'item_standard', 1, 402, 1, '{}', 'nice item', 0.30),
	('goldring', 'Anel de Ouro', 100, 1, 'item_standard', 1, 510, 1, '{}', 'nice item', 0.10),
	('goldtooth', 'Dente de Ouro', 100, 1, 'item_standard', 1, 509, 1, '{}', 'nice item', 0.10),
	('gold_nugget', 'Pepita de Ouro', 100, 1, 'item_standard', 1, 53, 1, '{}', 'nice item', 0.30),
	('grain_barley', 'Cevada', 100, 1, 'item_standard', 1, 481, 1, '{}', 'nice item', 0.30),
	('Granuls', 'Grão', 100, 1, 'item_standard', 1, 727, 1, '{}', 'nice item', 0.50),
	('grapes', 'Uvas', 100, 1, 'item_standard', 1, 462, 1, '{}', 'nice item', 0.30),
	('gunbelts', 'Cinturões de Arma', 100, 1, 'item_standard', 1, 263, 1, '{}', 'nice item', 0.50),
	('gunbelt_accs', 'Acessórios de Cinturão', 100, 1, 'item_standard', 1, 270, 1, '{}', 'nice item', 0.30),
	('gun_barrel', 'Barril de Armas', 100, 1, 'item_standard', 1, 175, 1, '{}', 'nice item', 8.00),
	('gypsywagon', 'Carroça Cigana', 100, 1, 'item_standard', 1, 158, 1, '{}', 'nice item', 40.00),
	('hair_accessories', 'Acessórios de Cabelo', 100, 1, 'item_standard', 1, 271, 1, '{}', 'nice item', 0.10),
	('hammer', 'Martelo', 100, 1, 'item_standard', 1, 729, 1, '{}', 'nice item', 0.50),
	('handcuffs', 'Algemas', 100, 1, 'item_standard', 1, 380, 1, '{}', 'nice item', 0.30),
	('handcuffskey', 'Chave de Algemas', 100, 1, 'item_standard', 1, 381, 1, '{}', 'nice item', 0.10),
	('handsaw', 'Serra Manual', 100, 1, 'item_standard', 1, 613, 1, '{}', 'nice item', 2.00),
	('hatchet', 'Machado', 100, 1, 'item_standard', 1, 348, 1, '{}', 'nice item', 2.00),
	('hats', 'Chapéus', 100, 1, 'item_standard', 1, 251, 1, '{}', 'nice item', 0.30),
	('hay', 'Feno', 100, 1, 'item_standard', 1, 526, 1, '{}', 'nice item', 1.00),
	('Headband1', 'Bandana 1', 100, 1, 'item_standard', 1, 19, 1, '{}', 'nice item', 0.30),
	('Headband2', 'Bandana 2', 100, 1, 'item_standard', 1, 20, 1, '{}', 'nice item', 0.30),
	('Headband3', 'Bandana 3', 100, 1, 'item_standard', 1, 21, 1, '{}', 'nice item', 0.30),
	('Headband4', 'Bandana 4', 100, 1, 'item_standard', 1, 22, 1, '{}', 'nice item', 0.30),
	('Headband5', 'Bandana 5', 100, 1, 'item_standard', 1, 23, 1, '{}', 'nice item', 0.30),
	('Headband6', 'Bandana 6', 100, 1, 'item_standard', 1, 24, 1, '{}', 'nice item', 0.30),
	('Headdress1', 'Cocar 1', 100, 1, 'item_standard', 1, 25, 1, '{}', 'nice item', 0.50),
	('Headdress2', 'Cocar 2', 100, 1, 'item_standard', 1, 26, 1, '{}', 'nice item', 0.50),
	('Headdress3', 'Cocar 3', 100, 1, 'item_standard', 1, 27, 1, '{}', 'nice item', 0.50),
	('Headdress4', 'Cocar 4', 100, 1, 'item_standard', 1, 28, 1, '{}', 'nice item', 0.50),
	('Headdress5', 'Cocar 5', 100, 1, 'item_standard', 1, 29, 1, '{}', 'nice item', 0.50),
	('Headdress6', 'Cocar 6', 100, 1, 'item_standard', 1, 30, 1, '{}', 'nice item', 0.50),
	('healingitemPoison', 'Item Cura Veneno', 100, 1, 'item_standard', 1, 688, 1, '{}', 'nice item', 0.30),
	('Health_For_Dog', 'Saúde para Cachorro', 100, 1, 'item_standard', 1, 498, 1, '{}', 'nice item', 0.30),
	('heart_chicken', 'Coração de Galinha', 100, 1, 'item_standard', 1, 1475, 1, '{}', 'nice item', 0.10),
	('heart_panther', 'Coração de Pantera', 100, 1, 'item_standard', 1, 1476, 1, '{}', 'nice item', 0.30),
	('heart_pig_boar', 'Coração de Javali', 100, 1, 'item_standard', 1, 1474, 1, '{}', 'nice item', 0.30),
	('heart_wolf', 'Coração de Lobo', 100, 1, 'item_standard', 1, 1477, 1, '{}', 'nice item', 0.30),
	('hemp', 'Cânhamo', 100, 1, 'item_standard', 1, 619, 1, '{}', 'nice item', 0.30),
	('herb_agarita', 'Agarita', 100, 1, 'item_standard', 1, 451, 1, '{}', 'nice item', 0.20),
	('herb_alaskan_ginseng', 'Ginseng do Alaska', 100, 1, 'item_standard', 1, 460, 1, '{}', 'nice item', 0.20),
	('herb_chamomile', 'Camomila', 100, 1, 'item_standard', 1, 468, 1, '{}', 'nice item', 0.20),
	('herb_cotton', 'Algodão', 100, 1, 'item_standard', 1, 359, 1, '{}', 'nice item', 0.30),
	('herb_creekplum', 'Ameixa do Riacho', 100, 1, 'item_standard', 1, 477, 1, '{}', 'nice item', 0.20),
	('herb_crows_garlic', 'Alho do Corvo', 100, 1, 'item_standard', 1, 476, 1, '{}', 'nice item', 0.20),
	('herb_evergreen_huckleberry', 'Mirtilo Perene', 100, 1, 'item_standard', 1, 459, 1, '{}', 'nice item', 0.20),
	('herb_hummingbird_sage', 'Sálvia Beija-Flor', 100, 1, 'item_standard', 1, 458, 1, '{}', 'nice item', 0.20),
	('herb_indian_tobacco', 'Tabaco Indiano', 100, 1, 'item_standard', 1, 453, 1, '{}', 'nice item', 0.20),
	('herb_prairie_poppy', 'Papoula da Pradaria', 100, 1, 'item_standard', 1, 360, 1, '{}', 'nice item', 0.20),
	('herb_rams_head', 'Cabeça de Carneiro', 100, 1, 'item_standard', 1, 456, 1, '{}', 'nice item', 0.20),
	('herb_sugar', 'Cana de Açúcar', 100, 1, 'item_standard', 1, 461, 1, '{}', 'nice item', 0.30),
	('herb_wild_carrot', 'Cenoura Selvagem', 100, 1, 'item_standard', 1, 452, 1, '{}', 'nice item', 0.20),
	('herb_wild_mint', 'Menta Selvagem', 100, 1, 'item_standard', 1, 455, 1, '{}', 'nice item', 0.20),
	('heroin', 'Heroína', 100, 1, 'item_standard', 1, 617, 1, '{}', 'nice item', 0.30),
	('hitchingpost', 'Poste de Amarração', 100, 1, 'item_standard', 1, 153, 1, '{}', 'nice item', 5.00),
	('hoe', 'Enxada', 100, 1, 'item_standard', 1, 333, 1, '{}', 'nice item', 2.00),
	('holsters_left', 'Coldre Esquerdo', 100, 1, 'item_standard', 1, 264, 1, '{}', 'nice item', 0.50),
	('hop', 'Lúpulo', 100, 1, 'item_standard', 1, 581, 1, '{}', 'nice item', 0.20),
	('horsebrush', 'Escova de Cavalo', 100, 1, 'item_standard', 1, 293, 1, '{}', 'nice item', 0.50),
	('horsehitches', 'Amarrador de Cavalos', 100, 1, 'item_standard', 1, 137, 1, '{}', 'nice item', 5.00),
	('horserevive', 'Reviver Cavalo', 100, 1, 'item_standard', 1, 291, 1, '{}', 'nice item', 0.50),
	('hwood', 'Madeira Dura', 100, 1, 'item_standard', 1, 610, 1, '{}', 'nice item', 1.00),
	('hwoodboard', 'Tábua de Madeira Dura', 100, 1, 'item_standard', 1, 611, 1, '{}', 'nice item', 1.00),
	('iceitem', 'Item de Gelo', 100, 1, 'item_standard', 1, 686, 1, '{}', 'nice item', 0.50),
	('icemagic', 'Magia de Gelo', 100, 1, 'item_standard', 1, 684, 1, '{}', 'nice item', 0.50),
	('identitycard', 'Documento de Identidade', 1, 1, 'item_standard', 1, 396, 1, '{}', 'nice item', 0.10),
	('iguanabits', 'Pedaços de Iguana', 100, 1, 'item_standard', 1, 1504, 1, '{}', 'nice item', 0.20),
	('iguana_meat', 'Carne de Iguana', 100, 1, 'item_standard', 1, 1442, 1, '{}', 'nice item', 0.50),
	('inelargintsmarald', 'Anel de Esmeralda', 100, 1, 'item_standard', 1, 518, 1, '{}', 'nice item', 0.10),
	('inelmagic', 'Anel Mágico', 100, 1, 'item_standard', 1, 519, 1, '{}', 'nice item', 0.10),
	('Ingredient_Pig_Meat', 'Carne de porco', 100, 1, 'item_standard', 1, 1443, 1, '{}', 'nice item', 0.50),
	('ironbar', 'Barra de Ferro', 100, 1, 'item_standard', 1, 612, 1, '{}', 'nice item', 2.00),
	('ironhammer', 'Martelo de Ferro', 100, 1, 'item_standard', 1, 614, 1, '{}', 'nice item', 1.50),
	('jewelry_bracelets', 'Pulseiras', 100, 1, 'item_standard', 1, 257, 1, '{}', 'nice item', 0.20),
	('jewelry_rings_left', 'Anel Mão Esquerda', 100, 1, 'item_standard', 1, 256, 1, '{}', 'nice item', 0.10),
	('jewelry_rings_right', 'Anel Mão Direita', 100, 1, 'item_standard', 1, 255, 1, '{}', 'nice item', 0.10),
	('journal', 'Jornal Pessoal', 100, 1, 'item_standard', 1, 405, 1, '{}', 'nice item', 0.30),
	('jumpitem', 'Item de Pulo', 100, 1, 'item_standard', 1, 690, 1, '{}', 'nice item', 0.50),
	('kitchencounter', 'Balcão de Cozinha', 100, 1, 'item_standard', 1, 145, 1, '{}', 'nice item', 15.00),
	('kitmedico', 'Kit Médico', 20, 1, 'item_standard', 1, 675, 1, '{}', 'nice item', 1.00),
	('kit_bandana', 'Kit Bandana', 100, 1, 'item_standard', 1, 84, 1, '{}', 'nice item', 0.50),
	('lamppost1', 'Poste de Luz 1', 100, 1, 'item_standard', 1, 140, 1, '{}', 'nice item', 8.00),
	('lamppost2', 'Poste de Luz 2', 100, 1, 'item_standard', 1, 141, 1, '{}', 'nice item', 8.00),
	('lanterna', 'Lanterna', 100, 1, 'item_standard', 1, 199, 1, '{}', 'nice item', 0.80),
	('leather', 'Couro', 100, 1, 'item_standard', 1, 503, 1, '{}', 'nice item', 1.00),
	('leather_chair', 'Cadeira de Couro', 100, 1, 'item_standard', 1, 163, 1, '{}', 'nice item', 4.00),
	('lettuce', 'Alface', 100, 1, 'item_standard', 1, 487, 1, '{}', 'nice item', 0.20),
	('lighter', 'Isqueiro', 100, 1, 'item_standard', 1, 511, 1, '{}', 'nice item', 0.20),
	('limao', 'Limão', 100, 1, 'item_standard', 1, 105, 1, '{}', 'nice item', 0.20),
	('lime', 'Lima', 100, 1, 'item_standard', 1, 478, 1, '{}', 'nice item', 0.20),
	('limpacasco', 'Limpa Casco', 100, 1, 'item_standard', 1, 525, 1, '{}', 'nice item', 0.30),
	('loadouts', 'Equipamentos', 100, 1, 'item_standard', 1, 253, 1, '{}', 'nice item', 2.00),
	('lockpick', 'Gazua', 100, 1, 'item_standard', 1, 111, 1, '{}', 'nice item', 0.20),
	('log_bencha', 'Banco de Tronco A', 100, 1, 'item_standard', 1, 188, 1, '{}', 'nice item', 5.00),
	('log_benchb', 'Banco de Tronco B', 100, 1, 'item_standard', 1, 189, 1, '{}', 'nice item', 5.00),
	('loungechair', 'Cadeira de Descanso', 100, 1, 'item_standard', 1, 132, 1, '{}', 'nice item', 5.00),
	('loungechair2', 'Cadeira de Descanso 2', 100, 1, 'item_standard', 1, 133, 1, '{}', 'nice item', 5.00),
	('maca', 'Maçã', 100, 1, 'item_standard', 1, 467, 1, '{}', 'nice item', 0.20),
	('madeira', 'Madeira', 100, 1, 'item_standard', 1, 357, 1, '{}', 'nice item', 1.00),
	('madeira_cerno', 'Madeira de Cerne', 100, 1, 'item_standard', 1, 554, 1, '{}', 'nice item', 1.50),
	('magicitem', 'Item Mágico', 100, 1, 'item_standard', 1, 679, 1, '{}', 'nice item', 0.50),
	('magicitem2', 'Item Mágico 2', 100, 1, 'item_standard', 1, 680, 1, '{}', 'nice item', 0.50),
	('mapa', 'Mapa', 10, 1, 'item_standard', 1, 1566, 1, '{}', 'nice item', 0.10),
	('Mariuhana', 'Maconha', 100, 1, 'item_standard', 1, 384, 1, '{}', 'nice item', 0.30),
	('mashalaskan', 'Mosto de Alaska', 100, 1, 'item_standard', 1, 594, 1, '{}', 'nice item', 0.50),
	('mashamerican', 'Mosto Americano', 100, 1, 'item_standard', 1, 595, 1, '{}', 'nice item', 0.50),
	('mashapple', 'Mosto de Maçã', 100, 1, 'item_standard', 1, 591, 1, '{}', 'nice item', 0.50),
	('mashblackberry', 'Mosto de Amora', 100, 1, 'item_standard', 1, 589, 1, '{}', 'nice item', 0.50),
	('mashblackberry90p', 'Mosto Amora 90%', 100, 1, 'item_standard', 1, 596, 1, '{}', 'nice item', 0.50),
	('mashpeach', 'Mosto de Pêssego', 100, 1, 'item_standard', 1, 592, 1, '{}', 'nice item', 0.50),
	('mashplum', 'Mosto de Ameixa', 100, 1, 'item_standard', 1, 593, 1, '{}', 'nice item', 0.50),
	('mashraspberry', 'Mosto de Framboesa', 100, 1, 'item_standard', 1, 590, 1, '{}', 'nice item', 0.50),
	('mashraspberry90p', 'Mosto Framboesa 90%', 100, 1, 'item_standard', 1, 597, 1, '{}', 'nice item', 0.50),
	('mashstrong', 'Mosto Forte', 100, 1, 'item_standard', 1, 598, 1, '{}', 'nice item', 0.50),
	('masks', 'Máscaras', 100, 1, 'item_standard', 1, 249, 1, '{}', 'nice item', 0.30),
	('masks_large', 'Máscaras Grandes', 100, 1, 'item_standard', 1, 250, 1, '{}', 'nice item', 0.50),
	('milk', 'Leite', 100, 1, 'item_standard', 1, 499, 1, '{}', 'nice item', 0.50),
	('mindmagic', 'Magia Mental', 100, 1, 'item_standard', 1, 685, 1, '{}', 'nice item', 0.50),
	('MinerHat1', 'Chapéu de Mineiro', 100, 1, 'item_standard', 1, 398, 1, '{}', 'nice item', 0.50),
	('minerio_de_cobre', 'Minério de Cobre', 100, 1, 'item_standard', 1, 54, 1, '{}', 'nice item', 1.00),
	('minerio_de_prata', 'Minério de Prata', 100, 1, 'item_standard', 1, 56, 1, '{}', 'nice item', 1.00),
	('moneysujo', 'Dinheiro Sujo', 1000, 1, 'item_standard', 1, 403, 1, '{}', 'nice item', 0.10),
	('moonshine', 'Moonshine', 100, 1, 'item_standard', 1, 606, 1, '{}', 'nice item', 0.80),
	('moonshinealaskan', 'Moonshine Alaska', 100, 1, 'item_standard', 1, 604, 1, '{}', 'nice item', 0.80),
	('moonshineamerican', 'Moonshine Americano', 100, 1, 'item_standard', 1, 605, 1, '{}', 'nice item', 0.80),
	('moonshineapple', 'Moonshine de Maçã', 100, 1, 'item_standard', 1, 601, 1, '{}', 'nice item', 0.80),
	('moonshineblackberry', 'Moonshine de Amora', 100, 1, 'item_standard', 1, 599, 1, '{}', 'nice item', 0.80),
	('moonshineblackberry90p', 'Moonshine Amora 90%', 100, 1, 'item_standard', 1, 607, 1, '{}', 'nice item', 0.80),
	('moonshinepeach', 'Moonshine de Pêssego', 100, 1, 'item_standard', 1, 602, 1, '{}', 'nice item', 0.80),
	('moonshineplum', 'Moonshine de Ameixa', 100, 1, 'item_standard', 1, 603, 1, '{}', 'nice item', 0.80),
	('moonshineraspberry', 'Moonshine de Framboesa', 100, 1, 'item_standard', 1, 600, 1, '{}', 'nice item', 0.80),
	('moonshineraspberry90p', 'Moonshine Framboesa 90%', 100, 1, 'item_standard', 1, 608, 1, '{}', 'nice item', 0.80),
	('morphine', 'Morfina', 100, 1, 'item_standard', 1, 618, 1, '{}', 'nice item', 0.30),
	('mountainmen', 'Homens da Montanha', 100, 1, 'item_standard', 1, 142, 1, '{}', 'nice item', 0.50),
	('mushroom_chanterelles', 'Cogumelo Chanterelle', 100, 1, 'item_standard', 1, 469, 1, '{}', 'nice item', 0.20),
	('mushroom_parasol_mushroom', 'Cogumelo Guarda-Sol', 100, 1, 'item_standard', 1, 457, 1, '{}', 'nice item', 0.20),
	('muskrats', 'Pele de Rato Almiscarado', 100, 1, 'item_standard', 1, 1465, 1, '{}', 'nice item', 0.50),
	('Na1', 'Item Nativo 1', 100, 1, 'item_standard', 1, 11, 1, '{}', 'nice item', 0.50),
	('Na2', 'Item Nativo 2', 100, 1, 'item_standard', 1, 12, 1, '{}', 'nice item', 0.50),
	('Na3', 'Item Nativo 3', 100, 1, 'item_standard', 1, 13, 1, '{}', 'nice item', 0.50),
	('Na4', 'Item Nativo 4', 100, 1, 'item_standard', 1, 14, 1, '{}', 'nice item', 0.50),
	('Na5', 'Item Nativo 5', 100, 1, 'item_standard', 1, 15, 1, '{}', 'nice item', 0.50),
	('Na6', 'Item Nativo 6', 100, 1, 'item_standard', 1, 16, 1, '{}', 'nice item', 0.50),
	('Na7', 'Item Nativo 7', 100, 1, 'item_standard', 1, 17, 1, '{}', 'nice item', 0.50),
	('Na8', 'Item Nativo 8', 100, 1, 'item_standard', 1, 18, 1, '{}', 'nice item', 0.50),
	('nails', 'Pregos', 100, 1, 'item_standard', 1, 520, 1, '{}', 'nice item', 0.50),
	('nativearms', 'Armas Nativas', 100, 1, 'item_standard', 1, 118, 1, '{}', 'nice item', 2.00),
	('nativearrowdisplay', 'Expositor de Flechas Nativo', 100, 1, 'item_standard', 1, 222, 1, '{}', 'nice item', 2.00),
	('nativebasket1', 'Cesta Nativa 1', 100, 1, 'item_standard', 1, 128, 1, '{}', 'nice item', 1.00),
	('nativebasket2', 'Cesta Nativa 2', 100, 1, 'item_standard', 1, 129, 1, '{}', 'nice item', 1.00),
	('nativebed', 'Cama Nativa', 100, 1, 'item_standard', 1, 116, 1, '{}', 'nice item', 8.00),
	('nativebench', 'Banco Nativo', 100, 1, 'item_standard', 1, 211, 1, '{}', 'nice item', 4.00),
	('nativebloodrock', 'Pedra de Sangue Nativa', 100, 1, 'item_standard', 1, 218, 1, '{}', 'nice item', 10.00),
	('nativebowdisplay', 'Expositor de Arco Nativo', 100, 1, 'item_standard', 1, 220, 1, '{}', 'nice item', 3.00),
	('nativebuckskull', 'Crânio de Veado Nativo', 100, 1, 'item_standard', 1, 223, 1, '{}', 'nice item', 2.00),
	('nativecage', 'Gaiola Nativa', 100, 1, 'item_standard', 1, 219, 1, '{}', 'nice item', 5.00),
	('nativechair', 'Cadeira Nativa', 100, 1, 'item_standard', 1, 209, 1, '{}', 'nice item', 3.00),
	('nativecookpot', 'Panela de Cozinha Nativa', 100, 1, 'item_standard', 1, 221, 1, '{}', 'nice item', 2.00),
	('nativedecor', 'Decoração Nativa', 100, 1, 'item_standard', 1, 157, 1, '{}', 'nice item', 2.00),
	('nativeelkcanvas', 'Lona Alce Nativa', 100, 1, 'item_standard', 1, 213, 1, '{}', 'nice item', 5.00),
	('nativeleatherstand', 'Suporte de Couro Nativo', 100, 1, 'item_standard', 1, 224, 1, '{}', 'nice item', 3.00),
	('nativemask', 'Máscara Nativa', 100, 1, 'item_standard', 1, 117, 1, '{}', 'nice item', 0.50),
	('nativeplatform', 'Plataforma Nativa', 100, 1, 'item_standard', 1, 216, 1, '{}', 'nice item', 15.00),
	('nativepot', 'Panela Nativa', 100, 1, 'item_standard', 1, 127, 1, '{}', 'nice item', 2.00),
	('nativeskull', 'Crânio Nativo', 100, 1, 'item_standard', 1, 130, 1, '{}', 'nice item', 1.50),
	('nativeskullchair', 'Cadeira Crânio Nativa', 100, 1, 'item_standard', 1, 208, 1, '{}', 'nice item', 5.00),
	('nativesmoker', 'Defumador Nativo', 100, 1, 'item_standard', 1, 217, 1, '{}', 'nice item', 8.00),
	('nativewickchair', 'Cadeira Vime Nativa', 100, 1, 'item_standard', 1, 210, 1, '{}', 'nice item', 3.00),
	('naturalwagon', 'Carroça Natural', 100, 1, 'item_standard', 1, 139, 1, '{}', 'nice item', 50.00),
	('neckties', 'Gravatas', 100, 1, 'item_standard', 1, 242, 1, '{}', 'nice item', 0.10),
	('neckwear', 'Acessórios de Pescoço', 100, 1, 'item_standard', 1, 243, 1, '{}', 'nice item', 0.20),
	('newspaper', 'Jornal', 100, 1, 'item_standard', 1, 397, 1, '{}', 'nice item', 0.20),
	('nightstand', 'Mesa de Cabeceira', 100, 1, 'item_standard', 1, 195, 1, '{}', 'nice item', 5.00),
	('ns1', 'Item NS 1', 100, 1, 'item_standard', 1, 39, 1, '{}', 'nice item', 0.50),
	('ns10', 'Item NS 10', 100, 1, 'item_standard', 1, 48, 1, '{}', 'nice item', 0.50),
	('ns11', 'Item NS 11', 100, 1, 'item_standard', 1, 49, 1, '{}', 'nice item', 0.50),
	('ns12', 'Item NS 12', 100, 1, 'item_standard', 1, 50, 1, '{}', 'nice item', 0.50),
	('ns13', 'Item NS 13', 100, 1, 'item_standard', 1, 51, 1, '{}', 'nice item', 0.50),
	('ns14', 'Item NS 14', 100, 1, 'item_standard', 1, 52, 1, '{}', 'nice item', 0.50),
	('ns2', 'Item NS 2', 100, 1, 'item_standard', 1, 40, 1, '{}', 'nice item', 0.50),
	('ns3', 'Item NS 3', 100, 1, 'item_standard', 1, 41, 1, '{}', 'nice item', 0.50),
	('ns4', 'Item NS 4', 100, 1, 'item_standard', 1, 42, 1, '{}', 'nice item', 0.50),
	('ns5', 'Item NS 5', 100, 1, 'item_standard', 1, 43, 1, '{}', 'nice item', 0.50),
	('ns6', 'Item NS 6', 100, 1, 'item_standard', 1, 44, 1, '{}', 'nice item', 0.50),
	('ns7', 'Item NS 7', 100, 1, 'item_standard', 1, 45, 1, '{}', 'nice item', 0.50),
	('ns8', 'Item NS 8', 100, 1, 'item_standard', 1, 46, 1, '{}', 'nice item', 0.50),
	('ns9', 'Item NS 9', 100, 1, 'item_standard', 1, 47, 1, '{}', 'nice item', 0.50),
	('obed', 'Cama Simples', 100, 1, 'item_standard', 1, 204, 1, '{}', 'nice item', 15.00),
	('oldwatch', 'Relógio Velho', 100, 1, 'item_standard', 1, 512, 1, '{}', 'nice item', 0.30),
	('opium', 'Ópio', 100, 1, 'item_standard', 1, 383, 1, '{}', 'nice item', 0.30),
	('opossumc', 'Garras de Gamba', 100, 1, 'item_standard', 1, 1488, 1, '{}', 'nice item', 0.10),
	('opossums', 'Pele de Gamba', 100, 1, 'item_standard', 1, 1468, 1, '{}', 'nice item', 0.50),
	('orange', 'Laranja', 100, 1, 'item_standard', 1, 479, 1, '{}', 'nice item', 0.20),
	('outfit', 'Roupa Completa', 100, 1, 'item_standard', 1, 272, 1, '{}', 'nice item', 2.00),
	('Ovelhapronta', 'Carne de Ovelha Pronta', 100, 1, 'item_standard', 1, 96, 1, '{}', 'nice item', 0.50),
	('panfleto', 'Panfleto', 100, 1, 'item_standard', 1, 488, 1, '{}', 'nice item', 0.10),
	('panquecas', 'Panquecas', 100, 1, 'item_standard', 1, 276, 1, '{}', 'nice item', 0.40),
	('panthere', 'Olhos de Pantera', 100, 1, 'item_standard', 1, 1507, 1, '{}', 'nice item', 0.10),
	('pants', 'Calças', 100, 1, 'item_standard', 1, 259, 1, '{}', 'nice item', 0.50),
	('papersign', 'Documento Assinado', 50, 1, 'item_standard', 1, 85, 1, '{}', 'nice item', 0.10),
	('papoula', 'Papoula', 100, 1, 'item_standard', 1, 364, 1, '{}', 'nice item', 0.20),
	('peach', 'Pêssego', 100, 1, 'item_standard', 1, 473, 1, '{}', 'nice item', 0.20),
	('pear', 'Pera', 100, 1, 'item_standard', 1, 480, 1, '{}', 'nice item', 0.20),
	('pearl', 'Pérola', 100, 1, 'item_standard', 1, 513, 1, '{}', 'nice item', 0.10),
	('pheasant_taxidermy', 'Taxidermia de Faisão', 100, 1, 'item_standard', 1, 183, 1, '{}', 'nice item', 3.00),
	('phonograph', 'Fonógrafo', 100, 1, 'item_standard', 1, 406, 1, '{}', 'nice item', 5.00),
	('pickaxe', 'Picareta', 100, 1, 'item_standard', 1, 332, 1, '{}', 'nice item', 2.50),
	('pigs_feet', 'Patas de Porco', 100, 1, 'item_standard', 1, 1505, 1, '{}', 'nice item', 0.30),
	('pimenta', 'Pimenta', 100, 1, 'item_standard', 1, 466, 1, '{}', 'nice item', 0.20),
	('pipe', 'Cachimbo', 5, 1, 'item_standard', 1, 551, 1, '{}', 'nice item', 0.20),
	('pipecopper', 'Tubo de Cobre', 100, 1, 'item_standard', 1, 355, 1, '{}', 'nice item', 1.50),
	('piratecoin', 'Moeda Pirata', 100, 1, 'item_standard', 1, 514, 1, '{}', 'nice item', 0.10),
	('pistolbarrel', 'Cano de Pistola', 100, 1, 'item_standard', 1, 339, 1, '{}', 'nice item', 0.50),
	('pistolgrip', 'Cabo de Pistola', 100, 1, 'item_standard', 1, 301, 1, '{}', 'nice item', 0.30),
	('pistolmold', 'Molde de Pistola', 100, 1, 'item_standard', 1, 345, 1, '{}', 'nice item', 1.00),
	('pistolreceiver', 'Receptor de Pistola', 100, 1, 'item_standard', 1, 344, 1, '{}', 'nice item', 0.50),
	('planttrimmer', 'Tesoura de Poda', 100, 1, 'item_standard', 1, 352, 1, '{}', 'nice item', 1.00),
	('pocket_compass', 'Bússola de Bolso', 1, 1, 'item_standard', 1, 1564, 1, '{}', 'nice item', 0.20),
	('poisonItem', 'Item de Veneno', 100, 1, 'item_standard', 1, 687, 1, '{}', 'nice item', 0.30),
	('pokerset', 'Kit de Poker', 100, 1, 'item_standard', 1, 152, 1, '{}', 'nice item', 1.00),
	('polvora', 'Pólvora', 100, 1, 'item_standard', 1, 358, 1, '{}', 'nice item', 0.50),
	('pomade', 'Pomada', 100, 1, 'item_standard', 1, 386, 1, '{}', 'nice item', 0.20),
	('ponchos', 'Ponchos', 100, 1, 'item_standard', 1, 248, 1, '{}', 'nice item', 0.80),
	('Porcopronta', 'Carne de Porco Pronta', 100, 1, 'item_standard', 1, 95, 1, '{}', 'nice item', 0.50),
	('pork', 'Carne de Porco', 100, 1, 'item_standard', 1, 504, 1, '{}', 'nice item', 0.50),
	('pot', 'Panela', 100, 1, 'item_standard', 1, 354, 1, '{}', 'nice item', 2.00),
	('pota', 'Pote', 100, 1, 'item_standard', 1, 169, 1, '{}', 'nice item', 1.00),
	('potato', 'Batata', 100, 1, 'item_standard', 1, 463, 1, '{}', 'nice item', 0.30),
	('potion', 'Poção', 50, 1, 'item_standard', 1, 1565, 1, '{}', 'nice item', 0.30),
	('potion1', 'Poção 1', 100, 1, 'item_standard', 1, 489, 1, '{}', 'nice item', 0.30),
	('potion10', 'Poção 10', 100, 1, 'item_standard', 1, 495, 1, '{}', 'nice item', 0.30),
	('potion2', 'Poção 2', 100, 1, 'item_standard', 1, 490, 1, '{}', 'nice item', 0.30),
	('potion3', 'Poção 3', 100, 1, 'item_standard', 1, 491, 1, '{}', 'nice item', 0.30),
	('potion4', 'Poção 4', 100, 1, 'item_standard', 1, 492, 1, '{}', 'nice item', 0.30),
	('potion5', 'Poção 5', 100, 1, 'item_standard', 1, 493, 1, '{}', 'nice item', 0.30),
	('potion6', 'Poção 6', 100, 1, 'item_standard', 1, 494, 1, '{}', 'nice item', 0.30),
	('prancheta', 'Prancheta', 100, 1, 'item_standard', 1, 677, 1, '{}', 'nice item', 0.50),
	('Pripronta', 'Carne de Peru Pronta', 100, 1, 'item_standard', 1, 94, 1, '{}', 'nice item', 0.50),
	('provision_feather_owl', 'Pena de Coruja', 100, 1, 'item_standard', 1, 1501, 1, '{}', 'nice item', 0.10),
	('pumpkin', 'Abóbora', 100, 1, 'item_standard', 1, 485, 1, '{}', 'nice item', 0.50),
	('punchitem', 'Item de Soco', 100, 1, 'item_standard', 1, 691, 1, '{}', 'nice item', 0.50),
	('p_baitBread01x', 'Isca de Pão', 100, 1, 'item_standard', 1, 542, 1, '{}', 'nice item', 0.10),
	('p_baitCheese01x', 'Isca de Queijo', 100, 1, 'item_standard', 1, 543, 1, '{}', 'nice item', 0.10),
	('p_baitCorn01x', 'Isca de Milho', 100, 1, 'item_standard', 1, 544, 1, '{}', 'nice item', 0.10),
	('p_baitCricket01x', 'Isca de Grilo', 100, 1, 'item_standard', 1, 545, 1, '{}', 'nice item', 0.10),
	('p_baitWorm01x', 'Isca de Minhoca', 100, 1, 'item_standard', 1, 546, 1, '{}', 'nice item', 0.10),
	('p_crawdad01x', 'p_crawdad01x', 100, 1, 'item_standard', 1, 734, 1, '{}', 'nice item', 0.50),
	('p_FinisdFishlure01x', 'Isca de Peixe', 100, 1, 'item_standard', 1, 534, 1, '{}', 'nice item', 0.10),
	('p_finisdfishlurelegendary01x', 'Isca Lendária', 100, 1, 'item_standard', 1, 535, 1, '{}', 'nice item', 0.10),
	('p_finishdcrawd01x', 'Isca de Caranguejo', 100, 1, 'item_standard', 1, 536, 1, '{}', 'nice item', 0.10),
	('p_finishdcrawdlegendary01x', 'Isca Caranguejo Lendária', 100, 1, 'item_standard', 1, 537, 1, '{}', 'nice item', 0.10),
	('p_finishedragonfly01x', 'Libélula', 100, 1, 'item_standard', 1, 538, 1, '{}', 'nice item', 0.10),
	('p_finishedragonflylegendary01x', 'Libélula Lendária', 100, 1, 'item_standard', 1, 539, 1, '{}', 'nice item', 0.10),
	('p_lgoc_spinner_v4', 'Spinner V4', 100, 1, 'item_standard', 1, 540, 1, '{}', 'nice item', 0.10),
	('p_lgoc_spinner_v6', 'Spinner V6', 100, 1, 'item_standard', 1, 541, 1, '{}', 'nice item', 0.10),
	('rabbitpaw', 'Pata de Coelho', 100, 1, 'item_standard', 1, 1506, 1, '{}', 'nice item', 0.10),
	('raccoons', 'Pele de Guaxinim', 100, 1, 'item_standard', 1, 1470, 1, '{}', 'nice item', 0.50),
	('raccoont', 'Dente de Guaxinim', 100, 1, 'item_standard', 1, 1494, 1, '{}', 'nice item', 0.10),
	('rat_c', 'Rato', 100, 1, 'item_standard', 1, 1512, 1, '{}', 'nice item', 0.10),
	('raw_peanuts', 'Amendoim Cru', 100, 1, 'item_standard', 1, 486, 1, '{}', 'nice item', 0.20),
	('rcboat_remote', 'Controle de Barco', 100, 1, 'item_standard', 1, 505, 1, '{}', 'nice item', 0.30),
	('rectangle_table', 'Mesa Retangular', 100, 1, 'item_standard', 1, 166, 1, '{}', 'nice item', 8.00),
	('red_raspberry', 'Framboesa Vermelha', 100, 1, 'item_standard', 1, 475, 1, '{}', 'nice item', 0.20),
	('remediopet', 'Remedio para pet', 100, 1, 'item_standard', 1, 726, 1, '{}', 'nice item', 0.50),
	('Repair_Kit', 'Kit Reparo', 100, 1, 'item_standard', 1, 733, 1, '{}', 'nice item', 0.50),
	('repeaterbarrel', 'Cano de Repetidora', 100, 1, 'item_standard', 1, 340, 1, '{}', 'nice item', 0.80),
	('repeatermold', 'Molde de Repetidora', 100, 1, 'item_standard', 1, 563, 1, '{}', 'nice item', 1.00),
	('repeaterreceiver', 'Receptor de Repetidora', 100, 1, 'item_standard', 1, 347, 1, '{}', 'nice item', 0.80),
	('repeaterrecmold', 'Molde Receptor Repetidora', 100, 1, 'item_standard', 1, 368, 1, '{}', 'nice item', 1.00),
	('repeaterstock', 'Coronha de Repetidora', 100, 1, 'item_standard', 1, 303, 1, '{}', 'nice item', 1.00),
	('resource_antler_moose', 'Chifres de Alce Grande', 100, 1, 'item_standard', 1, 1485, 1, '{}', 'nice item', 0.50),
	('resource_claw_owl', 'Garra de Coruja', 100, 1, 'item_standard', 1, 1490, 1, '{}', 'nice item', 0.10),
	('resource_claw_panther', 'Garras de Pantera', 100, 1, 'item_standard', 1, 1489, 1, '{}', 'nice item', 0.20),
	('resource_coal', 'Carvão', 100, 1, 'item_standard', 1, 58, 1, '{}', 'nice item', 0.80),
	('resource_empty_jar', 'Pote Vazio', 100, 1, 'item_standard', 1, 309, 1, '{}', 'nice item', 0.30),
	('resource_head_goat', 'Cabeça de Cabra', 100, 1, 'item_standard', 1, 1478, 1, '{}', 'nice item', 2.00),
	('resource_head_sheep', 'Cabeça de Ovelha', 100, 1, 'item_standard', 1, 1481, 1, '{}', 'nice item', 2.00),
	('resource_hide_cow_bull', 'Pele de Gado', 100, 1, 'item_standard', 1, 1457, 1, '{}', 'nice item', 1.00),
	('resource_horn_buffalo', 'Chifres de Búfalo', 100, 1, 'item_standard', 1, 1483, 1, '{}', 'nice item', 0.50),
	('resource_iron', 'Minério de Ferro', 100, 1, 'item_standard', 1, 55, 1, '{}', 'nice item', 1.00),
	('resource_iron_bar', 'Barra de Ferro', 100, 1, 'item_standard', 1, 331, 1, '{}', 'nice item', 2.00),
	('resource_nails', 'Pregos', 100, 1, 'item_standard', 1, 338, 1, '{}', 'nice item', 0.50),
	('resource_pelt_badger', 'Pele de Texugo', 100, 1, 'item_standard', 1, 1452, 1, '{}', 'nice item', 1.00),
	('resource_pelt_beaver', 'Pele de Castor', 100, 1, 'item_standard', 1, 1454, 1, '{}', 'nice item', 1.00),
	('resource_pelt_coyote', 'Pele de Coiote', 100, 1, 'item_standard', 1, 1459, 1, '{}', 'nice item', 1.00),
	('resource_pelt_fox', 'Pele de Raposa', 100, 1, 'item_standard', 1, 1461, 1, '{}', 'nice item', 1.00),
	('resource_pelt_rabbit', 'Pele de Coelho', 100, 1, 'item_standard', 1, 1469, 1, '{}', 'nice item', 0.30),
	('resource_pelt_wolf', 'Pele de Lobo', 100, 1, 'item_standard', 1, 1472, 1, '{}', 'nice item', 1.00),
	('resource_shell_turtle', 'Casco de Tartaruga', 100, 1, 'item_standard', 1, 1499, 1, '{}', 'nice item', 0.50),
	('resource_skin_buffalo', 'Pele de Bisão', 100, 1, 'item_standard', 1, 1456, 1, '{}', 'nice item', 1.50),
	('resource_skin_desert_iguana', 'Pele de Iguana do Deserto', 100, 1, 'item_standard', 1, 1463, 1, '{}', 'nice item', 0.50),
	('resource_skin_elk', 'Pele de Alce', 100, 1, 'item_standard', 1, 1460, 1, '{}', 'nice item', 1.00),
	('resource_skin_goat', 'Pele de Cabra', 100, 1, 'item_standard', 1, 1450, 1, '{}', 'nice item', 1.00),
	('resource_skin_iguana_green', 'Pele de Iguana Verde', 100, 1, 'item_standard', 1, 1462, 1, '{}', 'nice item', 0.50),
	('resource_skin_javelina_boar', 'Pele de Javali', 100, 1, 'item_standard', 1, 1455, 1, '{}', 'nice item', 1.00),
	('resource_skin_moose', 'Pele de Alce Grande', 100, 1, 'item_standard', 1, 1464, 1, '{}', 'nice item', 1.50),
	('resource_skin_panther', 'Pele de Pantera', 100, 1, 'item_standard', 1, 1466, 1, '{}', 'nice item', 1.00),
	('resource_skin_pig', 'Pele de Porco', 100, 1, 'item_standard', 1, 1467, 1, '{}', 'nice item', 1.00),
	('resource_skin_snake_blacktail_rattlesnake', 'Pele de Cobra', 100, 1, 'item_standard', 1, 1471, 1, '{}', 'nice item', 0.30),
	('resource_tail_beaver', 'Cauda de Castor', 100, 1, 'item_standard', 1, 1502, 1, '{}', 'nice item', 0.30),
	('resource_tooth_alligator', 'Dente de Jacare', 100, 1, 'item_standard', 1, 1491, 1, '{}', 'nice item', 0.20),
	('resource_wool', 'Lã', 100, 1, 'item_standard', 1, 1508, 1, '{}', 'nice item', 0.50),
	('revolverbarrel', 'Cano de Revólver', 100, 1, 'item_standard', 1, 342, 1, '{}', 'nice item', 0.50),
	('revolvercylinder', 'Cilindro de Revólver', 100, 1, 'item_standard', 1, 306, 1, '{}', 'nice item', 0.30),
	('revolverhandle', 'Cabo de Revólver', 100, 1, 'item_standard', 1, 305, 1, '{}', 'nice item', 0.30),
	('revolvermold', 'Molde de Revólver', 100, 1, 'item_standard', 1, 366, 1, '{}', 'nice item', 1.00),
	('riflebarrel', 'Cano de Rifle', 100, 1, 'item_standard', 1, 341, 1, '{}', 'nice item', 0.80),
	('riflemold', 'Molde de Rifle', 100, 1, 'item_standard', 1, 367, 1, '{}', 'nice item', 1.00),
	('riflereceiver', 'Receptor de Rifle', 100, 1, 'item_standard', 1, 346, 1, '{}', 'nice item', 0.80),
	('riflerecmold', 'Molde Receptor Rifle', 100, 1, 'item_standard', 1, 564, 1, '{}', 'nice item', 1.00),
	('riflestock', 'Coronha de Rifle', 100, 1, 'item_standard', 1, 302, 1, '{}', 'nice item', 1.00),
	('robberyplanning', 'Planejamento de Roubo', 100, 1, 'item_standard', 1, 138, 1, '{}', 'nice item', 1.00),
	('rock', 'Pedra', 100, 1, 'item_standard', 1, 102, 1, '{}', 'nice item', 1.50),
	('rollingpaper', 'Papel de Enrolar', 100, 1, 'item_standard', 1, 527, 1, '{}', 'nice item', 0.05),
	('round_table', 'Mesa Redonda', 100, 1, 'item_standard', 1, 164, 1, '{}', 'nice item', 8.00),
	('rubber', 'Borracha', 100, 1, 'item_standard', 1, 297, 1, '{}', 'nice item', 0.30),
	('rubbertube', 'Tubo de Borracha', 100, 1, 'item_standard', 1, 529, 1, '{}', 'nice item', 0.50),
	('saco_vazio', 'Saco Vazio', 100, 1, 'item_standard', 1, 308, 1, '{}', 'nice item', 0.10),
	('saintdeniskey', 'Chave de Saint Denis', 100, 1, 'item_standard', 1, 515, 1, '{}', 'nice item', 0.20),
	('salitre', 'Salitre', 100, 1, 'item_standard', 1, 400, 1, '{}', 'nice item', 0.50),
	('salt', 'Sal', 100, 1, 'item_standard', 1, 401, 1, '{}', 'nice item', 0.30),
	('sangue', 'Sangue', 100, 1, 'item_standard', 1, 694, 1, '{}', 'nice item', 0.30),
	('sap', 'Seiva', 100, 1, 'item_standard', 1, 615, 1, '{}', 'nice item', 0.30),
	('satchels', 'Sacolas', 100, 1, 'item_standard', 1, 254, 1, '{}', 'nice item', 1.00),
	('Scalp1', 'Escalpo 1', 100, 1, 'item_standard', 1, 31, 1, '{}', 'nice item', 0.30),
	('Scalp2', 'Escalpo 2', 100, 1, 'item_standard', 1, 32, 1, '{}', 'nice item', 0.30),
	('Scalp3', 'Escalpo 3', 100, 1, 'item_standard', 1, 33, 1, '{}', 'nice item', 0.30),
	('Scalp4', 'Escalpo 4', 100, 1, 'item_standard', 1, 34, 1, '{}', 'nice item', 0.30),
	('Scalp5', 'Escalpo 5', 100, 1, 'item_standard', 1, 35, 1, '{}', 'nice item', 0.30),
	('Scalp6', 'Escalpo 6', 100, 1, 'item_standard', 1, 36, 1, '{}', 'nice item', 0.30),
	('Scalp7', 'Escalpo 7', 100, 1, 'item_standard', 1, 37, 1, '{}', 'nice item', 0.30),
	('Scalp8', 'Escalpo 8', 100, 1, 'item_standard', 1, 38, 1, '{}', 'nice item', 0.30),
	('scratchcard', 'Raspadinha', 100, 1, 'item_standard', 1, 521, 1, '{}', 'nice item', 0.10),
	('segundachanse', 'Segunda chanse', 100, 1, 'item_standard', 1, 732, 1, '{}', 'nice item', 0.50),
	('semente_abobora', 'Semente de Abóbora', 100, 1, 'item_standard', 1, 448, 1, '{}', 'nice item', 0.10),
	('semente_agarita', 'Semente de Agarita', 100, 1, 'item_standard', 1, 411, 1, '{}', 'nice item', 0.10),
	('semente_alaska_ginseng', 'Semente de Ginseng do Alaska', 100, 1, 'item_standard', 1, 421, 1, '{}', 'nice item', 0.10),
	('semente_alface', 'Semente de Alface', 100, 1, 'item_standard', 1, 450, 1, '{}', 'nice item', 0.10),
	('semente_algodao', 'Semente de Algodão', 100, 1, 'item_standard', 1, 443, 1, '{}', 'nice item', 0.10),
	('semente_alho_corvo', 'Semente de Alho do Corvo', 100, 1, 'item_standard', 1, 437, 1, '{}', 'nice item', 0.10),
	('semente_ameixa', 'Semente de Ameixa', 100, 1, 'item_standard', 1, 438, 1, '{}', 'nice item', 0.10),
	('semente_amendoin', 'Semente de Amendoim', 100, 1, 'item_standard', 1, 449, 1, '{}', 'nice item', 0.10),
	('semente_batata', 'Semente de Batata', 100, 1, 'item_standard', 1, 424, 1, '{}', 'nice item', 0.10),
	('semente_cabeca_carneiro', 'Semente de Cabeça de Carneiro', 100, 1, 'item_standard', 1, 417, 1, '{}', 'nice item', 0.10),
	('semente_camomila', 'Semente de Camomila', 100, 1, 'item_standard', 1, 429, 1, '{}', 'nice item', 0.10),
	('semente_cana_acucar', 'Semente de Cana de Açúcar', 100, 1, 'item_standard', 1, 422, 1, '{}', 'nice item', 0.10),
	('semente_cebola', 'Semente de Cebola', 100, 1, 'item_standard', 1, 426, 1, '{}', 'nice item', 0.10),
	('semente_cenoura', 'Semente de Cenoura', 100, 1, 'item_standard', 1, 432, 1, '{}', 'nice item', 0.10),
	('semente_cenoura_selvagem', 'Semente de Cenoura Selvagem', 100, 1, 'item_standard', 1, 412, 1, '{}', 'nice item', 0.10),
	('semente_coffee', 'Semente de Café', 100, 1, 'item_standard', 1, 433, 1, '{}', 'nice item', 0.10),
	('semente_cogumelo', 'Semente de Cogumelo', 100, 1, 'item_standard', 1, 430, 1, '{}', 'nice item', 0.10),
	('semente_cogumelo_guarda_sol', 'Semente de Cogumelo Guarda-Sol', 100, 1, 'item_standard', 1, 418, 1, '{}', 'nice item', 0.10),
	('semente_framboesa_vermelha', 'Semente de Framboesa Vermelha', 100, 1, 'item_standard', 1, 436, 1, '{}', 'nice item', 0.10),
	('semente_groselha_preta', 'Semente de Groselha Preta', 100, 1, 'item_standard', 1, 431, 1, '{}', 'nice item', 0.10),
	('semente_guarma_tabaco', 'Semente de Tabaco Guarma', 100, 1, 'item_standard', 1, 414, 1, '{}', 'nice item', 0.10),
	('semente_laranja', 'Semente de Laranja', 100, 1, 'item_standard', 1, 440, 1, '{}', 'nice item', 0.10),
	('semente_limao', 'Semente de Limão', 100, 1, 'item_standard', 1, 439, 1, '{}', 'nice item', 0.10),
	('semente_maca', 'Semente de Maçã', 100, 1, 'item_standard', 1, 428, 1, '{}', 'nice item', 0.10),
	('semente_menta_selvagem', 'Semente de Menta Selvagem', 100, 1, 'item_standard', 1, 416, 1, '{}', 'nice item', 0.10),
	('semente_milho', 'Semente de Milho', 100, 1, 'item_standard', 1, 415, 1, '{}', 'nice item', 0.10),
	('semente_mirtilo_perene', 'Semente de Mirtilo Perene', 100, 1, 'item_standard', 1, 420, 1, '{}', 'nice item', 0.10),
	('semente_morango', 'Semente de Morango', 100, 1, 'item_standard', 1, 447, 1, '{}', 'nice item', 0.10),
	('semente_papoula', 'Semente de Papoula', 100, 1, 'item_standard', 1, 444, 1, '{}', 'nice item', 0.10),
	('semente_pecego', 'Semente de Pêssego', 100, 1, 'item_standard', 1, 434, 1, '{}', 'nice item', 0.10),
	('semente_pera', 'Semente de Pera', 100, 1, 'item_standard', 1, 441, 1, '{}', 'nice item', 0.10),
	('semente_pimenta', 'Semente de Pimenta', 100, 1, 'item_standard', 1, 427, 1, '{}', 'nice item', 0.10),
	('semente_pimentao_misto', 'Semente de Pimentão Misto', 100, 1, 'item_standard', 1, 446, 1, '{}', 'nice item', 0.10),
	('semente_pimentao_verde', 'Semente de Pimentão Verde', 100, 1, 'item_standard', 1, 445, 1, '{}', 'nice item', 0.10),
	('semente_selvia_beija_flor', 'Semente de Sálvia Beija-Flor', 100, 1, 'item_standard', 1, 419, 1, '{}', 'nice item', 0.10),
	('semente_tabaco', 'Semente de Tabaco', 100, 1, 'item_standard', 1, 435, 1, '{}', 'nice item', 0.10),
	('semente_tabaco_indiano', 'Semente de Tabaco Indiano', 100, 1, 'item_standard', 1, 413, 1, '{}', 'nice item', 0.10),
	('semente_tomate', 'Semente de Tomate', 100, 1, 'item_standard', 1, 425, 1, '{}', 'nice item', 0.10),
	('semente_trigo', 'Semente de Trigo', 100, 1, 'item_standard', 1, 442, 1, '{}', 'nice item', 0.10),
	('semente_uva', 'Semente de Uva', 100, 1, 'item_standard', 1, 423, 1, '{}', 'nice item', 0.10),
	('seringa_vazia', 'Seringa Vazia', 100, 1, 'item_standard', 1, 300, 1, '{}', 'nice item', 0.10),
	('SerrariaBW', 'Livro Serraria BW', 100, 1, 'item_standard', 1, 715, 1, '{}', 'nice item', 0.50),
	('shellcasing', 'Estojo de Bala', 1000, 1, 'item_standard', 1, 337, 1, '{}', 'nice item', 0.01),
	('shirts_full', 'Camisas Completas', 100, 1, 'item_standard', 1, 238, 1, '{}', 'nice item', 0.50),
	('shootingtarget', 'Alvo de Tiro', 100, 1, 'item_standard', 1, 147, 1, '{}', 'nice item', 5.00),
	('shoptoken', 'Licença de loja normal', 100, 1, 'item_standard', 1, 730, 1, '{}', 'nice item', 0.50),
	('shotgunbarrel', 'Cano de Espingarda', 100, 1, 'item_standard', 1, 343, 1, '{}', 'nice item', 1.00),
	('shotgunmold', 'Molde de Espingarda', 100, 1, 'item_standard', 1, 369, 1, '{}', 'nice item', 1.00),
	('shotgunstock', 'Coronha de Espingarda', 100, 1, 'item_standard', 1, 304, 1, '{}', 'nice item', 1.00),
	('shovel', 'Pá', 100, 1, 'item_standard', 1, 351, 1, '{}', 'nice item', 2.50),
	('side_table', 'Mesa Lateral', 100, 1, 'item_standard', 1, 196, 1, '{}', 'nice item', 5.00),
	('side_tablea', 'Mesa Lateral A', 100, 1, 'item_standard', 1, 197, 1, '{}', 'nice item', 5.00),
	('side_tableb', 'Mesa Lateral B', 100, 1, 'item_standard', 1, 198, 1, '{}', 'nice item', 5.00),
	('simplenativetent', 'Tenda Nativa Simples', 100, 1, 'item_standard', 1, 212, 1, '{}', 'nice item', 10.00),
	('singlebed', 'Cama de Solteiro', 100, 1, 'item_standard', 1, 206, 1, '{}', 'nice item', 15.00),
	('skirts', 'Saias', 100, 1, 'item_standard', 1, 260, 1, '{}', 'nice item', 0.50),
	('skullpost', 'Poste de Crânio', 100, 1, 'item_standard', 1, 131, 1, '{}', 'nice item', 3.00),
	('smallmcandle', 'Vela Pequena', 100, 1, 'item_standard', 1, 202, 1, '{}', 'nice item', 0.20),
	('small_firecracker', 'pequeno foguete', 100, 1, 'item_standard', 1, 722, 1, '{}', 'nice item', 0.50),
	('small_fireworks', 'pequenos fogos de artifício', 100, 1, 'item_standard', 1, 721, 1, '{}', 'nice item', 0.50),
	('smoke_campfire', 'fogueira de fumaça', 100, 1, 'item_standard', 1, 724, 1, '{}', 'nice item', 0.50),
	('snaket', 'Dente de Cobra', 100, 1, 'item_standard', 1, 1495, 1, '{}', 'nice item', 0.10),
	('Snake_Poison', 'Veneno de Cobra', 100, 1, 'item_standard', 1, 1514, 1, '{}', 'nice item', 0.10),
	('soap', 'Sabão', 100, 1, 'item_standard', 1, 393, 1, '{}', 'nice item', 0.30),
	('societytoken', 'Licença de loja Sociedade', 100, 1, 'item_standard', 1, 731, 1, '{}', 'nice item', 0.50),
	('spats', 'Polainas', 100, 1, 'item_standard', 1, 267, 1, '{}', 'nice item', 0.30),
	('speeditem', 'Item de Velocidade', 100, 1, 'item_standard', 1, 689, 1, '{}', 'nice item', 0.50),
	('squirrel_grey_c', 'Esquilo Cinza', 100, 1, 'item_standard', 1, 1513, 1, '{}', 'nice item', 0.20),
	('standard_table', 'Mesa Padrão', 100, 1, 'item_standard', 1, 165, 1, '{}', 'nice item', 8.00),
	('standingtorch', 'Tocha em Pé', 100, 1, 'item_standard', 1, 146, 1, '{}', 'nice item', 3.00),
	('stillkit', 'Kit de Destilaria', 100, 1, 'item_standard', 1, 609, 1, '{}', 'nice item', 5.00),
	('stim', 'Estimulante', 100, 1, 'item_standard', 1, 292, 1, '{}', 'nice item', 0.30),
	('strawberry', 'Morango', 100, 1, 'item_standard', 1, 484, 1, '{}', 'nice item', 0.20),
	('sugar', 'Açúcar', 100, 1, 'item_standard', 1, 582, 1, '{}', 'nice item', 0.30),
	('suspenders', 'Suspensórios', 100, 1, 'item_standard', 1, 241, 1, '{}', 'nice item', 0.20),
	('syn', 'Sintético', 100, 1, 'item_standard', 1, 616, 1, '{}', 'nice item', 0.30),
	('syringe', 'Seringa', 50, 1, 'item_standard', 1, 87, 1, '{}', 'nice item', 0.10),
	('tabacodemascar', 'Tabaco de Mascar Brasileiro', 50, 1, 'item_standard', 1, 549, 1, '{}', 'nice item', 0.10),
	('Teapot_Can', 'Lata de Chá', 100, 1, 'item_standard', 1, 532, 1, '{}', 'nice item', 0.50),
	('tecido', 'Tecido', 100, 1, 'item_standard', 1, 295, 1, '{}', 'nice item', 0.50),
	('teleitem', 'Item de Teleporte', 100, 1, 'item_standard', 1, 692, 1, '{}', 'nice item', 0.50),
	('tent', 'Tenda', 100, 1, 'item_standard', 1, 161, 1, '{}', 'nice item', 10.00),
	('tent2', 'Tenda 2', 100, 1, 'item_standard', 1, 122, 1, '{}', 'nice item', 10.00),
	('tent3', 'Tenda 3', 100, 1, 'item_standard', 1, 123, 1, '{}', 'nice item', 10.00),
	('tent4', 'Tenda 4', 100, 1, 'item_standard', 1, 124, 1, '{}', 'nice item', 10.00),
	('timber_table', 'Mesa de Madeira', 100, 1, 'item_standard', 1, 167, 1, '{}', 'nice item', 8.00),
	('tipi', 'Tenda Tipi', 100, 1, 'item_standard', 1, 121, 1, '{}', 'nice item', 15.00),
	('toalha', 'toalha', 100, 1, 'item_standard', 1, 728, 1, '{}', 'nice item', 0.50),
	('tobaccopipe', 'Cachimbo de Tabaco', 100, 1, 'item_standard', 1, 553, 1, '{}', 'nice item', 0.30),
	('tobacco_leaf', 'Folha de Tabaco', 100, 1, 'item_standard', 1, 474, 1, '{}', 'nice item', 0.20),
	('tomato', 'Tomate', 100, 1, 'item_standard', 1, 464, 1, '{}', 'nice item', 0.20),
	('tonico_medicina', 'Tônico Medicinal', 50, 1, 'item_standard', 1, 697, 1, '{}', 'nice item', 0.30),
	('tool_barrel', 'Barril de Ferramentas', 100, 1, 'item_standard', 1, 181, 1, '{}', 'nice item', 8.00),
	('towel', 'Toalha', 100, 1, 'item_standard', 1, 395, 1, '{}', 'nice item', 0.50),
	('trainkey', 'Chave do Trem', 100, 1, 'item_standard', 1, 580, 1, '{}', 'nice item', 0.20),
	('trayoffood', 'Bandeja de Comida', 100, 1, 'item_standard', 1, 148, 1, '{}', 'nice item', 1.00),
	('tronco2', 'Tronco', 100, 1, 'item_standard', 1, 387, 1, '{}', 'nice item', 5.00),
	('turtlet', 'Dente de Tartaruga', 100, 1, 'item_standard', 1, 1496, 1, '{}', 'nice item', 0.10),
	('undertaker1', 'Coveiro 1', 100, 1, 'item_standard', 1, 143, 1, '{}', 'nice item', 5.00),
	('undertaker2', 'Coveiro 2', 100, 1, 'item_standard', 1, 144, 1, '{}', 'nice item', 5.00),
	('unique_medicinal_cocaine', 'Cocaína Medicinal', 100, 1, 'item_standard', 1, 385, 1, '{}', 'nice item', 0.30),
	('upperclassclothes', 'Roupas Classe Alta', 100, 1, 'item_standard', 1, 227, 1, '{}', 'nice item', 1.00),
	('vampire', 'Vampiro', 100, 1, 'item_standard', 1, 693, 1, '{}', 'nice item', 0.50),
	('vests', 'Coletes', 100, 1, 'item_standard', 1, 244, 1, '{}', 'nice item', 0.50),
	('vip1', 'vip1', 100, 1, 'item_standard', 1, 735, 1, '{}', 'nice item', 0.50),
	('vulture_taxidermy', 'Taxidermia de Abutre', 100, 1, 'item_standard', 1, 186, 1, '{}', 'nice item', 3.00),
	('washcloth', 'Pano de Lavar', 100, 1, 'item_standard', 1, 522, 1, '{}', 'nice item', 0.20),
	('washtub', 'Tina de Lavar', 100, 1, 'item_standard', 1, 179, 1, '{}', 'nice item', 5.00),
	('water', 'Água', 100, 1, 'item_standard', 1, 88, 1, '{}', 'nice item', 0.50),
	('waterbarrel', 'Barril de Água', 100, 1, 'item_standard', 1, 160, 1, '{}', 'nice item', 8.00),
	('wateringcan', 'Regador', 100, 1, 'item_standard', 1, 407, 1, '{}', 'nice item', 1.50),
	('wateringcan_dirtywater', 'Regador com Água Suja', 100, 1, 'item_standard', 1, 408, 1, '{}', 'nice item', 1.50),
	('wateringcan_empty', 'Regador Vazio', 100, 1, 'item_standard', 1, 334, 1, '{}', 'nice item', 1.00),
	('water_clean', 'Água Limpa', 100, 1, 'item_standard', 1, 99, 1, '{}', 'nice item', 0.50),
	('water_pump', 'Bomba de Água', 100, 1, 'item_standard', 1, 170, 1, '{}', 'nice item', 15.00),
	('WEAPON_BOW', 'Arco', 1, 1, 'item_weapon', 1, 566, 1, '{}', 'nice item', 1.50),
	('WEAPON_BOW_IMPROVED', 'Arco Melhorado', 1, 1, 'item_weapon', 1, 655, 1, '{}', 'nice item', 1.80),
	('WEAPON_FISHINGROD', 'Vara de Pesca', 1, 1, 'item_weapon', 1, 533, 1, '{}', 'nice item', 2.00),
	('WEAPON_KIT_BINOCULARS', 'Binóculos', 1, 1, 'item_weapon', 1, 569, 1, '{}', 'nice item', 0.50),
	('WEAPON_KIT_BINOCULARS_IMPROVED', 'Binóculos Melhorados', 1, 1, 'item_weapon', 1, 669, 1, '{}', 'nice item', 0.80),
	('WEAPON_KIT_CAMERA', 'Câmera', 1, 1, 'item_weapon', 1, 670, 1, '{}', 'nice item', 1.50),
	('WEAPON_kIT_CAMERA_ADVANCED', 'Câmera Avançada', 1, 1, 'item_weapon', 1, 671, 1, '{}', 'nice item', 2.00),
	('WEAPON_KIT_METAL_DETECTOR', 'Detector de Metais', 1, 1, 'item_weapon', 1, 666, 1, '{}', 'nice item', 2.00),
	('WEAPON_LASSO', 'Laço', 1, 1, 'item_weapon', 1, 568, 1, '{}', 'nice item', 1.00),
	('WEAPON_LASSO_REINFORCED', 'Laço Reforçado', 1, 1, 'item_weapon', 1, 668, 1, '{}', 'nice item', 1.20),
	('WEAPON_MELEE_CLEAVER', 'Cutelo', 1, 1, 'item_weapon', 1, 653, 1, '{}', 'nice item', 1.00),
	('WEAPON_MELEE_DAVY_LANTERN', 'Lanterna Davy', 1, 1, 'item_weapon', 1, 672, 1, '{}', 'nice item', 0.80),
	('WEAPON_MELEE_HATCHET_HUNTER', 'Machado Caçador', 1, 1, 'item_weapon', 1, 654, 1, '{}', 'nice item', 2.00),
	('weapon_melee_knife', 'Faca', 1, 1, 'item_weapon', 1, 336, 1, '{}', 'nice item', 0.50),
	('WEAPON_MELEE_KNIFE_HORROR', 'Faca de Horror', 1, 1, 'item_weapon', 1, 649, 1, '{}', 'nice item', 0.50),
	('WEAPON_MELEE_KNIFE_JAWBONE', 'Faca Mandíbula', 1, 1, 'item_weapon', 1, 652, 1, '{}', 'nice item', 0.50),
	('WEAPON_MELEE_KNIFE_RUSTIC', 'Faca Rústica', 1, 1, 'item_weapon', 1, 650, 1, '{}', 'nice item', 0.50),
	('WEAPON_MELEE_KNIFE_TRADER', 'Faca do Comerciante', 1, 1, 'item_weapon', 1, 651, 1, '{}', 'nice item', 0.50),
	('WEAPON_MELEE_LANTERN', 'Lanterna', 1, 1, 'item_weapon', 1, 570, 1, '{}', 'nice item', 0.80),
	('WEAPON_MELEE_LANTERN_HALLOWEEN', 'Lanterna Halloween', 1, 1, 'item_weapon', 1, 667, 1, '{}', 'nice item', 0.80),
	('WEAPON_MELEE_MACHETE', 'Facão', 1, 1, 'item_weapon', 1, 565, 1, '{}', 'nice item', 1.50),
	('weapon_melee_machete_collector', 'Facão Colecionador', 100, 1, 'item_weapon', 1, 335, 1, '{}', 'nice item', 1.50),
	('WEAPON_PISTOL_M1899', 'Pistola M1899', 1, 1, 'item_weapon', 1, 657, 1, '{}', 'nice item', 2.00),
	('WEAPON_PISTOL_MAUSER', 'Pistola Mauser', 1, 1, 'item_weapon', 1, 321, 1, '{}', 'nice item', 2.00),
	('WEAPON_PISTOL_SEMIAUTO', 'Pistola Semiautomática', 1, 1, 'item_weapon', 1, 322, 1, '{}', 'nice item', 2.00),
	('WEAPON_PISTOL_VOLCANIC', 'Pistola Volcanic', 1, 1, 'item_weapon', 1, 656, 1, '{}', 'nice item', 2.00),
	('WEAPON_REPEATER_CARBINE', 'Repetidora Carbine', 1, 1, 'item_weapon', 1, 327, 1, '{}', 'nice item', 3.50),
	('WEAPON_REPEATER_EVANS', 'Repetidora Evans', 1, 1, 'item_weapon', 1, 571, 1, '{}', 'nice item', 3.50),
	('WEAPON_REPEATER_HENRY', 'Repetidora Henry', 1, 1, 'item_weapon', 1, 572, 1, '{}', 'nice item', 3.50),
	('WEAPON_REPEATER_WINCHESTER', 'Repetidora Winchester', 1, 1, 'item_weapon', 1, 328, 1, '{}', 'nice item', 3.50),
	('WEAPON_REVOLVER_CATTLEMAN', 'Revólver Cattleman', 1, 1, 'item_weapon', 1, 318, 1, '{}', 'nice item', 2.00),
	('WEAPON_REVOLVER_DOUBLEACTION', 'Revólver Ação Dupla', 1, 1, 'item_weapon', 1, 320, 1, '{}', 'nice item', 2.00),
	('WEAPON_REVOLVER_LEMAT', 'Revólver LeMat', 1, 1, 'item_weapon', 1, 319, 1, '{}', 'nice item', 2.50),
	('WEAPON_REVOLVER_NAVY', 'Revólver Navy', 1, 1, 'item_weapon', 1, 316, 1, '{}', 'nice item', 2.00),
	('WEAPON_REVOLVER_NAVY_CROSSOVER', 'Revólver Navy Crossover', 1, 1, 'item_weapon', 1, 376, 1, '{}', 'nice item', 2.00),
	('WEAPON_REVOLVER_SCHOFIELD', 'Revólver Schofield', 1, 1, 'item_weapon', 1, 317, 1, '{}', 'nice item', 2.00),
	('WEAPON_RIFLE_BOLTACTION', 'Rifle Bolt Action', 1, 1, 'item_weapon', 1, 377, 1, '{}', 'nice item', 4.00),
	('WEAPON_RIFLE_ELEPHANT', 'Rifle de Elefante', 1, 1, 'item_weapon', 1, 323, 1, '{}', 'nice item', 5.00),
	('WEAPON_RIFLE_SPRINGFIELD', 'Rifle Springfield', 1, 1, 'item_weapon', 1, 324, 1, '{}', 'nice item', 4.00),
	('WEAPON_RIFLE_VARMINT', 'Rifle Varmint', 1, 1, 'item_weapon', 1, 325, 1, '{}', 'nice item', 3.50),
	('WEAPON_SHOTGUN_DOUBLEBARREL', 'Espingarda Cano Duplo', 1, 1, 'item_weapon', 1, 330, 1, '{}', 'nice item', 4.00),
	('WEAPON_SHOTGUN_PUMP', 'Espingarda Pump', 1, 1, 'item_weapon', 1, 329, 1, '{}', 'nice item', 4.00),
	('WEAPON_SHOTGUN_REPEATING', 'Espingarda Repetidora', 1, 1, 'item_weapon', 1, 574, 1, '{}', 'nice item', 4.00),
	('WEAPON_SHOTGUN_SAWEDOFF', 'Espingarda Serrada', 1, 1, 'item_weapon', 1, 573, 1, '{}', 'nice item', 3.00),
	('WEAPON_SHOTGUN_SEMIAUTO', 'Espingarda Semiautomática', 1, 1, 'item_weapon', 1, 575, 1, '{}', 'nice item', 4.00),
	('WEAPON_SNIPERRIFLE_CARCANO', 'Rifle Carcano', 1, 1, 'item_weapon', 1, 378, 1, '{}', 'nice item', 4.50),
	('WEAPON_SNIPERRIFLE_ROLLINGBLOCK', 'Rifle Rolling Block', 1, 1, 'item_weapon', 1, 326, 1, '{}', 'nice item', 4.50),
	('WEAPON_THROWN_BOLAS', 'Bolas', 1, 1, 'item_weapon', 1, 663, 1, '{}', 'nice item', 1.00),
	('WEAPON_THROWN_BOLAS_HAWKMOTH', 'Bolas Falcão', 1, 1, 'item_weapon', 1, 658, 1, '{}', 'nice item', 1.00),
	('WEAPON_THROWN_BOLAS_INTERTWINED', 'Bolas Entrelaçadas', 1, 1, 'item_weapon', 1, 660, 1, '{}', 'nice item', 1.00),
	('WEAPON_THROWN_BOLAS_IRONSPIKED', 'Bolas Ferro com Espinhos', 1, 1, 'item_weapon', 1, 659, 1, '{}', 'nice item', 1.00),
	('WEAPON_THROWN_DYNAMITE', 'Dinamite', 1, 1, 'item_weapon', 1, 664, 1, '{}', 'nice item', 0.80),
	('WEAPON_THROWN_MOLOTOV', 'Coquetel Molotov', 1, 1, 'item_weapon', 1, 665, 1, '{}', 'nice item', 0.80),
	('WEAPON_THROWN_POISONBOTTLE', 'Garrafa de Veneno', 1, 1, 'item_weapon', 1, 662, 1, '{}', 'nice item', 0.50),
	('WEAPON_THROWN_THROWING_KNIVES', 'Facas de Arremesso', 1, 1, 'item_weapon', 1, 661, 1, '{}', 'nice item', 0.80),
	('WEAPON_THROWN_TOMAHAWK', 'Tomahawk', 1, 1, 'item_weapon', 1, 567, 1, '{}', 'nice item', 1.00),
	('weed', 'Maconha', 100, 1, 'item_standard', 1, 365, 1, '{}', 'nice item', 0.30),
	('weedpack', 'Pacote de Ervas', 50, 1, 'item_standard', 1, 550, 1, '{}', 'nice item', 0.20),
	('weedseed', 'Semente de Erva', 100, 1, 'item_standard', 1, 410, 1, '{}', 'nice item', 0.10),
	('wheat', 'Trigo', 100, 1, 'item_standard', 1, 496, 1, '{}', 'nice item', 0.30),
	('whisky', 'Whisky', 100, 1, 'item_standard', 1, 285, 1, '{}', 'nice item', 0.80),
	('wicker_bench', 'Banco de Vime', 100, 1, 'item_standard', 1, 192, 1, '{}', 'nice item', 4.00),
	('Wild_Carrot', 'Cenoura Selvagem', 100, 1, 'item_standard', 1, 497, 1, '{}', 'nice item', 0.20),
	('wolfnativetent', 'Tenda Lobo Nativa', 100, 1, 'item_standard', 1, 215, 1, '{}', 'nice item', 12.00),
	('wolftooth', 'Dente de Lobo', 100, 1, 'item_standard', 1, 1497, 1, '{}', 'nice item', 0.10),
	('wood', 'Madeira', 100, 1, 'item_standard', 1, 103, 1, '{}', 'nice item', 1.00),
	('wooden_bench', 'Banco de Madeira', 100, 1, 'item_standard', 1, 191, 1, '{}', 'nice item', 5.00),
	('wooden_boards', 'Tábuas de Madeira', 100, 1, 'item_standard', 1, 555, 1, '{}', 'nice item', 1.00),
	('woodfence', 'Cerca de Madeira', 100, 1, 'item_standard', 1, 126, 1, '{}', 'nice item', 8.00),
	('woodsaw', 'Serra de Madeira', 100, 1, 'item_standard', 1, 531, 1, '{}', 'nice item', 2.00),
	('wood_chair', 'Cadeira de Madeira', 100, 1, 'item_standard', 1, 162, 1, '{}', 'nice item', 3.00),
	('wood_vieja', 'Madeira Velha', 100, 1, 'item_standard', 1, 556, 1, '{}', 'nice item', 1.00),
	('wool', 'Lã', 100, 1, 'item_standard', 1, 501, 1, '{}', 'nice item', 0.50),
	('xmaspole', 'Poste de Natal', 100, 1, 'item_standard', 1, 113, 1, '{}', 'nice item', 5.00),
	('xmastree', 'Árvore de Natal', 100, 1, 'item_standard', 1, 120, 1, '{}', 'nice item', 8.00);

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.mail: ~0 rows (aproximadamente)

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

-- Copiando dados para a tabela mdg_ultimate.mdgfarmsdex: ~1 rows (aproximadamente)
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

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
  `inventory_capacity` int(11) DEFAULT 500,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



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

-- Copiando dados para a tabela mdg_ultimate.real_logic_horses: ~1 rows (aproximadamente)
INSERT IGNORE INTO `real_logic_horses` (`update_time`) VALUES
	(8);

-- Copiando estrutura para tabela mdg_ultimate.real_logic_pets
CREATE TABLE IF NOT EXISTS `real_logic_pets` (
  `update_time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.real_logic_pets: ~1 rows (aproximadamente)
INSERT IGNORE INTO `real_logic_pets` (`update_time`) VALUES
	(0);

-- Copiando estrutura para tabela mdg_ultimate.real_logic_ranch
CREATE TABLE IF NOT EXISTS `real_logic_ranch` (
  `update_time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.real_logic_ranch: ~1 rows (aproximadamente)
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

-- Copiando dados para a tabela mdg_ultimate.society_ledger: ~90 rows (aproximadamente)
INSERT IGNORE INTO `society_ledger` (`job`, `ledger`) VALUES
	('police', 150),
	('miner', 0),
	('doctor', 1050),
	('horsetrainer', 0),
	('Fazenda08', 0),
	('doctor', 1050),
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
	('TreinadorSD', 0),
	('TreinadorSW', 0);

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
  `max_jobs` int(11) DEFAULT 3,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.users: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mdg_ultimate.vltfarmsdex
CREATE TABLE IF NOT EXISTS `vltfarmsdex` (
  `dex` longtext DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vltfarmsdex: ~1 rows (aproximadamente)
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

-- Copiando estrutura para tabela mdg_ultimate.vlt_balloons
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

-- Copiando dados para a tabela mdg_ultimate.vlt_balloons: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- Copiando dados para a tabela mdg_ultimate.vlt_barber_system: ~0 rows (aproximadamente)

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

-- Copiando dados para a tabela mdg_ultimate.vlt_journalist: ~1 rows (aproximadamente)
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

-- Copiando estrutura para tabela mdg_ultimate.vlt_quests
CREATE TABLE IF NOT EXISTS `vlt_quests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `questtype` int(2) NOT NULL,
  `questid` int(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela mdg_ultimate.vlt_quests: ~0 rows (aproximadamente)

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
