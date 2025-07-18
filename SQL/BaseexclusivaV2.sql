-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.28-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.6.0.6796
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para baseexclusivav2
CREATE DATABASE IF NOT EXISTS `baseexclusivav2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `baseexclusivav2`;

-- Copiando estrutura para procedure baseexclusivav2.AlterTableMail
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

-- Copiando estrutura para tabela baseexclusivav2.bank_users
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

-- Copiando dados para a tabela baseexclusivav2.bank_users: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.banneds
CREATE TABLE IF NOT EXISTS `banneds` (
  `b_id` int(11) NOT NULL AUTO_INCREMENT,
  `b_steam` varchar(100) NOT NULL,
  `b_license` varchar(255) DEFAULT NULL,
  `b_discord` varchar(100) DEFAULT NULL,
  `b_reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `b_banned` varchar(100) NOT NULL,
  `b_unban` varchar(100) NOT NULL,
  `b_permanent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`b_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela baseexclusivav2.banneds: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.bills
CREATE TABLE IF NOT EXISTS `bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longtext DEFAULT NULL,
  `playername` longtext DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `issuer` longtext DEFAULT NULL,
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.bills: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.birds
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

-- Copiando dados para a tabela baseexclusivav2.birds: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.boats
CREATE TABLE IF NOT EXISTS `boats` (
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.boats: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.bounty
CREATE TABLE IF NOT EXISTS `bounty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT '',
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `info` longtext DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.bounty: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.bountyboard
CREATE TABLE IF NOT EXISTS `bountyboard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT '',
  `bounty` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.bountyboard: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.bulgar_madamnazar_market
CREATE TABLE IF NOT EXISTS `bulgar_madamnazar_market` (
  `charid` int(11) DEFAULT NULL,
  `identifier` varchar(100) NOT NULL,
  `bulgar_madamnazar_market` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela baseexclusivav2.bulgar_madamnazar_market: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.camping
CREATE TABLE IF NOT EXISTS `camping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `center` longtext DEFAULT '{}',
  `identifier` varchar(255) NOT NULL DEFAULT '0',
  `charid` varchar(255) NOT NULL DEFAULT '0',
  `shared` longtext DEFAULT '{}',
  `money` longtext DEFAULT '0',
  `storage` longtext DEFAULT '{}',
  `storage_w` longtext DEFAULT '{}',
  `camp_prop` longtext DEFAULT '{}',
  `camp_fire` longtext DEFAULT '{}',
  `damage` int(255) DEFAULT 100,
  `damageTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.camping: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.cartaz
CREATE TABLE IF NOT EXISTS `cartaz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `poster_link` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT '',
  `charidentifier` varchar(255) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.cartaz: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.characters
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
  `pending_payment` int(11) DEFAULT 0,
  `clan` int(11) DEFAULT 0,
  `moonshineenty` longtext DEFAULT '{}',
  `info` longtext DEFAULT '{}',
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

-- Copiando dados para a tabela baseexclusivav2.characters: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.character_inventories
CREATE TABLE IF NOT EXISTS `character_inventories` (
  `character_id` int(11) DEFAULT NULL,
  `inventory_type` varchar(100) NOT NULL DEFAULT 'default',
  `item_crafted_id` int(11) NOT NULL,
  `item_name` varchar(50) DEFAULT 'item',
  `amount` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  KEY `character_inventory_idx` (`character_id`,`inventory_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.character_inventories: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.clothes_bought
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.clothes_bought: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.communityservice
CREATE TABLE IF NOT EXISTS `communityservice` (
  `identifier` varchar(100) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '0',
  `characterid` varchar(5) NOT NULL DEFAULT '0',
  `communityservice` varchar(100) NOT NULL DEFAULT '0',
  `servicecount` varchar(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela baseexclusivav2.communityservice: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.companions
CREATE TABLE IF NOT EXISTS `companions` (
  `identifier` varchar(40) NOT NULL,
  `charidentifier` int(11) NOT NULL DEFAULT 0,
  `dog` varchar(255) NOT NULL,
  `skin` int(11) NOT NULL DEFAULT 0,
  `xp` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela baseexclusivav2.companions: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.container
CREATE TABLE IF NOT EXISTS `container` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT NULL,
  `items` longtext NOT NULL DEFAULT '{}',
  `invslots` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ID` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.container: ~85 rows (aproximadamente)
INSERT IGNORE INTO `container` (`id`, `name`, `items`, `invslots`) VALUES
	(1, 'police', '[]', 5000),
	(2, 'miner', '[]', 5000),
	(3, 'horsetrainer', '[]', 5000),
	(4, 'doctor', '[]', 5000),
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
	(85, 'aaaaa', '{}', 0);

-- Copiando estrutura para tabela baseexclusivav2.craft
CREATE TABLE IF NOT EXISTS `craft` (
  `identifier` varchar(500) NOT NULL,
  `charidentifier` varchar(50) NOT NULL,
  `profession` longtext NOT NULL DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.craft: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.diseases
CREATE TABLE IF NOT EXISTS `diseases` (
  `charid` int(11) NOT NULL,
  `diseases` longtext DEFAULT '{}',
  PRIMARY KEY (`charid`),
  CONSTRAINT `charid_fk` FOREIGN KEY (`charid`) REFERENCES `characters` (`charidentifier`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.diseases: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.doors
CREATE TABLE IF NOT EXISTS `doors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doorinfo` longtext NOT NULL DEFAULT '[]',
  `job` longtext NOT NULL DEFAULT '[]',
  `item` longtext NOT NULL,
  `break` int(11) DEFAULT 0,
  `breakin` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.doors: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.farming
CREATE TABLE IF NOT EXISTS `farming` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` varchar(500) NOT NULL,
  `charid` varchar(255) DEFAULT NULL,
  `plant_center` varchar(255) DEFAULT '{}',
  `herbs` longtext NOT NULL DEFAULT '{}',
  `scarecrow` longtext NOT NULL DEFAULT '{}',
  `protect` varchar(255) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.farming: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.farmingdata
CREATE TABLE IF NOT EXISTS `farmingdata` (
  `job` varchar(255) DEFAULT NULL,
  `blipSprite` varchar(255) DEFAULT NULL,
  `coords` longtext DEFAULT '{}',
  `count` int(11) DEFAULT NULL,
  `protect` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.farmingdata: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.farmingdatafree
CREATE TABLE IF NOT EXISTS `farmingdatafree` (
  `blipSprite` varchar(255) DEFAULT NULL,
  `coords` longtext DEFAULT '{}',
  `count` int(11) DEFAULT NULL,
  `protect` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.farmingdatafree: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.herbalists
CREATE TABLE IF NOT EXISTS `herbalists` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `location` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`identifier`) USING BTREE,
  UNIQUE KEY `identifier_charidentifier` (`identifier`,`charidentifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela baseexclusivav2.herbalists: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.horses
CREATE TABLE IF NOT EXISTS `horses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `components` longtext NOT NULL DEFAULT '{}',
  `exp` int(11) NOT NULL DEFAULT 0,
  `items` longtext NOT NULL DEFAULT '{}',
  `weapons` longtext NOT NULL DEFAULT '{}',
  `age` varchar(50) DEFAULT '0',
  `clothes` longtext DEFAULT NULL,
  `courage` int(11) NOT NULL DEFAULT 0,
  `cityPosition` int(11) NOT NULL DEFAULT 0,
  `spotPosition` int(11) NOT NULL DEFAULT 0,
  `horseCompany` int(11) NOT NULL DEFAULT 0,
  `interiorPosition` int(11) NOT NULL DEFAULT 0,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.horses: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.horsesstore
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.horsesstore: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.horsestrainers
CREATE TABLE IF NOT EXISTS `horsestrainers` (
  `steam` varchar(600) DEFAULT NULL,
  `charidentifier` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `name` varchar(600) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.horsestrainers: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.horses_breeding
CREATE TABLE IF NOT EXISTS `horses_breeding` (
  `identifier` varchar(255) NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.horses_breeding: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.horse_complements
CREATE TABLE IF NOT EXISTS `horse_complements` (
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `complements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela baseexclusivav2.horse_complements: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.hospital
CREATE TABLE IF NOT EXISTS `hospital` (
  `hospital` varchar(50) NOT NULL,
  PRIMARY KEY (`hospital`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.hospital: ~1 rows (aproximadamente)
INSERT IGNORE INTO `hospital` (`hospital`) VALUES
	('Saint Denis Hospital');

-- Copiando estrutura para tabela baseexclusivav2.hospital_notes
CREATE TABLE IF NOT EXISTS `hospital_notes` (
  `note_id` int(11) NOT NULL AUTO_INCREMENT,
  `hospital` varchar(50) NOT NULL DEFAULT '',
  `written_by` int(11) NOT NULL DEFAULT 0,
  `date` bigint(20) NOT NULL DEFAULT 0,
  `note` longtext NOT NULL,
  `patient` int(11) DEFAULT NULL,
  PRIMARY KEY (`note_id`) USING BTREE,
  KEY `hospital` (`hospital`),
  CONSTRAINT `hospital` FOREIGN KEY (`hospital`) REFERENCES `hospital` (`hospital`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.hospital_notes: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.housing
CREATE TABLE IF NOT EXISTS `housing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `charidentifier` int(11) NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `furniture` longtext DEFAULT NULL,
  `open` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela baseexclusivav2.housing: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.injured
CREATE TABLE IF NOT EXISTS `injured` (
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `charidentifier` int(11) DEFAULT NULL,
  `injured` varchar(50) DEFAULT '0',
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela baseexclusivav2.injured: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.items
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
) ENGINE=InnoDB AUTO_INCREMENT=215858 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela baseexclusivav2.items: ~1.775 rows (aproximadamente)
INSERT IGNORE INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `id`, `groupId`, `metadata`, `desc`, `weight`) VALUES
	('absinthe', 'Absinto', 100, 1, 'item_standard', 1, 1600, 1, '{}', '', 0.25),
	('accessories', 'Accessories', 20, 1, 'item_standard', 1, 17605, 1, '{}', 'nice item', 0.25),
	('acid', 'Ácido', 100, 1, 'item_standard', 1, 1, 1, '{}', '', 0.25),
	('Agarita', 'Agarita ', 100, 1, 'item_standard', 1, 2, 1, '{}', '', 0.25),
	('Agarita_Seed', 'Agarita Seed', 100, 1, 'item_standard', 1, 3, 1, '{}', '', 0.25),
	('aguapurificada', 'Agua Fervida', 100, 1, 'item_standard', 1, 215673, 1, '{}', 'nice item', 0.25),
	('Alaskan_Ginseng', 'Alaskan Ginseng', 100, 1, 'item_standard', 1, 4, 1, '{}', '', 0.25),
	('Alaskan_Ginseng_Seed', 'Alaskan Ginseng Seed', 100, 1, 'item_standard', 1, 5, 1, '{}', '', 0.25),
	('alcool', 'Álcool', 100, 1, 'item_standard', 1, 16805, 1, '{}', '', 0.25),
	('alcool_industrial', 'alcool industrial', 100, 1, 'item_standard', 1, 16804, 1, '{}', '', 0.25),
	('aldeia01', 'Aldeia 01', 100, 1, 'item_standard', 1, 215813, 1, '{}', 'nice item', 0.25),
	('algodao', 'Algodão', 100, 1, 'item_standard', 1, 215814, 1, '{}', 'nice item', 0.25),
	('algodao_Seed', 'Semente de Algodão', 100, 1, 'item_standard', 1, 215800, 1, '{}', 'nice item', 0.25),
	('aligatormeat', 'carne de jacaré', 100, 1, 'item_standard', 1, 568, 1, '{}', '', 0.25),
	('aligators', 'pele de jacaré', 100, 1, 'item_standard', 1, 544, 1, '{}', '', 0.25),
	('aligatorto', 'dente de jacaré', 100, 1, 'item_standard', 1, 543, 1, '{}', '', 0.25),
	('American_Ginseng', 'Ginseng Americano', 100, 1, 'item_standard', 1, 7, 1, '{}', '', 0.25),
	('American_Ginseng_Seed', 'Semente de Ginseng Americano', 100, 1, 'item_standard', 1, 8, 1, '{}', '', 0.25),
	('amidomilho', 'Amido de Milho', 100, 1, 'item_standard', 1, 170503, 1, '{}', 'nice item', 0.25),
	('ammoarrmownormal', 'flecha  Normal', 100, 1, 'item_standard', 1, 1238, 1, '{}', '', 0.25),
	('ammoarrowdynamite', 'flecha Dynamite', 100, 1, 'item_standard', 1, 10, 1, '{}', '', 0.25),
	('ammoarrowfire', 'flecha Fire', 100, 1, 'item_standard', 1, 11, 1, '{}', '', 0.25),
	('ammoarrowimproved', 'flecha Improved', 100, 1, 'item_standard', 1, 12, 1, '{}', '', 0.25),
	('ammoarrownormal', 'flexa normal', 100, 1, 'item_standard', 1, 16929, 1, '{}', '', 0.25),
	('ammoarrowpoison', 'flecha Poison', 100, 1, 'item_standard', 1, 13, 1, '{}', '', 0.25),
	('ammoarrowsmallgame', 'flecha Small Game', 100, 1, 'item_standard', 1, 14, 1, '{}', '', 0.25),
	('ammobolahawk', 'Bola Ammo Hawk', 100, 1, 'item_standard', 1, 15, 1, '{}', '', 0.25),
	('ammobolainterwired', 'Bola Ammo Interwired', 100, 1, 'item_standard', 1, 16, 1, '{}', '', 0.25),
	('ammobolaironspiked', 'Bola Ammo Ironspiked', 100, 1, 'item_standard', 1, 17, 1, '{}', '', 0.25),
	('ammobolla', 'Munição Bolla ', 100, 1, 'item_standard', 1, 18, 1, '{}', '', 0.25),
	('ammodynamite', 'munição de dinamite', 100, 1, 'item_standard', 1, 19, 1, '{}', '', 0.25),
	('ammoelephant', 'Elefante Rifle Munição', 100, 1, 'item_standard', 1, 20, 1, '{}', '', 0.25),
	('ammoknives', 'munição de facas', 100, 1, 'item_standard', 1, 21, 1, '{}', '', 0.25),
	('ammomolotov', 'munição molotov', 100, 1, 'item_standard', 1, 22, 1, '{}', '', 0.25),
	('ammopistolexplosive', 'Munição de Pistola Explosiva', 100, 1, 'item_standard', 1, 23, 1, '{}', '', 0.25),
	('ammopistolexpress', 'Munição de Pistola Expressa', 100, 1, 'item_standard', 1, 24, 1, '{}', '', 0.25),
	('ammopistolnormal', 'Arma Munição Normal', 100, 1, 'item_standard', 1, 25, 1, '{}', '', 0.25),
	('ammopistolsplitpoint', 'Ponto de divisão de munição de pistola', 100, 1, 'item_standard', 1, 26, 1, '{}', '', 0.25),
	('ammopistolvelocity', 'Velocidade de Munição de Pistola', 100, 1, 'item_standard', 1, 27, 1, '{}', '', 0.25),
	('ammopoisonbottle', 'Munição de garrafa de veneno', 100, 1, 'item_standard', 1, 28, 1, '{}', '', 0.25),
	('ammorepeaterexplosive', 'Repetidor Munição Explosiva', 100, 1, 'item_standard', 1, 29, 1, '{}', '', 0.25),
	('ammorepeaterexpress', 'Repetidor Ammo Express', 100, 1, 'item_standard', 1, 30, 1, '{}', '', 0.25),
	('ammorepeaternormal', 'Repetidor Munição Normal', 100, 1, 'item_standard', 1, 31, 1, '{}', '', 0.25),
	('ammorepeatersplitpoint', 'Ponto de divisão de munição do repetidor', 100, 1, 'item_standard', 1, 32, 1, '{}', '', 0.25),
	('ammorepeatervelocity', 'Velocidade da munição do repetidor', 100, 1, 'item_standard', 1, 33, 1, '{}', '', 0.25),
	('ammorevolverexplosive', 'Revolver Munição Explosiva', 100, 1, 'item_standard', 1, 34, 1, '{}', '', 0.25),
	('ammorevolverexpress', 'Revolver Ammo Express', 100, 1, 'item_standard', 1, 35, 1, '{}', '', 0.25),
	('ammorevolvernormal', 'Munição de revólver normal', 100, 1, 'item_standard', 1, 36, 1, '{}', '', 0.25),
	('ammorevolversplitpoint', 'Ponto de divisão de munição de revólver', 100, 1, 'item_standard', 1, 37, 1, '{}', '', 0.25),
	('ammorevolvervelocity', 'Velocidade da munição do revólver', 100, 1, 'item_standard', 1, 38, 1, '{}', '', 0.25),
	('ammorifleexplosive', 'Munição de Rifle Explosiva', 100, 1, 'item_standard', 1, 39, 1, '{}', '', 0.25),
	('ammorifleexpress', 'Munição de Rifle Express', 100, 1, 'item_standard', 1, 40, 1, '{}', '', 0.25),
	('ammoriflenormal', 'Munição de Rifle Normal', 100, 1, 'item_standard', 1, 41, 1, '{}', '', 0.25),
	('ammoriflesplitpoint', 'Ponto de divisão de munição de rifle', 100, 1, 'item_standard', 1, 42, 1, '{}', '', 0.25),
	('ammoriflevelocity', 'Velocidade da munição do rifle', 100, 1, 'item_standard', 1, 43, 1, '{}', '', 0.25),
	('ammoshotgunexplosive', 'Munição de Espingarda Explosiva', 100, 1, 'item_standard', 1, 44, 1, '{}', '', 0.25),
	('ammoshotgunincendiary', 'Munição de Espingarda Incendiária', 100, 1, 'item_standard', 1, 45, 1, '{}', '', 0.25),
	('ammoshotgunnormal', 'Munição de Espingarda Normal', 100, 1, 'item_standard', 1, 46, 1, '{}', '', 0.25),
	('ammoshotgunslug', 'Bala de munição de espingarda', 100, 1, 'item_standard', 1, 47, 1, '{}', '', 0.25),
	('ammothrowingknives', 'test', 100, 1, 'item_standard', 1, 17342, 1, '{}', 'nice item', 0.25),
	('ammotomahawk', 'Munição Tomahawk', 100, 1, 'item_standard', 1, 48, 1, '{}', '', 0.25),
	('ammovarmint', 'Munição Varmint', 100, 1, 'item_standard', 1, 49, 1, '{}', '', 0.25),
	('ammovarminttranq', 'Munição Tranquilizante Varmint', 100, 1, 'item_standard', 1, 50, 1, '{}', '', 0.25),
	('ammovoldynamite', 'Munição Volátil de Dinamite', 100, 1, 'item_standard', 1, 51, 1, '{}', '', 0.25),
	('ammovolmolotov', 'Munição Molotov Volátil', 100, 1, 'item_standard', 1, 52, 1, '{}', '', 0.25),
	('ammo_arrow', 'flecha', 100, 1, 'item_standard', 1, 16816, 1, '{}', '', 0.25),
	('ammo_arrow_fire', 'flexa de fogo', 100, 1, 'item_standard', 1, 17101, 1, '{}', '', 0.25),
	('AMMO_SHOTGUN', 'munição normal de espingarda', 100, 1, 'item_standard', 1, 17220, 1, '{}', '', 0.25),
	('AMMO_THROWING_KNIVES', 'muni', 100, 1, 'item_standard', 1, 17341, 1, '{}', 'nice item', 0.25),
	('animal_crab', 'caranguejo', 100, 1, 'item_standard', 1, 17195, 1, '{}', '', 0.25),
	('animal_crawfish', 'Lagostin', 100, 1, 'item_standard', 1, 215812, 1, '{}', 'nice item', 0.25),
	('antipoison', 'Anti-coral', 100, 1, 'item_standard', 1, 53, 1, '{}', '', 0.25),
	('antipoison2', 'Veneno anti-cobra', 100, 1, 'item_standard', 1, 617, 1, '{}', '', 0.25),
	('aoemagic', 'Poção quebra ossos 2', 100, 1, 'item_standard', 1, 1202, 1, '{}', 'nice item', 0.25),
	('apiary_bee_gk', 'abelhas', 10, 1, 'item_standard', 1, 17039, 1, '{}', '', 0.25),
	('apiary_honeycomb_gk', 'Favo de mel', 100, 1, 'item_standard', 1, 17040, 1, '{}', '', 0.25),
	('apple', 'Maçã', 30, 1, 'item_standard', 1, 54, 1, '{}', '', 0.25),
	('Apple Tree', 'arvore de maça', 100, 1, 'item_standard', 1, 16882, 1, '{}', '', 0.25),
	('applebarrel', 'barril de maçã', 100, 1, 'item_standard', 1, 762, 1, '{}', '', 0.25),
	('applebasket', 'Cesta de Maçã', 100, 1, 'item_standard', 1, 763, 1, '{}', '', 0.25),
	('appleCrumbMash', 'Purê de Minty Berry', 100, 1, 'item_standard', 1, 55, 1, '{}', '', 0.25),
	('appleCrumbMoonshine', 'Minty Berry Moonshine', 100, 1, 'item_standard', 1, 56, 1, '{}', '', 0.25),
	('apple_barrel', 'barril de maçã', 100, 1, 'item_standard', 1, 634, 1, '{}', '', 0.25),
	('apple_basket', 'Cesta de Maçã', 100, 1, 'item_standard', 1, 635, 1, '{}', '', 0.25),
	('Apple_Seed', 'semente de maçã', 100, 1, 'item_standard', 1, 727, 1, '{}', '', 0.25),
	('archivesbook', 'aquivo policial', 100, 1, 'item_standard', 1, 17107, 1, '{}', '', 0.25),
	('ardu', 'Revolver Ação Dupla', 10, 1, 'item_standard', 1, 1016, 1, '{}', '010', 0.25),
	('areaheal', 'Poção da cura ', 100, 1, 'item_standard', 1, 1203, 1, '{}', 'nice item', 0.25),
	('arm1', 'Revolver Vaqueiro', 5, 1, 'item_standard', 1, 1022, 1, '{}', 'nice item', 0.25),
	('arm2', 'Revolver Ação Dupla', 5, 1, 'item_standard', 1, 1023, 1, '{}', 'nice item', 0.25),
	('arm3', 'Revolver Lemat', 5, 1, 'item_standard', 1, 1024, 1, '{}', 'nice item', 0.25),
	('arm4', 'Repetidora Winchester', 5, 1, 'item_standard', 1, 1025, 1, '{}', 'nice item', 0.25),
	('arm5', 'Rifle De Ferrolho', 5, 1, 'item_standard', 1, 1026, 1, '{}', 'nice item', 0.25),
	('arm6', 'Escopeta Cano Duplo', 5, 1, 'item_standard', 1, 1027, 1, '{}', 'nice item', 0.25),
	('armadilloc', 'garras de tatu', 100, 1, 'item_standard', 1, 449, 1, '{}', '', 0.25),
	('armadillos', 'pele de tatu', 100, 1, 'item_standard', 1, 448, 1, '{}', '', 0.25),
	('armduplo', 'Escopeta Cano Duplo', 10, 1, 'item_standard', 1, 1013, 1, '{}', '007', 0.25),
	('armfe', 'Rifle de Ferrolho', 10, 1, 'item_standard', 1, 1012, 1, '{}', '006', 0.25),
	('armor', 'Armor', 20, 1, 'item_standard', 1, 17612, 1, '{}', 'nice item', 0.25),
	('arrowhead1', 'Arrowhead 1', 100, 1, 'item_standard', 1, 17510, 1, '{}', 'nice item', 0.25),
	('arrowhead10', 'Crude Arrowhead', 100, 1, 'item_standard', 1, 17519, 1, '{}', 'nice item', 0.25),
	('arrowhead11', 'Chipped Arrowhead', 100, 1, 'item_standard', 1, 17520, 1, '{}', 'nice item', 0.25),
	('arrowhead12', 'Bone Arrowhead', 100, 1, 'item_standard', 1, 17521, 1, '{}', 'nice item', 0.25),
	('arrowhead13', 'Agate Arrowhead', 100, 1, 'item_standard', 1, 17522, 1, '{}', 'nice item', 0.25),
	('arrowhead2', 'Arrowhead 2', 100, 1, 'item_standard', 1, 17511, 1, '{}', 'nice item', 0.25),
	('arrowhead3', 'Arrowhead 3', 100, 1, 'item_standard', 1, 17512, 1, '{}', 'nice item', 0.25),
	('arrowhead4', 'Rough Arrowhead', 100, 1, 'item_standard', 1, 17513, 1, '{}', 'nice item', 0.25),
	('arrowhead5', 'Raw Arrowhead', 100, 1, 'item_standard', 1, 17514, 1, '{}', 'nice item', 0.25),
	('arrowhead6', 'Quartz Arrowhead', 100, 1, 'item_standard', 1, 17515, 1, '{}', 'nice item', 0.25),
	('arrowhead7', 'Obsidian Arrowhead', 100, 1, 'item_standard', 1, 17516, 1, '{}', 'nice item', 0.25),
	('arrowhead8', 'Granite Arrowhead', 100, 1, 'item_standard', 1, 17517, 1, '{}', 'nice item', 0.25),
	('arrowhead9', 'Feldspar Arrowhead', 100, 1, 'item_standard', 1, 17518, 1, '{}', 'nice item', 0.25),
	('arroz', 'arroz', 100, 1, 'item_standard', 1, 16793, 1, '{}', '', 0.25),
	('artichokeseed', 'Artichoke seed', 50, 1, 'item_standard', 1, 17688, 1, '{}', 'an item', 0.25),
	('arva', 'Revolver Vaqueiro', 10, 1, 'item_standard', 1, 1008, 1, '{}', '002', 0.25),
	('asnakes', 'Copperhead pele de cobra', 100, 1, 'item_standard', 1, 487, 1, '{}', '', 0.25),
	('azeite', 'azeite', 100, 1, 'item_standard', 1, 17146, 1, '{}', '', 0.25),
	('azeitona', 'azeitona', 100, 1, 'item_standard', 1, 17147, 1, '{}', '', 0.25),
	('a_c_fishbluegil_01_ms', 'Bluegill médio', 100, 1, 'item_standard', 1, 57, 1, '{}', '', 0.25),
	('a_c_fishbluegil_01_sm', 'Bluegill pequeno', 100, 1, 'item_standard', 1, 58, 1, '{}', '', 0.25),
	('a_c_fishbullheadcat_01_ms', 'Bullhead Médio', 100, 1, 'item_standard', 1, 59, 1, '{}', '', 0.25),
	('a_c_fishbullheadcat_01_sm', 'Bullhead pequeno', 100, 1, 'item_standard', 1, 60, 1, '{}', '', 0.25),
	('a_c_fishchainpickerel_01_ms', 'Picanha Média', 100, 1, 'item_standard', 1, 61, 1, '{}', '', 0.25),
	('a_c_fishchainpickerel_01_sm', 'Pickerel pequeno', 100, 1, 'item_standard', 1, 62, 1, '{}', '', 0.25),
	('a_c_fishchannelcatfish_01_lg', 'Peixe-gato do canal (grande)', 100, 1, 'item_standard', 1, 16761, 1, '{}', '', 0.25),
	('a_c_fishchannelcatfish_01_xl', 'Bagre do Canal (Extra Grande)', 100, 1, 'item_standard', 1, 16762, 1, '{}', '', 0.25),
	('a_c_fishlakesturgeon_01_lg', 'Lago Sturgeon (Grande)', 100, 1, 'item_standard', 1, 16763, 1, '{}', '', 0.25),
	('a_c_fishlargemouthbass_01_lg', 'Baixo de boca grande (grande)', 100, 1, 'item_standard', 1, 16764, 1, '{}', '', 0.25),
	('a_c_fishlargemouthbass_01_ms', 'Achigã', 100, 1, 'item_standard', 1, 63, 1, '{}', '', 0.25),
	('a_c_fishlongnosegar_01_lg', 'Gar de Nariz Longo (Grande)', 100, 1, 'item_standard', 1, 16765, 1, '{}', '', 0.25),
	('a_c_fishmuskie_01_lg', 'Muskie (Grande)', 100, 1, 'item_standard', 1, 16766, 1, '{}', '', 0.25),
	('a_c_fishnorthernpike_01_lg', 'Pique do Norte (Grande)', 100, 1, 'item_standard', 1, 16767, 1, '{}', '', 0.25),
	('a_c_fishperch_01_ms', 'poleiro médio', 100, 1, 'item_standard', 1, 64, 1, '{}', '', 0.25),
	('a_c_fishperch_01_sm', 'poleiro pequeno', 100, 1, 'item_standard', 1, 65, 1, '{}', '', 0.25),
	('a_c_fishrainbowtrout_01_lg', 'Truta arco-íris (grande)', 100, 1, 'item_standard', 1, 16768, 1, '{}', '', 0.25),
	('a_c_fishrainbowtrout_01_ms', 'Truta arco-íris', 100, 1, 'item_standard', 1, 66, 1, '{}', '', 0.25),
	('a_c_fishredfinpickerel_01_ms', 'Pickerel Redfin médio', 100, 1, 'item_standard', 1, 67, 1, '{}', '', 0.25),
	('a_c_fishredfinpickerel_01_sm', 'Small Redfin Pickerel', 100, 1, 'item_standard', 1, 68, 1, '{}', '', 0.25),
	('a_c_fishrockbass_01_ms', 'Rock baixo médio', 100, 1, 'item_standard', 1, 69, 1, '{}', '', 0.25),
	('a_c_fishrockbass_01_sm', 'baixo baixo rock', 100, 1, 'item_standard', 1, 70, 1, '{}', '', 0.25),
	('a_c_fishsalmonsockeye_01_lg', 'Sockeye Salmão (Grande)', 100, 1, 'item_standard', 1, 16769, 1, '{}', '', 0.25),
	('a_c_fishsalmonsockeye_01_ml', 'Salmão sockeye (médio-grande)', 100, 1, 'item_standard', 1, 16770, 1, '{}', '', 0.25),
	('a_c_fishsalmonsockeye_01_ms', 'Salmão Sockeye', 100, 1, 'item_standard', 1, 71, 1, '{}', '', 0.25),
	('a_c_fishsmallmouthbass_01_lg', 'Baixo de boca pequena (grande)', 100, 1, 'item_standard', 1, 16771, 1, '{}', '', 0.25),
	('a_c_fishsmallmouthbass_01_ms', 'baixo smallmouth', 100, 1, 'item_standard', 1, 72, 1, '{}', '', 0.25),
	('backpack1', 'Mochila 100kg', 100, 1, 'item_standard', 1, 98664, 1, '{}', 'mochila 100kg', 0.25),
	('backpack2', 'Mochila v2', 100, 1, 'item_standard', 1, 98665, 1, '{}', 'mochila 100kg', 0.25),
	('backpack_10', 'mochila +10', 100, 1, 'item_standard', 1, 17250, 1, '{}', '', 0.25),
	('backpack_15', 'Backpack 15', 10, 1, 'item_standard', 1, 17345, 1, '{}', 'nice item', 0.25),
	('backpack_20', 'Backpack 20', 10, 1, 'item_standard', 1, 17346, 1, '{}', 'nice item', 0.25),
	('backpack_5', 'mochila +5', 100, 1, 'item_standard', 1, 17249, 1, '{}', '', 0.25),
	('bacon', 'Bacon', 100, 1, 'item_standard', 1, 1601, 1, '{}', '', 0.25),
	('badge', 'distintivo', 1, 1, 'item_standard', 1, 17106, 1, '{}', '', 0.25),
	('badgers', 'pele de texugo', 100, 1, 'item_standard', 1, 491, 1, '{}', '', 0.25),
	('bagofcoal', 'Carvão', 100, 1, 'item_standard', 1, 16930, 1, '{}', '', 0.25),
	('bait', 'Isca', 100, 1, 'item_standard', 1, 73, 1, '{}', '', 0.25),
	('banana', 'Banana', 100, 1, 'item_standard', 1, 74, 1, '{}', '', 0.25),
	('banana_seed', 'semente de banana', 100, 1, 'item_standard', 1, 16947, 1, '{}', '', 0.25),
	('bandage', 'Curativo', 100, 1, 'item_standard', 1, 75, 1, '{}', '', 0.25),
	('bandage_clean', 'Bandage Clean', 10, 1, 'item_standard', 1, 17278, 1, '{}', 'A clean bandage for medical use.', 0.25),
	('bandage_dirty', 'Bandage Dirty', 10, 1, 'item_standard', 1, 17279, 1, '{}', 'A dirty bandage, not ideal for treatment.', 0.25),
	('Barley', 'Cevada', 100, 1, 'item_standard', 1, 1673, 1, '{}', '', 0.25),
	('Barley_Seed', 'semente de cevada', 100, 1, 'item_standard', 1, 1674, 1, '{}', '', 0.25),
	('barra_de_prata', 'barra de prata', 100, 1, 'item_standard', 1, 16921, 1, '{}', '', 0.25),
	('barrel', 'Barril', 100, 1, 'item_standard', 1, 800, 1, '{}', '', 0.25),
	('barrier', 'barricada', 100, 1, 'item_standard', 1, 16978, 1, '{}', '', 0.25),
	('barriloil', 'Barril de Oleo', 10, 1, 'item_standard', 1, 170501, 1, '{}', 'nice item', 0.25),
	('bat_c', 'Bat', 100, 1, 'item_standard', 1, 420, 1, '{}', '', 0.25),
	('Bay_Bolete', 'Bay Bolete', 100, 1, 'item_standard', 1, 76, 1, '{}', '', 0.25),
	('Bay_Bolete_Seed', 'Bay Bolete Seed', 100, 1, 'item_standard', 1, 77, 1, '{}', '', 0.25),
	('bbears', 'pele de urso preto', 100, 1, 'item_standard', 1, 452, 1, '{}', '', 0.25),
	('bbirdb', 'bico de cormorão', 100, 1, 'item_standard', 1, 528, 1, '{}', '', 0.25),
	('bbirdf', 'pena de cormorão', 100, 1, 'item_standard', 1, 527, 1, '{}', '', 0.25),
	('bcandle', 'garrafa de vela', 100, 1, 'item_standard', 1, 663, 1, '{}', '', 0.25),
	('bearbench', 'banco de urso', 100, 1, 'item_standard', 1, 773, 1, '{}', '', 0.25),
	('bearc', 'garras de urso', 100, 1, 'item_standard', 1, 450, 1, '{}', '', 0.25),
	('beart', 'dente de urso', 100, 1, 'item_standard', 1, 451, 1, '{}', '', 0.25),
	('beartrap', 'Armadilha para urso', 1, 1, 'item_standard', 1, 1602, 1, '{}', '', 0.25),
	('bear_bench', 'banco de urso', 100, 1, 'item_standard', 1, 645, 1, '{}', '', 0.25),
	('beavertail', 'cauda de castor', 100, 1, 'item_standard', 1, 542, 1, '{}', '', 0.25),
	('beawers', 'pele de castor', 100, 1, 'item_standard', 1, 541, 1, '{}', '', 0.25),
	('bedroll', 'Saco de Dormir', 100, 1, 'item_standard', 1, 215664, 1, '{}', 'nice item', 0.25),
	('beef', 'Carne bovina', 100, 1, 'item_standard', 1, 567, 1, '{}', '', 0.25),
	('beefjerky', 'Carne seca', 100, 1, 'item_standard', 1, 78, 1, '{}', '', 0.25),
	('beer', 'Cerveja', 20, 1, 'item_standard', 1, 79, 1, '{}', '', 0.25),
	('beerbarrel', 'barril ', 20, 1, 'item_standard', 1, 17260, 1, '{}', 'nice item', 0.25),
	('beerbox', 'caixa de cerveja', 100, 1, 'item_standard', 1, 586, 1, '{}', '', 0.25),
	('bee_house_gk_1', 'Caixa de Abelha 1', 100, 1, 'item_standard', 1, 17042, 1, '{}', '', 0.25),
	('bee_house_gk_2', 'Caixa de Abelha 2', 100, 1, 'item_standard', 1, 17043, 1, '{}', '', 0.25),
	('bee_house_gk_3', 'Caixa de Abelha 3', 100, 1, 'item_standard', 1, 17044, 1, '{}', '', 0.25),
	('bee_house_gk_4', 'Caixa de Abelha 4', 100, 1, 'item_standard', 1, 17045, 1, '{}', '', 0.25),
	('bee_house_gk_5', 'Caixa de Abelha 5', 100, 1, 'item_standard', 1, 170464, 1, '{}', '', 0.25),
	('bee_house_gk_6', 'Caixa de Abelha 6', 100, 1, 'item_standard', 1, 17046, 1, '{}', '', 0.25),
	('beggarhat', 'Mendigo', 100, 1, 'item_standard', 1, 215810, 1, '{}', 'nice item', 0.25),
	('belts', 'Belt', 20, 1, 'item_standard', 1, 17608, 1, '{}', 'nice item', 0.25),
	('belt_buckles', 'Buckle', 20, 1, 'item_standard', 1, 17606, 1, '{}', 'nice item', 0.25),
	('Bicabornato', 'Bicabornato de Sodio', 100, 1, 'item_standard', 1, 215625, 1, '{}', 'nice item', 0.25),
	('bifedeveado', 'Bife de Veado', 100, 1, 'item_standard', 1, 170473, 1, '{}', 'nice item', 0.25),
	('bigchest', 'baú grande', 100, 1, 'item_standard', 1, 658, 1, '{}', '', 0.25),
	('biggame', 'carne de caça grossa', 100, 1, 'item_standard', 1, 565, 1, '{}', '', 0.25),
	('biggamemeat', 'Big Game Meat', 30, 1, 'item_standard', 1, 17566, 1, '{}', 'nice item', 0.25),
	('biggamesteak', 'prato de carne de caça grande', 100, 1, 'item_standard', 1, 17172, 1, '{}', '', 0.25),
	('big_firecracker', 'foguete', 100, 1, 'item_standard', 1, 16897, 1, '{}', '', 0.25),
	('big_fireworks', 'fogos', 100, 1, 'item_standard', 1, 16989, 1, '{}', '', 0.25),
	('Big_Leather', 'Couro grande ', 100, 1, 'item_standard', 1, 80, 1, '{}', '', 0.25),
	('bird', 'pássaro', 100, 1, 'item_standard', 1, 569, 1, '{}', '', 0.25),
	('birdalert', 'pombo alerta ', 20, 1, 'item_standard', 1, 17127, 1, '{}', '', 0.25),
	('birdmeat', 'Bird meat', 30, 1, 'item_standard', 1, 17559, 1, '{}', 'nice item', 0.25),
	('birdmeatcook', 'carne de ave assada ', 100, 1, 'item_standard', 1, 17173, 1, '{}', '', 0.25),
	('biscuitbox', 'caixa de biscoitos', 100, 1, 'item_standard', 1, 1603, 1, '{}', '', 0.25),
	('bisonhorn', 'bisonhorn', 100, 1, 'item_standard', 1, 461, 1, '{}', '', 0.25),
	('bisons', 'pele de bisão', 100, 1, 'item_standard', 1, 462, 1, '{}', '', 0.25),
	('Bitter_Weed', 'Erva Amarga', 100, 1, 'item_standard', 1, 81, 1, '{}', '', 0.25),
	('Bitter_Weed_Seed', 'Semente de Erva Amarga', 100, 1, 'item_standard', 1, 82, 1, '{}', '', 0.25),
	('bituca', 'Bituca de Cigarro', 100, 1, 'item_standard', 1, 215647, 1, '{}', 'nice item', 0.25),
	('blackberry', 'amora', 100, 1, 'item_standard', 1, 16885, 1, '{}', '', 0.25),
	('blackberryale', 'cerveja', 100, 1, 'item_standard', 1, 83, 1, '{}', '', 0.25),
	('blacktelegram', 'telegrama anonimo', 5, 1, 'item_standard', 1, 17155, 1, '{}', '', 0.25),
	('Black_Berry', 'Amora', 100, 1, 'item_standard', 1, 84, 1, '{}', '', 0.25),
	('Black_Berry_Seed', 'Semente de amora', 100, 1, 'item_standard', 1, 85, 1, '{}', '', 0.25),
	('Black_Currant', 'groselha preta', 100, 1, 'item_standard', 1, 86, 1, '{}', '', 0.25),
	('Black_Currant_Seed', 'Semente de Groselha Preta', 100, 1, 'item_standard', 1, 87, 1, '{}', '', 0.25),
	('blanketbox', 'Caixa de cobertor', 100, 1, 'item_standard', 1, 760, 1, '{}', '', 0.25),
	('blanket_box', 'Caixa de cobertor', 100, 1, 'item_standard', 1, 632, 1, '{}', '', 0.25),
	('blindfold', 'De olhos vendados', 100, 1, 'item_standard', 1, 16977, 1, '{}', '', 0.25),
	('bloodflower', 'Bloodflower', 50, 1, 'item_standard', 1, 17684, 1, '{}', 'an item', 0.25),
	('Blood_Flower', 'flor de sangue', 100, 1, 'item_standard', 1, 88, 1, '{}', '', 0.25),
	('Blood_Flower_Seed', 'flor de sangue Seed', 100, 1, 'item_standard', 1, 89, 1, '{}', '', 0.25),
	('Blueberries Shrub', 'Arbusto de Mirtilos', 100, 1, 'item_standard', 1, 16883, 1, '{}', '', 0.25),
	('blueberry', 'Mirtilo', 100, 1, 'item_standard', 1, 90, 1, '{}', '', 0.25),
	('bluejay_c', 'gaio azul', 100, 1, 'item_standard', 1, 421, 1, '{}', '', 0.25),
	('bmdresser', 'cômoda com espelho marrom', 100, 1, 'item_standard', 1, 652, 1, '{}', '', 0.25),
	('boarmusk', 'presa de javali', 100, 1, 'item_standard', 1, 456, 1, '{}', '', 0.25),
	('boars', 'pele de javali', 100, 1, 'item_standard', 1, 457, 1, '{}', '', 0.25),
	('boaskin', 'Pele de Boa Cobra', 100, 1, 'item_standard', 1, 486, 1, '{}', '', 0.25),
	('boat_ticket', 'Bilhete de Barco', 100, 1, 'item_standard', 1, 16926, 1, '{}', '', 0.25),
	('boifood', 'Ração de Vacas', 100, 1, 'item_standard', 1, 6342, 1, '{}', 'nice item', 0.25),
	('boiledegg', 'Ovo Cozido', 100, 1, 'item_standard', 1, 91, 1, '{}', '', 0.25),
	('bolado', 'Charuto  de Weed', 100, 1, 'item_standard', 1, 17164, 1, '{}', '', 0.25),
	('bolts', 'Parafusos', 100, 1, 'item_standard', 1, 1604, 1, '{}', '', 0.25),
	('bomb', 'bomba pegajosa', 100, 1, 'item_standard', 1, 16894, 1, '{}', '', 0.25),
	('bonesmagic', 'Poção quebra ossos', 100, 1, 'item_standard', 1, 215704, 1, '{}', 'nice item', 0.25),
	('bone_deer', 'Deer Bone', 50, 1, 'item_standard', 1, 17570, 1, '{}', 'nice item', 0.25),
	('bone_mice', 'Mice Bone', 50, 1, 'item_standard', 1, 17574, 1, '{}', 'nice item', 0.25),
	('bone_owl', 'Owl Bone', 50, 1, 'item_standard', 1, 17575, 1, '{}', 'nice item', 0.25),
	('bone_rabbit', 'Rabbit Bone', 50, 1, 'item_standard', 1, 17573, 1, '{}', 'nice item', 0.25),
	('bone_raccoon', 'Raccoon Bone', 50, 1, 'item_standard', 1, 17572, 1, '{}', 'nice item', 0.25),
	('bone_skunk', 'Skunk Bone', 50, 1, 'item_standard', 1, 17571, 1, '{}', 'nice item', 0.25),
	('boobyb', 'Bico de patas vermelhas', 100, 1, 'item_standard', 1, 501, 1, '{}', '', 0.25),
	('boobyf', 'Pena de atobá-de-pés-vermelhos', 100, 1, 'item_standard', 1, 500, 1, '{}', '', 0.25),
	('book', 'Livro', 100, 1, 'item_standard', 1, 92, 1, '{}', '', 0.25),
	('bookarm', 'Livro do Armeiro', 100, 1, 'item_standard', 1, 98680, 1, '{}', 'nice item', 0.25),
	('bookart', 'Livro do Artesanato', 100, 1, 'item_standard', 1, 98678, 1, '{}', 'nice item', 0.25),
	('bookestab', 'Livro do Estabulo', 100, 1, 'item_standard', 1, 98679, 1, '{}', 'nice item', 0.25),
	('bookferr', 'Livro da Ferraria', 100, 1, 'item_standard', 1, 98681, 1, '{}', 'nice item', 0.25),
	('bookileg', 'Livro Ilegal', 100, 1, 'item_standard', 1, 98721, 1, '{}', 'nice item', 0.25),
	('bookmedic', 'Livro Medico', 100, 1, 'item_standard', 1, 98716, 1, '{}', 'nice item', 0.25),
	('booksbw', 'Livro Saloon BW', 100, 1, 'item_standard', 1, 98713, 1, '{}', 'nice item', 0.25),
	('booksrh', 'Livro Saloon RH', 100, 1, 'item_standard', 1, 98676, 1, '{}', 'nice item', 0.25),
	('bookssd', 'Livro Saloon SD', 100, 1, 'item_standard', 1, 98714, 1, '{}', 'nice item', 0.25),
	('booksvh', 'Livro Saloon VH', 100, 1, 'item_standard', 1, 98715, 1, '{}', 'nice item', 0.25),
	('booksvl', 'Livro Saloon VL', 100, 1, 'item_standard', 1, 98712, 1, '{}', 'nice item', 0.25),
	('boots', 'Boots', 20, 1, 'item_standard', 1, 17609, 1, '{}', 'nice item', 0.25),
	('boot_accessories', 'Spurs', 20, 1, 'item_standard', 1, 17607, 1, '{}', 'nice item', 0.25),
	('bountylicns', 'Licença de Caçador de Recompensas', 100, 1, 'item_standard', 1, 93, 1, '{}', '', 0.25),
	('bouquet', 'Ramalhete', 100, 1, 'item_standard', 1, 342, 1, '{}', '', 0.25),
	('boxempty', 'caixa de munição vazia', 100, 1, 'item_standard', 1, 17202, 1, '{}', '', 0.25),
	('boxmister', 'Caixa Misteriosa', 100, 1, 'item_standard', 1, 98663, 1, '{}', 'nice item', 0.25),
	('bparrotb', 'bico de papagaio', 100, 1, 'item_standard', 1, 522, 1, '{}', '', 0.25),
	('bparrotf', 'pena de papagaio', 100, 1, 'item_standard', 1, 521, 1, '{}', '', 0.25),
	('bread', 'Pão', 100, 1, 'item_standard', 1, 170512, 1, '{}', 'nice item', 0.25),
	('breedpills', 'pilula da criação', 100, 1, 'item_standard', 1, 16903, 1, '{}', '', 0.25),
	('brokenpearlnecklace', 'colar de pérolas quebradas', 100, 1, 'item_standard', 1, 1605, 1, '{}', '', 0.25),
	('bronzeticket', 'bilhete', 100, 1, 'item_standard', 1, 16911, 1, '{}', '', 0.25),
	('btobaccoseed', 'Burnley Tobacco', 50, 1, 'item_standard', 1, 17696, 1, '{}', 'an item', 0.25),
	('buckantler', 'Buck Antlers', 100, 1, 'item_standard', 1, 459, 1, '{}', '', 0.25),
	('bucket', 'Bucket', 3, 1, 'item_standard', 1, 17322, 1, '{}', 'nice item', 0.25),
	('bucks', 'Pele de Buck', 100, 1, 'item_standard', 1, 460, 1, '{}', '', 0.25),
	('bullhorn', 'chifre de touro', 100, 1, 'item_standard', 1, 463, 1, '{}', '', 0.25),
	('bulls', 'pele de touro', 100, 1, 'item_standard', 1, 464, 1, '{}', '', 0.25),
	('Bulrush', 'Junco', 100, 1, 'item_standard', 1, 94, 1, '{}', '', 0.25),
	('bulrushseed', 'Bulrush seed', 50, 1, 'item_standard', 1, 17695, 1, '{}', 'an item', 0.25),
	('Bulrush_Seed', 'semente de junco', 100, 1, 'item_standard', 1, 95, 1, '{}', '', 0.25),
	('bunkbed', 'beliche', 100, 1, 'item_standard', 1, 665, 1, '{}', '', 0.25),
	('Burdock_Root', 'raiz de bardana', 100, 1, 'item_standard', 1, 96, 1, '{}', '', 0.25),
	('Burdock_Root_Seed', 'Semente de Raiz de Bardana', 100, 1, 'item_standard', 1, 97, 1, '{}', '', 0.25),
	('burialoil', 'Burial Perfume Oil', 20, 1, 'item_standard', 1, 17455, 1, '{}', 'nice item', 0.25),
	('burialwraps', 'Burial Wraps', 20, 1, 'item_standard', 1, 17456, 1, '{}', 'nice item', 0.25),
	('butchertable1', 'Mesa de açougueiro pequena', 100, 1, 'item_standard', 1, 583, 1, '{}', '', 0.25),
	('butchertable2', 'Mesa de Açougueiro Média', 100, 1, 'item_standard', 1, 582, 1, '{}', '', 0.25),
	('butchertable3', 'Mesa de açougueiro grande', 100, 1, 'item_standard', 1, 581, 1, '{}', '', 0.25),
	('bwdresser', 'cômoda de madeira marrom', 100, 1, 'item_standard', 1, 651, 1, '{}', '', 0.25),
	('C1', 'C1', 100, 1, 'item_standard', 1, 215715, 1, '{}', 'nice item', 0.25),
	('C2', 'C2', 100, 1, 'item_standard', 1, 215716, 1, '{}', 'nice item', 0.25),
	('Cabbage', 'Repolho', 100, 1, 'item_standard', 1, 215820, 1, '{}', 'nice item', 0.25),
	('Cabbage_Seed', 'Semente de Repolho', 100, 1, 'item_standard', 1, 215795, 1, '{}', 'nice item', 0.25),
	('cabomadeira', 'Cabo de Madeira', 100, 1, 'item_standard', 1, 170470, 1, '{}', 'nice item', 0.25),
	('cabrafood', 'Ração para Cabras', 100, 1, 'item_standard', 1, 98353, 1, '{}', 'nice item', 0.25),
	('cacau', 'cacau ', 100, 1, 'item_standard', 1, 17148, 1, '{}', '', 0.25),
	('cacau_Seed', 'semente de cacau', 100, 1, 'item_standard', 1, 17149, 1, '{}', '', 0.25),
	('caixaarma', 'Caixa de Arma', 50, 1, 'item_standard', 1, 20583, 1, '{}', 'Beschreibung', 0.25),
	('caixacavalo', 'Caixa de Cavalo', 50, 1, 'item_standard', 1, 7461, 1, '{}', 'Beschreibung', 0.25),
	('caixadollar', 'Caixa de Dollar', 50, 1, 'item_standard', 1, 74531, 1, '{}', 'Beschreibung', 0.25),
	('caixagold', 'Caixa Gold', 50, 1, 'item_standard', 1, 18521, 1, '{}', 'Beschreibung', 0.25),
	('caixavip', 'Caixa Vip', 50, 1, 'item_standard', 1, 1006, 1, '{}', '019', 0.25),
	('callbird', 'chamar passaro', 1, 1, 'item_standard', 1, 17677, 1, '{}', 'nice item', 0.25),
	('CalledBird', 'CHAMAR PASSARO 1 ', 1, 1, 'item_standard', 1, 17676, 1, '{}', 'nice item', 0.25),
	('calmante', 'tira stress', 20, 1, 'item_standard', 1, 17037, 1, '{}', '', 0.25),
	('camera', 'Camera', 100, 1, 'item_standard', 1, 346, 1, '{}', '', 0.25),
	('camomila', 'Camomila', 100, 1, 'item_standard', 1, 98682, 1, '{}', 'nice item', 0.25),
	('campfire', 'fogueira', 100, 1, 'item_standard', 1, 98, 1, '{}', '', 0.25),
	('Camp_Book', 'Livro de acampamento', 100, 1, 'item_standard', 1, 17471, 1, '{}', 'nice item', 0.25),
	('candlea', 'Vela', 100, 1, 'item_standard', 1, 661, 1, '{}', '', 0.25),
	('cane', 'Bengala', 100, 1, 'item_standard', 1, 344, 1, '{}', '', 0.25),
	('cannedevieux', 'Bengala Esquerda', 100, 1, 'item_standard', 1, 215828, 1, '{}', 'nice item', 0.25),
	('canteen', 'Canteen', 1, 1, 'item_standard', 1, 16723, 1, '{}', '', 0.25),
	('canteenempty', 'cantil vazio', 1, 1, 'item_standard', 1, 17222, 1, '{}', '', 0.25),
	('canteen_100', 'Canteen', 3, 1, 'item_standard', 1, 17317, 1, '{}', 'nice item', 0.25),
	('canteen_25', 'Canteen', 3, 1, 'item_standard', 1, 17320, 1, '{}', 'nice item', 0.25),
	('canteen_50', 'Canteen', 3, 1, 'item_standard', 1, 17319, 1, '{}', 'nice item', 0.25),
	('canteen_75', 'Canteen', 3, 1, 'item_standard', 1, 17318, 1, '{}', 'nice item', 0.25),
	('can_100', 'cantil 100%', 100, 1, 'item_standard', 1, 16914, 1, '{}', '', 0.25),
	('can_25', 'cantil 25%', 100, 1, 'item_standard', 1, 16917, 1, '{}', '', 0.25),
	('can_50', 'cantil 50%', 100, 1, 'item_standard', 1, 16916, 1, '{}', '', 0.25),
	('can_75', 'cantil 75%', 100, 1, 'item_standard', 1, 16915, 1, '{}', '', 0.25),
	('cardinal_c', 'pássaro cardeal', 100, 1, 'item_standard', 1, 422, 1, '{}', '', 0.25),
	('Cardinal_Flower', 'flor cardeal', 100, 1, 'item_standard', 1, 99, 1, '{}', '', 0.25),
	('Cardinal_Flower_Seed', 'semente de flor cardinal', 100, 1, 'item_standard', 1, 100, 1, '{}', '', 0.25),
	('carnebatata', 'Carne com Batatas', 100, 1, 'item_standard', 1, 170481, 1, '{}', 'nice item', 0.25),
	('carnegrelha', 'Carne Grelhada', 100, 1, 'item_standard', 1, 170482, 1, '{}', 'nice item', 0.25),
	('carriage_parts', 'kit reparo carroça', 100, 1, 'item_standard', 1, 16902, 1, '{}', '', 0.25),
	('carrots', 'Cenoura', 100, 1, 'item_standard', 1, 101, 1, '{}', '', 0.25),
	('Carrot_Seed', 'semente de cenoura ', 100, 1, 'item_standard', 1, 17139, 1, '{}', '', 0.25),
	('cavalofood', 'Ração de Cavalos', 100, 1, 'item_standard', 1, 2463, 1, '{}', 'nice item', 0.25),
	('cebola', 'cebola', 100, 1, 'item_standard', 1, 17259, 1, '{}', 'nice item', 0.25),
	('cebola_Seed', 'Semente de Cebola', 100, 1, 'item_standard', 1, 215808, 1, '{}', 'nice item', 0.25),
	('cedarwaxwing_c', 'cera de cedro', 100, 1, 'item_standard', 1, 423, 1, '{}', '', 0.25),
	('Chamomile', 'camomila', 100, 1, 'item_standard', 1, 215824, 1, '{}', 'nice item', 0.25),
	('Chamomile_Seed', 'Semente de Camomila', 100, 1, 'item_standard', 1, 215792, 1, '{}', 'nice item', 0.25),
	('Chanterelles', 'chanterelles', 100, 1, 'item_standard', 1, 102, 1, '{}', '', 0.25),
	('Chanterelles_Seed', 'semente de chanterelle', 100, 1, 'item_standard', 1, 103, 1, '{}', '', 0.25),
	('chaps', 'Chaps', 20, 1, 'item_standard', 1, 17610, 1, '{}', 'nice item', 0.25),
	('char', 'Caracteres', 100, 1, 'item_standard', 1, 104, 1, '{}', '', 0.25),
	('cheesecake', 'bolo de queijo', 100, 1, 'item_standard', 1, 1606, 1, '{}', '', 0.25),
	('chesta', 'chest 1', 20, 1, 'item_standard', 1, 17430, 1, '{}', 'nice item', 0.25),
	('chestb', 'chest 2', 20, 1, 'item_standard', 1, 17431, 1, '{}', 'nice item', 0.25),
	('chestc', 'Peito C', 100, 1, 'item_standard', 1, 578, 1, '{}', '', 0.25),
	('chest_shovel', 'Chest Shovel', 10, 1, 'item_standard', 1, 98711, 1, '{}', 'nice item', 0.25),
	('chewingtobacco', 'Mastigar tabaco', 100, 1, 'item_standard', 1, 105, 1, '{}', '', 0.25),
	('chewingtobacco2', 'Tobacco de Mascar', 100, 1, 'item_standard', 1, 215639, 1, '{}', 'You have 4 doses left', 0.25),
	('chewingtobacco3', 'Tobacco de Mascar', 100, 1, 'item_standard', 1, 215640, 1, '{}', 'You have 3 doses left', 0.25),
	('chewingtobacco4', 'Tobacco de Mascar', 100, 1, 'item_standard', 1, 215641, 1, '{}', 'You have 2 doses left', 0.25),
	('chewingtobacco5', 'Tobacco de Mascar', 100, 1, 'item_standard', 1, 215642, 1, '{}', 'You have 1 dose left', 0.25),
	('chickenf', 'pena de galinha', 100, 1, 'item_standard', 1, 525, 1, '{}', '', 0.25),
	('chickenheart', 'Coração de galinha', 100, 1, 'item_standard', 1, 526, 1, '{}', '', 0.25),
	('chipmunk_c', 'Esquilo', 100, 1, 'item_standard', 1, 419, 1, '{}', '', 0.25),
	('chococake', 'fatia de chocolate', 20, 1, 'item_standard', 1, 1607, 1, '{}', '', 0.25),
	('Choc_Daisy', 'Shock Daisy', 100, 1, 'item_standard', 1, 106, 1, '{}', '', 0.25),
	('Choc_Daisy_Seed', 'Choc Daisy Seed', 100, 1, 'item_standard', 1, 107, 1, '{}', '', 0.25),
	('cigar', 'Charuto', 20, 1, 'item_standard', 1, 108, 1, '{}', '', 0.25),
	('cigarcard1', 'Carteira de Cigarro 10uni', 100, 1, 'item_standard', 1, 215644, 1, '{}', 'nice item', 0.25),
	('cigarcard2', 'Carteira de Cigarro 5uni', 100, 1, 'item_standard', 1, 215645, 1, '{}', 'nice item', 0.25),
	('cigarcard3', 'Carteira de Cigarro Vazia', 100, 1, 'item_standard', 1, 215646, 1, '{}', 'nice item', 0.25),
	('cigaret', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215628, 1, '{}', 'New package', 0.25),
	('cigaret10', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215637, 1, '{}', 'You have 1 cigarette left', 0.25),
	('cigaret2', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215629, 1, '{}', 'You have 9 cigarettes left', 0.25),
	('cigaret3', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215630, 1, '{}', 'You have 8 cigarettes left', 0.25),
	('cigaret4', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215631, 1, '{}', 'You have 7 cigarettes left', 0.25),
	('cigaret5', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215632, 1, '{}', 'You have 6 cigarettes left', 0.25),
	('cigaret6', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215633, 1, '{}', 'You have 5 cigarettes left', 0.25),
	('cigaret7', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215634, 1, '{}', 'You have 4 cigarettes left', 0.25),
	('cigaret8', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215635, 1, '{}', 'You have 3 cigarettes left', 0.25),
	('cigaret9', 'Maço de cigarros', 100, 1, 'item_standard', 1, 215636, 1, '{}', 'You have 2 cigarettes left', 0.25),
	('cigarette', 'Cigarro', 20, 1, 'item_standard', 1, 109, 1, '{}', '', 0.25),
	('cigarettefilter', 'Filtro Cig', 100, 1, 'item_standard', 1, 110, 1, '{}', '', 0.25),
	('cigarety', 'carteira de cigarro vazia', 100, 1, 'item_standard', 1, 17197, 1, '{}', '', 0.25),
	('cigcard01', 'cigcard01', 1, 1, 'item_standard', 1, 17206, 1, '{}', '', 0.25),
	('cigcard02', 'cigcard02', 1, 1, 'item_standard', 1, 17207, 1, '{}', '', 0.25),
	('cigcard03', 'cigcard03', 1, 1, 'item_standard', 1, 17208, 1, '{}', '', 0.25),
	('cigcard04', 'cigcard04', 1, 1, 'item_standard', 1, 17209, 1, '{}', '', 0.25),
	('cigcard05', 'cigcard05', 1, 1, 'item_standard', 1, 17210, 1, '{}', '', 0.25),
	('cigcard06', 'cigcard06', 1, 1, 'item_standard', 1, 17211, 1, '{}', '', 0.25),
	('cigcard07', 'cigcard07', 1, 1, 'item_standard', 1, 17212, 1, '{}', '', 0.25),
	('cigcard08', 'cigcard08', 1, 1, 'item_standard', 1, 17213, 1, '{}', '', 0.25),
	('cigcard09', 'cigcard09', 1, 1, 'item_standard', 1, 17214, 1, '{}', '', 0.25),
	('cigcard10', 'cigcard10', 1, 1, 'item_standard', 1, 17215, 1, '{}', '', 0.25),
	('cigcard11', 'cigcard11', 1, 1, 'item_standard', 1, 17216, 1, '{}', '', 0.25),
	('cigcard12', 'cigcard12', 1, 1, 'item_standard', 1, 17217, 1, '{}', '', 0.25),
	('cinematicket', 'Ticket', 100, 1, 'item_standard', 1, 351, 1, '{}', '', 0.25),
	('clay', 'Argila', 100, 1, 'item_standard', 1, 111, 1, '{}', '', 0.25),
	('cleanser', 'Limpador', 100, 1, 'item_standard', 1, 340, 1, '{}', '', 0.25),
	('cleanshort', 'Pano', 100, 1, 'item_standard', 1, 1608, 1, '{}', '', 0.25),
	('cloaks', 'Cloak', 20, 1, 'item_standard', 1, 17625, 1, '{}', 'nice item', 0.25),
	('cloth', 'paninho', 100, 1, 'item_standard', 1, 215694, 1, '{}', 'nice item', 0.25),
	('clothbench', 'banco de pano', 100, 1, 'item_standard', 1, 776, 1, '{}', '', 0.25),
	('clothesline', 'Varal de roupas', 100, 1, 'item_standard', 1, 766, 1, '{}', '', 0.25),
	('clothes_line', 'Varal de roupas', 100, 1, 'item_standard', 1, 638, 1, '{}', '', 0.25),
	('clothingset', 'Kit Roupa 1', 20, 1, 'item_standard', 1, 17602, 1, '{}', 'nice item', 0.25),
	('clothingset2', 'Kit Roupa 2', 20, 1, 'item_standard', 1, 17603, 1, '{}', 'nice item', 0.25),
	('cloth_bench', 'banco de pano', 100, 1, 'item_standard', 1, 648, 1, '{}', '', 0.25),
	('coal', 'carvão', 100, 1, 'item_standard', 1, 112, 1, '{}', '', 0.25),
	('coats', 'Coat', 20, 1, 'item_standard', 1, 17627, 1, '{}', 'nice item', 0.25),
	('coats_closed', 'Closed Coat', 20, 1, 'item_standard', 1, 17615, 1, '{}', 'nice item', 0.25),
	('Coca', 'Coca', 100, 1, 'item_standard', 1, 215815, 1, '{}', 'nice item', 0.25),
	('cocaina', 'Cocaina', 100, 1, 'item_standard', 1, 16936, 1, '{}', '', 0.25),
	('cocaine', 'tonic de cocaina', 100, 1, 'item_standard', 1, 16923, 1, '{}', '', 0.25),
	('cocain_seed', 'semente de cocaina', 100, 1, 'item_standard', 1, 1677, 1, '{}', '', 0.25),
	('Coca_Seed', 'Semente de coca', 100, 1, 'item_standard', 1, 215791, 1, '{}', 'nice item', 0.25),
	('cockc', 'garras de galo', 100, 1, 'item_standard', 1, 499, 1, '{}', '', 0.25),
	('cockf', 'pena de galo', 100, 1, 'item_standard', 1, 498, 1, '{}', '', 0.25),
	('cocoa', 'Cocoa', 100, 1, 'item_standard', 1, 113, 1, '{}', '', 0.25),
	('cocoaseeds', 'Cocoa Seeds', 100, 1, 'item_standard', 1, 733, 1, '{}', '', 0.25),
	('coffe', 'cafe', 100, 1, 'item_standard', 1, 17177, 1, '{}', '', 0.25),
	('coffeebeans', 'grãos de café', 100, 1, 'item_standard', 1, 1678, 1, '{}', '', 0.25),
	('coffeefilter', 'Coffee Filter', 100, 1, 'item_standard', 1, 1610, 1, '{}', '', 0.25),
	('Coffee_Seed', 'semente de caffe', 100, 1, 'item_standard', 1, 1679, 1, '{}', '', 0.25),
	('coffindecor', 'decoração de caixão', 100, 1, 'item_standard', 1, 629, 1, '{}', '', 0.25),
	('cogomelo', 'Cogomelo Selvagem', 100, 1, 'item_standard', 1, 215850, 1, '{}', 'nice item', 0.25),
	('coin1', 'Coin 1800 Half Dime', 100, 1, 'item_standard', 1, 17493, 1, '{}', 'nice item', 0.25),
	('coin10', 'Coin 1792 Quarter', 100, 1, 'item_standard', 1, 17502, 1, '{}', 'nice item', 0.25),
	('coin11', 'Coin 1792 Nickel', 100, 1, 'item_standard', 1, 17503, 1, '{}', 'nice item', 0.25),
	('coin12', 'Coin 1792 Liberty', 100, 1, 'item_standard', 1, 17504, 1, '{}', 'nice item', 0.25),
	('coin13', 'Coin 1789 Penny', 100, 1, 'item_standard', 1, 17505, 1, '{}', 'nice item', 0.25),
	('coin14', 'Coin 1787 Cent', 100, 1, 'item_standard', 1, 17506, 1, '{}', 'nice item', 0.25),
	('coin15', 'Coin 1700', 100, 1, 'item_standard', 1, 17507, 1, '{}', 'nice item', 0.25),
	('coin16', 'Coin Loanshark', 100, 1, 'item_standard', 1, 17508, 1, '{}', 'nice item', 0.25),
	('coin17', 'Money Coin', 100, 1, 'item_standard', 1, 17509, 1, '{}', 'nice item', 0.25),
	('coin2', 'Coin 1800 Gold Quarter', 100, 1, 'item_standard', 1, 17494, 1, '{}', 'nice item', 0.25),
	('coin3', 'Coin 1800 Gold Dollar', 100, 1, 'item_standard', 1, 17495, 1, '{}', 'nice item', 0.25),
	('coin4', 'Coin 1800 Five Dollar', 100, 1, 'item_standard', 1, 17496, 1, '{}', 'nice item', 0.25),
	('coin5', 'Coin 1798 Silver Dollar', 100, 1, 'item_standard', 1, 17497, 1, '{}', 'nice item', 0.25),
	('coin6', 'Coin 1797 Gold Eagle', 100, 1, 'item_standard', 1, 17498, 1, '{}', 'nice item', 0.25),
	('coin7', 'Coin 1796 Half Penny', 100, 1, 'item_standard', 1, 17499, 1, '{}', 'nice item', 0.25),
	('coin8', 'Coin 1795 Half Eagle', 100, 1, 'item_standard', 1, 17500, 1, '{}', 'nice item', 0.25),
	('coin9', 'Coin 1794 Silver Dollar', 100, 1, 'item_standard', 1, 17501, 1, '{}', 'nice item', 0.25),
	('collector_fossil_bivalve', 'fóssil bivalve', 100, 1, 'item_standard', 1, 1611, 1, '{}', '', 0.25),
	('collector_fossil_brachiopod', 'Fóssil de Braquiópode', 100, 1, 'item_standard', 1, 1612, 1, '{}', '', 0.25),
	('collector_fossil_brow_horn', 'Fóssil de Chifre Frontal', 100, 1, 'item_standard', 1, 1613, 1, '{}', '', 0.25),
	('collector_fossil_cephalopod', 'Fóssil de cefalópode', 100, 1, 'item_standard', 1, 1614, 1, '{}', '', 0.25),
	('collector_fossil_coral', 'Fóssil de Coral Agatizado', 100, 1, 'item_standard', 1, 1615, 1, '{}', '', 0.25),
	('collector_fossil_neo', 'Fóssil Neospirífero', 100, 1, 'item_standard', 1, 1616, 1, '{}', '', 0.25),
	('collector_fossil_pet_wood', 'Fóssil Comum de Madeira Petrificada', 100, 1, 'item_standard', 1, 1617, 1, '{}', '', 0.25),
	('collector_fossil_pet_wood_rainbow', 'Fóssil de madeira petrificada arco-íris', 100, 1, 'item_standard', 1, 1618, 1, '{}', '', 0.25),
	('collector_fossil_pet_wood_yellow_cat', 'Fóssil de madeira petrificada de gato amarelo', 100, 1, 'item_standard', 1, 1619, 1, '{}', '', 0.25),
	('collector_fossil_sea_lily', 'Fóssil de Lírio do Mar', 100, 1, 'item_standard', 1, 1620, 1, '{}', '', 0.25),
	('collector_fossil_sea_scorpion', 'Fóssil de Escorpião Marinho', 100, 1, 'item_standard', 1, 1621, 1, '{}', '', 0.25),
	('collector_fossil_stone', 'Fóssil de Pedra Petoskey', 100, 1, 'item_standard', 1, 1622, 1, '{}', '', 0.25),
	('collector_fossil_tail_spike', 'Fóssil de Espiga de Cauda', 100, 1, 'item_standard', 1, 1623, 1, '{}', '', 0.25),
	('collector_fossil_toe_claw', 'Fóssil de garra de foice', 100, 1, 'item_standard', 1, 1624, 1, '{}', '', 0.25),
	('collector_fossil_tooth_mega', 'Fóssil de dente superior', 100, 1, 'item_standard', 1, 1625, 1, '{}', '', 0.25),
	('collector_fossil_tooth_serrated', 'Fóssil de Dente Serrado', 100, 1, 'item_standard', 1, 1626, 1, '{}', '', 0.25),
	('collector_fossil_tooth_trex', 'Fóssil de dente da frente', 100, 1, 'item_standard', 1, 1627, 1, '{}', '', 0.25),
	('collector_fossil_trilobite_crypto', 'Fóssil de Cryptolithus Trilobite', 100, 1, 'item_standard', 1, 1628, 1, '{}', '', 0.25),
	('collector_fossil_trilobite_iso', 'Fóssil de Isotelus Trilobite', 100, 1, 'item_standard', 1, 1629, 1, '{}', '', 0.25),
	('collector_fossil_tully_monster', 'Fóssil do Monstro Tully', 100, 1, 'item_standard', 1, 1630, 1, '{}', '', 0.25),
	('comidahorse', 'ração de cavalo', 100, 1, 'item_standard', 1, 17062, 1, '{}', '', 0.25),
	('compas', 'Compas', 100, 1, 'item_standard', 1, 16975, 1, '{}', '', 0.25),
	('condenser', 'Condensador', 100, 1, 'item_standard', 1, 816, 1, '{}', '', 0.25),
	('condorb', 'bico de condor', 100, 1, 'item_standard', 1, 480, 1, '{}', '', 0.25),
	('condorf', 'pena de condor', 100, 1, 'item_standard', 1, 479, 1, '{}', '', 0.25),
	('consumable_blueberrypie', 'torta de amora', 20, 1, 'item_standard', 1, 1631, 1, '{}', '', 0.25),
	('consumable_bluegil', 'Bluegil Seco', 100, 1, 'item_standard', 1, 114, 1, '{}', '', 0.25),
	('consumable_breakfast', 'Café da manhã', 20, 1, 'item_standard', 1, 115, 1, '{}', '', 0.25),
	('consumable_caramel', 'Caramelo', 100, 1, 'item_standard', 1, 116, 1, '{}', '', 0.25),
	('consumable_chickenpie', 'cozido de frango', 20, 1, 'item_standard', 1, 1632, 1, '{}', '', 0.25),
	('consumable_chocolate', 'Barra de Chocolate', 100, 1, 'item_standard', 1, 117, 1, '{}', '', 0.25),
	('consumable_chocolatecake', 'torta de chocolate', 20, 1, 'item_standard', 1, 1633, 1, '{}', '', 0.25),
	('consumable_chocolatecoffee', 'café achocolatado', 20, 1, 'item_standard', 1, 1634, 1, '{}', '', 0.25),
	('consumable_coffee', 'cafe', 20, 1, 'item_standard', 1, 118, 1, '{}', '', 0.25),
	('consumable_coffeecake', 'bolo de cafe', 20, 1, 'item_standard', 1, 1635, 1, '{}', '', 0.25),
	('consumable_corn', 'milho cozido', 100, 1, 'item_standard', 1, 16721, 1, '{}', '', 0.25),
	('consumable_corncob', 'milho cozido', 20, 1, 'item_standard', 1, 17254, 1, '{}', 'nice item', 0.25),
	('consumable_cowboychilli', 'cozinhada', 20, 1, 'item_standard', 1, 17253, 1, '{}', 'nice item', 0.25),
	('consumable_crumbcake', 'bolo de migalhas', 20, 1, 'item_standard', 1, 1636, 1, '{}', '', 0.25),
	('consumable_cupcake', 'Cupcake', 100, 1, 'item_standard', 1, 1637, 1, '{}', '', 0.25),
	('consumable_donut', 'rosquinha', 20, 1, 'item_standard', 1, 1638, 1, '{}', '', 0.25),
	('consumable_fishstew', 'mix peixe', 20, 1, 'item_standard', 1, 17255, 1, '{}', 'nice item', 0.25),
	('consumable_fruitsalad', 'Salada de frutas', 100, 1, 'item_standard', 1, 119, 1, '{}', '', 0.25),
	('consumable_game', 'carne de caça seca', 100, 1, 'item_standard', 1, 120, 1, '{}', '', 0.25),
	('consumable_grapejelly', 'Geleia de uva', 100, 1, 'item_standard', 1, 1639, 1, '{}', '', 0.25),
	('consumable_grilled_fish', 'prato de peixe', 100, 1, 'item_standard', 1, 17171, 1, '{}', '', 0.25),
	('consumable_haycube', 'cubo de feno', 100, 1, 'item_standard', 1, 121, 1, '{}', '', 0.25),
	('consumable_herb_chanterelles', 'chanterelles', 100, 1, 'item_standard', 1, 122, 1, '{}', '', 0.25),
	('consumable_herb_evergreen_huckleberry', 'Evergreen Huckleberry', 100, 1, 'item_standard', 1, 123, 1, '{}', '', 0.25),
	('consumable_herb_ginseng', 'erva ginseng', 100, 1, 'item_standard', 1, 17099, 1, '{}', '', 0.25),
	('consumable_herb_oregano', 'Oregano', 100, 1, 'item_standard', 1, 124, 1, '{}', '', 0.25),
	('consumable_herb_vanilla_flower', 'flor de baunilha', 100, 1, 'item_standard', 1, 125, 1, '{}', '', 0.25),
	('consumable_herb_wintergreen_berry', 'Wintergreen Berry', 100, 1, 'item_standard', 1, 126, 1, '{}', '', 0.25),
	('consumable_horsepeppermints', 'bastão de hortelã-pimenta', 100, 1, 'item_standard', 1, 1640, 1, '{}', '', 0.25),
	('consumable_horse_medicine', 'remedio pra cavalo', 100, 1, 'item_standard', 1, 16811, 1, '{}', '', 0.25),
	('consumable_horse_reviver', 'adrenalina cavalo', 100, 1, 'item_standard', 1, 16810, 1, '{}', '', 0.25),
	('consumable_horse_stimulant', 'estimulante de cavalo', 100, 1, 'item_standard', 1, 16808, 1, '{}', '', 0.25),
	('consumable_kidneybeans_can', 'Feijão em lata', 100, 1, 'item_standard', 1, 127, 1, '{}', '', 0.25),
	('consumable_lemoncake', 'Bolo de limão', 100, 1, 'item_standard', 1, 1641, 1, '{}', '', 0.25),
	('consumable_lemondrops', 'Gotas de Limão', 100, 1, 'item_standard', 1, 1642, 1, '{}', '', 0.25),
	('consumable_lock_breaker', 'Disjuntor', 100, 1, 'item_standard', 1, 128, 1, '{}', '', 0.25),
	('consumable_meat_greavy', 'Ensopado de carne', 100, 1, 'item_standard', 1, 129, 1, '{}', '', 0.25),
	('consumable_meat_plump_bird_cooked', 'ave ', 100, 1, 'item_standard', 1, 17141, 1, '{}', '', 0.25),
	('consumable_medicine', 'Medicamento', 100, 1, 'item_standard', 1, 130, 1, '{}', '', 0.25),
	('consumable_peach', 'Pêssego', 100, 1, 'item_standard', 1, 131, 1, '{}', '', 0.25),
	('consumable_peachcobbler', 'torta de pêssego', 100, 1, 'item_standard', 1, 1643, 1, '{}', '', 0.25),
	('consumable_peachjelly', 'geleia de pêssego', 100, 1, 'item_standard', 1, 1644, 1, '{}', '', 0.25),
	('consumable_pear', 'Pera', 100, 1, 'item_standard', 1, 132, 1, '{}', '', 0.25),
	('consumable_peppermint', 'hortelã-pimenta', 100, 1, 'item_standard', 1, 1645, 1, '{}', '', 0.25),
	('consumable_poundcake', 'Bolo de Libra', 100, 1, 'item_standard', 1, 1646, 1, '{}', '', 0.25),
	('consumable_pretzel', 'cebolitas', 100, 1, 'item_standard', 1, 1647, 1, '{}', '', 0.25),
	('consumable_raspberryjelly', 'geleia de framboesa', 100, 1, 'item_standard', 1, 1648, 1, '{}', '', 0.25),
	('consumable_raspberrywater', 'água de baga', 100, 1, 'item_standard', 1, 133, 1, '{}', '', 0.25),
	('consumable_salmon', 'Salmão Seco', 100, 1, 'item_standard', 1, 134, 1, '{}', '', 0.25),
	('consumable_salmon_can', 'lata de salmão', 100, 1, 'item_standard', 1, 135, 1, '{}', '', 0.25),
	('consumable_spongecake', 'Pão de ló', 100, 1, 'item_standard', 1, 1649, 1, '{}', '', 0.25),
	('consumable_steakpie', 'cozido de boi', 20, 1, 'item_standard', 1, 1650, 1, '{}', '', 0.25),
	('consumable_sugarcube', 'cubo de feno', 100, 1, 'item_standard', 1, 16728, 1, '{}', '', 0.25),
	('consumable_trout', 'Truta Cozida', 100, 1, 'item_standard', 1, 136, 1, '{}', '', 0.25),
	('consumable_veggies', 'Vegetais comestíveis', 100, 1, 'item_standard', 1, 137, 1, '{}', '', 0.25),
	('cookedbluegil', 'cozido com legumes', 100, 1, 'item_standard', 1, 138, 1, '{}', '', 0.25),
	('copper', 'Barra de Cobre', 100, 1, 'item_standard', 1, 139, 1, '{}', '', 0.25),
	('cordbow', 'corda de arco', 100, 1, 'item_standard', 1, 1651, 1, '{}', '', 0.25),
	('corn', 'Milho', 100, 1, 'item_standard', 1, 140, 1, '{}', '', 0.25),
	('cornseed', 'semente de milho', 100, 1, 'item_standard', 1, 141, 1, '{}', '', 0.25),
	('Corn_Seed', 'Semente de Milho', 100, 1, 'item_standard', 1, 215805, 1, '{}', 'nice item', 0.25),
	('cougarf', 'dente de puma', 100, 1, 'item_standard', 1, 558, 1, '{}', '', 0.25),
	('cougars', 'pele de puma', 100, 1, 'item_standard', 1, 557, 1, '{}', '', 0.25),
	('cougartaxi', 'Taxidermia do puma', 100, 1, 'item_standard', 1, 771, 1, '{}', '', 0.25),
	('cougar_taxidermy', 'Taxidermia do puma', 100, 1, 'item_standard', 1, 643, 1, '{}', '', 0.25),
	('coverbook', 'coverbook', 100, 1, 'item_standard', 1, 17237, 1, '{}', '', 0.25),
	('cowh', 'Chifre de vaca', 100, 1, 'item_standard', 1, 562, 1, '{}', '', 0.25),
	('cows', 'pele de vaca', 100, 1, 'item_standard', 1, 561, 1, '{}', '', 0.25),
	('coyotef', 'dente de coiote', 100, 1, 'item_standard', 1, 560, 1, '{}', '', 0.25),
	('coyotepelt', 'pele de coiote', 100, 1, 'item_standard', 1, 759, 1, '{}', '', 0.25),
	('coyotes', 'pele de coiote', 100, 1, 'item_standard', 1, 559, 1, '{}', '', 0.25),
	('coyotetaxi', 'Taxidermia do coiote', 100, 1, 'item_standard', 1, 768, 1, '{}', '', 0.25),
	('coyote_pelt', 'pele de coiote', 100, 1, 'item_standard', 1, 631, 1, '{}', '', 0.25),
	('coyote_taxidermy', 'Taxidermia do coiote', 100, 1, 'item_standard', 1, 640, 1, '{}', '', 0.25),
	('crabbutter', 'Manteiga de Caranguejo', 100, 1, 'item_standard', 1, 1652, 1, '{}', '', 0.25),
	('crablegs', 'Pernas de carangueijo', 100, 1, 'item_standard', 1, 1653, 1, '{}', '', 0.25),
	('crab_c', 'Caranguejo', 100, 1, 'item_standard', 1, 425, 1, '{}', '', 0.25),
	('craftingfire', 'Criando Fogo', 100, 1, 'item_standard', 1, 753, 1, '{}', '', 0.25),
	('crafting_fire', 'Criando Fogo', 100, 1, 'item_standard', 1, 625, 1, '{}', '', 0.25),
	('cranio_humano', 'cranio humano', 100, 1, 'item_standard', 1, 17289, 1, '{}', 'nice item', 0.25),
	('crawfish_c', 'lagosta', 100, 1, 'item_standard', 1, 424, 1, '{}', '', 0.25),
	('Creeking_Thyme', 'Tomilho Rastejante', 100, 1, 'item_standard', 1, 142, 1, '{}', '', 0.25),
	('Creeking_Thyme_Seed', 'Semente de Tomilho Rastejante', 100, 1, 'item_standard', 1, 143, 1, '{}', '', 0.25),
	('Creekplum', 'Creekplum', 100, 1, 'item_standard', 1, 144, 1, '{}', '', 0.25),
	('Creekplum_Seed', 'Creekplum', 100, 1, 'item_standard', 1, 145, 1, '{}', '', 0.25),
	('Crows_Garlic', 'Corvo Alho', 100, 1, 'item_standard', 1, 146, 1, '{}', '', 0.25),
	('Crows_Garlic_Seed', 'alho Seed', 100, 1, 'item_standard', 1, 147, 1, '{}', '', 0.25),
	('crow_c', 'Corvo', 100, 1, 'item_standard', 1, 426, 1, '{}', '', 0.25),
	('Currant Bush', 'grosselha', 100, 1, 'item_standard', 1, 16880, 1, '{}', '', 0.25),
	('darub', 'bico de guindaste', 100, 1, 'item_standard', 1, 530, 1, '{}', '', 0.25),
	('daruf', 'pena de guindaste', 100, 1, 'item_standard', 1, 529, 1, '{}', '', 0.25),
	('dbcandle', 'vela dbl', 100, 1, 'item_standard', 1, 660, 1, '{}', '', 0.25),
	('decortent1', 'Tenda Decorativa 1 Conjunto', 100, 1, 'item_standard', 1, 600, 1, '{}', '', 0.25),
	('decortent2', 'Conjunto de 2 tendas decorativas', 100, 1, 'item_standard', 1, 601, 1, '{}', '', 0.25),
	('decortent3', 'Conjunto de 3 tendas decorativas', 100, 1, 'item_standard', 1, 602, 1, '{}', '', 0.25),
	('deerheart', 'coração de veado', 100, 1, 'item_standard', 1, 466, 1, '{}', '', 0.25),
	('deerpelt', 'pele de veado', 100, 1, 'item_standard', 1, 758, 1, '{}', '', 0.25),
	('deerskin', 'pele de veado', 100, 1, 'item_standard', 1, 465, 1, '{}', '', 0.25),
	('deertaxi', 'Taxidermia de Cervos', 100, 1, 'item_standard', 1, 770, 1, '{}', '', 0.25),
	('deertrophy', 'Cabeça de Veado', 100, 1, 'item_standard', 1, 17219, 1, '{}', '', 0.25),
	('deer_pelt', 'pele de veado', 100, 1, 'item_standard', 1, 630, 1, '{}', '', 0.25),
	('deer_taxidermy', 'Taxidermia de Cervos', 100, 1, 'item_standard', 1, 642, 1, '{}', '', 0.25),
	('desertsage', 'Desert Sage', 50, 1, 'item_standard', 1, 17690, 1, '{}', 'an item', 0.25),
	('desertsageseed', 'Desert Sage seed', 50, 1, 'item_standard', 1, 17694, 1, '{}', 'an item', 0.25),
	('Desert_Sage', 'Sálvia do Deserto', 100, 1, 'item_standard', 1, 148, 1, '{}', '', 0.25),
	('Desert_Sage_Seed', 'Semente de Sálvia do Deserto', 100, 1, 'item_standard', 1, 149, 1, '{}', '', 0.25),
	('detectiveverify', 'Verifique o kit de morte', 2, 1, 'item_standard', 1, 17105, 1, '{}', '', 0.25),
	('detector', 'detector de metal', 2, 1, 'item_standard', 1, 17248, 1, '{}', 'nice item', 0.25),
	('diamond', 'Diamante', 100, 1, 'item_standard', 1, 150, 1, '{}', '', 0.25),
	('diamondore', 'diamante falso', 100, 1, 'item_standard', 1, 17203, 1, '{}', '', 0.25),
	('dino_bone', 'Dinosaur Bone', 5, 1, 'item_standard', 1, 17286, 1, '{}', 'A dinosaur bone.', 0.25),
	('dleguans', 'pele de iguana do deserto', 100, 1, 'item_standard', 1, 551, 1, '{}', '', 0.25),
	('docanimalkit', 'kit morte de animal', 100, 1, 'item_standard', 1, 16901, 1, '{}', '', 0.25),
	('docbandage', 'Curar Bandagem', 20, 1, 'item_standard', 1, 17137, 1, '{}', '', 0.25),
	('docburnedkit', 'kit queimadura', 20, 1, 'item_standard', 1, 17133, 1, '{}', '', 0.25),
	('docfirstaidkit', 'kit medico', 20, 1, 'item_standard', 1, 17128, 1, '{}', '', 0.25),
	('dochitkit', 'kit medico basico', 20, 1, 'item_standard', 1, 17132, 1, '{}', '', 0.25),
	('docmeleekit', 'kit medico facada', 20, 1, 'item_standard', 1, 17130, 1, '{}', '', 0.25),
	('docsnakekit', 'remedio de cobra', 2, 1, 'item_standard', 1, 17129, 1, '{}', '', 0.25),
	('doctorbag', 'Sac du docteur', 10, 1, 'item_standard', 1, 912, 1, '{}', '', 0.25),
	('docunarmedkit', 'Kit Médico Desarmado', 20, 1, 'item_standard', 1, 17134, 1, '{}', '', 0.25),
	('docverify', 'Verifique o kit de lesões', 20, 1, 'item_standard', 1, 17138, 1, '{}', '', 0.25),
	('docweaponskit', 'kit medico tiro', 100, 1, 'item_standard', 1, 17131, 1, '{}', '', 0.25),
	('dog_syringe', 'Dog Syringe', 10, 1, 'item_standard', 1, 17569, 1, '{}', 'nice item', 0.25),
	('dog_whistle', 'Dog Whistle', 1, 1, 'item_standard', 1, 17568, 1, '{}', 'nice item', 0.25),
	('dreamcatcher', 'Apanhador de Sonhos', 100, 1, 'item_standard', 1, 591, 1, '{}', '', 0.25),
	('dring', 'anel de noivado', 100, 1, 'item_standard', 1, 17205, 1, '{}', '', 0.25),
	('Drink_For_Dog', 'água para animais de estimação', 100, 1, 'item_standard', 1, 151, 1, '{}', '', 0.25),
	('duckfat', 'gordura de pato', 100, 1, 'item_standard', 1, 467, 1, '{}', '', 0.25),
	('Duck_Egg', 'Ovo de pato', 100, 1, 'item_standard', 1, 152, 1, '{}', '', 0.25),
	('dynamite', 'dinamite de carga de tubo', 100, 1, 'item_standard', 1, 153, 1, '{}', '', 0.25),
	('dynamitebundle', 'pacote de dinamite', 100, 1, 'item_standard', 1, 16932, 1, '{}', '', 0.25),
	('eaglef', 'Pena de águia', 100, 1, 'item_standard', 1, 468, 1, '{}', '', 0.25),
	('eaglet', 'garras de águia', 100, 1, 'item_standard', 1, 469, 1, '{}', '', 0.25),
	('egg', 'ovo', 100, 1, 'item_standard', 1, 796, 1, '{}', '', 0.25),
	('eggs', 'ovos', 100, 1, 'item_standard', 1, 154, 1, '{}', '', 0.25),
	('egg_condor', 'Condor Egg', 50, 1, 'item_standard', 1, 17340, 1, '{}', 'nice item', 0.25),
	('egg_duck', 'Duck Egg', 50, 1, 'item_standard', 1, 17336, 1, '{}', 'nice item', 0.25),
	('egg_gator', 'Gator Egg', 50, 1, 'item_standard', 1, 17338, 1, '{}', 'nice item', 0.25),
	('egg_loon', 'Loon Egg', 50, 1, 'item_standard', 1, 17337, 1, '{}', 'nice item', 0.25),
	('egg_vulture', 'Vulture Egg', 50, 1, 'item_standard', 1, 17339, 1, '{}', 'nice item', 0.25),
	('egretb', 'bico de garça nevada', 100, 1, 'item_standard', 1, 473, 1, '{}', '', 0.25),
	('egretf', 'Pena de garça-das-neves', 100, 1, 'item_standard', 1, 472, 1, '{}', '', 0.25),
	('electricitypaper', 'Papel de Instruções de Eletricidade', 100, 1, 'item_standard', 1, 16789, 1, '{}', '', 0.25),
	('elkantler', 'chifre de alce', 100, 1, 'item_standard', 1, 474, 1, '{}', '', 0.25),
	('elks', 'pele de alce', 100, 1, 'item_standard', 1, 475, 1, '{}', '', 0.25),
	('embalagem', 'Embalagem Plastica', 10, 1, 'item_standard', 1, 170502, 1, '{}', 'nice item', 0.25),
	('emerald', 'Esmeralda', 100, 1, 'item_standard', 1, 155, 1, '{}', '', 0.25),
	('emptybottle', 'Garrafa Vazia ', 100, 1, 'item_standard', 1, 215674, 1, '{}', 'nice item', 0.25),
	('emptypills', 'recipiente vazio', 100, 1, 'item_standard', 1, 17196, 1, '{}', '', 0.25),
	('empty_bucket', 'Empty Bucket', 3, 1, 'item_standard', 1, 17323, 1, '{}', 'nice item', 0.25),
	('empty_can', 'cantil', 1, 1, 'item_standard', 1, 16918, 1, '{}', '', 0.25),
	('empty_canteen', 'Canteen', 3, 1, 'item_standard', 1, 17321, 1, '{}', 'nice item', 0.25),
	('empty_mud_bucket', 'jaro 2', 100, 1, 'item_standard', 1, 98695, 1, '{}', 'nice item', 0.25),
	('English_Mace', 'maça inglesa', 100, 1, 'item_standard', 1, 156, 1, '{}', '', 0.25),
	('English_Mace_Seed', 'Semente de Mace Inglesa', 100, 1, 'item_standard', 1, 157, 1, '{}', '', 0.25),
	('ensopado', 'Ensopado de carne', 1, 1, 'item_standard', 1, 170474, 1, '{}', 'nice item', 0.25),
	('enxofre', 'enxofre', 100, 1, 'item_standard', 1, 17163, 1, '{}', '', 0.25),
	('escada', 'Escada', 100, 1, 'item_standard', 1, 215688, 1, '{}', 'nice item', 0.25),
	('escudo1', 'Escudo 1', 100, 1, 'item_standard', 1, 215741, 1, '{}', 'nice item', 0.25),
	('escudo10', 'Escudo 10', 100, 1, 'item_standard', 1, 215750, 1, '{}', 'nice item', 0.25),
	('escudo11', 'Escudo 11', 100, 1, 'item_standard', 1, 215751, 1, '{}', 'nice item', 0.25),
	('escudo12', 'Escudo 12', 100, 1, 'item_standard', 1, 215752, 1, '{}', 'nice item', 0.25),
	('escudo13', 'Escudo 13', 100, 1, 'item_standard', 1, 215753, 1, '{}', 'nice item', 0.25),
	('escudo14', 'Escudo 14', 100, 1, 'item_standard', 1, 215766, 1, '{}', 'nice item', 0.25),
	('escudo2', 'Escudo 2', 100, 1, 'item_standard', 1, 215742, 1, '{}', 'nice item', 0.25),
	('escudo3', 'Escudo 3', 100, 1, 'item_standard', 1, 215743, 1, '{}', 'nice item', 0.25),
	('escudo4', 'Escudo 4', 100, 1, 'item_standard', 1, 215744, 1, '{}', 'nice item', 0.25),
	('escudo5', 'Escudo 5', 100, 1, 'item_standard', 1, 215745, 1, '{}', 'nice item', 0.25),
	('escudo6', 'Escudo 6', 100, 1, 'item_standard', 1, 215746, 1, '{}', 'nice item', 0.25),
	('escudo7', 'Escudo 7', 100, 1, 'item_standard', 1, 215747, 1, '{}', 'nice item', 0.25),
	('escudo8', 'Escudo 8', 100, 1, 'item_standard', 1, 215748, 1, '{}', 'nice item', 0.25),
	('escudo9', 'Escudo 9', 100, 1, 'item_standard', 1, 215749, 1, '{}', 'nice item', 0.25),
	('esterco', 'esterco ', 100, 1, 'item_standard', 1, 17290, 1, '{}', 'nice item', 0.25),
	('Evergreen_Huckleberry', 'Mirtilo perene', 100, 1, 'item_standard', 1, 158, 1, '{}', '', 0.25),
	('Evergreen_Huckleberry_Seed', 'Semente de Mirtilo perene', 100, 1, 'item_standard', 1, 159, 1, '{}', '', 0.25),
	('eyewear', 'Eyewear', 20, 1, 'item_standard', 1, 17633, 1, '{}', 'nice item', 0.25),
	('fan', 'Fan', 100, 1, 'item_standard', 1, 160, 1, '{}', '', 0.25),
	('fancydouble', 'Quarto Duplo Extravagante', 100, 1, 'item_standard', 1, 667, 1, '{}', '', 0.25),
	('farelo_trigo', 'farelo de trigo', 100, 1, 'item_standard', 1, 17061, 1, '{}', '', 0.25),
	('farinha', 'farinha industrial', 100, 1, 'item_standard', 1, 17123, 1, '{}', '', 0.25),
	('Fat', 'Gordura animal', 100, 1, 'item_standard', 1, 161, 1, '{}', '', 0.25),
	('fazenda01', 'Livro da Fazenda 1', 100, 1, 'item_standard', 1, 170504, 1, '{}', 'nice item', 0.25),
	('fazenda02', 'Livro da Fazenda 2', 100, 1, 'item_standard', 1, 170509, 1, '{}', 'nice item', 0.25),
	('fazenda03', 'Livro da Fazenda 3', 100, 1, 'item_standard', 1, 170510, 1, '{}', 'nice item', 0.25),
	('fazenda04', 'Livro da Fazenda 4', 100, 1, 'item_standard', 1, 170513, 1, '{}', 'nice item', 0.25),
	('Feather', 'Pena', 100, 1, 'item_standard', 1, 162, 1, '{}', '', 0.25),
	('Feather1', 'Penar 1', 100, 1, 'item_standard', 1, 215756, 1, '{}', 'nice item', 0.25),
	('Feather2', 'Penar 2', 100, 1, 'item_standard', 1, 215757, 1, '{}', 'nice item', 0.25),
	('Feather3', 'Penar 3', 100, 1, 'item_standard', 1, 215758, 1, '{}', 'nice item', 0.25),
	('Feather4', 'Penar 4', 100, 1, 'item_standard', 1, 215759, 1, '{}', 'nice item', 0.25),
	('Feather5', 'Penar 5', 100, 1, 'item_standard', 1, 215760, 1, '{}', 'nice item', 0.25),
	('Feather6', 'Penar 6', 100, 1, 'item_standard', 1, 215761, 1, '{}', 'nice item', 0.25),
	('Feather7', 'Penar 7', 100, 1, 'item_standard', 1, 215762, 1, '{}', 'nice item', 0.25),
	('Feather8', 'Penar 8', 100, 1, 'item_standard', 1, 215763, 1, '{}', 'nice item', 0.25),
	('feathers', 'pena', 100, 1, 'item_standard', 1, 16995, 1, '{}', '', 0.25),
	('Feed_For_Dog', 'Comida de cão', 100, 1, 'item_standard', 1, 163, 1, '{}', '', 0.25),
	('feijao', 'feijao', 100, 1, 'item_standard', 1, 16795, 1, '{}', '', 0.25),
	('feijaoisland', 'Feijão Island', 100, 1, 'item_standard', 1, 170475, 1, '{}', 'nice item', 0.25),
	('fermento', 'fermento', 100, 1, 'item_standard', 1, 17095, 1, '{}', '', 0.25),
	('ferradura', 'ferradura ', 100, 1, 'item_standard', 1, 16806, 1, '{}', '', 0.25),
	('ferreirovl', 'Livro Ferreiro', 100, 1, 'item_standard', 1, 98677, 1, '{}', 'nice item', 0.25),
	('Fertilizer', 'Fertilizante', 100, 1, 'item_standard', 1, 736, 1, '{}', '', 0.25),
	('fertilizerbless', 'Abençoado Fertilizante', 100, 1, 'item_standard', 1, 738, 1, '{}', '', 0.25),
	('fertilizeregg', 'Adubo com ovos', 100, 1, 'item_standard', 1, 737, 1, '{}', '', 0.25),
	('fertilizerpro', 'Fertilizante com Produtos', 100, 1, 'item_standard', 1, 740, 1, '{}', '', 0.25),
	('fertilizerpulpsap', 'Fertilizante com Polpa/Seiva', 100, 1, 'item_standard', 1, 741, 1, '{}', '', 0.25),
	('fertilizersn', 'fertilizante com cobra', 100, 1, 'item_standard', 1, 742, 1, '{}', '', 0.25),
	('fertilizersq', 'Fertilizante com Esquilo', 100, 1, 'item_standard', 1, 743, 1, '{}', '', 0.25),
	('fertilizersw', 'Adubo com Madeira Macia', 100, 1, 'item_standard', 1, 745, 1, '{}', '', 0.25),
	('fertilizersyn', 'Fertilizante Synful', 100, 1, 'item_standard', 1, 739, 1, '{}', '', 0.25),
	('fertilizerwoj', 'Fertilizante com Wojape', 100, 1, 'item_standard', 1, 744, 1, '{}', '', 0.25),
	('feuilletabac', 'folha estimulante', 100, 1, 'item_standard', 1, 17100, 1, '{}', '', 0.25),
	('feuille_tabac', 'folha de tabaco', 100, 1, 'item_standard', 1, 16891, 1, '{}', '', 0.25),
	('feverfewseed', 'Wild Feverfew seed', 50, 1, 'item_standard', 1, 17692, 1, '{}', 'an item', 0.25),
	('fibers', 'fibras', 100, 1, 'item_standard', 1, 164, 1, '{}', '', 0.25),
	('fiche', 'Fichas', 100, 1, 'item_standard', 1, 215656, 1, '{}', 'nice item', 0.25),
	('fireportal', 'Portal', 100, 1, 'item_standard', 1, 215831, 1, '{}', 'nice item', 0.25),
	('fish', 'Peixe', 100, 1, 'item_standard', 1, 165, 1, '{}', '', 0.25),
	('fishbait', 'Isca de pesca', 100, 1, 'item_standard', 1, 166, 1, '{}', '', 0.25),
	('fishchips', 'Peixe e batata frita', 100, 1, 'item_standard', 1, 167, 1, '{}', '', 0.25),
	('fishmeat', 'carne de peixe grande', 100, 1, 'item_standard', 1, 572, 1, '{}', '', 0.25),
	('fivela', 'Fivela de Cinto', 100, 1, 'item_standard', 1, 215665, 1, '{}', 'nice item', 0.25),
	('flag', 'bandeira do acampamento', 100, 1, 'item_standard', 1, 168, 1, '{}', '', 0.25),
	('florzinha', 'Flor de Marijuana', 100, 1, 'item_standard', 1, 215651, 1, '{}', 'nice item', 0.25),
	('flour', 'Farinha', 100, 1, 'item_standard', 1, 1654, 1, '{}', '', 0.25),
	('floursack', 'Saco de farinha', 100, 1, 'item_standard', 1, 1655, 1, '{}', '', 0.25),
	('flowerarrangement', 'Flower Arrangement', 20, 1, 'item_standard', 1, 17458, 1, '{}', 'nice item', 0.25),
	('flowerboxes', 'floreiras', 100, 1, 'item_standard', 1, 628, 1, '{}', '', 0.25),
	('folder_skill_pages', 'cartazes', 100, 1, 'item_standard', 1, 16983, 1, '{}', '', 0.25),
	('folha_cocain', 'folha de cocaina', 100, 1, 'item_standard', 1, 16922, 1, '{}', '', 0.25),
	('foodbarrel', 'barril de comida', 100, 1, 'item_standard', 1, 764, 1, '{}', '', 0.25),
	('food_barrel', 'barril de comida', 100, 1, 'item_standard', 1, 636, 1, '{}', '', 0.25),
	('fosforo', 'fosforos', 100, 1, 'item_standard', 1, 215643, 1, '{}', 'nice item', 0.25),
	('foxskin', 'pele de raposa', 100, 1, 'item_standard', 1, 512, 1, '{}', '', 0.25),
	('foxt', 'dente de raposa', 100, 1, 'item_standard', 1, 513, 1, '{}', '', 0.25),
	('friedtater', 'batata Frita', 100, 1, 'item_standard', 1, 169, 1, '{}', '', 0.25),
	('frogbull2_c', 'Frogbull envenenado', 100, 1, 'item_standard', 1, 428, 1, '{}', '', 0.25),
	('frogbull_c', 'Frogbull', 100, 1, 'item_standard', 1, 427, 1, '{}', '', 0.25),
	('Fruit Tree', 'arvore frutifera', 100, 1, 'item_standard', 1, 16881, 1, '{}', '', 0.25),
	('fsnakes', 'Pele de cascavel Blacktail', 100, 1, 'item_standard', 1, 488, 1, '{}', '', 0.25),
	('galinhafood', 'Ração de Galinha', 100, 1, 'item_standard', 1, 98356, 1, '{}', 'nice item', 0.25),
	('game', 'carne de caça', 100, 1, 'item_standard', 1, 570, 1, '{}', '', 0.25),
	('Gamey_Meat', 'carne de caça', 30, 1, 'item_standard', 1, 170, 1, '{}', '', 0.25),
	('Gator_Egg_3', 'Ovo de Jacaré 3', 100, 1, 'item_standard', 1, 171, 1, '{}', '', 0.25),
	('Gator_Egg_4', 'Ovos de Jacaré 4', 100, 1, 'item_standard', 1, 172, 1, '{}', '', 0.25),
	('Gator_Egg_5', 'Ovo de Jacaré 5', 100, 1, 'item_standard', 1, 173, 1, '{}', '', 0.25),
	('gauntlets', 'Gauntlets', 20, 1, 'item_standard', 1, 17619, 1, '{}', 'nice item', 0.25),
	('gbarrelx', 'Cano da arma', 100, 1, 'item_standard', 1, 761, 1, '{}', '', 0.25),
	('gbears', 'pele de urso pardo', 100, 1, 'item_standard', 1, 453, 1, '{}', '', 0.25),
	('gemstone', 'Stone', 100, 1, 'item_standard', 1, 98666, 1, '{}', 'nice item', 0.25),
	('generic_list', 'carta de desconhecido', 100, 1, 'item_standard', 1, 17198, 1, '{}', '', 0.25),
	('gigantinho', 'Formula para crecer', 5, 1, 'item_standard', 1, 215672, 1, '{}', 'nice item', 0.25),
	('ginseng', 'Ginseng', 50, 1, 'item_standard', 1, 17683, 1, '{}', 'an item', 0.25),
	('Ginseng Americano', 'Ginseng Americano', 100, 1, 'item_standard', 1, 16876, 1, '{}', '', 0.25),
	('ginsengtea', 'chá de ginseng', 100, 1, 'item_standard', 1, 174, 1, '{}', '', 0.25),
	('glass', 'vidro quebrado', 100, 1, 'item_standard', 1, 17200, 1, '{}', '', 0.25),
	('glassbottle', 'Garrafa Vazia', 100, 1, 'item_standard', 1, 175, 1, '{}', '', 0.25),
	('glasseye', 'Olho de vidro', 100, 1, 'item_standard', 1, 1656, 1, '{}', '', 0.25),
	('gleguans', 'pele de iguana verde', 100, 1, 'item_standard', 1, 552, 1, '{}', '', 0.25),
	('gloves', 'Gloves', 20, 1, 'item_standard', 1, 17624, 1, '{}', 'nice item', 0.25),
	('goathead', 'cabeça de bode', 100, 1, 'item_standard', 1, 556, 1, '{}', '', 0.25),
	('goats', 'pele de cabra', 100, 1, 'item_standard', 1, 555, 1, '{}', '', 0.25),
	('goldbar', 'Barra de ouro', 100, 1, 'item_standard', 1, 176, 1, '{}', '', 0.25),
	('goldcraddlestand', 'planta de garimpo', 10, 1, 'item_standard', 1, 17262, 1, '{}', 'nice item', 0.25),
	('golddust', 'pepita de ouro', 100, 1, 'item_standard', 1, 16979, 1, '{}', '', 0.25),
	('Golden_Currant', 'groselha dourada', 100, 1, 'item_standard', 1, 177, 1, '{}', '', 0.25),
	('Golden_Currant_Seed', 'semente de groselha dourada', 100, 1, 'item_standard', 1, 178, 1, '{}', '', 0.25),
	('golden_nugget', 'Golden Nugget', 40, 1, 'item_standard', 1, 17325, 1, '{}', 'nice item', 0.25),
	('goldfish', 'peixe dourado', 100, 1, 'item_standard', 1, 179, 1, '{}', '', 0.25),
	('goldhorseshoe', 'ferradura de ouro', 100, 1, 'item_standard', 1, 16909, 1, '{}', '', 0.25),
	('goldnugget', 'pepita', 100, 1, 'item_standard', 1, 16987, 1, '{}', '', 0.25),
	('goldpan', 'prato de garimpo', 2, 1, 'item_standard', 1, 181, 1, '{}', '', 0.25),
	('goldring', 'Anel de ouro', 100, 1, 'item_standard', 1, 182, 1, '{}', '', 0.25),
	('goldticket', 'bilhete 3', 100, 1, 'item_standard', 1, 16913, 1, '{}', '', 0.25),
	('goldtooth', 'Dente de Ouro', 100, 1, 'item_standard', 1, 215657, 1, '{}', 'nice item', 0.25),
	('gold_flakes', 'Flocos de Ouro', 100, 1, 'item_standard', 1, 98693, 1, '{}', 'nice item', 0.25),
	('gold_nugget', 'Pepita de ouro', 100, 1, 'item_standard', 1, 180, 1, '{}', '', 0.25),
	('gold_pan', 'Gold Pan', 1, 1, 'item_standard', 1, 17324, 1, '{}', 'nice item', 0.25),
	('gold_panning_license', 'Licença de garimpo de ouro', 100, 1, 'item_standard', 1, 1657, 1, '{}', '', 0.25),
	('goodbyliquor', 'Good-bye Liquor', 20, 1, 'item_standard', 1, 17457, 1, '{}', 'nice item', 0.25),
	('gooseb', 'bico de ganso', 100, 1, 'item_standard', 1, 532, 1, '{}', '', 0.25),
	('goosef', 'Pena de ganso', 100, 1, 'item_standard', 1, 531, 1, '{}', '', 0.25),
	('Goose_Egg_4', 'ovo de ganso', 100, 1, 'item_standard', 1, 183, 1, '{}', '', 0.25),
	('Grain', 'Grão', 100, 1, 'item_standard', 1, 215816, 1, '{}', 'nice item', 0.25),
	('grainmill', 'Moinho de grãos', 100, 1, 'item_standard', 1, 1658, 1, '{}', '', 0.25),
	('Grain_Seed', 'Semente de Grão', 100, 1, 'item_standard', 1, 215804, 1, '{}', 'nice item', 0.25),
	('Granuls', 'Comida para passaros', 100, 1, 'item_standard', 1, 215690, 1, '{}', 'nice item', 0.25),
	('grapes', 'uvas', 100, 1, 'item_standard', 1, 1680, 1, '{}', '', 0.25),
	('Grape_Seed', 'semente de uva', 100, 1, 'item_standard', 1, 1681, 1, '{}', '', 0.25),
	('grinder', 'grinder', 100, 1, 'item_standard', 1, 1660, 1, '{}', '', 0.25),
	('Guarma_Tobacco', 'Tabaco de Guarma', 100, 1, 'item_standard', 1, 215825, 1, '{}', 'nice item', 0.25),
	('Guarma_Tobacco_Seed', 'Semente de Tabaco Guarma', 100, 1, 'item_standard', 1, 215793, 1, '{}', 'nice item', 0.25),
	('guitar', 'Guitarra Clássica', 100, 1, 'item_standard', 1, 341, 1, '{}', '', 0.25),
	('gunbelts', 'Gunbelt', 20, 1, 'item_standard', 1, 17614, 1, '{}', 'nice item', 0.25),
	('gunbelt_accs', 'Gunbelt Accs', 20, 1, 'item_standard', 1, 17616, 1, '{}', 'nice item', 0.25),
	('guncloth', 'pano', 100, 1, 'item_standard', 1, 215693, 1, '{}', 'nice item', 0.25),
	('gun_barrel', 'Cano da arma', 100, 1, 'item_standard', 1, 633, 1, '{}', '', 0.25),
	('gypsywagon', 'Conjunto de Carroça Cigana', 100, 1, 'item_standard', 1, 585, 1, '{}', '', 0.25),
	('hairpomade', 'pomada para cabelo', 100, 1, 'item_standard', 1, 184, 1, '{}', '', 0.25),
	('hair_accessories', 'Bow', 20, 1, 'item_standard', 1, 17611, 1, '{}', 'nice item', 0.25),
	('hammer', 'martelo', 100, 1, 'item_standard', 1, 17234, 1, '{}', '', 0.25),
	('handcuffs', 'Algemas', 100, 1, 'item_standard', 1, 185, 1, '{}', '', 0.25),
	('handcuffskey', 'chave de algemas', 1, 1, 'item_standard', 1, 17108, 1, '{}', '', 0.25),
	('handmixer', 'batedeira', 100, 1, 'item_standard', 1, 1661, 1, '{}', '', 0.25),
	('handsaw', 'serrote', 100, 1, 'item_standard', 1, 1662, 1, '{}', '', 0.25),
	('hatchet', 'machado', 100, 1, 'item_standard', 1, 186, 1, '{}', '', 0.25),
	('hats', 'Hat', 20, 1, 'item_standard', 1, 17635, 1, '{}', 'nice item', 0.25),
	('hawkf', 'pena de gavião', 100, 1, 'item_standard', 1, 535, 1, '{}', '', 0.25),
	('hawkt', 'garras de falcão', 100, 1, 'item_standard', 1, 536, 1, '{}', '', 0.25),
	('hay', 'cubo de feno', 20, 1, 'item_standard', 1, 16925, 1, '{}', '', 0.25),
	('Headband1', 'Headband1', 5, 1, 'item_standard', 1, 17481, 1, '{}', 'nice item', 0.25),
	('Headband2', 'Headband2', 5, 1, 'item_standard', 1, 17482, 1, '{}', 'nice item', 0.25),
	('Headband3', 'Headband3', 5, 1, 'item_standard', 1, 17483, 1, '{}', 'nice item', 0.25),
	('Headband4', 'Headband4', 5, 1, 'item_standard', 1, 17484, 1, '{}', 'nice item', 0.25),
	('Headband5', 'Headband5', 5, 1, 'item_standard', 1, 17485, 1, '{}', 'nice item', 0.25),
	('Headband6', 'Headband6', 5, 1, 'item_standard', 1, 17486, 1, '{}', 'nice item', 0.25),
	('Headdress1', 'Headdress1', 5, 1, 'item_standard', 1, 17487, 1, '{}', 'nice item', 0.25),
	('Headdress2', 'Headdress2', 5, 1, 'item_standard', 1, 17488, 1, '{}', 'nice item', 0.25),
	('Headdress3', 'Headdress3', 5, 1, 'item_standard', 1, 17489, 1, '{}', 'nice item', 0.25),
	('Headdress4', 'Headdress4', 5, 1, 'item_standard', 1, 17490, 1, '{}', 'nice item', 0.25),
	('Headdress5', 'Headdress5', 5, 1, 'item_standard', 1, 17491, 1, '{}', 'nice item', 0.25),
	('Headdress6', 'Headdress6', 6, 1, 'item_standard', 1, 17492, 1, '{}', 'nice item', 0.25),
	('Health_For_Dog', 'Bandagens para animais de estimação', 100, 1, 'item_standard', 1, 187, 1, '{}', '', 0.25),
	('hemp', 'Cânhamo', 100, 1, 'item_standard', 1, 188, 1, '{}', '', 0.25),
	('hemp_cig', 'cigarro de cânhamo', 100, 1, 'item_standard', 1, 189, 1, '{}', '', 0.25),
	('hemp_seed', 'Sementes de cânhamo', 100, 1, 'item_standard', 1, 615, 1, '{}', '', 0.25),
	('herbal_medicine', 'Fitoterapia', 100, 1, 'item_standard', 1, 338, 1, '{}', '', 0.25),
	('herbal_tonic', 'tonico de ervas', 100, 1, 'item_standard', 1, 339, 1, '{}', '', 0.25),
	('herbmed', 'Fitoterápico', 100, 1, 'item_standard', 1, 190, 1, '{}', '', 0.25),
	('heroin', 'Heroin', 100, 1, 'item_standard', 1, 191, 1, '{}', '', 0.25),
	('herptile', 'carne herptil', 100, 1, 'item_standard', 1, 573, 1, '{}', '', 0.25),
	('hitchingpost', 'Posto de amarração', 100, 1, 'item_standard', 1, 580, 1, '{}', '', 0.25),
	('hoe', 'rastelo', 100, 1, 'item_standard', 1, 679, 1, '{}', '', 0.25),
	('hojacocaina', 'Hoja de Cocaina', 100, 1, 'item_standard', 1, 16934, 1, '{}', '', 0.25),
	('hojaepi', 'Hoja Epi (Methanfetamina)', 100, 1, 'item_standard', 1, 16938, 1, '{}', '', 0.25),
	('holsters_left', 'Holster', 20, 1, 'item_standard', 1, 17621, 1, '{}', 'nice item', 0.25),
	('honey', 'mel', 30, 1, 'item_standard', 1, 192, 1, '{}', '', 0.25),
	('honeywhisky', 'Whisky de Mel', 100, 1, 'item_standard', 1, 215775, 1, '{}', 'nice item', 0.25),
	('honey_gk', 'Mel', 100, 1, 'item_standard', 1, 17041, 1, '{}', '', 0.25),
	('hop', 'lúpulo', 100, 1, 'item_standard', 1, 685, 1, '{}', '', 0.25),
	('hop_seed', 'Semente de lúpulo', 100, 1, 'item_standard', 1, 684, 1, '{}', '', 0.25),
	('horapa', 'Cavalo Appaloosa', 5, 1, 'item_standard', 1, 1015, 1, '{}', '009', 0.25),
	('horbre', 'Cavalo Breton ', 5, 1, 'item_standard', 1, 1014, 1, '{}', '008', 0.25),
	('hormis', 'Cavalo Missourifox', 10, 1, 'item_standard', 1, 1010, 1, '{}', '004', 0.25),
	('horse1', 'Vale Cavalo 1', 5, 1, 'item_standard', 1, 1028, 1, '{}', 'nice item', 0.25),
	('horse2', 'Vale Cavalo 2', 5, 1, 'item_standard', 1, 1029, 1, '{}', 'nice item', 0.25),
	('horse3', 'Vale Cavalo 3', 5, 1, 'item_standard', 1, 1030, 1, '{}', 'nice item', 0.25),
	('horse4', 'Vale Cavalo 4', 5, 1, 'item_standard', 1, 1031, 1, '{}', 'nice item', 0.25),
	('horsebrush', 'escova de cavalo', 100, 1, 'item_standard', 1, 193, 1, '{}', '', 0.25),
	('HorseCartTag', 'Licensa de carroça', 100, 1, 'item_standard', 1, 215768, 1, '{}', 'nice item', 0.25),
	('horsehitches', 'Conjunto de engates de cavalo', 100, 1, 'item_standard', 1, 603, 1, '{}', '', 0.25),
	('horsemeal', 'Ração de cavalo', 100, 1, 'item_standard', 1, 348, 1, '{}', '', 0.25),
	('horserevive', 'revive cavalo', 100, 1, 'item_standard', 1, 17184, 1, '{}', '', 0.25),
	('hortur', 'Cavalo Turkoman', 5, 1, 'item_standard', 1, 1009, 1, '{}', '003', 0.25),
	('humbirdsage', 'Hummingbird Sage', 50, 1, 'item_standard', 1, 17697, 1, '{}', 'an item', 0.25),
	('Hummingbird_Sage', 'Sálvia Beija-flor', 100, 1, 'item_standard', 1, 194, 1, '{}', '', 0.25),
	('Hummingbird_Sage_Seed', 'Semente de Sálvia Beija-flor', 100, 1, 'item_standard', 1, 195, 1, '{}', '', 0.25),
	('hwood', 'madeira dura', 30, 1, 'item_standard', 1, 196, 1, '{}', '', 0.25),
	('icemagic', 'Poção do gelo', 100, 1, 'item_standard', 1, 215829, 1, '{}', 'nice item', 0.25),
	('idcard', 'Identidade', 1, 1, 'item_standard', 1, 17327, 1, '{}', 'nice item', 0.25),
	('identitycard', 'identidade', 1, 1, 'item_standard', 1, 17074, 1, '{}', '', 0.25),
	('identitycardfalsa', 'identidade', 1, 1, 'item_standard', 1, 17073, 1, '{}', '', 0.25),
	('idfalsa', 'identidade falsa', 1, 1, 'item_standard', 1, 17072, 1, '{}', '', 0.25),
	('id_card', 'Cartao de Identidade', 1, 1, 'item_standard', 1, 17247, 1, '{}', '', 0.25),
	('iguanabits', 'pedaços de iguana', 100, 1, 'item_standard', 1, 1663, 1, '{}', '', 0.25),
	('Indian_Tobbaco', 'tabaco indiano', 100, 1, 'item_standard', 1, 197, 1, '{}', '', 0.25),
	('Indian_Tobbaco_Seed', 'Semente de Tabaco Indiano', 100, 1, 'item_standard', 1, 198, 1, '{}', '', 0.25),
	('Indigo', 'Indigo', 100, 1, 'item_standard', 1, 215826, 1, '{}', 'nice item', 0.25),
	('Indigo_Seed', 'Semente de Indico', 100, 1, 'item_standard', 1, 215802, 1, '{}', 'nice item', 0.25),
	('indovinello', 'indovinello', 100, 1, 'item_standard', 1, 215687, 1, '{}', 'nice item', 0.25),
	('inelargintsmarald', 'Anel de Esmeralda', 100, 1, 'item_standard', 1, 215658, 1, '{}', 'nice item', 0.25),
	('inelmagic', 'Anel Magico', 100, 1, 'item_standard', 1, 215659, 1, '{}', 'nice item', 0.25),
	('Ingredient_Beef_Meat', 'carne de vaca', 100, 1, 'item_standard', 1, 16968, 1, '{}', '', 0.25),
	('Ingredient_Goat_Meat', 'carne de cabra ', 100, 1, 'item_standard', 1, 16970, 1, '{}', '', 0.25),
	('Ingredient_Pig_Meat', 'carne de porco', 100, 1, 'item_standard', 1, 16969, 1, '{}', '', 0.25),
	('injeanimal', 'Injeção de Animais', 100, 1, 'item_standard', 1, 98355, 1, '{}', 'nice item', 0.25),
	('ink', 'Tinta', 100, 1, 'item_standard', 1, 1664, 1, '{}', '', 0.25),
	('iogurtem', 'Iogurte de Morango', 100, 1, 'item_standard', 1, 170508, 1, '{}', 'nice item', 0.25),
	('iron', 'ferro', 100, 1, 'item_standard', 1, 199, 1, '{}', '', 0.25),
	('ironbar', 'barra de ferro', 100, 1, 'item_standard', 1, 200, 1, '{}', '', 0.25),
	('ironextract', 'Extrato de ferro', 100, 1, 'item_standard', 1, 201, 1, '{}', '', 0.25),
	('ironhammer', 'martelo de ferro', 100, 1, 'item_standard', 1, 202, 1, '{}', '', 0.25),
	('ironhorseshoe', 'ferradura de ferro', 100, 1, 'item_standard', 1, 16907, 1, '{}', '', 0.25),
	('jewelrybook', 'livro', 100, 1, 'item_standard', 1, 17236, 1, '{}', '', 0.25),
	('jewelry_bracelets', 'Bracelet', 20, 1, 'item_standard', 1, 17636, 1, '{}', 'nice item', 0.25),
	('jewelry_rings_left', 'Ring Lh', 20, 1, 'item_standard', 1, 17622, 1, '{}', 'nice item', 0.25),
	('jewelry_rings_right', 'Ring Rh', 20, 1, 'item_standard', 1, 17623, 1, '{}', 'nice item', 0.25),
	('jobnotepad', 'Bloco de notas de trabalho', 100, 1, 'item_standard', 1, 16887, 1, '{}', '', 0.25),
	('joint', 'Joint', 20, 1, 'item_standard', 1, 17461, 1, '{}', 'nice item', 0.25),
	('kbirdb', 'Grande bico de garça azul', 100, 1, 'item_standard', 1, 534, 1, '{}', '', 0.25),
	('kbirdf', 'Pena de garça-real', 100, 1, 'item_standard', 1, 533, 1, '{}', '', 0.25),
	('kitbandagem', 'Bandagem', 100, 1, 'item_standard', 1, 215666, 1, '{}', '', 0.25),
	('kitchencounter', 'Balcão de cozinha', 100, 1, 'item_standard', 1, 611, 1, '{}', '', 0.25),
	('kitmedicamento', 'Medicamento simples', 100, 1, 'item_standard', 1, 215667, 1, '{}', '', 0.25),
	('kitmedicervas', 'Medicamento de Ervas', 100, 1, 'item_standard', 1, 215668, 1, '{}', '', 0.25),
	('kitmedico', 'Kit Medico', 100, 1, 'item_standard', 1, 215669, 1, '{}', '', 0.25),
	('kittonicoervas', 'Tonico de Ervas', 100, 1, 'item_standard', 1, 215670, 1, '{}', '', 0.25),
	('kit_bandana', 'Bandana', 100, 1, 'item_standard', 1, 203, 1, '{}', '', 0.25),
	('kit_camp', 'kit acampamento', 1, 1, 'item_standard', 1, 16740, 1, '{}', '', 0.25),
	('kit_camp_simple', 'kit acampamento simples', 100, 1, 'item_standard', 1, 16739, 1, '{}', '', 0.25),
	('kit_collectors_bag', 'mochila', 100, 1, 'item_standard', 1, 17299, 1, '{}', 'nice item', 0.25),
	('kit_collector_spade', 'pá de coleta', 100, 1, 'item_standard', 1, 16734, 1, '{}', '', 0.25),
	('lamppost1', 'Poste de luz 1 conjunto', 100, 1, 'item_standard', 1, 606, 1, '{}', '', 0.25),
	('lamppost2', 'Poste de luz 2 conjunto', 100, 1, 'item_standard', 1, 607, 1, '{}', '', 0.25),
	('lanterna', 'lanterna', 100, 1, 'item_standard', 1, 659, 1, '{}', '', 0.25),
	('laranja', 'laranja ', 100, 1, 'item_standard', 1, 17117, 1, '{}', '', 0.25),
	('laranja_seed', 'semente de laranja', 100, 1, 'item_standard', 1, 17112, 1, '{}', '', 0.25),
	('leather', 'Couro', 100, 1, 'item_standard', 1, 204, 1, '{}', '', 0.25),
	('leatherchair', 'cadeira de couro', 100, 1, 'item_standard', 1, 748, 1, '{}', '', 0.25),
	('leather_chair', 'cadeira de couro', 100, 1, 'item_standard', 1, 620, 1, '{}', '', 0.25),
	('legalbook', 'livro legal', 100, 1, 'item_standard', 1, 892, 1, '{}', '', 0.25),
	('legaligators', 'Pele de Jacaré Lendária', 100, 1, 'item_standard', 1, 417, 1, '{}', '', 0.25),
	('legaligators1', 'Legendary Teca Alligator pelt', 100, 1, 'item_standard', 1, 400, 1, '{}', '', 0.25),
	('legaligators2', 'Pele Lendária de Jacaré do Sol', 100, 1, 'item_standard', 1, 401, 1, '{}', '', 0.25),
	('legaligators3', 'Pele lendária de crocodilo com faixas', 100, 1, 'item_standard', 1, 402, 1, '{}', '', 0.25),
	('legalpaper', 'Papel Legal', 100, 1, 'item_standard', 1, 891, 1, '{}', '', 0.25),
	('legbears1', 'Pele Lendária de Urso Mortal', 100, 1, 'item_standard', 1, 376, 1, '{}', '', 0.25),
	('legbears2', 'Pele lendária do Urso Owiza', 100, 1, 'item_standard', 1, 377, 1, '{}', '', 0.25),
	('legbears3', 'Pele Lendária do Urso Espírito Ridgeback', 100, 1, 'item_standard', 1, 378, 1, '{}', '', 0.25),
	('legbears4', 'Pele Lendária do Urso Espírito Dourado', 100, 1, 'item_standard', 1, 379, 1, '{}', '', 0.25),
	('legbeavers1', 'Pele Lendária de Castor Cinzento', 100, 1, 'item_standard', 1, 397, 1, '{}', '', 0.25),
	('legbeavers2', 'Pele Lendária de Castor Branco', 100, 1, 'item_standard', 1, 398, 1, '{}', '', 0.25),
	('legbeavers3', 'Pele Lendária de Castor Negro', 100, 1, 'item_standard', 1, 399, 1, '{}', '', 0.25),
	('legbeawers', 'Pele de castor lendária', 100, 1, 'item_standard', 1, 411, 1, '{}', '', 0.25),
	('legbisonhorn', 'Chifres de Bisão Lendários', 100, 1, 'item_standard', 1, 353, 1, '{}', '', 0.25),
	('legbisons', 'Pele de Bisão Lendária', 100, 1, 'item_standard', 1, 416, 1, '{}', '', 0.25),
	('legbisons1', 'Pele lendária de Tatanka Bison', 100, 1, 'item_standard', 1, 365, 1, '{}', '', 0.25),
	('legbisons2', 'Pele lendária de Winyan Bison', 100, 1, 'item_standard', 1, 366, 1, '{}', '', 0.25),
	('legbisons3', 'Pele lendária de Payata Bison', 100, 1, 'item_standard', 1, 367, 1, '{}', '', 0.25),
	('legbisonstak', 'Pele lendária de Takanta Bison', 100, 1, 'item_standard', 1, 415, 1, '{}', '', 0.25),
	('legboars', 'Pele de javali lendária', 100, 1, 'item_standard', 1, 414, 1, '{}', '', 0.25),
	('legboars1', 'Pele de Javali Cogi Lendária', 100, 1, 'item_standard', 1, 393, 1, '{}', '', 0.25),
	('legboars2', 'Pele de Javali Wakpa Lendária', 100, 1, 'item_standard', 1, 394, 1, '{}', '', 0.25),
	('legboars3', 'Pele de Javali Icahi Lendária', 100, 1, 'item_standard', 1, 395, 1, '{}', '', 0.25),
	('legboars4', 'Pele de Wildhog lendária', 100, 1, 'item_standard', 1, 396, 1, '{}', '', 0.25),
	('legbucks', 'Skin Lendária Buck', 100, 1, 'item_standard', 1, 410, 1, '{}', '', 0.25),
	('legbucks1', 'Pele de Buck Lendária', 100, 1, 'item_standard', 1, 368, 1, '{}', '', 0.25),
	('legbucks2', 'Pele Lendária Mudrunner Buck', 100, 1, 'item_standard', 1, 369, 1, '{}', '', 0.25),
	('legbucks3', 'Pele Lendária de Snow Buck', 100, 1, 'item_standard', 1, 370, 1, '{}', '', 0.25),
	('legbucks4', 'Pele Lendária de Shadow Buck', 100, 1, 'item_standard', 1, 371, 1, '{}', '', 0.25),
	('legcougars', 'Pele lendária de puma', 100, 1, 'item_standard', 1, 409, 1, '{}', '', 0.25),
	('legcougars1', 'Pele lendária de Iguga Cougar', 100, 1, 'item_standard', 1, 389, 1, '{}', '', 0.25),
	('legcougars2', 'Pele lendária de Maza Cougar', 100, 1, 'item_standard', 1, 390, 1, '{}', '', 0.25),
	('legcougars3', 'Pele lendária de Sapa Cougar', 100, 1, 'item_standard', 1, 391, 1, '{}', '', 0.25),
	('legcougars4', 'Pele de Puma Negra Lendária', 100, 1, 'item_standard', 1, 392, 1, '{}', '', 0.25),
	('legcoyotes', 'Pele lendária de coiote', 100, 1, 'item_standard', 1, 408, 1, '{}', '', 0.25),
	('legcoyotes1', 'Pele de Coiote Lendária Red Streak', 100, 1, 'item_standard', 1, 386, 1, '{}', '', 0.25),
	('legcoyotes2', 'Pele Lendária Midnight Paw Coyote', 100, 1, 'item_standard', 1, 387, 1, '{}', '', 0.25),
	('legcoyotes3', 'Pele lendária de coiote de leite', 100, 1, 'item_standard', 1, 388, 1, '{}', '', 0.25),
	('legelkantler', 'Chifres de Alce Lendários', 100, 1, 'item_standard', 1, 355, 1, '{}', '', 0.25),
	('legelks', 'Pele de Alce Lendária', 100, 1, 'item_standard', 1, 403, 1, '{}', '', 0.25),
	('legelks1', 'Pele Lendária de Alce Katata', 100, 1, 'item_standard', 1, 362, 1, '{}', '', 0.25),
	('legelks2', 'Pele lendária de alce Ozula', 100, 1, 'item_standard', 1, 363, 1, '{}', '', 0.25),
	('legelks3', 'Legendary Inahme Elk pelt', 20, 1, 'item_standard', 1, 364, 1, '{}', 'An exquisite pelt from a legendary Inahme Elk', 0.25),
	('legendbuckantler', 'Lendário Buck Antlers', 100, 1, 'item_standard', 1, 356, 1, '{}', '', 0.25),
	('legendsnakes', 'Legendary Boa pelt', 100, 1, 'item_standard', 1, 418, 1, '{}', '', 0.25),
	('legfoxs2', 'Pele de raposa de mármore lendária', 100, 1, 'item_standard', 1, 360, 1, '{}', '', 0.25),
	('legfoxs3', 'Pele Lendária de Raposa Cruzada', 100, 1, 'item_standard', 1, 361, 1, '{}', '', 0.25),
	('legfoxskin', 'Skin Lendária da Raposa', 100, 1, 'item_standard', 1, 413, 1, '{}', '', 0.25),
	('leggbears', 'Pele de urso lendária', 100, 1, 'item_standard', 1, 404, 1, '{}', '', 0.25),
	('legmooseantler', 'Chifres de Alce Lendários', 100, 1, 'item_standard', 1, 352, 1, '{}', '', 0.25),
	('legmooses', 'Pele de alce lendária', 100, 1, 'item_standard', 1, 405, 1, '{}', '', 0.25),
	('legmooses1', 'Pele de Alce Floco de Neve Lendária', 100, 1, 'item_standard', 1, 357, 1, '{}', '', 0.25),
	('legmooses2', 'Pele Lendária de Alce Cavaleiro', 100, 1, 'item_standard', 1, 358, 1, '{}', '', 0.25),
	('legmooses3', 'Pele lendária de Rudy Moose', 100, 1, 'item_standard', 1, 359, 1, '{}', '', 0.25),
	('legpanthers1', 'Pele de Pantera Nightwalker Lendária', 100, 1, 'item_standard', 1, 383, 1, '{}', '', 0.25),
	('legpanthers2', 'Pele Lendária de Iwakta Panther', 100, 1, 'item_standard', 1, 384, 1, '{}', '', 0.25),
	('legpanthers3', 'Pele Lendária de Iwakta Panther', 100, 1, 'item_standard', 1, 385, 1, '{}', '', 0.25),
	('legprongs', 'Pele Lendária Pronghorn', 100, 1, 'item_standard', 1, 407, 1, '{}', '', 0.25),
	('legramhorn', 'Chifres de Carneiro Lendários', 100, 1, 'item_standard', 1, 354, 1, '{}', '', 0.25),
	('legrams', 'Pele de Carneiro Lendária', 100, 1, 'item_standard', 1, 412, 1, '{}', '', 0.25),
	('legrams1', 'Pele Lendária Gabbro Horn Ram', 100, 1, 'item_standard', 1, 372, 1, '{}', '', 0.25),
	('legrams2', 'Pele de carneiro com chifre de giz lendária', 100, 1, 'item_standard', 1, 373, 1, '{}', '', 0.25),
	('legrams3', 'Pele de carneiro com chifre de rutilo lendário', 100, 1, 'item_standard', 1, 374, 1, '{}', '', 0.25),
	('legrams4', 'Pele Lendária de Carneiro Grande Chifre', 100, 1, 'item_standard', 1, 375, 1, '{}', '', 0.25),
	('legwolfpelt', 'Pele de Lobo Lendário', 100, 1, 'item_standard', 1, 406, 1, '{}', '', 0.25),
	('legwolfs1', 'Pele Lendária do Lobo Esmeralda', 100, 1, 'item_standard', 1, 380, 1, '{}', '', 0.25),
	('legwolfs2', 'Pele lendária de lobo ônix', 100, 1, 'item_standard', 1, 381, 1, '{}', '', 0.25),
	('legwolfs3', 'Pele Lendária do Lobo da Pedra da Lua', 100, 1, 'item_standard', 1, 382, 1, '{}', '', 0.25),
	('lighter', 'Isqueiro antigo', 100, 1, 'item_standard', 1, 215660, 1, '{}', 'nice item', 0.25),
	('limao', 'limão', 100, 1, 'item_standard', 1, 17118, 1, '{}', '', 0.25),
	('limao_seed', 'semente de limão', 100, 1, 'item_standard', 1, 17113, 1, '{}', '', 0.25),
	('limpacasco', 'Limpa casco', 100, 1, 'item_standard', 1, 215767, 1, '{}', 'nice item', 0.25),
	('Livrofazendasvip', 'Livro de Produção Fazendas VIP', 100, 1, 'item_standard', 1, 1005, 1, '{}', '018', 0.25),
	('lizardl', 'pé de lagarto', 100, 1, 'item_standard', 1, 554, 1, '{}', '', 0.25),
	('lizards', 'pele de lagarto', 100, 1, 'item_standard', 1, 553, 1, '{}', '', 0.25),
	('loadouts', 'Loadout', 20, 1, 'item_standard', 1, 17618, 1, '{}', 'nice item', 0.25),
	('lockpick', 'Lockpick', 100, 1, 'item_standard', 1, 205, 1, '{}', '', 0.25),
	('lockpickmold', 'Molde Lockpick', 100, 1, 'item_standard', 1, 206, 1, '{}', '', 0.25),
	('logbechs', 'banco de toras 2', 100, 1, 'item_standard', 1, 775, 1, '{}', '', 0.25),
	('logbench', 'Banco de toras 1', 100, 1, 'item_standard', 1, 774, 1, '{}', '', 0.25),
	('log_bencha', 'Banco de toras 1', 100, 1, 'item_standard', 1, 646, 1, '{}', '', 0.25),
	('log_benchb', 'banco de toras 2', 100, 1, 'item_standard', 1, 647, 1, '{}', '', 0.25),
	('loonb', 'bico de mergulhão comum', 100, 1, 'item_standard', 1, 538, 1, '{}', '', 0.25),
	('loonf', 'pena de mergulhão comum', 100, 1, 'item_standard', 1, 537, 1, '{}', '', 0.25),
	('loungechair', 'Espreguiçadeira', 100, 1, 'item_standard', 1, 598, 1, '{}', '', 0.25),
	('loungechair2', 'Espreguiçadeira 2', 100, 1, 'item_standard', 1, 599, 1, '{}', '', 0.25),
	('lumberaxe', 'machado de madeira', 100, 1, 'item_standard', 1, 345, 1, '{}', '', 0.25),
	('mackerel', 'Cavalinha', 100, 1, 'item_standard', 1, 207, 1, '{}', '', 0.25),
	('magicpoison', 'Poção magica', 100, 1, 'item_standard', 1, 215832, 1, '{}', 'nice item', 0.25),
	('man_idcard', 'Identificação', 1, 1, 'item_standard', 1, 215653, 1, '{}', 'Identity card with information written on it', 0.25),
	('map', 'map', 1, 1, 'item_standard', 1, 17094, 1, '{}', '', 0.25),
	('map1', 'mapa 1', 100, 1, 'item_standard', 1, 215676, 1, '{}', 'nice item', 0.25),
	('map10', 'mapa 10', 100, 1, 'item_standard', 1, 215685, 1, '{}', 'nice item', 0.25),
	('map2', 'mapa 2', 100, 1, 'item_standard', 1, 215677, 1, '{}', 'nice item', 0.25),
	('map3', 'mapa 3', 100, 1, 'item_standard', 1, 215678, 1, '{}', 'nice item', 0.25),
	('map4', 'mapa 4', 100, 1, 'item_standard', 1, 215679, 1, '{}', 'nice item', 0.25),
	('map5', 'mapa 5', 100, 1, 'item_standard', 1, 215680, 1, '{}', 'nice item', 0.25),
	('map6', 'mapa 6', 100, 1, 'item_standard', 1, 215681, 1, '{}', 'nice item', 0.25),
	('map7', 'mapa 7', 100, 1, 'item_standard', 1, 215682, 1, '{}', 'nice item', 0.25),
	('map8', 'mapa 8', 100, 1, 'item_standard', 1, 215683, 1, '{}', 'nice item', 0.25),
	('map9', 'mapa 9', 100, 1, 'item_standard', 1, 215684, 1, '{}', 'nice item', 0.25),
	('mapa', 'mapa', 1, 1, 'item_standard', 1, 16726, 1, '{}', '', 0.25),
	('mappa', 'mapa completo', 100, 1, 'item_standard', 1, 215686, 1, '{}', 'nice item', 0.25),
	('Mariuhana', 'Maconha ', 100, 1, 'item_standard', 1, 215624, 1, '{}', 'nice item', 0.25),
	('marriagebook', 'livro de casamento', 100, 1, 'item_standard', 1, 894, 1, '{}', '', 0.25),
	('marriagecertification', 'Certidão de Casamento', 100, 1, 'item_standard', 1, 895, 1, '{}', '', 0.25),
	('mascado', 'Tabacco mascado', 100, 1, 'item_standard', 1, 215648, 1, '{}', 'nice item', 0.25),
	('mashalaskan', 'Purê de Gin do Alasca', 100, 1, 'item_standard', 1, 824, 1, '{}', '', 0.25),
	('mashamerican', 'Purê de Gin do Alasca', 100, 1, 'item_standard', 1, 825, 1, '{}', '', 0.25),
	('mashapple', 'purê de maçã', 100, 1, 'item_standard', 1, 826, 1, '{}', '', 0.25),
	('mashblackberry', 'Purê de Amora', 100, 1, 'item_standard', 1, 827, 1, '{}', '', 0.25),
	('mashblackberry90p', 'Puré De Amora 90p', 100, 1, 'item_standard', 1, 828, 1, '{}', '', 0.25),
	('mashpeach', 'purê de pêssego', 100, 1, 'item_standard', 1, 829, 1, '{}', '', 0.25),
	('mashplum', 'purê de ameixa', 100, 1, 'item_standard', 1, 830, 1, '{}', '', 0.25),
	('mashraspberry', 'purê de framboesa', 100, 1, 'item_standard', 1, 831, 1, '{}', '', 0.25),
	('mashraspberry90p', 'Purê de Framboesa 90p', 100, 1, 'item_standard', 1, 832, 1, '{}', '', 0.25),
	('mashstrong', 'Lote de Mash Forte', 100, 1, 'item_standard', 1, 833, 1, '{}', '', 0.25),
	('masks', 'Mask', 20, 1, 'item_standard', 1, 17634, 1, '{}', 'nice item', 0.25),
	('meat', 'Carne', 30, 1, 'item_standard', 1, 208, 1, '{}', '', 0.25),
	('med1', 'Faixa medica', 100, 1, 'item_standard', 1, 215849, 1, '{}', 'nice item', 0.25),
	('melado_de_cana', 'melado de cana', 100, 1, 'item_standard', 1, 17056, 1, '{}', '', 0.25),
	('melone', 'Melancia', 100, 1, 'item_standard', 1, 98683, 1, '{}', 'nice item', 0.25),
	('metal_gear', 'engrenagem de metal', 100, 1, 'item_standard', 1, 1665, 1, '{}', '', 0.25),
	('metha', 'Methanfetamina', 100, 1, 'item_standard', 1, 16940, 1, '{}', '', 0.25),
	('mexitillas', 'mexicanos', 100, 1, 'item_standard', 1, 1666, 1, '{}', '', 0.25),
	('mexitillastaco', 'taco mexicano', 100, 1, 'item_standard', 1, 1667, 1, '{}', '', 0.25),
	('milk', 'leite', 100, 1, 'item_standard', 1, 209, 1, '{}', '', 0.25),
	('milkweedseed', 'Milkweed seed', 50, 1, 'item_standard', 1, 17686, 1, '{}', 'an item', 0.25),
	('Milk_Weed', 'erva de leite', 100, 1, 'item_standard', 1, 210, 1, '{}', '', 0.25),
	('Milk_Weed_Seed', 'semente de serralha', 100, 1, 'item_standard', 1, 211, 1, '{}', '', 0.25),
	('mindmagic', 'Poção2', 100, 1, 'item_standard', 1, 215830, 1, '{}', 'nice item', 0.25),
	('MinerHat1', 'Capacete de Minerador', 100, 1, 'item_standard', 1, 215697, 1, '{}', 'nice item', 0.25),
	('minerio_de_cobre', 'minerio de cobre', 100, 1, 'item_standard', 1, 17054, 1, '{}', '', 0.25),
	('minerio_de_ferro', 'minerio de ferro', 100, 1, 'item_standard', 1, 17055, 1, '{}', '', 0.25),
	('minerio_de_prata', 'minerio de prata ', 100, 1, 'item_standard', 1, 16973, 1, '{}', '', 0.25),
	('moneybagfv', 'Saco de Dinheiro de Bando', 100, 1, 'item_standard', 1, 170519, 1, '{}', 'nice item', 0.25),
	('moneysujo', 'Dinheiro Sujo', 100, 1, 'item_standard', 1, 170514, 1, '{}', 'nice item', 0.25),
	('money_coin', 'Moeda', 100, 1, 'item_standard', 1, 1668, 1, '{}', '', 0.25),
	('money_coinpurse', 'porta-moedas', 100, 1, 'item_standard', 1, 1669, 1, '{}', '', 0.25),
	('moonshine', 'aguardente', 100, 1, 'item_standard', 1, 212, 1, '{}', '', 0.25),
	('mooseantler', 'chifres de alce', 100, 1, 'item_standard', 1, 548, 1, '{}', '', 0.25),
	('mooses', 'pele de alce', 100, 1, 'item_standard', 1, 549, 1, '{}', '', 0.25),
	('morango', 'Morango', 100, 1, 'item_standard', 1, 98685, 1, '{}', 'nice item', 0.25),
	('morango_Seed', 'Semente de Morango', 100, 1, 'item_standard', 1, 215797, 1, '{}', 'nice item', 0.25),
	('morpcert', 'Prescrição de Morfina', 100, 1, 'item_standard', 1, 213, 1, '{}', '', 0.25),
	('morphine', 'Prescrição de Morfina', 100, 1, 'item_standard', 1, 214, 1, '{}', '', 0.25),
	('mountainmen', 'mountainmen', 100, 1, 'item_standard', 1, 608, 1, '{}', '', 0.25),
	('mp001_p_mp_still02x', 'destilaria', 100, 1, 'item_standard', 1, 215, 1, '{}', '', 0.25),
	('mud_bucket', 'Jaro 1', 100, 1, 'item_standard', 1, 98694, 1, '{}', 'nice item', 0.25),
	('muskrats', 'pele de rato almiscarado', 100, 1, 'item_standard', 1, 547, 1, '{}', '', 0.25),
	('Mutton', 'pork', 100, 1, 'item_standard', 1, 216, 1, '{}', '', 0.25),
	('Na1', 'Aljava Lateral', 10, 1, 'item_standard', 1, 17473, 1, '{}', 'nice item', 0.25),
	('Na2', 'Aljava traseira', 10, 1, 'item_standard', 1, 17474, 1, '{}', 'nice item', 0.25),
	('Na3', 'Saco de cachimbo', 10, 1, 'item_standard', 1, 17475, 1, '{}', 'nice item', 0.25),
	('Na4', 'Cachimbo da Paz', 10, 1, 'item_standard', 1, 17476, 1, '{}', 'nice item', 0.25),
	('Na5', 'Pulseira de Penas', 10, 1, 'item_standard', 1, 17477, 1, '{}', 'nice item', 0.25),
	('Na6', 'Peça de cabelo pena dourada', 10, 1, 'item_standard', 1, 17478, 1, '{}', 'nice item', 0.25),
	('Na7', 'Acessório Tomahawk Antigo', 10, 1, 'item_standard', 1, 17479, 1, '{}', 'nice item', 0.25),
	('Na8', 'Acessório de escudo e lança', 10, 1, 'item_standard', 1, 17480, 1, '{}', 'nice item', 0.25),
	('nails', 'pregos', 100, 1, 'item_standard', 1, 217, 1, '{}', '', 0.25),
	('nativebasket1', 'Cesta Nativa 1', 100, 1, 'item_standard', 1, 593, 1, '{}', '', 0.25),
	('nativebasket2', 'Cesta Nativa 2', 100, 1, 'item_standard', 1, 594, 1, '{}', '', 0.25),
	('nativedecor', 'Conjunto de decoração nativa', 100, 1, 'item_standard', 1, 584, 1, '{}', '', 0.25),
	('nativepot', 'panela nativa', 100, 1, 'item_standard', 1, 592, 1, '{}', '', 0.25),
	('nativeskull', 'Decoração nativa 1', 100, 1, 'item_standard', 1, 595, 1, '{}', '', 0.25),
	('naturalwagon', 'Conjunto de Vagões de Naturalistas', 100, 1, 'item_standard', 1, 605, 1, '{}', '', 0.25),
	('neckties', 'NeckTie', 20, 1, 'item_standard', 1, 17631, 1, '{}', 'nice item', 0.25),
	('neckwear', 'Neckwear', 20, 1, 'item_standard', 1, 17632, 1, '{}', 'nice item', 0.25),
	('NeedleandThread', 'Agulha e linha', 100, 1, 'item_standard', 1, 215786, 1, '{}', 'nice item', 0.25),
	('newspaper', 'Jornal', 100, 1, 'item_standard', 1, 218, 1, '{}', '', 0.25),
	('nightstand', 'Criado-mudo', 100, 1, 'item_standard', 1, 653, 1, '{}', '', 0.25),
	('nitroglyserolia', 'Nitroglycerol', 100, 1, 'item_standard', 1, 220, 1, '{}', '', 0.25),
	('nn1', 'Colar 1', 100, 1, 'item_standard', 1, 1250, 1, '{}', 'nice item', 0.25),
	('nn10', 'Colar 10', 100, 1, 'item_standard', 1, 1251, 1, '{}', 'nice item', 0.25),
	('nn11', 'Colar 11', 100, 1, 'item_standard', 1, 1252, 1, '{}', 'nice item', 0.25),
	('nn12', 'Colar 12', 100, 1, 'item_standard', 1, 1253, 1, '{}', 'nice item', 0.25),
	('nn13', 'Colar 13 Feminino', 100, 1, 'item_standard', 1, 1254, 1, '{}', 'nice item', 0.25),
	('nn14', 'Colar 14  Feminino', 100, 1, 'item_standard', 1, 1255, 1, '{}', 'nice item', 0.25),
	('nn15', 'Colar 15 Feminino', 100, 1, 'item_standard', 1, 1256, 1, '{}', 'nice item', 0.25),
	('nn16', 'Colar 16 Feminino', 100, 1, 'item_standard', 1, 1257, 1, '{}', 'nice item', 0.25),
	('nn17', 'Colar 17 Feminino', 100, 1, 'item_standard', 1, 1258, 1, '{}', 'nice item', 0.25),
	('nn18', 'Colar 18 Feminino', 100, 1, 'item_standard', 1, 1259, 1, '{}', 'nice item', 0.25),
	('nn19', 'Colar 19 Femino', 100, 1, 'item_standard', 1, 1260, 1, '{}', 'nice item', 0.25),
	('nn2', 'Colar 2', 100, 1, 'item_standard', 1, 1261, 1, '{}', 'nice item', 0.25),
	('nn20', 'Colar 20 Feminino', 100, 1, 'item_standard', 1, 1262, 1, '{}', 'nice item', 0.25),
	('nn21', 'Colar 21 Feminino', 100, 1, 'item_standard', 1, 1263, 1, '{}', 'nice item', 0.25),
	('nn22', 'Colar 22 Feminino', 100, 1, 'item_standard', 1, 1264, 1, '{}', 'nice item', 0.25),
	('nn23', 'Colar 23 Feminino', 100, 1, 'item_standard', 1, 1265, 1, '{}', 'nice item', 0.25),
	('nn24', 'Colar 24 Feminino', 100, 1, 'item_standard', 1, 1266, 1, '{}', 'nice item', 0.25),
	('nn3', 'Colar 3', 100, 1, 'item_standard', 1, 1267, 1, '{}', 'nice item', 0.25),
	('nn4', 'Colar 4', 100, 1, 'item_standard', 1, 1268, 1, '{}', 'nice item', 0.25),
	('nn5', 'Colar 5', 100, 1, 'item_standard', 1, 1269, 1, '{}', 'nice item', 0.25),
	('nn6', 'Colar 6', 100, 1, 'item_standard', 1, 1270, 1, '{}', 'nice item', 0.25),
	('nn7', 'Colar 7', 100, 1, 'item_standard', 1, 1271, 1, '{}', 'nice item', 0.25),
	('nn8', 'Colar 8', 100, 1, 'item_standard', 1, 1272, 1, '{}', 'nice item', 0.25),
	('nn9', 'Colar 9', 100, 1, 'item_standard', 1, 1273, 1, '{}', 'nice item', 0.25),
	('normaltable', 'Mesa', 100, 1, 'item_standard', 1, 750, 1, '{}', '', 0.25),
	('notebook', 'planilia', 100, 1, 'item_standard', 1, 221, 1, '{}', '', 0.25),
	('notepad', 'Bloco de anotações', 100, 1, 'item_standard', 1, 16966, 1, '{}', '', 0.25),
	('ns1', 'Escudo 1', 100, 1, 'item_standard', 1, 215835, 1, '{}', 'nice item', 0.25),
	('ns10', 'Escudo 10', 100, 1, 'item_standard', 1, 215844, 1, '{}', 'nice item', 0.25),
	('ns11', 'Escudo 11', 100, 1, 'item_standard', 1, 215845, 1, '{}', 'nice item', 0.25),
	('ns12', 'Escudo 12', 100, 1, 'item_standard', 1, 215846, 1, '{}', 'nice item', 0.25),
	('ns13', 'Escudo 13', 100, 1, 'item_standard', 1, 215847, 1, '{}', 'nice item', 0.25),
	('ns14', 'Escudo 14', 100, 1, 'item_standard', 1, 215848, 1, '{}', 'nice item', 0.25),
	('ns2', 'Escudo 2', 100, 1, 'item_standard', 1, 215836, 1, '{}', 'nice item', 0.25),
	('ns3', 'Escudo 3', 100, 1, 'item_standard', 1, 215837, 1, '{}', 'nice item', 0.25),
	('ns4', 'Escudo 4', 100, 1, 'item_standard', 1, 215838, 1, '{}', 'nice item', 0.25),
	('ns5', 'Escudo 5', 100, 1, 'item_standard', 1, 215839, 1, '{}', 'nice item', 0.25),
	('ns6', 'Escudo 6', 100, 1, 'item_standard', 1, 215840, 1, '{}', 'nice item', 0.25),
	('ns7', 'Escudo 7', 100, 1, 'item_standard', 1, 215841, 1, '{}', 'nice item', 0.25),
	('ns8', 'Escudo 8 ', 100, 1, 'item_standard', 1, 215842, 1, '{}', 'nice item', 0.25),
	('ns9', 'Escudo 9', 100, 1, 'item_standard', 1, 215843, 1, '{}', 'nice item', 0.25),
	('obed', 'cama velha', 100, 1, 'item_standard', 1, 664, 1, '{}', '', 0.25),
	('oil_lantern', 'Lanterna a óleo', 100, 1, 'item_standard', 1, 1672, 1, '{}', '', 0.25),
	('oldwatch', 'Relogio Antigo', 100, 1, 'item_standard', 1, 215661, 1, '{}', 'nice item', 0.25),
	('Oleander_Sage', 'Sálvia Oleandro', 100, 1, 'item_standard', 1, 222, 1, '{}', '', 0.25),
	('Oleander_Sage_Seed', 'Semente de Sálvia Oleandro', 100, 1, 'item_standard', 1, 223, 1, '{}', '', 0.25),
	('oleo', 'azeite ', 100, 1, 'item_standard', 1, 16799, 1, '{}', '', 0.25),
	('oliva', 'oliva', 100, 1, 'item_standard', 1, 16798, 1, '{}', '', 0.25),
	('oliveira', 'oliveira ', 100, 1, 'item_standard', 1, 16797, 1, '{}', '', 0.25),
	('oliveira_seed', 'semente de oliva ', 100, 1, 'item_standard', 1, 17110, 1, '{}', '', 0.25),
	('Onion', 'Oregano', 100, 1, 'item_standard', 1, 215817, 1, '{}', 'nice item', 0.25),
	('Onion_Seed', 'Semente de Oregano', 100, 1, 'item_standard', 1, 215803, 1, '{}', 'nice item', 0.25),
	('opium', 'Opium', 100, 1, 'item_standard', 1, 170518, 1, '{}', 'nice item', 0.25),
	('opiumseed', 'Semente de Opium', 100, 1, 'item_standard', 1, 215799, 1, '{}', 'nice item', 0.25),
	('opossumc', 'garras de gambá', 100, 1, 'item_standard', 1, 515, 1, '{}', '', 0.25),
	('opossums', 'pele de gambá', 100, 1, 'item_standard', 1, 514, 1, '{}', '', 0.25),
	('orden_presidente', 'ordem do presidente', 100, 1, 'item_standard', 1, 224, 1, '{}', '', 0.25),
	('Oregano', 'Orégano', 100, 1, 'item_standard', 1, 225, 1, '{}', '', 0.25),
	('Oregano_Seed', 'semente de orégano', 100, 1, 'item_standard', 1, 226, 1, '{}', '', 0.25),
	('oriole2_c', 'papa-figo encapuzado', 100, 1, 'item_standard', 1, 430, 1, '{}', '', 0.25),
	('oriole_c', 'Oriole', 100, 1, 'item_standard', 1, 429, 1, '{}', '', 0.25),
	('orleanderseed', 'Orleander seed', 50, 1, 'item_standard', 1, 17693, 1, '{}', 'an item', 0.25),
	('ossos_comun', 'osso comum', 100, 1, 'item_standard', 1, 17288, 1, '{}', 'nice item', 0.25),
	('ossos_horse', 'osso de cavalo', 100, 1, 'item_standard', 1, 17287, 1, '{}', 'nice item', 0.25),
	('ouro100', 'Vale 100 Gold', 5, 1, 'item_standard', 1, 1033, 1, '{}', 'nice item', 0.25),
	('ouro200', 'Vale 200 Gold', 5, 1, 'item_standard', 1, 1034, 1, '{}', 'nice item', 0.25),
	('ouro50', 'Vale 50 Gold', 5, 1, 'item_standard', 1, 1032, 1, '{}', 'nice item', 0.25),
	('ouro500', 'Vale 500 Gold', 5, 1, 'item_standard', 1, 1035, 1, '{}', 'nice item', 0.25),
	('ouromil', 'Vale 1000 Gold', 5, 1, 'item_standard', 1, 1036, 1, '{}', 'nice item', 0.25),
	('ovelhafood', 'Ração para Ovelhas', 100, 1, 'item_standard', 1, 98354, 1, '{}', 'nice item', 0.25),
	('owlf', 'pena de coruja', 100, 1, 'item_standard', 1, 539, 1, '{}', '', 0.25),
	('owlt', 'garras de coruja', 100, 1, 'item_standard', 1, 540, 1, '{}', '', 0.25),
	('oxhorn', 'chifre de touro angus', 100, 1, 'item_standard', 1, 545, 1, '{}', '', 0.25),
	('oxs', 'pele de touro angus', 100, 1, 'item_standard', 1, 546, 1, '{}', '', 0.25),
	('pac_eau', 'pac_eau', 100, 1, 'item_standard', 1, 215771, 1, '{}', 'nice item', 0.25),
	('panela', 'panela', 1, 1, 'item_standard', 1, 17256, 1, '{}', 'nice item', 0.25),
	('panthere', 'olhos de pantera', 100, 1, 'item_standard', 1, 564, 1, '{}', '', 0.25),
	('panthers', 'pele de pantera', 100, 1, 'item_standard', 1, 563, 1, '{}', '', 0.25),
	('pants', 'Pants', 20, 1, 'item_standard', 1, 17604, 1, '{}', 'nice item', 0.25),
	('paobatata', 'Pao de Batata', 100, 1, 'item_standard', 1, 170478, 1, '{}', 'nice item', 0.25),
	('paomel', 'Pao de Mel', 100, 1, 'item_standard', 1, 170483, 1, '{}', 'nice item', 0.25),
	('paomilhomel', 'Pão de Milho com Mel', 100, 1, 'item_standard', 1, 170476, 1, '{}', 'nice item', 0.25),
	('paoquebacon', 'Pao de milho queijo e bacon', 100, 1, 'item_standard', 1, 170479, 1, '{}', 'nice item', 0.25),
	('paper', 'Papel', 100, 1, 'item_standard', 1, 227, 1, '{}', '', 0.25),
	('papersign', 'Papel Assinado', 100, 1, 'item_standard', 1, 215811, 1, '{}', 'nice item', 0.25),
	('papoula', 'Papoula', 100, 1, 'item_standard', 1, 215827, 1, '{}', 'nice item', 0.25),
	('paquet_biscuit', 'paquet_biscuit', 100, 1, 'item_standard', 1, 215773, 1, '{}', 'nice item', 0.25),
	('paquet_cigarette', 'paquet_cigarette', 100, 1, 'item_standard', 1, 215774, 1, '{}', 'nice item', 0.25),
	('paquet_clou', 'paquet_clou', 100, 1, 'item_standard', 1, 215772, 1, '{}', 'nice item', 0.25),
	('parasol', 'sombrinha', 100, 1, 'item_standard', 1, 343, 1, '{}', '', 0.25),
	('Parasol_Mushroom', 'cogumelo guarda-sol', 100, 1, 'item_standard', 1, 228, 1, '{}', '', 0.25),
	('Parasol_Mushroom_Seed', 'Semente de Cogumelo Parasol', 100, 1, 'item_standard', 1, 229, 1, '{}', '', 0.25),
	('peachseeds', 'semente de pera', 100, 1, 'item_standard', 1, 735, 1, '{}', '', 0.25),
	('pearl', 'Pérola', 100, 1, 'item_standard', 1, 1670, 1, '{}', '', 0.25),
	('peasantb', 'bico de camponês', 100, 1, 'item_standard', 1, 518, 1, '{}', '', 0.25),
	('peasantf', 'pena camponesa', 100, 1, 'item_standard', 1, 517, 1, '{}', '', 0.25),
	('pecaris', 'pecaris', 100, 1, 'item_standard', 1, 550, 1, '{}', '', 0.25),
	('pelicanb', 'bico de pelicano', 100, 1, 'item_standard', 1, 520, 1, '{}', '', 0.25),
	('pelicanf', 'pena de pelicano', 100, 1, 'item_standard', 1, 519, 1, '{}', '', 0.25),
	('pelle', 'pá de corte', 100, 1, 'item_standard', 1, 16733, 1, '{}', '', 0.25),
	('pen', 'Caneta', 100, 1, 'item_standard', 1, 896, 1, '{}', '', 0.25),
	('Pepper', 'Pimenta', 100, 1, 'item_standard', 1, 215818, 1, '{}', 'nice item', 0.25),
	('Pepper_Seed', 'Semente de Pimentão', 100, 1, 'item_standard', 1, 215798, 1, '{}', 'nice item', 0.25),
	('pequenino', 'Formula para encolher', 5, 1, 'item_standard', 1, 215671, 1, '{}', 'nice item', 0.25),
	('pera', 'pera', 100, 1, 'item_standard', 1, 17116, 1, '{}', '', 0.25),
	('pera_seed', 'semente de pera ', 100, 1, 'item_standard', 1, 17111, 1, '{}', '', 0.25),
	('peyote', 'algo estranho', 100, 1, 'item_standard', 1, 16889, 1, '{}', '', 0.25),
	('pheasant_taxidermy', 'Faisão Taxidermia', 100, 1, 'item_standard', 1, 641, 1, '{}', '', 0.25),
	('phestaxi', 'Faisão Taxidermia', 100, 1, 'item_standard', 1, 769, 1, '{}', '', 0.25),
	('pickaxe', 'picareta', 100, 1, 'item_standard', 1, 230, 1, '{}', '', 0.25),
	('pigcrap', 'Pig Crap', 50, 1, 'item_standard', 1, 17685, 1, '{}', 'an item', 0.25),
	('pigeon_c', 'Pombo', 100, 1, 'item_standard', 1, 431, 1, '{}', '', 0.25),
	('pigs', 'pele de porco', 100, 1, 'item_standard', 1, 516, 1, '{}', '', 0.25),
	('pimenta', 'Pimenta', 100, 1, 'item_standard', 1, 215821, 1, '{}', 'nice item', 0.25),
	('pimentao', 'Pimentão', 100, 1, 'item_standard', 1, 215819, 1, '{}', 'nice item', 0.25),
	('pimentao_Seed', 'Semente de Pimentão', 100, 1, 'item_standard', 1, 215807, 1, '{}', 'nice item', 0.25),
	('pimenta_Seed', 'Semente de Pimenta', 100, 1, 'item_standard', 1, 215794, 1, '{}', 'nice item', 0.25),
	('pipe', 'Cachimbo', 1, 1, 'item_standard', 1, 231, 1, '{}', '', 0.25),
	('pipecopper', 'Tubo de cobre', 100, 1, 'item_standard', 1, 835, 1, '{}', '', 0.25),
	('pipe_smoker', 'Cachimbo', 100, 1, 'item_standard', 1, 215626, 1, '{}', 'To smoke with class', 0.25),
	('piratecoin', 'Moeda de Pirata', 100, 1, 'item_standard', 1, 215662, 1, '{}', 'nice item', 0.25),
	('pistolbarrel', 'cano de pistola', 100, 1, 'item_standard', 1, 17157, 1, '{}', '', 0.25),
	('pistolgrip', 'cabo de pistola', 100, 1, 'item_standard', 1, 17158, 1, '{}', '', 0.25),
	('pistolmold', 'molde de pistola', 100, 1, 'item_standard', 1, 17159, 1, '{}', '', 0.25),
	('pistolreceiver', 'carregador de pistola', 100, 1, 'item_standard', 1, 17160, 1, '{}', '', 0.25),
	('planttrimmer', 'tesoura de poda', 100, 1, 'item_standard', 1, 678, 1, '{}', '', 0.25),
	('planttrimmer2', 'Aparador de plantas', 100, 1, 'item_standard', 1, 16710, 1, '{}', '', 0.25),
	('plastico', 'Plastico', 10, 1, 'item_standard', 1, 170500, 1, '{}', 'nice item', 0.25),
	('pocket_compass', 'Bussula', 100, 1, 'item_standard', 1, 17292, 1, '{}', 'nice item', 0.25),
	('pocket_watch', 'relogio de bolso', 2, 1, 'item_standard', 1, 232, 1, '{}', '', 0.25),
	('poisonheal', 'Poção da vida', 100, 1, 'item_standard', 1, 215833, 1, '{}', 'nice item', 0.25),
	('pokerset', 'Conjunto de mesa de pôquer', 100, 1, 'item_standard', 1, 579, 1, '{}', '', 0.25),
	('polvora', 'polvora', 100, 1, 'item_standard', 1, 17162, 1, '{}', '', 0.25),
	('pomade', 'pomada para cabelo', 100, 1, 'item_standard', 1, 16980, 1, '{}', '', 0.25),
	('ponchos', 'Poncho', 20, 1, 'item_standard', 1, 17626, 1, '{}', 'nice item', 0.25),
	('porcofood', 'Ração para Porcos', 100, 1, 'item_standard', 1, 98352, 1, '{}', 'nice item', 0.25),
	('pork', 'Carne de porco', 100, 1, 'item_standard', 1, 571, 1, '{}', '', 0.25),
	('porkfat', 'gordura de porco', 100, 1, 'item_standard', 1, 458, 1, '{}', '', 0.25),
	('portable_canoe', 'Canoa Portátil', 100, 1, 'item_standard', 1, 16878, 1, '{}', '', 0.25),
	('pot', 'pote de destilaria', 100, 1, 'item_standard', 1, 836, 1, '{}', '', 0.25),
	('pota', 'panela de casa', 100, 1, 'item_standard', 1, 626, 1, '{}', '', 0.25),
	('potato', 'Potato', 100, 1, 'item_standard', 1, 233, 1, '{}', '', 0.25),
	('potatoseed', 'Batata Seed', 100, 1, 'item_standard', 1, 731, 1, '{}', '', 0.25),
	('Potato_Seed', 'Semente de Batata', 100, 1, 'item_standard', 1, 215806, 1, '{}', 'nice item', 0.25),
	('potion1', 'Poção do Lobo', 100, 1, 'item_standard', 1, 215764, 1, '{}', 'nice item', 0.25),
	('potion10', 'Poção do Rato', 100, 1, 'item_standard', 1, 215778, 1, '{}', 'nice item', 0.25),
	('potion2', 'Poção da Pantera', 100, 1, 'item_standard', 1, 215783, 1, '{}', 'nice item', 0.25),
	('potion3', 'Poção do Pato', 100, 1, 'item_standard', 1, 215782, 1, '{}', 'nice item', 0.25),
	('potion4', 'Poção da Rapoza', 100, 1, 'item_standard', 1, 215781, 1, '{}', 'nice item', 0.25),
	('potion5', 'Poção da Coruja', 100, 1, 'item_standard', 1, 215780, 1, '{}', 'nice item', 0.25),
	('potion55', 'Poção de Vampiro', 100, 1, 'item_standard', 1, 215834, 1, '{}', 'nice item', 0.25),
	('potion6', 'Poção do Urso', 100, 1, 'item_standard', 1, 215779, 1, '{}', 'nice item', 0.25),
	('potiontransformation', 'Poção de transformação', 100, 1, 'item_standard', 1, 17176, 1, '{}', '', 0.25),
	('po_de_cafe', 'po de cafe ', 100, 1, 'item_standard', 1, 17221, 1, '{}', '', 0.25),
	('prairib', 'Bico De Frango Da Pradaria', 100, 1, 'item_standard', 1, 509, 1, '{}', '', 0.25),
	('Prairie_Poppy', 'oliva', 100, 1, 'item_standard', 1, 234, 1, '{}', '', 0.25),
	('Prairie_Poppy_Seed', 'semente de papoula da pradaria', 100, 1, 'item_standard', 1, 235, 1, '{}', '', 0.25),
	('prairif', 'Pena de Frango da Pradaria', 100, 1, 'item_standard', 1, 508, 1, '{}', '', 0.25),
	('printphoto', 'Foto de Bolso', 10, 1, 'item_standard', 1, 215655, 1, '{}', 'Identity photo', 0.25),
	('prison_clothes', 'roupa de prisão', 100, 1, 'item_standard', 1, 17294, 1, '{}', 'nice item', 0.25),
	('pronghornh', 'Chifre Pronghorn', 100, 1, 'item_standard', 1, 511, 1, '{}', '', 0.25),
	('prongs', 'Pele Pronghorn', 100, 1, 'item_standard', 1, 510, 1, '{}', '', 0.25),
	('provision_arrowhead_agate', 'ponta de flecha ágata', 100, 1, 'item_standard', 1, 16720, 1, '{}', '', 0.25),
	('provision_arrowhead_crude', 'ponta de flecha bruta', 100, 1, 'item_standard', 1, 1675, 1, '{}', '', 0.25),
	('provision_arrowhead_feldspar', 'ponta de flecha de feldspato', 100, 1, 'item_standard', 1, 1676, 1, '{}', '', 0.25),
	('provision_boar_skin', 'pele de javali', 100, 1, 'item_standard', 1, 17193, 1, '{}', '', 0.25),
	('provision_bracelet_gold', 'Pulseira de ouro', 100, 1, 'item_standard', 1, 1685, 1, '{}', '', 0.25),
	('provision_bracelet_platinum', 'pulseira de platina', 100, 1, 'item_standard', 1, 1686, 1, '{}', '', 0.25),
	('provision_bracelet_silver', 'Bracelete de prata', 100, 1, 'item_standard', 1, 1687, 1, '{}', '', 0.25),
	('provision_bra_shield', 'escudo de latão', 100, 1, 'item_standard', 1, 1688, 1, '{}', '', 0.25),
	('provision_buckle_gold', 'fivela de ouro', 100, 1, 'item_standard', 1, 1689, 1, '{}', '', 0.25),
	('provision_buckle_platinum', 'fivela de platina', 100, 1, 'item_standard', 1, 1690, 1, '{}', '', 0.25),
	('provision_buckle_silver', 'fivela de prata', 100, 1, 'item_standard', 1, 1691, 1, '{}', '', 0.25),
	('provision_calderon_cross', 'Cruz de madeira', 100, 1, 'item_standard', 1, 1692, 1, '{}', '', 0.25),
	('provision_capitale', 'Capital', 100, 1, 'item_standard', 1, 1693, 1, '{}', '', 0.25),
	('provision_coal', 'minerio de carvão', 100, 1, 'item_standard', 1, 16996, 1, '{}', '', 0.25),
	('provision_coin_1700_ny_tkn', '1700 Token de Nova York', 100, 1, 'item_standard', 1, 1694, 1, '{}', '', 0.25),
	('provision_coin_1787_cent_tkn', '1787 Token de um centavo', 100, 1, 'item_standard', 1, 1695, 1, '{}', '', 0.25),
	('provision_coin_1789_pny', '1789 Penny', 100, 1, 'item_standard', 1, 1696, 1, '{}', '', 0.25),
	('provision_coin_1792_lib_qtr', 'Bairro da Liberdade de 1792', 100, 1, 'item_standard', 1, 1697, 1, '{}', '', 0.25),
	('provision_coin_1792_nickel', '1792 níquel', 100, 1, 'item_standard', 1, 1698, 1, '{}', '', 0.25),
	('provision_coin_1792_qtr', '1792 trimestre', 100, 1, 'item_standard', 1, 1699, 1, '{}', '', 0.25),
	('provision_coin_1794_slv_dlr', 'Dólar de Prata de 1794', 100, 1, 'item_standard', 1, 1700, 1, '{}', '', 0.25),
	('provision_coin_1795_hlf_eag', '1795 meia águia', 100, 1, 'item_standard', 1, 1701, 1, '{}', '', 0.25),
	('provision_coin_1796_hlf_pny', '1796 meio centavo', 100, 1, 'item_standard', 1, 1702, 1, '{}', '', 0.25),
	('provision_coin_1797_gld_eag', '1797 Águia Dourada', 100, 1, 'item_standard', 1, 1703, 1, '{}', '', 0.25),
	('provision_coin_1798_slv_dlr', 'Dólar de Prata de 1798', 100, 1, 'item_standard', 1, 1704, 1, '{}', '', 0.25),
	('provision_coin_1800_five_dlr', '1800 cinco dólares', 100, 1, 'item_standard', 1, 1705, 1, '{}', '', 0.25),
	('provision_coin_1800_gld_dlr', '1800 dólares de ouro', 100, 1, 'item_standard', 1, 1706, 1, '{}', '', 0.25),
	('provision_coin_1800_gld_qtr', 'Quarto de ouro de 1800', 100, 1, 'item_standard', 1, 1707, 1, '{}', '', 0.25),
	('provision_coin_1800_hlf_dime', '1800 Meia Moeda', 100, 1, 'item_standard', 1, 1708, 1, '{}', '', 0.25),
	('provision_db_finger_bone', 'Osso', 100, 1, 'item_standard', 1, 1709, 1, '{}', '', 0.25),
	('provision_diamond_ring', 'Anel de diamante', 100, 1, 'item_standard', 1, 1710, 1, '{}', '', 0.25),
	('provision_disco_ammolite', 'amolita', 100, 1, 'item_standard', 1, 1711, 1, '{}', '', 0.25),
	('provision_disco_ancient_eagle', 'Águia Antiga', 100, 1, 'item_standard', 1, 1712, 1, '{}', '', 0.25),
	('provision_disco_ancient_necklace', 'colar antigo', 100, 1, 'item_standard', 1, 1713, 1, '{}', '', 0.25),
	('provision_disco_fertility_statue', 'Estátua da Fertilidade', 100, 1, 'item_standard', 1, 1714, 1, '{}', '', 0.25),
	('provision_disco_fluorite', 'fluorita', 100, 1, 'item_standard', 1, 1715, 1, '{}', '', 0.25),
	('provision_disco_shrunken_head', 'Cabeça encolhida', 100, 1, 'item_standard', 1, 1716, 1, '{}', '', 0.25),
	('provision_disco_urn', 'Urn', 100, 1, 'item_standard', 1, 1717, 1, '{}', '', 0.25),
	('provision_disco_viking_comb', 'pente viking', 100, 1, 'item_standard', 1, 1718, 1, '{}', '', 0.25),
	('provision_dog_tag', 'Dog Tag', 100, 1, 'item_standard', 1, 1719, 1, '{}', '', 0.25),
	('provision_earring_gold', 'brinco de ouro', 100, 1, 'item_standard', 1, 1720, 1, '{}', '', 0.25),
	('provision_earring_pearl', 'brinco de pérola', 100, 1, 'item_standard', 1, 1721, 1, '{}', '', 0.25),
	('provision_earring_platinum', 'brinco de platina', 100, 1, 'item_standard', 1, 1722, 1, '{}', '', 0.25),
	('provision_earring_silver', 'brinco de prata', 100, 1, 'item_standard', 1, 1723, 1, '{}', '', 0.25),
	('provision_generic_key', 'Chave', 100, 1, 'item_standard', 1, 1724, 1, '{}', '', 0.25),
	('provision_hrlm_brush_boar', 'escova de cerdas de javali', 100, 1, 'item_standard', 1, 1725, 1, '{}', '', 0.25),
	('provision_hrlm_brush_ebony', 'escova de cabelo de ébano', 100, 1, 'item_standard', 1, 1726, 1, '{}', '', 0.25),
	('provision_hrlm_brush_goathair', 'Escova de Pelo de Cabra', 100, 1, 'item_standard', 1, 1727, 1, '{}', '', 0.25),
	('provision_hrlm_brush_horsehair', 'escova de cavalo', 100, 1, 'item_standard', 1, 1728, 1, '{}', '', 0.25),
	('provision_hrlm_brush_rosewood', 'jacarandá', 100, 1, 'item_standard', 1, 1729, 1, '{}', '', 0.25),
	('provision_hrlm_brush_rosewood_ng', 'Escova de cabelo de jacarandá da Nova Guiné', 100, 1, 'item_standard', 1, 1730, 1, '{}', '', 0.25),
	('provision_hrlm_comb_boxwood', 'pente de buxo', 100, 1, 'item_standard', 1, 1731, 1, '{}', '', 0.25),
	('provision_hrlm_comb_cherrywood', 'pente cerejeira', 100, 1, 'item_standard', 1, 1732, 1, '{}', '', 0.25),
	('provision_hrlm_comb_ivory', 'pente de marfim', 100, 1, 'item_standard', 1, 1733, 1, '{}', '', 0.25),
	('provision_hrlm_comb_tortoiseshell', 'pente de tartaruga', 100, 1, 'item_standard', 1, 1734, 1, '{}', '', 0.25),
	('provision_hrlm_hairpin_ebony', 'grampo de cabelo de ébano', 100, 1, 'item_standard', 1, 1735, 1, '{}', '', 0.25),
	('provision_hrlm_hairpin_ivory', 'grampo de marfim', 100, 1, 'item_standard', 1, 1736, 1, '{}', '', 0.25),
	('provision_hrlm_hairpin_jade', 'Jade Hairpin', 100, 1, 'item_standard', 1, 1737, 1, '{}', '', 0.25),
	('provision_hrlm_hairpin_metal', 'Gancho de metal', 100, 1, 'item_standard', 1, 1738, 1, '{}', '', 0.25),
	('provision_hrlm_hairpin_wooden', 'Grampo de cabelo de madeira', 100, 1, 'item_standard', 1, 1739, 1, '{}', '', 0.25),
	('provision_jail_keys', 'Chaves da Prisão', 100, 1, 'item_standard', 1, 236, 1, '{}', '', 0.25),
	('provision_jewelry_amethyst_necklace', 'Colar Richelieu Ametista', 100, 1, 'item_standard', 1, 1740, 1, '{}', '', 0.25),
	('provision_jewelry_blck_pearl_necklace', 'Colar de Pérolas Tuamotu', 100, 1, 'item_standard', 1, 1741, 1, '{}', '', 0.25),
	('provision_jewelry_box', 'Caixa de jóias', 100, 1, 'item_standard', 1, 1742, 1, '{}', '', 0.25),
	('provision_jewelry_carved_bracelet', 'Pulseira esculpida Elliston', 100, 1, 'item_standard', 1, 1743, 1, '{}', '', 0.25),
	('provision_jewelry_coral_dngl_earring', 'Brincos Emmeline Coral', 100, 1, 'item_standard', 1, 1744, 1, '{}', '', 0.25),
	('provision_jewelry_coral_ring', 'anel de coral Harland', 100, 1, 'item_standard', 1, 1745, 1, '{}', '', 0.25),
	('provision_jewelry_dmnd_bngle_bracelet', 'Pulseira de rubi Abelló', 100, 1, 'item_standard', 1, 1746, 1, '{}', '', 0.25),
	('provision_jewelry_dmnd_pendt_earring', 'Brincos de diamante Orchidée', 100, 1, 'item_standard', 1, 1747, 1, '{}', '', 0.25),
	('provision_jewelry_elk_tooth_earring', 'Brincos de dente de lei', 100, 1, 'item_standard', 1, 1748, 1, '{}', '', 0.25),
	('provision_jewelry_emerald_earring', 'Brincos Duquesa Esmeralda', 100, 1, 'item_standard', 1, 1749, 1, '{}', '', 0.25),
	('provision_jewelry_emerald_ring', 'Bosque anel de esmeralda', 100, 1, 'item_standard', 1, 1750, 1, '{}', '', 0.25),
	('provision_jewelry_french_dmnd_ring', 'Anel de Diamante Beaulieux', 100, 1, 'item_standard', 1, 1751, 1, '{}', '', 0.25),
	('provision_jewelry_gld_bngle_bracelet', 'Pulseira Ojeda Ouro Rosa', 100, 1, 'item_standard', 1, 1752, 1, '{}', '', 0.25),
	('provision_jewelry_gld_cross_necklace', 'Colar Cruz Ainsworth', 100, 1, 'item_standard', 1, 1753, 1, '{}', '', 0.25),
	('provision_jewelry_gld_pearl_necklace', 'Colar de Pérolas Rou', 100, 1, 'item_standard', 1, 1754, 1, '{}', '', 0.25),
	('provision_jewelry_gld_pendt_necklace', 'Colar Gosselin Ouro Branco', 100, 1, 'item_standard', 1, 1755, 1, '{}', '', 0.25),
	('provision_jewelry_grnet_bracelet', 'Pulseira Dawn Garnet', 100, 1, 'item_standard', 1, 1756, 1, '{}', '', 0.25),
	('provision_jewelry_grnet_post_earring', 'Brincos Harford Garnet', 100, 1, 'item_standard', 1, 1757, 1, '{}', '', 0.25),
	('provision_jewelry_moon_ring', 'Anel de Pedra da Lua do Peregrino', 100, 1, 'item_standard', 1, 1758, 1, '{}', '', 0.25),
	('provision_jewelry_mthr_pearl_necklace', 'Colar de Pérolas Pellé', 100, 1, 'item_standard', 1, 1759, 1, '{}', '', 0.25),
	('provision_jewelry_onyx_ring', 'Anel de ônix Aubrey', 100, 1, 'item_standard', 1, 1760, 1, '{}', '', 0.25),
	('provision_jewelry_pearl_bracelet', 'Pulseira Durant Pearl', 100, 1, 'item_standard', 1, 1761, 1, '{}', '', 0.25),
	('provision_jewelry_pearl_earring', 'Brincos de pérola Josephine', 100, 1, 'item_standard', 1, 1762, 1, '{}', '', 0.25),
	('provision_jewelry_pearl_ring', 'Anel de Pérola Bonnard', 100, 1, 'item_standard', 1, 1763, 1, '{}', '', 0.25),
	('provision_jewelry_pers_turq_ring', 'Anel Turquesa Thorburn', 100, 1, 'item_standard', 1, 1764, 1, '{}', '', 0.25),
	('provision_jewelry_porcelain_necklace', 'Colar de Ametista Braxton', 100, 1, 'item_standard', 1, 1765, 1, '{}', '', 0.25),
	('provision_jewelry_qn_dmnd_earring', 'Brincos de diamante Royal Victoria', 100, 1, 'item_standard', 1, 1766, 1, '{}', '', 0.25),
	('provision_jewelry_rudy_dngl_earring', 'Brincos de Rubi Beauchêne', 100, 1, 'item_standard', 1, 1767, 1, '{}', '', 0.25),
	('provision_jewelry_slvr_pearl_necklace', 'colar de pérolas de prata', 100, 1, 'item_standard', 1, 1768, 1, '{}', '', 0.25),
	('provision_jewelry_sphr_bngle_bracelet', 'Pulseira Greco Safira', 100, 1, 'item_standard', 1, 1769, 1, '{}', '', 0.25),
	('provision_jewelry_sphr_bracelet', 'Helena Sapphire Bracelet', 100, 1, 'item_standard', 1, 1770, 1, '{}', '', 0.25),
	('provision_jewelry_topaz_necklace', 'colar topázio dinamarquês', 100, 1, 'item_standard', 1, 1771, 1, '{}', '', 0.25),
	('provision_jewelry_topaz_ring', 'Banais Topaz Ring', 100, 1, 'item_standard', 1, 1772, 1, '{}', '', 0.25),
	('provision_jewelry_turquoise_bracelet', 'Infanta Turquoise Bracelet', 100, 1, 'item_standard', 1, 1773, 1, '{}', '', 0.25),
	('provision_jewelry_turquoise_ring', 'Anel Magnata Turquesa', 100, 1, 'item_standard', 1, 1774, 1, '{}', '', 0.25),
	('provision_jewelry_turq_stud_earring', 'Brincos Calumet Turquesa', 100, 1, 'item_standard', 1, 1775, 1, '{}', '', 0.25),
	('provision_jewelry_whtgld_dmnd_ring', 'Sackville anel de diamante', 100, 1, 'item_standard', 1, 1776, 1, '{}', '', 0.25),
	('provision_jewelry_wht_dmnd_earring', 'Brincos Endicott Diamante', 100, 1, 'item_standard', 1, 1777, 1, '{}', '', 0.25),
	('provision_jewelry_ylwgld_dmnd_ring', 'anel de diamante Yates', 100, 1, 'item_standard', 1, 1778, 1, '{}', '', 0.25),
	('provision_meat_prime_beef', 'carne ', 100, 1, 'item_standard', 1, 17142, 1, '{}', '', 0.25),
	('provision_ring_platinum', 'anel de platina', 100, 1, 'item_standard', 1, 1779, 1, '{}', '', 0.25),
	('provision_ro_flower_acunas_star', 'Orquídea Estrela Acunas', 100, 1, 'item_standard', 1, 1780, 1, '{}', '', 0.25),
	('provision_ro_flower_cigar', 'orquídea charuto', 100, 1, 'item_standard', 1, 1781, 1, '{}', '', 0.25),
	('provision_ro_flower_clamshell', 'Orquídea Clamshell', 100, 1, 'item_standard', 1, 1782, 1, '{}', '', 0.25),
	('provision_ro_flower_dragons', 'dragão orquídea', 100, 1, 'item_standard', 1, 1783, 1, '{}', '', 0.25),
	('provision_ro_flower_ghost', 'orquídea fantasma', 100, 1, 'item_standard', 1, 1784, 1, '{}', '', 0.25),
	('provision_ro_flower_lady_of_night', 'Dama da Noite Orquídea', 100, 1, 'item_standard', 1, 1785, 1, '{}', '', 0.25),
	('provision_ro_flower_lady_slipper', 'Senhora sapatinho orquídea', 100, 1, 'item_standard', 1, 1786, 1, '{}', '', 0.25),
	('provision_ro_flower_moccasin', 'orquídea mocassim', 100, 1, 'item_standard', 1, 1787, 1, '{}', '', 0.25),
	('provision_ro_flower_night_scented', 'Orquídea Perfumada Noturna', 100, 1, 'item_standard', 1, 1788, 1, '{}', '', 0.25),
	('provision_ro_flower_queens', 'rainhas orquídea', 100, 1, 'item_standard', 1, 1789, 1, '{}', '', 0.25),
	('provision_ro_flower_rat_tail', 'orquídea rabo de rato', 100, 1, 'item_standard', 1, 1790, 1, '{}', '', 0.25),
	('provision_ro_flower_sparrows', 'Pardais Orquídea', 100, 1, 'item_standard', 1, 1791, 1, '{}', '', 0.25),
	('provision_ro_flower_spider', 'orquídea aranha', 100, 1, 'item_standard', 1, 1792, 1, '{}', '', 0.25),
	('provision_trinket_alligator_skin', 'pele de jacare', 100, 1, 'item_standard', 1, 16879, 1, '{}', '', 0.25),
	('provision_wedding_ring_male', 'Anel de Ouro', 100, 1, 'item_standard', 1, 170520, 1, '{}', 'nice item', 0.25),
	('pulp', 'Polpa', 100, 1, 'item_standard', 1, 237, 1, '{}', '', 0.25),
	('purse1', 'bolsa de mão 1', 10, 1, 'item_standard', 1, 909, 1, '{}', 'Pour rendre jalouse votre belle mère', 0.25),
	('purse2', 'bolsa de mão 2', 10, 1, 'item_standard', 1, 910, 1, '{}', 'Vos copines vous', 0.25),
	('purse3', 'bolsa de mão 3', 10, 1, 'item_standard', 1, 911, 1, '{}', 'Le tout dernier sac en vogue à StDenis', 0.25),
	('purse4', 'bolsa de mão 4', 10, 1, 'item_standard', 1, 920, 1, '{}', 'Pour les soirées entre cowgirls', 0.25),
	('p_baitBread01x', 'isca de pão', 100, 1, 'item_standard', 1, 838, 1, '{}', '', 0.25),
	('p_baitCheese01x', 'isca de queijo', 100, 1, 'item_standard', 1, 16748, 1, '{}', '', 0.25),
	('p_baitCorn01x', 'isca de milho', 100, 1, 'item_standard', 1, 16747, 1, '{}', '', 0.25),
	('p_baitCricket01x', 'isca de críquete', 100, 1, 'item_standard', 1, 16750, 1, '{}', '', 0.25),
	('p_baitWorm01x', 'isca de minhoca', 100, 1, 'item_standard', 1, 16749, 1, '{}', '', 0.25),
	('p_barrelmoonshine', 'Barril', 100, 1, 'item_standard', 1, 238, 1, '{}', '', 0.25),
	('p_copperpan02x', 'mesa cobre 2', 100, 1, 'item_standard', 1, 98692, 1, '{}', 'nice item', 0.25),
	('p_crawdad01x', 'isca de lagostim', 100, 1, 'item_standard', 1, 16751, 1, '{}', '', 0.25),
	('p_FinisdFishlure01x', 'isca de peixe', 100, 1, 'item_standard', 1, 16753, 1, '{}', '', 0.25),
	('p_finisdfishlurelegendary01x', 'Isca de Peixe Lendária', 100, 1, 'item_standard', 1, 16756, 1, '{}', '', 0.25),
	('p_finishdcrawd01x', 'isca lagosta', 100, 1, 'item_standard', 1, 16754, 1, '{}', '', 0.25),
	('p_finishdcrawdlegendary01x', 'Isca Lendária de Lagostim', 100, 1, 'item_standard', 1, 16757, 1, '{}', '', 0.25),
	('p_finishedragonfly01x', 'isca de libélula', 100, 1, 'item_standard', 1, 16752, 1, '{}', '', 0.25),
	('p_finishedragonflylegendary01x', 'Isca Lendária de Libélula', 100, 1, 'item_standard', 1, 16755, 1, '{}', '', 0.25),
	('p_goldcradlestand01x', 'mesa 1 ', 100, 1, 'item_standard', 1, 98691, 1, '{}', 'nice item', 0.25),
	('p_lgoc_spinner_v4', 'Spinner V4', 100, 1, 'item_standard', 1, 16758, 1, '{}', '', 0.25),
	('p_lgoc_spinner_v6', 'Spinner V6', 100, 1, 'item_standard', 1, 16759, 1, '{}', '', 0.25),
	('p_parasol02x', 'sombrinha 2 ', 1, 1, 'item_standard', 1, 17675, 1, '{}', 'nice item', 0.25),
	('p_pocketmirror01x', 'espelho de mão', 2, 1, 'item_standard', 1, 17298, 1, '{}', 'nice item', 0.25),
	('quailb', 'bico de codorna', 100, 1, 'item_standard', 1, 471, 1, '{}', '', 0.25),
	('quailf', 'pena de codorna', 100, 1, 'item_standard', 1, 470, 1, '{}', '', 0.25),
	('quartz', 'Quartzo', 100, 1, 'item_standard', 1, 239, 1, '{}', '', 0.25),
	('queijo', 'Queijo', 100, 1, 'item_standard', 1, 170511, 1, '{}', 'nice item', 0.25),
	('quimicos', 'Quimicos', 100, 1, 'item_standard', 1, 16939, 1, '{}', '', 0.25),
	('rabbitpaw', 'pé de coelho', 100, 1, 'item_standard', 1, 507, 1, '{}', '', 0.25),
	('rabbits', 'pele de coelho', 100, 1, 'item_standard', 1, 506, 1, '{}', '', 0.25),
	('raccoons', 'pele de guaxinim', 100, 1, 'item_standard', 1, 504, 1, '{}', '', 0.25),
	('raccoont', 'dente de guaxinim', 100, 1, 'item_standard', 1, 505, 1, '{}', '', 0.25),
	('raisin', 'passas', 100, 1, 'item_standard', 1, 1793, 1, '{}', '', 0.25),
	('rajahdysoljy', 'óleo explosivo', 100, 1, 'item_standard', 1, 240, 1, '{}', '', 0.25),
	('ramhorn', 'chifre de carneiro', 100, 1, 'item_standard', 1, 454, 1, '{}', '', 0.25),
	('rams', 'Ram Pelt', 100, 1, 'item_standard', 1, 455, 1, '{}', '', 0.25),
	('Rams_Head', 'cogumelo ostra', 100, 1, 'item_standard', 1, 241, 1, '{}', '', 0.25),
	('Rams_Head_Seed', 'Rams Head Seed', 100, 1, 'item_standard', 1, 242, 1, '{}', '', 0.25),
	('raspadinha', 'raspadinha', 5, 1, 'item_standard', 1, 17466, 1, '{}', 'nice item', 0.25),
	('Raspberries Shrub', 'Arbusto De Framboesa', 100, 1, 'item_standard', 1, 16884, 1, '{}', '', 0.25),
	('raspberryale', 'Framboesa', 100, 1, 'item_standard', 1, 243, 1, '{}', '', 0.25),
	('rat_c', 'Rato', 100, 1, 'item_standard', 1, 432, 1, '{}', '', 0.25),
	('ravenc', 'garras de corvo', 100, 1, 'item_standard', 1, 502, 1, '{}', '', 0.25),
	('ravenf', 'pena de corvo', 100, 1, 'item_standard', 1, 503, 1, '{}', '', 0.25),
	('rawpetrol', 'oil barril', 100, 1, 'item_standard', 1, 17293, 1, '{}', 'nice item', 0.25),
	('raw_bacon', 'bacon cru', 100, 1, 'item_standard', 1, 1794, 1, '{}', '', 0.25),
	('Receitas', 'Livro de Receitas', 100, 1, 'item_standard', 1, 17251, 1, '{}', 'nice item', 0.25),
	('rectable', 'Mesa Retangular', 100, 1, 'item_standard', 1, 751, 1, '{}', '', 0.25),
	('rectangle_table', 'Mesa Retangular', 100, 1, 'item_standard', 1, 623, 1, '{}', '', 0.25),
	('Red_Raspberry', 'Framboesa vermelha', 100, 1, 'item_standard', 1, 244, 1, '{}', '', 0.25),
	('Red_Raspberry_Seed', 'semente de framboesa', 100, 1, 'item_standard', 1, 245, 1, '{}', '', 0.25),
	('Red_Sage', 'Sálvia Vermelha', 100, 1, 'item_standard', 1, 246, 1, '{}', '', 0.25),
	('Red_Sage_Seed', 'Semente de Sálvia Vermelha', 100, 1, 'item_standard', 1, 247, 1, '{}', '', 0.25),
	('Relho', 'Relho para treino', 5, 1, 'item_standard', 1, 17097, 1, '{}', '', 0.25),
	('remediopet', 'Remedio de Pet', 100, 1, 'item_standard', 1, 215809, 1, '{}', 'nice item', 0.25),
	('Repair_Kit', 'Kit Reparo Carroça', 100, 1, 'item_standard', 1, 98686, 1, '{}', 'nice item', 0.25),
	('repeaterbarrel', 'cano de repetidor', 100, 1, 'item_standard', 1, 248, 1, '{}', '', 0.25),
	('repeatermold', 'Molde de Repetidor comum', 100, 1, 'item_standard', 1, 249, 1, '{}', '', 0.25),
	('repeaterreceiver', 'Receptor Repetidor', 100, 1, 'item_standard', 1, 250, 1, '{}', '', 0.25),
	('repeaterrecmold', 'Molde Receptor Repetidor ', 100, 1, 'item_standard', 1, 251, 1, '{}', '', 0.25),
	('repeaterstock', 'cabo de repetidor', 100, 1, 'item_standard', 1, 252, 1, '{}', '', 0.25),
	('Reseitas', 'livro de receitas', 100, 1, 'item_standard', 1, 17151, 1, '{}', '', 0.25),
	('revolverbarrel', 'cano do revólver', 100, 1, 'item_standard', 1, 253, 1, '{}', '', 0.25),
	('revolvercylinder', 'cilindro do revólver', 100, 1, 'item_standard', 1, 254, 1, '{}', '', 0.25),
	('revolverhandle', 'cabo de revólver', 100, 1, 'item_standard', 1, 255, 1, '{}', '', 0.25),
	('revolvermold', 'molde de revólver', 100, 1, 'item_standard', 1, 256, 1, '{}', '', 0.25),
	('rhum', 'rum', 100, 1, 'item_standard', 1, 17170, 1, '{}', '', 0.25),
	('riflebarrel', 'cano da rifle', 100, 1, 'item_standard', 1, 257, 1, '{}', '', 0.25),
	('riflemold', 'molde de rifle', 100, 1, 'item_standard', 1, 258, 1, '{}', '', 0.25),
	('riflereceiver', 'Receptor de Rifle', 100, 1, 'item_standard', 1, 259, 1, '{}', '', 0.25),
	('riflerecmold', 'Molde Receptor de Rifle', 100, 1, 'item_standard', 1, 260, 1, '{}', '', 0.25),
	('riflestock', 'cabo de Rifle', 100, 1, 'item_standard', 1, 261, 1, '{}', '', 0.25),
	('roach', 'Barata', 100, 1, 'item_standard', 1, 262, 1, '{}', '', 0.25),
	('robberyplanning', 'Conjunto de Planejamento de Roubo', 100, 1, 'item_standard', 1, 604, 1, '{}', '', 0.25),
	('robin_c', 'Robin', 100, 1, 'item_standard', 1, 433, 1, '{}', '', 0.25),
	('rock', 'pedra', 100, 1, 'item_standard', 1, 263, 1, '{}', '', 0.25),
	('rollingpaper', 'Papel de enrolar', 100, 1, 'item_standard', 1, 264, 1, '{}', '', 0.25),
	('rope', 'corda', 100, 1, 'item_standard', 1, 16813, 1, '{}', '', 0.25),
	('roundtable', 'Mesa redonda', 100, 1, 'item_standard', 1, 749, 1, '{}', '', 0.25),
	('round_table', 'Mesa redonda', 100, 1, 'item_standard', 1, 621, 1, '{}', '', 0.25),
	('rspoonb', 'Roseta Spoonbill beak', 100, 1, 'item_standard', 1, 497, 1, '{}', '', 0.25),
	('rspoonf', 'Roseta Spoonbill feather', 100, 1, 'item_standard', 1, 496, 1, '{}', '', 0.25),
	('rubber', 'borracha', 100, 1, 'item_standard', 1, 265, 1, '{}', '', 0.25),
	('rubbertube', 'Tubo de borracha', 100, 1, 'item_standard', 1, 841, 1, '{}', '', 0.25),
	('rumbarrel', 'barril de rum', 1, 1, 'item_standard', 1, 17271, 1, '{}', 'nice item', 0.25),
	('rumrecipe', 'Recipiente para rum', 1, 1, 'item_standard', 1, 17267, 1, '{}', 'nice item', 0.25),
	('r_bracelet1', 'Gold Bracelet', 10, 1, 'item_standard', 1, 17543, 1, '{}', 'nice item', 0.25),
	('r_bracelet2', 'Platinum Bracelet', 10, 1, 'item_standard', 1, 17544, 1, '{}', 'nice item', 0.25),
	('r_bracelet3', 'Silver Bracelet', 10, 1, 'item_standard', 1, 17545, 1, '{}', 'nice item', 0.25),
	('r_bracelet4', 'Penelope Bracelet', 10, 1, 'item_standard', 1, 17546, 1, '{}', 'nice item', 0.25),
	('r_chest1', 'Chest 1', 10, 1, 'item_standard', 1, 98696, 1, '{}', 'nice item', 0.25),
	('r_chest10', 'Chest 10', 10, 1, 'item_standard', 1, 98705, 1, '{}', 'nice item', 0.25),
	('r_chest11', 'Chest 11', 10, 1, 'item_standard', 1, 98706, 1, '{}', 'nice item', 0.25),
	('r_chest12', 'Chest 12', 10, 1, 'item_standard', 1, 98707, 1, '{}', 'nice item', 0.25),
	('r_chest13', 'Chest 13', 10, 1, 'item_standard', 1, 98708, 1, '{}', 'nice item', 0.25),
	('r_chest14', 'Chest 14', 10, 1, 'item_standard', 1, 98709, 1, '{}', 'nice item', 0.25),
	('r_chest15', 'Chest 15', 10, 1, 'item_standard', 1, 98710, 1, '{}', 'nice item', 0.25),
	('r_chest2', 'Chest 2', 10, 1, 'item_standard', 1, 98697, 1, '{}', 'nice item', 0.25),
	('r_chest3', 'Chest 3', 10, 1, 'item_standard', 1, 98698, 1, '{}', 'nice item', 0.25),
	('r_chest4', 'Chest 4', 10, 1, 'item_standard', 1, 98699, 1, '{}', 'nice item', 0.25),
	('r_chest5', 'Chest 5', 10, 1, 'item_standard', 1, 98700, 1, '{}', 'nice item', 0.25),
	('r_chest6', 'Chest 6', 10, 1, 'item_standard', 1, 98701, 1, '{}', 'nice item', 0.25),
	('r_chest7', 'Chest 7', 10, 1, 'item_standard', 1, 98702, 1, '{}', 'nice item', 0.25),
	('r_chest8', 'Chest 8', 10, 1, 'item_standard', 1, 98703, 1, '{}', 'nice item', 0.25),
	('r_chest9', 'Chest 9', 10, 1, 'item_standard', 1, 98704, 1, '{}', 'nice item', 0.25),
	('r_compass1', 'Brass Compass', 10, 1, 'item_standard', 1, 17523, 1, '{}', 'nice item', 0.25),
	('r_compass2', 'Naval Compass', 10, 1, 'item_standard', 1, 17524, 1, '{}', 'nice item', 0.25),
	('r_earring1', 'Silver Earring', 10, 1, 'item_standard', 1, 17553, 1, '{}', 'nice item', 0.25),
	('r_earring2', 'Platinum Earring', 10, 1, 'item_standard', 1, 17554, 1, '{}', 'nice item', 0.25),
	('r_earring3', 'Pearl Earring', 10, 1, 'item_standard', 1, 17555, 1, '{}', 'nice item', 0.25),
	('r_earring4', 'Gold Earring', 10, 1, 'item_standard', 1, 17556, 1, '{}', 'nice item', 0.25),
	('r_necklace1', 'Penelope Necklace', 10, 1, 'item_standard', 1, 17547, 1, '{}', 'nice item', 0.25),
	('r_necklace2', 'Silver Necklace', 10, 1, 'item_standard', 1, 17548, 1, '{}', 'nice item', 0.25),
	('r_necklace3', 'Platinum Necklace', 10, 1, 'item_standard', 1, 17549, 1, '{}', 'nice item', 0.25),
	('r_necklace4', 'Pearl Necklace', 10, 1, 'item_standard', 1, 17550, 1, '{}', 'nice item', 0.25),
	('r_necklace5', 'Gold Necklace', 10, 1, 'item_standard', 1, 17551, 1, '{}', 'nice item', 0.25),
	('r_necklace6', 'Necklace', 10, 1, 'item_standard', 1, 17552, 1, '{}', 'nice item', 0.25),
	('r_other1', 'Thimbleab', 10, 1, 'item_standard', 1, 17532, 1, '{}', 'nice item', 0.25),
	('r_other2', 'Silver Tooth', 10, 1, 'item_standard', 1, 17533, 1, '{}', 'nice item', 0.25),
	('r_other3', 'Reading Glasses', 10, 1, 'item_standard', 1, 17534, 1, '{}', 'nice item', 0.25),
	('r_other4', 'Marys Brooch', 10, 1, 'item_standard', 1, 17535, 1, '{}', 'nice item', 0.25),
	('r_other5', 'Silver Locket', 10, 1, 'item_standard', 1, 17536, 1, '{}', 'nice item', 0.25),
	('r_other6', 'Emerald Locket', 10, 1, 'item_standard', 1, 17537, 1, '{}', 'nice item', 0.25),
	('r_other7', 'Bra Shield', 10, 1, 'item_standard', 1, 17538, 1, '{}', 'nice item', 0.25),
	('r_other8', 'Beaus Gift', 10, 1, 'item_standard', 1, 17539, 1, '{}', 'nice item', 0.25),
	('r_other9', 'Asteroid Chunk', 10, 1, 'item_standard', 1, 17540, 1, '{}', 'nice item', 0.25),
	('r_ring1', 'Diamond Ring', 10, 1, 'item_standard', 1, 17541, 1, '{}', 'nice item', 0.25),
	('r_ring2', 'Marys Ring', 10, 1, 'item_standard', 1, 17542, 1, '{}', 'nice item', 0.25),
	('r_watch1', 'Pocket Watch 1', 10, 1, 'item_standard', 1, 17525, 1, '{}', 'nice item', 0.25),
	('r_watch2', 'Catcher Pocket Watch', 10, 1, 'item_standard', 1, 17526, 1, '{}', 'nice item', 0.25),
	('r_watch3', 'Silver Pocket Watch', 10, 1, 'item_standard', 1, 17527, 1, '{}', 'nice item', 0.25),
	('r_watch4', 'Reutlinge Pocket Watch', 10, 1, 'item_standard', 1, 17528, 1, '{}', 'nice item', 0.25),
	('r_watch5', 'Platinum Pocket Watch', 10, 1, 'item_standard', 1, 17529, 1, '{}', 'nice item', 0.25),
	('r_watch6', 'Gold Pocket Watch', 10, 1, 'item_standard', 1, 17530, 1, '{}', 'nice item', 0.25),
	('r_watch7', 'Gleaming Brass Pocket Watch', 10, 1, 'item_standard', 1, 17531, 1, '{}', 'nice item', 0.25),
	('sacclasse', 'Bolsa 1', 10, 1, 'item_standard', 1, 914, 1, '{}', 'Inspiré par un sac ayant appartenu à quelqu\'un d\'important...', 0.25),
	('sacodedinheio', 'Saco de Dinheiro Sujo', 100, 1, 'item_standard', 1, 170515, 1, '{}', 'nice item', 0.25),
	('saco_vazio', 'saco vazio', 100, 1, 'item_standard', 1, 16800, 1, '{}', '', 0.25),
	('sactravail', 'Bolsa de Trabalho', 10, 1, 'item_standard', 1, 913, 1, '{}', 'Un sac parfait pour partir au bureau de bonne heure.', 0.25),
	('sac_tabac', 'saco de tabaco', 100, 1, 'item_standard', 1, 16893, 1, '{}', '', 0.25),
	('saddlebag', 'bolsa ', 100, 1, 'item_standard', 1, 16943, 1, '{}', '', 0.25),
	('saintdeniskey', 'Chave de Saint Denis', 100, 1, 'item_standard', 1, 215663, 1, '{}', 'nice item', 0.25),
	('salamelle', 'carne de porco fresca', 100, 1, 'item_standard', 1, 266, 1, '{}', '', 0.25),
	('salitre', 'salitre', 100, 1, 'item_standard', 1, 219, 1, '{}', '', 0.25),
	('salmon', 'Salmão', 100, 1, 'item_standard', 1, 267, 1, '{}', '', 0.25),
	('salt', 'Sal', 100, 1, 'item_standard', 1, 268, 1, '{}', '', 0.25),
	('Saltbush', 'erva-sal', 100, 1, 'item_standard', 1, 269, 1, '{}', '', 0.25),
	('Saltbush_Seed', 'semente de erva-sal', 100, 1, 'item_standard', 1, 270, 1, '{}', '', 0.25),
	('sandbag', 'Saco de areia', 100, 1, 'item_standard', 1, 1795, 1, '{}', '', 0.25),
	('sandpaper', 'Lixa', 100, 1, 'item_standard', 1, 1796, 1, '{}', '', 0.25),
	('sap', 'seiva', 100, 1, 'item_standard', 1, 271, 1, '{}', '', 0.25),
	('sarsaparilla', 'Cerveja artesanal', 100, 1, 'item_standard', 1, 272, 1, '{}', '', 0.25),
	('satchels', 'Satchel', 20, 1, 'item_standard', 1, 17617, 1, '{}', 'nice item', 0.25),
	('scale', 'Escala', 100, 1, 'item_standard', 1, 273, 1, '{}', '', 0.25),
	('Scalp1', 'Scalp1', 100, 1, 'item_standard', 1, 215707, 1, '{}', 'nice item', 0.25),
	('Scalp2', 'Scalp2', 100, 1, 'item_standard', 1, 215708, 1, '{}', 'nice item', 0.25),
	('Scalp3', 'Scalp3', 100, 1, 'item_standard', 1, 215709, 1, '{}', 'nice item', 0.25),
	('Scalp4', 'Scalp4', 100, 1, 'item_standard', 1, 215710, 1, '{}', 'nice item', 0.25),
	('Scalp5', 'Scalp5', 100, 1, 'item_standard', 1, 215711, 1, '{}', 'nice item', 0.25),
	('Scalp6', 'Scalp6', 100, 1, 'item_standard', 1, 215712, 1, '{}', 'nice item', 0.25),
	('Scalp7', 'Scalp7', 100, 1, 'item_standard', 1, 215713, 1, '{}', 'nice item', 0.25),
	('Scalp8', 'Scalp8', 100, 1, 'item_standard', 1, 215714, 1, '{}', 'nice item', 0.25),
	('scentg', 'glândula de cheiro', 100, 1, 'item_standard', 1, 492, 1, '{}', '', 0.25),
	('scratchcard', 'raspadinha', 10, 1, 'item_standard', 1, 16984, 1, '{}', '', 0.25),
	('scr_adv_sok_torchsmoke', 'scr_adv_sok_torchsmoke', 100, 1, 'item_standard', 1, 16898, 1, '{}', '', 0.25),
	('seagullb', 'bico de gaivota', 100, 1, 'item_standard', 1, 495, 1, '{}', '', 0.25),
	('seagullf', 'pena de gaivota', 100, 1, 'item_standard', 1, 494, 1, '{}', '', 0.25),
	('secondchance', 'Segunda chance', 100, 1, 'item_standard', 1, 274, 1, '{}', '', 0.25),
	('segundachanse', 'Sua segunda chanse', 100, 1, 'item_standard', 1, 215770, 1, '{}', 'nice item', 0.25),
	('semente_de_arroz', 'semente de arroz', 100, 1, 'item_standard', 1, 16794, 1, '{}', '', 0.25),
	('semente_de_feijao', 'semente de feijao', 100, 1, 'item_standard', 1, 16796, 1, '{}', '', 0.25),
	('semente_de_tomate', 'semente de tomate', 100, 1, 'item_standard', 1, 16792, 1, '{}', '', 0.25),
	('semente_de_trigo', 'semente de trigo', 100, 1, 'item_standard', 1, 16801, 1, '{}', 'nice item', 0.25),
	('semillacocaina', 'Semilla Cocaina', 100, 1, 'item_standard', 1, 16935, 1, '{}', 'nice item', 0.25),
	('semillaepi', 'Semilla Epi (Methanfetamina)', 100, 1, 'item_standard', 1, 16937, 1, '{}', 'nice item', 0.25),
	('seringa_vazia', 'seringa vazia', 100, 1, 'item_standard', 1, 16807, 1, '{}', 'nice item', 0.25),
	('SerrariaBW', 'Livro da Serraria', 100, 1, 'item_standard', 1, 170471, 1, '{}', 'nice item', 0.25),
	('sheephead', 'cabeça de ovelha', 100, 1, 'item_standard', 1, 493, 1, '{}', 'Head of a sheep', 0.25),
	('shellcasing', 'capsula', 100, 1, 'item_standard', 1, 275, 1, '{}', 'Empty shell casing', 0.25),
	('shellspistol', 'Capsula revolver/pistola', 100, 1, 'item_standard', 1, 215695, 1, '{}', 'nice item', 0.25),
	('shirts_full', 'Shirt', 20, 1, 'item_standard', 1, 17630, 1, '{}', 'nice item', 0.25),
	('shootingtarget', 'tiro ao alvo', 100, 1, 'item_standard', 1, 613, 1, '{}', 'Target for shooting practice', 0.25),
	('shoptoken', 'Licença de Criação de Loja', 5, 1, 'item_standard', 1, 17049, 1, '{}', 'nice item', 0.25),
	('shotgunbarrel', 'cano da espingarda', 100, 1, 'item_standard', 1, 276, 1, '{}', 'Barrel for a shotgun', 0.25),
	('shotgunmold', 'molde de espingarda', 100, 1, 'item_standard', 1, 277, 1, '{}', 'Mold for a shotgun', 0.25),
	('shotgunstock', 'cabo de espingarda', 100, 1, 'item_standard', 1, 278, 1, '{}', 'Stock for a shotgun', 0.25),
	('shovel', 'pa', 1, 1, 'item_standard', 1, 17235, 1, '{}', 'nice item', 0.25),
	('shrimps', 'Moqueca de camarão', 100, 1, 'item_standard', 1, 279, 1, '{}', 'Delicious shrimp stew', 0.25),
	('sidetable', 'mesa lateral 1', 100, 1, 'item_standard', 1, 782, 1, '{}', 'Functional side table', 0.25),
	('sidetablea', 'mesa lateral 2', 100, 1, 'item_standard', 1, 783, 1, '{}', 'Stylish side table', 0.25),
	('sidetableb', 'mesa lateral 3', 100, 1, 'item_standard', 1, 784, 1, '{}', 'A beautiful side table', 0.25),
	('side_table', 'mesa lateral 1', 100, 1, 'item_standard', 1, 654, 1, '{}', 'A stylish side table', 0.25),
	('side_tablea', 'mesa lateral 2', 100, 1, 'item_standard', 1, 655, 1, '{}', 'An elegant side table', 0.25),
	('side_tableb', 'mesa lateral 3', 100, 1, 'item_standard', 1, 656, 1, '{}', 'A modern side table', 0.25),
	('silverhorseshoe', 'ferradura de prata ', 100, 1, 'item_standard', 1, 16908, 1, '{}', 'nice item', 0.25),
	('silverticket', 'bilhete 2', 100, 1, 'item_standard', 1, 16912, 1, '{}', 'nice item', 0.25),
	('singlebed', 'cama de solteiro', 100, 1, 'item_standard', 1, 666, 1, '{}', 'A comfortable single bed', 0.25),
	('skirts', 'Skirt', 20, 1, 'item_standard', 1, 17613, 1, '{}', 'nice item', 0.25),
	('skullpost', 'poste de caveira', 100, 1, 'item_standard', 1, 597, 1, '{}', 'A decorative skull post', 0.25),
	('smallchest', 'Baú Pequeno', 100, 1, 'item_standard', 1, 657, 1, '{}', 'A small storage chest', 0.25),
	('smallmcandle', 'Vela pequena derretida', 100, 1, 'item_standard', 1, 662, 1, '{}', 'A small melted candle', 0.25),
	('small_firecracker', 'foguete', 100, 1, 'item_standard', 1, 16896, 1, '{}', 'nice item', 0.25),
	('small_fireworks', 'fogos', 100, 1, 'item_standard', 1, 16992, 1, '{}', 'nice item', 0.25),
	('Small_Leather', 'couro pequeno', 100, 1, 'item_standard', 1, 280, 1, '{}', 'A small piece of leather', 0.25),
	('smoke_campfire', 'foguete', 100, 1, 'item_standard', 1, 16895, 1, '{}', 'nice item', 0.25),
	('SnakeSkin', 'pele de cobra', 100, 1, 'item_standard', 1, 281, 1, '{}', 'A snake skin', 0.25),
	('snaket', 'dente de cobra', 100, 1, 'item_standard', 1, 490, 1, '{}', 'A tooth from a snake', 0.25),
	('Snake_Poison', 'veneno de cobra', 100, 1, 'item_standard', 1, 282, 1, '{}', 'Poison extracted from a snake', 0.25),
	('soap', 'sabão', 100, 1, 'item_standard', 1, 215784, 1, '{}', 'nice item', 0.25),
	('soborno', 'Suborno Álcool', 100, 1, 'item_standard', 1, 283, 1, '{}', 'A bottle of Soborno alcohol', 0.25),
	('societytoken', 'Licença de criação de loja de sociedade', 5, 1, 'item_standard', 1, 17050, 1, '{}', 'nice item', 0.25),
	('songbird2_c', 'pássaro canoro escarlate', 100, 1, 'item_standard', 1, 435, 1, '{}', 'A beautiful scarlet songbird', 0.25),
	('songbird_c', 'pássaro canoro', 100, 1, 'item_standard', 1, 434, 1, '{}', 'A lovely songbird', 0.25),
	('sopamilho', 'Sopa de Milho', 100, 1, 'item_standard', 1, 170477, 1, '{}', 'nice item', 0.25),
	('soparustica', 'Sopa de Batata Rustica', 100, 1, 'item_standard', 1, 170480, 1, '{}', 'nice item', 0.25),
	('sparrow0_c', 'pardal comum', 100, 1, 'item_standard', 1, 436, 1, '{}', 'A common sparrow', 0.25),
	('sparrow1_c', 'Pardal', 100, 1, 'item_standard', 1, 437, 1, '{}', 'A sparrow', 0.25),
	('sparrow2_c', 'pardal dourado', 100, 1, 'item_standard', 1, 438, 1, '{}', 'A golden sparrow', 0.25),
	('spats', 'Spats', 20, 1, 'item_standard', 1, 17620, 1, '{}', 'nice item', 0.25),
	('spool', 'carretel', 100, 1, 'item_standard', 1, 1797, 1, '{}', 'A empty spool. often used to wrap wire around.', 0.25),
	('squirrel_black_c', 'esquilo preto', 100, 1, 'item_standard', 1, 441, 1, '{}', 'A black squirrel', 0.25),
	('squirrel_grey_c', 'esquilo cinza', 100, 1, 'item_standard', 1, 439, 1, '{}', 'A gray squirrel', 0.25),
	('squirrel_red_c', 'Esquilo vermelho', 100, 1, 'item_standard', 1, 440, 1, '{}', 'A Red squirrel', 0.25),
	('standard_table', 'Mesa', 100, 1, 'item_standard', 1, 622, 1, '{}', 'A standard table for various uses.', 0.25),
	('standingtorch', 'Tocha Permanente', 100, 1, 'item_standard', 1, 612, 1, '{}', 'A standing torch to provide light.', 0.25),
	('statue13', 'estatua de jesus', 100, 1, 'item_standard', 1, 17199, 1, '{}', 'nice item', 0.25),
	('statue17', 'estatua antiga', 100, 1, 'item_standard', 1, 17204, 1, '{}', 'nice item', 0.25),
	('steak', 'Bife', 100, 1, 'item_standard', 1, 284, 1, '{}', 'A delicious steak for a hearty meal.', 0.25),
	('steakveg', 'bife com legumes', 100, 1, 'item_standard', 1, 285, 1, '{}', 'A balanced meal with steak and vegetables.', 0.25),
	('stillkit', 'Kit de destilação', 100, 1, 'item_standard', 1, 843, 1, '{}', 'A kit for setting up a still to make distilled spirits.', 0.25),
	('stim', 'Estimulante para cavalos', 100, 1, 'item_standard', 1, 286, 1, '{}', 'A stimulant to boost a horses performance.', 0.25),
	('stolenmerch', 'Mercadoria Roubada', 100, 1, 'item_standard', 1, 287, 1, '{}', 'Various stolen items of questionable origin.', 0.25),
	('stonehammer', 'martelo de pedra', 100, 1, 'item_standard', 1, 288, 1, '{}', 'A durable hammer made of stone.', 0.25),
	('string', 'Corda', 100, 1, 'item_standard', 1, 1798, 1, '{}', 'A bundle of string with many uses.', 0.25),
	('stringedmeat', 'Stringed meat', 30, 1, 'item_standard', 1, 17564, 1, '{}', 'nice item', 0.25),
	('stringy', 'carne fibrosa', 100, 1, 'item_standard', 1, 574, 1, '{}', 'Tough and chewy meat that requires thorough cooking.', 0.25),
	('suco_laranja', 'suco de laranja', 20, 1, 'item_standard', 1, 17075, 1, '{}', '', 0.25),
	('suco_limao', 'suco de limão', 20, 1, 'item_standard', 1, 17076, 1, '{}', 'nice item', 0.25),
	('suco_maca', 'suco de maça', 20, 1, 'item_standard', 1, 17077, 1, '{}', 'nice item', 0.25),
	('suco_pera', 'suco de pera', 20, 1, 'item_standard', 1, 17078, 1, '{}', 'nice item', 0.25),
	('sugar', 'Açúcar', 100, 1, 'item_standard', 1, 289, 1, '{}', 'A sweet and granulated substance used for sweetening.', 0.25),
	('Sugarcane', 'Cana de açúcar', 100, 1, 'item_standard', 1, 1682, 1, '{}', 'nice item', 0.25),
	('sugarcaneseed', 'semente de cana', 100, 1, 'item_standard', 1, 290, 1, '{}', 'Seeds for growing sugarcane.', 0.25),
	('Sugarcane_Seed', 'Semente de Cana', 100, 1, 'item_standard', 1, 215796, 1, '{}', 'nice item', 0.25),
	('sugarcube', 'Cubo de açúcar', 100, 1, 'item_standard', 1, 347, 1, '{}', 'A compact form of sugar for easy use.', 0.25),
	('sulfur', 'enxofre', 100, 1, 'item_standard', 1, 291, 1, '{}', 'A yellow chemical element often used in manufacturing.', 0.25),
	('Supply_Manure', 'esterco ', 100, 1, 'item_standard', 1, 16967, 1, '{}', 'nice item', 0.25),
	('suspenders', 'Suspenders', 20, 1, 'item_standard', 1, 17629, 1, '{}', 'nice item', 0.25),
	('syn', 'bebida simples', 100, 1, 'item_standard', 1, 292, 1, '{}', 'A synthetic substance used for various purposes.', 0.25),
	('synpackage', 'Pacote Syn', 100, 1, 'item_standard', 1, 293, 1, '{}', 'A package containing synthetic substances.', 0.25),
	('syringe', 'Seringa', 100, 1, 'item_standard', 1, 294, 1, '{}', 'A medical instrument used for injecting fluids.', 0.25),
	('syringecert', 'certificado de seringa', 100, 1, 'item_standard', 1, 295, 1, '{}', 'A certification for the proper use of syringes.', 0.25),
	('syringe_adrenalin', 'Syringe of Adrenalin', 5, 1, 'item_standard', 1, 17281, 1, '{}', 'A syringe filled with adrenalin.', 0.25),
	('syringe_steroids', 'Syringe of Steroids', 5, 1, 'item_standard', 1, 17280, 1, '{}', 'A syringe containing steroids.', 0.25),
	('tabac', 'tabaco louro', 100, 1, 'item_standard', 1, 16892, 1, '{}', 'nice item', 0.25),
	('tabacodemascar', 'Tabacco de Mascar', 100, 1, 'item_standard', 1, 215649, 1, '{}', 'nice item', 0.25),
	('tea', 'planta para cha ', 100, 1, 'item_standard', 1, 17225, 1, '{}', 'nice item', 0.25),
	('teabag', 'sarsaparilla', 100, 1, 'item_standard', 1, 1799, 1, '{}', 'A teabag for making that perfect cup.', 0.25),
	('tealeaf', 'Folha de chá', 100, 1, 'item_standard', 1, 1800, 1, '{}', 'Used to make tea or teabags.', 0.25),
	('Teapot_Can', 'Regador', 100, 1, 'item_standard', 1, 27532, 1, '{}', 'nice item', 0.25),
	('teaseeds', 'semente de cha', 100, 1, 'item_standard', 1, 17070, 1, '{}', 'nice item', 0.25),
	('tecido', 'Tecido', 100, 1, 'item_standard', 1, 170469, 1, '{}', 'nice item', 0.25),
	('telegram', 'telegrama ', 5, 1, 'item_standard', 1, 17156, 1, '{}', 'nice item', 0.25),
	('tellapple1', 'William Tell Apple', 5, 1, 'item_standard', 1, 17240, 1, '{}', 'nice item', 0.25),
	('tent', 'Barraca', 100, 1, 'item_standard', 1, 296, 1, '{}', 'A portable shelter for camping or temporary use.', 0.25),
	('tent2', 'Barraca do Comerciante', 100, 1, 'item_standard', 1, 588, 1, '{}', 'A tent specifically designed for trading purposes.', 0.25),
	('tent3', 'Tenda Simples', 100, 1, 'item_standard', 1, 589, 1, '{}', 'A basic tent for camping.', 0.25),
	('tent4', 'Sombra de tela', 100, 1, 'item_standard', 1, 590, 1, '{}', 'A canvas shade for shelter.', 0.25),
	('tentdroga', 'NarcoRefugio', 100, 1, 'item_standard', 1, 16941, 1, '{}', 'nice item', 0.25),
	('tequila', 'tequila', 100, 1, 'item_standard', 1, 297, 1, '{}', 'A bottle of tequila.', 0.25),
	('tequilabarrel', 'barril de tequila', 1, 1, 'item_standard', 1, 17272, 1, '{}', 'nice item', 0.25),
	('tequilarecipe', 'Recipiente para vinho', 1, 1, 'item_standard', 1, 17266, 1, '{}', 'nice item', 0.25),
	('texasbon', 'Texas Blue Bonnet', 50, 1, 'item_standard', 1, 17691, 1, '{}', 'an item', 0.25),
	('Texas_Bonnet', 'Boné do Texas', 100, 1, 'item_standard', 1, 298, 1, '{}', 'A traditional Texas bonnet.', 0.25),
	('Texas_Bonnet_Seed', 'Semente de gorro do Texas', 100, 1, 'item_standard', 1, 299, 1, '{}', 'Seeds to grow Texas Bonnet flowers.', 0.25),
	('ticket', 'bilhete', 100, 1, 'item_standard', 1, 16994, 1, '{}', 'nice item', 0.25),
	('timber', 'Madeira', 100, 1, 'item_standard', 1, 1801, 1, '{}', 'A sturdy chunck of timber.', 0.25),
	('timbertable', 'mesa de madeira', 100, 1, 'item_standard', 1, 752, 1, '{}', 'A sturdy table made of timber.', 0.25),
	('timber_table', 'mesa de madeira', 100, 1, 'item_standard', 1, 624, 1, '{}', 'A table made of timber.', 0.25),
	('tipi', 'Tipo nativo', 100, 1, 'item_standard', 1, 596, 1, '{}', 'A traditional Native American tipi.', 0.25),
	('toaddesert_c', 'sapo do deserto', 100, 1, 'item_standard', 1, 444, 1, '{}', 'A toad found in the desert.', 0.25),
	('toadpoison_c', 'sapo envenenado', 100, 1, 'item_standard', 1, 443, 1, '{}', 'A toad that carries poison.', 0.25),
	('toad_c', 'Sapo', 100, 1, 'item_standard', 1, 442, 1, '{}', 'A common toad.', 0.25),
	('toalha', 'Toalha de Banho', 100, 1, 'item_standard', 1, 215675, 1, '{}', 'nice item', 0.25),
	('tobacco', 'tabaco', 100, 1, 'item_standard', 1, 1683, 1, '{}', 'nice item', 0.25),
	('tobaccopipe', 'Tabaco seco', 100, 1, 'item_standard', 1, 215627, 1, '{}', 'Quality tobacco', 0.25),
	('tobacco_seed', 'semente de tabaco', 100, 1, 'item_standard', 1, 1684, 1, '{}', 'nice item', 0.25),
	('token', 'Licença de acampamento', 100, 1, 'item_standard', 1, 300, 1, '{}', 'A license for setting up a camp.', 0.25),
	('tomate', 'tomate', 100, 1, 'item_standard', 1, 16791, 1, '{}', 'nice item', 0.25),
	('Tomato', 'Tomate', 100, 1, 'item_standard', 1, 215823, 1, '{}', 'nice item', 0.25),
	('Tomato_Seed', 'Semente de Tomate', 100, 1, 'item_standard', 1, 215801, 1, '{}', 'nice item', 0.25),
	('toolbarrel', 'Cano de ferramentas', 100, 1, 'item_standard', 1, 767, 1, '{}', 'A barrel for storing tools.', 0.25),
	('tool_barrel', 'Cano de ferramentas', 100, 1, 'item_standard', 1, 639, 1, '{}', 'A barrel used for storing tools.', 0.25),
	('tortadebanana', 'Torta de Banana', 100, 1, 'item_standard', 1, 215777, 1, '{}', 'nice item', 0.25),
	('tortadecarne', 'Torta de Carne', 100, 1, 'item_standard', 1, 215776, 1, '{}', 'nice item', 0.25),
	('trainkey', 'Chave do Trem', 100, 1, 'item_standard', 1, 301, 1, '{}', 'A key to unlock a train.', 0.25),
	('trainoil', 'óleo de trem', 100, 1, 'item_standard', 1, 16931, 1, '{}', 'nice item', 0.25),
	('trayoffood', 'Mesa de Servir', 100, 1, 'item_standard', 1, 614, 1, '{}', 'A table used for serving food.', 0.25),
	('treat_dog_small', 'Dog Food', 50, 1, 'item_standard', 1, 17567, 1, '{}', 'nice item', 0.25),
	('trigo', 'trigo', 100, 1, 'item_standard', 1, 17114, 1, '{}', 'nice item', 0.25),
	('trigo2', 'trigo', 100, 1, 'item_standard', 1, 16802, 1, '{}', 'nice item', 0.25),
	('trigo_Seed', 'semente de trigo', 100, 1, 'item_standard', 1, 17109, 1, '{}', 'nice item', 0.25),
	('tronco1', 'Tronco de Cedro', 100, 1, 'item_standard', 1, 170466, 1, '{}', 'nice item', 0.25),
	('tronco2', 'Tronco de Pinheiro', 100, 1, 'item_standard', 1, 170467, 1, '{}', 'nice item', 0.25),
	('tronco3', 'Tronco de Eucalipto', 100, 1, 'item_standard', 1, 170468, 1, '{}', 'nice item', 0.25),
	('tropicalPunchMash', 'purê de ginseng', 100, 1, 'item_standard', 1, 302, 1, '{}', 'A mash made from ginseng.', 0.25),
	('tropicalPunchMoonshine', 'aguardente de ginseng', 100, 1, 'item_standard', 1, 303, 1, '{}', 'Moonshine infused with ginseng.', 0.25),
	('trout', 'Truta', 100, 1, 'item_standard', 1, 304, 1, '{}', 'A fish of the trout family.', 0.25),
	('tuicabar', 'tuica barril', 1, 1, 'item_standard', 1, 17270, 1, '{}', 'nice item', 0.25),
	('tuicarecipe', 'recipiente para tuica', 1, 1, 'item_standard', 1, 17268, 1, '{}', 'nice item', 0.25),
	('turkeyb', 'bico de peru', 100, 1, 'item_standard', 1, 484, 1, '{}', 'The beak of a turkey.', 0.25),
	('turkeyf', 'pena de peru', 100, 1, 'item_standard', 1, 483, 1, '{}', 'A feather from a turkey.', 0.25),
	('TurtleShell', 'casco de tartaruga', 100, 1, 'item_standard', 1, 305, 1, '{}', 'The shell of a turtle.', 0.25),
	('turtlet', 'dente de tartaruga', 100, 1, 'item_standard', 1, 482, 1, '{}', 'A tooth extracted from a turtle.', 0.25),
	('twice', 'roupa', 100, 1, 'item_standard', 1, 17472, 1, '{}', 'nice item', 0.25),
	('tylenol', 'Tylenol', 100, 1, 'item_standard', 1, 306, 1, '{}', 'A medication called Tylenol.', 0.25),
	('uccelloarrosto', 'Prato de Fitness', 100, 1, 'item_standard', 1, 98675, 1, '{}', 'nice item', 0.25),
	('ufoitem', 'Ufo', 100, 1, 'item_standard', 1, 215857, 1, '{}', 'nice item', 0.25),
	('undertaker1', 'Caixão', 100, 1, 'item_standard', 1, 609, 1, '{}', 'A wooden coffin.', 0.25),
	('undertaker2', 'flor caixão', 100, 1, 'item_standard', 1, 610, 1, '{}', 'A coffin decorated with flowers.', 0.25),
	('unique_brad_horsesugar', 'Açúcar Cavalo Brad', 100, 1, 'item_standard', 1, 350, 1, '{}', 'Sugar used for horses owned by Brad.', 0.25),
	('unique_helper', 'Unico Ajudante', 100, 1, 'item_standard', 1, 215787, 1, '{}', 'nice item', 0.25),
	('unique_horse_feed', 'Ração para cavalos', 100, 1, 'item_standard', 1, 349, 1, '{}', 'Feed for horses.', 0.25),
	('upgrade_fsh_bait_cheese', 'fatia de queijo', 100, 1, 'item_standard', 1, 16722, 1, '{}', 'nice item', 0.25),
	('upgrade_fsh_bait_cricket', 'isca', 10, 1, 'item_standard', 1, 17068, 1, '{}', 'nice item', 0.25),
	('upgrade_fsh_bait_leg_lure_river', 'isca', 100, 1, 'item_standard', 1, 17053, 1, '{}', 'nice item', 0.25),
	('upgrade_fsh_bait_worm', 'isca', 10, 1, 'item_standard', 1, 17069, 1, '{}', 'nice item', 0.25),
	('uva', 'uva', 100, 1, 'item_standard', 1, 17192, 1, '{}', 'nice item', 0.25),
	('valc', '500 Gold', 10, 1, 'item_standard', 1, 1017, 1, '{}', '011', 0.25),
	('vald', '200 Gold', 10, 1, 'item_standard', 1, 1019, 1, '{}', '013', 0.25),
	('valm', '1000 Gold', 10, 1, 'item_standard', 1, 1020, 1, '{}', '014', 0.25),
	('vals', '50 Gold', 10, 1, 'item_standard', 1, 1018, 1, '{}', '012', 0.25),
	('valu', '100 Gold', 10, 1, 'item_standard', 1, 1021, 1, '{}', '015', 0.25),
	('vanillacake', 'Bolo de baunilha', 100, 1, 'item_standard', 1, 1802, 1, '{}', 'A tasty vanilla flavored cake.', 0.25),
	('vanillaFlower', 'flor de baunilha', 100, 1, 'item_standard', 1, 307, 1, '{}', 'A flower known as Vanille.', 0.25),
	('varnish', 'Verniz', 100, 1, 'item_standard', 1, 1803, 1, '{}', 'A typical wood finish made from oils and resins.', 0.25),
	('venison', 'Carne de veado', 100, 1, 'item_standard', 1, 566, 1, '{}', 'Lean meat obtained from deer.', 0.25),
	('vests', 'Vest', 20, 1, 'item_standard', 1, 17628, 1, '{}', 'nice item', 0.25),
	('vinagre', 'Vinagre', 100, 1, 'item_standard', 1, 215689, 1, '{}', 'nice item', 0.25),
	('Violet_Snowdrop', 'Floco de Neve Violeta', 100, 1, 'item_standard', 1, 308, 1, '{}', 'A delicate flower called Violet Snowdrop.', 0.25),
	('Violet_Snowdrop_Seed', 'Semente Violet Snowdrop', 100, 1, 'item_standard', 1, 309, 1, '{}', 'Seeds to grow Violet Snowdrop flowers.', 0.25),
	('vip1', 'Vip Bronze', 10, 1, 'item_standard', 1, 1004, 1, '{}', '017', 0.25),
	('vip2', 'Vip Prata', 10, 1, 'item_standard', 1, 1000, 1, '{}', '013', 0.25),
	('vip3', 'Vip Ouro', 10, 1, 'item_standard', 1, 1002, 1, '{}', '015', 0.25),
	('vip4', 'Vip Platina', 10, 1, 'item_standard', 1, 1001, 1, '{}', '014', 0.25),
	('vip5', 'Vip Diamante ', 10, 1, 'item_standard', 1, 1003, 1, '{}', '016', 0.25),
	('vodka', 'Vodka', 100, 1, 'item_standard', 1, 310, 1, '{}', 'A strong alcoholic beverage known as Vodka.', 0.25),
	('Volture_Egg', 'ovo de volture', 100, 1, 'item_standard', 1, 311, 1, '{}', 'An egg laid by a Volture bird.', 0.25),
	('vulturetaxi', 'Taxidermia de Abutre', 100, 1, 'item_standard', 1, 772, 1, '{}', 'A taxidermy of a vulture bird.', 0.25),
	('vulture_taxidermy', 'Taxidermia de Abutre', 100, 1, 'item_standard', 1, 644, 1, '{}', 'A preserved vulture bird for display.', 0.25),
	('washcloth', 'Toalha', 100, 1, 'item_standard', 1, 215785, 1, '{}', 'nice item', 0.25),
	('washtub', 'Lavatório', 100, 1, 'item_standard', 1, 637, 1, '{}', 'A tub used for washing clothes or other items.', 0.25),
	('water', 'agua', 20, 1, 'item_standard', 1, 312, 1, '{}', 'Clean drinking water.', 0.25),
	('waterbarrel', 'Barril de água', 100, 1, 'item_standard', 1, 587, 1, '{}', 'A large barrel used for storing water.', 0.25),
	('waterhose', 'Water Hose', 50, 1, 'item_standard', 1, 17687, 1, '{}', 'an item', 0.25),
	('wateringcan', 'Balde de Agua', 100, 1, 'item_standard', 1, 313, 1, '{}', 'A jug-shaped container used for watering plants.', 0.25),
	('wateringcan_dirtywater', 'Jarro de rega sujo', 100, 1, 'item_standard', 1, 314, 1, '{}', 'A watering jug filled with dirty water.', 0.25),
	('wateringcan_empty', 'Balde Vazio', 100, 1, 'item_standard', 1, 315, 1, '{}', 'An empty watering jug.', 0.25),
	('waterpump', 'Bomba de água', 100, 1, 'item_standard', 1, 755, 1, '{}', 'A device used for pumping water.', 0.25),
	('water_pump', 'Bomba de água', 100, 1, 'item_standard', 1, 627, 1, '{}', 'A pump designed to move water.', 0.25),
	('weapon_bow', 'arco ', 100, 1, 'item_Weapon', 1, 16815, 1, '{}', 'nice item', 0.25),
	('WEAPON_FISHINGROD', 'vara de pesca', 100, 1, 'item_Weapon', 1, 17218, 1, '{}', 'nice item', 0.25),
	('WEAPON_kIT_BINOCULARS', 'binoculos ', 100, 1, 'item_Weapon', 1, 17183, 1, '{}', 'nice item', 0.25),
	('weapon_kit_binoculars_improved', 'binoculos', 100, 1, 'item_Weapon', 1, 16737, 1, '{}', 'nice item', 0.25),
	('weapon_kit_metal_detector', 'Detector de metal', 100, 1, 'item_Weapon', 1, 17263, 1, '{}', 'Detector de metal', 0.25),
	('WEAPON_LASSO', 'lasso', 100, 1, 'item_Weapon', 1, 17096, 1, '{}', 'nice item', 0.25),
	('WEAPON_LASSO_REINFORCED', 'lasso reforçado', 100, 1, 'item_Weapon', 1, 17181, 1, '{}', 'nice item', 0.25),
	('weapon_melee_hammer', 'martelo', 100, 1, 'item_Weapon', 1, 16731, 1, '{}', 'nice item', 0.25),
	('weapon_melee_hatchet', 'machado', 100, 1, 'item_Weapon', 1, 16730, 1, '{}', 'nice item', 0.25),
	('WEAPON_MELEE_KNIFE', 'faca', 100, 1, 'item_Weapon', 1, 16741, 1, '{}', 'nice item', 0.25),
	('WEAPON_MELEE_LANTERN_HALOWEEN', 'lanterna de walow', 100, 1, 'item_Weapon', 1, 16964, 1, '{}', 'nice item', 0.25),
	('WEAPON_MELEE_MACHETE_COLLECTOR', 'espada facão', 100, 1, 'item_Weapon', 1, 17178, 1, '{}', 'nice item', 0.25),
	('weapon_melee_torch', 'tocha', 100, 1, 'item_Weapon', 1, 16732, 1, '{}', 'nice item', 0.25),
	('WEAPON_PISTOL_M1899', 'pistola', 100, 1, 'item_Weapon', 1, 17143, 1, '{}', 'nice item', 0.25),
	('weapon_reinforced_lasso', 'chicote de treino', 100, 1, 'item_Weapon', 1, 16910, 1, '{}', 'nice item', 0.25),
	('WEAPON_REPEATER_HENRY', 'repetidora henry', 100, 1, 'item_Weapon', 1, 17153, 1, '{}', 'nice item', 0.25),
	('WEAPON_REPEATER_WINCHESTER', 'repetidora winchester', 100, 1, 'item_Weapon', 1, 17154, 1, '{}', 'nice item', 0.25),
	('WEAPON_REVOLVER_CATTLEMAN', 'revolver cattleman', 100, 1, 'item_weapon', 1, 17152, 1, '{}', 'nice item', 0.25),
	('WEAPON_REVOLVER_DOUBLEACTION', 'Revolver Dupla Ação', 100, 1, 'item_Weapon', 1, 98669, 1, '{}', 'nice item', 0.25),
	('WEAPON_REVOLVER_LEMAT', 'Revolver Lemat', 100, 1, 'item_Weapon', 1, 17187, 1, '{}', 'nice item', 0.25),
	('WEAPON_REVOLVER_NAVY', 'nevy', 100, 1, 'item_Weapon', 1, 17144, 1, '{}', 'nice item', 0.25),
	('WEAPON_RIFLE_SPRINGFIELD', 'Rifle Springfield', 100, 1, 'item_Weapon', 1, 98672, 1, '{}', 'nice item', 0.25),
	('WEAPON_SHOTGUN_DOUBLEBARREL', 'Escopeta Cano Duplo', 100, 1, 'item_Weapon', 1, 98673, 1, '{}', 'nice item', 0.25),
	('WEAPON_SNIPERRIFLE_ROLLINGBLOCK', 'ROLLINGBLOCK', 100, 1, 'item_Weapon', 1, 17179, 1, '{}', 'nice item', 0.25),
	('WEAPON_THROWN_BOLAS', 'bolas', 100, 1, 'item_Weapon', 1, 17103, 1, '{}', 'nice item', 0.25),
	('WEAPON_THROWN_MOLOTOV', 'molotov', 100, 1, 'item_Weapon', 1, 16965, 1, '{}', 'nice item', 0.25),
	('WEAPON_THROWN_POISONBOTTLE', 'poção', 100, 1, 'item_Weapon', 1, 17344, 1, '{}', 'nice item', 0.25),
	('WEAPON_THROWN_THROWING_KNIVES', 'faca de arremeço', 100, 1, 'item_Weapon', 1, 17343, 1, '{}', 'nice item', 0.25),
	('WEAPON_THROWN_TOMAHAWK', 'machado de arremeço', 100, 1, 'item_Weapon', 1, 17102, 1, '{}', 'nice item', 0.25),
	('weapon_thrown_tomahawk2', 'machado de arremeço', 100, 1, 'item_Weapon', 1, 16812, 1, '{}', 'nice item', 0.25),
	('wedding_chain_ring', 'Anel de casamento na cadeia', 100, 1, 'item_standard', 1, 1804, 1, '{}', 'A wedding ring on chain. usally worn this way so they dont get lost.', 0.25),
	('wedding_ring', 'Anel de noivado', 100, 1, 'item_standard', 1, 1805, 1, '{}', 'A beautiful wedding ring.', 0.25),
	('weed', 'cannabis', 100, 1, 'item_standard', 1, 17119, 1, '{}', 'nice item', 0.25),
	('weedbuds', 'cannabis flor', 100, 1, 'item_standard', 1, 17057, 1, '{}', 'nice item', 0.25),
	('weedpack', 'Pote de Marijuana', 100, 1, 'item_standard', 1, 215650, 1, '{}', 'nice item', 0.25),
	('weedseed', 'semente de cannabis', 100, 1, 'item_standard', 1, 17058, 1, '{}', 'nice item', 0.25),
	('weed_leaves', 'folha de cannabis', 100, 1, 'item_standard', 1, 17165, 1, '{}', 'nice item', 0.25),
	('weed_pooch', 'flor de cannabis', 100, 1, 'item_standard', 1, 17166, 1, '{}', 'nice item', 0.25),
	('weed_seed', 'semente de cannabis', 100, 1, 'item_standard', 1, 17167, 1, '{}', 'nice item', 0.25),
	('wheat', 'Trigo', 100, 1, 'item_standard', 1, 1806, 1, '{}', 'Often ground up into flour to used in cooking and baking', 0.25),
	('wheatseed', 'semente de trigo', 100, 1, 'item_standard', 1, 1807, 1, '{}', 'When planted will grow into wheat.', 0.25),
	('Whiskey', 'Garrafa de Whiskey', 100, 1, 'item_standard', 1, 98674, 1, '{}', 'nice item', 0.25),
	('whisky', 'Whisky', 100, 1, 'item_standard', 1, 316, 1, '{}', 'An alcoholic beverage known as whisky.', 0.25),
	('whiskybarrel', 'barril de whisky', 1, 1, 'item_standard', 1, 17274, 1, '{}', 'nice item', 0.25),
	('whiskyrecipe', 'Recipiente para whisky', 1, 1, 'item_standard', 1, 17264, 1, '{}', 'nice item', 0.25),
	('wicker', 'vime', 100, 1, 'item_standard', 1, 1808, 1, '{}', 'A natural material made from woven branches or reeds', 0.25),
	('wickerbench', 'banco de vime', 100, 1, 'item_standard', 1, 778, 1, '{}', 'A bench made from wicker material.', 0.25),
	('wicker_bench', 'banco de vime', 100, 1, 'item_standard', 1, 650, 1, '{}', 'A bench constructed with wicker material.', 0.25),
	('wildCiderMash', 'Purê de Bagas Pretas', 100, 1, 'item_standard', 1, 317, 1, '{}', 'Mashed blackberries used for making cider.', 0.25),
	('wildCiderMoonshine', 'Moonshine de Black Berry', 100, 1, 'item_standard', 1, 318, 1, '{}', 'Homemade moonshine crafted from blackberries.', 0.25),
	('Wild_Carrot', 'Cenoura Silvestre', 100, 1, 'item_standard', 1, 319, 1, '{}', 'A type of carrot that grows in the wild.', 0.25),
	('Wild_Carrot_Seed', 'Semente de Cenoura Selvagem', 100, 1, 'item_standard', 1, 320, 1, '{}', 'Seeds to cultivate wild carrots.', 0.25),
	('Wild_Feverfew', 'matricária selvagem', 100, 1, 'item_standard', 1, 321, 1, '{}', 'A wild plant known as Feverfew.', 0.25),
	('Wild_Feverfew_Seed', 'Semente de Matricária Selvagem', 100, 1, 'item_standard', 1, 322, 1, '{}', 'Seeds to grow Feverfew plants.', 0.25),
	('Wild_Mint', 'Menta selvagem', 100, 1, 'item_standard', 1, 323, 1, '{}', 'A type of mint that grows in the wild.', 0.25),
	('Wild_Mint_Seed', 'Semente de Hortelã Selvagem', 100, 1, 'item_standard', 1, 324, 1, '{}', 'Seeds to cultivate wild mint.', 0.25),
	('Wild_Rhubarb', 'ruibarbo selvagem', 100, 1, 'item_standard', 1, 325, 1, '{}', 'A rhubarb plant that grows in the wild.', 0.25),
	('Wild_Rhubarb_Seed', 'Semente de Ruibarbo Selvagem', 100, 1, 'item_standard', 1, 326, 1, '{}', 'Seeds to grow wild rhubarb.', 0.25),
	('wine', 'vinho', 20, 1, 'item_standard', 1, 17182, 1, '{}', 'nice item', 0.25),
	('winebarrel', 'barril de vinho', 1, 1, 'item_standard', 1, 17273, 1, '{}', 'nice item', 0.25),
	('winerecipe', 'Recipiente para vinho', 1, 1, 'item_standard', 1, 17265, 1, '{}', 'nice item', 0.25),
	('Wintergreen_Berry', 'Wintergreen Berry', 100, 1, 'item_standard', 1, 328, 1, '{}', 'Berries from the wintergreen plant.', 0.25),
	('Wintergreen_Berry_Seed', 'Semente de Gualtéria', 100, 1, 'item_standard', 1, 329, 1, '{}', 'Seeds to cultivate wintergreen berries.', 0.25),
	('Wisteria', 'glicínias', 100, 1, 'item_standard', 1, 330, 1, '{}', 'A flowering plant called Wisteria.', 0.25),
	('Wisteria_Seed', 'semente de wisteria', 100, 1, 'item_standard', 1, 331, 1, '{}', 'Seeds to grow Wisteria plants.', 0.25),
	('wojape', 'viagem', 100, 1, 'item_standard', 1, 332, 1, '{}', 'A traditional Native American sauce made from berries.', 0.25),
	('wolfheart', 'coração de lobo', 100, 1, 'item_standard', 1, 476, 1, '{}', 'The heart of a wolf.', 0.25),
	('wolfpelt', 'pele de lobo', 100, 1, 'item_standard', 1, 477, 1, '{}', 'The skin of a wolf.', 0.25),
	('wolftooth', 'dente de lobo', 100, 1, 'item_standard', 1, 478, 1, '{}', 'A tooth extracted from a wolf.', 0.25),
	('wolf_alfa', 'Poção do lobisomen alfa', 100, 1, NULL, NULL, 215853, 1, '{}', 'nice item', 0.25),
	('wolf_beta', 'Poção do lobisomen beta', 100, 1, 'item_standard', 1, 215852, 1, '{}', 'nice item', 0.25),
	('wolf_comum', 'Poção do lobisomen comum', 100, 1, 'item_standard', 1, 215851, 1, '{}', 'nice item', 0.25),
	('woman_idcard', 'Identificação', 1, 1, 'item_standard', 1, 215654, 1, '{}', 'Identity card with information written on it', 0.25),
	('wood', 'madeira macia', 100, 1, 'item_standard', 1, 333, 1, '{}', 'A type of wood that is soft and easy to work with.', 0.25),
	('woodbench', 'Banco de madeira', 100, 1, 'item_standard', 1, 777, 1, '{}', 'A bench made from wood material.', 0.25),
	('woodchair', 'cadeira de madeira', 100, 1, 'item_standard', 1, 747, 1, '{}', 'A chair made from wood material.', 0.25),
	('wooden_bench', 'Banco de madeira', 100, 1, 'item_standard', 1, 649, 1, '{}', 'A bench constructed with wooden material.', 0.25),
	('wooden_boards', 'Pranchas de madeira', 100, 1, 'item_standard', 1, 334, 1, '{}', 'Boards made from wood material.', 0.25),
	('woodpeck01_c', 'pica-pau', 100, 1, 'item_standard', 1, 445, 1, '{}', 'The skin and feathers of a woodpecker.', 0.25),
	('woodpeck02_c', 'pica-pau 2', 100, 1, 'item_standard', 1, 446, 1, '{}', 'The skin and feathers of a woodpecker.', 0.25),
	('woodsaw', 'Serra de madeira', 100, 1, 'item_standard', 1, 1809, 1, '{}', 'Used to cut wood.', 0.25),
	('wood_chair', 'cadeira de madeira', 100, 1, 'item_standard', 1, 619, 1, '{}', 'A chair made from wood material.', 0.25),
	('wood_plane', 'avião de madeira', 100, 1, 'item_standard', 1, 1810, 1, '{}', 'A wood plane used for shaping wood.', 0.25),
	('wood_vieja', 'Madeira para entrega', 100, 1, 'item_standard', 1, 17275, 1, '{}', 'nice item', 0.25),
	('wool', 'Lã', 100, 1, 'item_standard', 1, 335, 1, '{}', 'Fiber obtained from the fleece of sheep.', 0.25),
	('wrench', 'chave inglesa', 100, 1, 'item_standard', 1, 1811, 1, '{}', 'A wrech used to tighten bolts and other things.', 0.25),
	('wsnakes', 'pele de cascavel ocidental', 100, 1, 'item_standard', 1, 489, 1, '{}', 'The skin of a western rattlesnake.', 0.25),
	('wsnakeskin', 'pele de cobra dágua', 100, 1, 'item_standard', 1, 485, 1, '{}', 'The skin of a watersnake.', 0.25),
	('Yarrow', 'Yarrow', 30, 1, 'item_standard', 1, 336, 1, '{}', 'A flowering plant known as Yarrow.', 0.25),
	('Yarrow_Seed', 'semente de milefólio', 100, 1, 'item_standard', 1, 337, 1, '{}', 'Seeds to grow Yarrow plants.', 0.25),
	('yuccaleaf', 'Yucca Leaf', 50, 1, 'item_standard', 1, 17689, 1, '{}', 'an item', 0.25);

-- Copiando estrutura para tabela baseexclusivav2.items_crafted
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

-- Copiando dados para a tabela baseexclusivav2.items_crafted: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.item_group
CREATE TABLE IF NOT EXISTS `item_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL COMMENT 'Description of Item Group',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.item_group: ~1 rows (aproximadamente)
INSERT IGNORE INTO `item_group` (`id`, `description`) VALUES
	(1, 'default');

-- Copiando estrutura para tabela baseexclusivav2.jail
CREATE TABLE IF NOT EXISTS `jail` (
  `identifier` varchar(100) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '0',
  `characterid` varchar(5) NOT NULL DEFAULT '0',
  `time` varchar(100) NOT NULL DEFAULT '0',
  `time_s` varchar(100) NOT NULL DEFAULT '0',
  `jaillocation` varchar(100) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela baseexclusivav2.jail: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.jaildata
CREATE TABLE IF NOT EXISTS `jaildata` (
  `identifier` varchar(600) NOT NULL DEFAULT '0',
  `charid` varchar(100) NOT NULL DEFAULT '0',
  `name` varchar(500) DEFAULT '',
  `fromTime` datetime DEFAULT NULL,
  `toTime` datetime DEFAULT NULL,
  `jailTime` varchar(255) DEFAULT NULL,
  `escape` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.jaildata: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.jailwork
CREATE TABLE IF NOT EXISTS `jailwork` (
  `identifier` varchar(600) NOT NULL DEFAULT '0',
  `charid` varchar(100) NOT NULL DEFAULT '0',
  `city` varchar(500) DEFAULT '',
  `workCount` varchar(255) DEFAULT NULL,
  `workTime` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.jailwork: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.loadout
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
  `label` varchar(50) DEFAULT NULL,
  `curr_inv` varchar(100) NOT NULL DEFAULT 'default',
  `serial_number` varchar(50) DEFAULT NULL,
  `custom_label` varchar(50) DEFAULT NULL,
  `custom_desc` varchar(50) DEFAULT NULL,
  `dropped` int(11) NOT NULL DEFAULT 0,
  `comps` longtext DEFAULT '{}',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.loadout: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mail
CREATE TABLE IF NOT EXISTS `mail` (
  `address` int(11) NOT NULL AUTO_INCREMENT,
  `charidentifier` int(11) DEFAULT NULL,
  PRIMARY KEY (`address`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mail: ~7 rows (aproximadamente)
INSERT IGNORE INTO `mail` (`address`, `charidentifier`) VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 5),
	(6, 6),
	(7, 7);

-- Copiando estrutura para tabela baseexclusivav2.mailboxes
CREATE TABLE IF NOT EXISTS `mailboxes` (
  `char_identifier` varchar(255) DEFAULT NULL,
  `mailbox_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`mailbox_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mailboxes: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mailbox_mails
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

-- Copiando dados para a tabela baseexclusivav2.mailbox_mails: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mailbox_messages
CREATE TABLE IF NOT EXISTS `mailbox_messages` (
  `from_char` varchar(255) DEFAULT NULL,
  `to_char` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `timestamp` datetime DEFAULT current_timestamp(),
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eta_timestamp` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mailbox_messages: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mails
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mails: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mail_addressbook
CREATE TABLE IF NOT EXISTS `mail_addressbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `poBox` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `address` (`address`),
  CONSTRAINT `mail_addressbook_ibfk_1` FOREIGN KEY (`address`) REFERENCES `mail` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mail_addressbook: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mail_editablefolders
CREATE TABLE IF NOT EXISTS `mail_editablefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` int(11) DEFAULT NULL,
  `folderName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `address` (`address`),
  CONSTRAINT `mail_editablefolders_ibfk_1` FOREIGN KEY (`address`) REFERENCES `mail` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mail_editablefolders: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mdg_bank
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

-- Copiando dados para a tabela baseexclusivav2.mdg_bank: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mdg_clothes_state
CREATE TABLE IF NOT EXISTS `mdg_clothes_state` (
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `category` varchar(20) NOT NULL,
  `state` int(11) NOT NULL,
  PRIMARY KEY (`identifier`,`charid`,`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mdg_clothes_state: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mdg_farming
CREATE TABLE IF NOT EXISTS `mdg_farming` (
  `plant_id` int(40) NOT NULL AUTO_INCREMENT,
  `plant_coords` longtext NOT NULL,
  `plant_type` varchar(40) NOT NULL,
  `plant_watered` char(6) NOT NULL DEFAULT 'false',
  `time_left` varchar(100) NOT NULL,
  `plant_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `plant_owner` int(40) NOT NULL,
  PRIMARY KEY (`plant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mdg_farming: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mdg_horses
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mdg_horses: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mdg_horses_stats
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mdg_horses_stats: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mdg_ident
CREATE TABLE IF NOT EXISTS `mdg_ident` (
  `steam` varchar(255) DEFAULT NULL,
  `charid` varchar(50) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mdg_ident: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mdg_madame_nazar
CREATE TABLE IF NOT EXISTS `mdg_madame_nazar` (
  `charid` int(11) DEFAULT NULL,
  `identifier` varchar(100) DEFAULT NULL,
  `mdg_madame_nazar` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mdg_madame_nazar: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mdg_outfits
CREATE TABLE IF NOT EXISTS `mdg_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) NOT NULL,
  `charid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `outfit` varchar(5000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`,`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mdg_outfits: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mdg_stable_bought
CREATE TABLE IF NOT EXISTS `mdg_stable_bought` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charid` int(11) NOT NULL,
  `category` varchar(50) NOT NULL,
  `hash` bigint(20) NOT NULL,
  `equiped_on` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`,`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mdg_stable_bought: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mdg_stable_color
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mdg_stable_color: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mdg_vip
CREATE TABLE IF NOT EXISTS `mdg_vip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` text DEFAULT NULL,
  `charid` int(11) DEFAULT NULL,
  `vip` text DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `charid` (`charid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mdg_vip: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mdg_wagons
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mdg_wagons: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.mms_huntingid
CREATE TABLE IF NOT EXISTS `mms_huntingid` (
  `identifier` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `age` varchar(50) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `picture` longtext DEFAULT NULL,
  `days` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela baseexclusivav2.mms_huntingid: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.moonshiner
CREATE TABLE IF NOT EXISTS `moonshiner` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object` text NOT NULL DEFAULT '',
  `xpos` float NOT NULL,
  `ypos` float NOT NULL,
  `zpos` float NOT NULL,
  `actif` int(10) unsigned DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.moonshiner: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.moonshiner_plants
CREATE TABLE IF NOT EXISTS `moonshiner_plants` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object` text NOT NULL DEFAULT '',
  `xpos` float NOT NULL,
  `ypos` float NOT NULL,
  `zpos` float NOT NULL,
  `cooldown` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.moonshiner_plants: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.newspaper
CREATE TABLE IF NOT EXISTS `newspaper` (
  `news` longtext DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.newspaper: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.notepad
CREATE TABLE IF NOT EXISTS `notepad` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `charidentifier` int(11) NOT NULL,
  `message` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `charidentifier` (`charidentifier`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela baseexclusivav2.notepad: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.oil
CREATE TABLE IF NOT EXISTS `oil` (
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `manager_trust` int(100) NOT NULL DEFAULT 0,
  `enemy_trust` int(100) NOT NULL DEFAULT 0,
  `oil_wagon` varchar(50) NOT NULL DEFAULT 'none',
  `delivery_wagon` varchar(50) NOT NULL DEFAULT 'none',
  UNIQUE KEY `charidentifier` (`charidentifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.oil: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.outfits
CREATE TABLE IF NOT EXISTS `outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(45) NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `comps` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela baseexclusivav2.outfits: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.outfitter
CREATE TABLE IF NOT EXISTS `outfitter` (
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `props` longtext DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.outfitter: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.pets
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

-- Copiando dados para a tabela baseexclusivav2.pets: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.playerfarms
CREATE TABLE IF NOT EXISTS `playerfarms` (
  `charid` int(11) NOT NULL,
  `farm` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.playerfarms: ~2 rows (aproximadamente)
INSERT IGNORE INTO `playerfarms` (`charid`, `farm`) VALUES
	(1, '1'),
	(2, '1');

-- Copiando estrutura para tabela baseexclusivav2.playerfarmsdex
CREATE TABLE IF NOT EXISTS `playerfarmsdex` (
  `dex` longtext DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.playerfarmsdex: ~3 rows (aproximadamente)
INSERT IGNORE INTO `playerfarmsdex` (`dex`) VALUES
	('0'),
	('0'),
	('0');

-- Copiando estrutura para tabela baseexclusivav2.playerhousing
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
  `motel` longtext DEFAULT '0',
  `taxledger` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `primarydoor` (`primarydoor`(768))
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.playerhousing: ~106 rows (aproximadamente)
INSERT IGNORE INTO `playerhousing` (`id`, `type`, `primarydoor`, `otherdoors`, `range`, `owned`, `selleridentifier`, `sellercharidentifier`, `ledger`, `tax`, `repoed`, `invspace`, `upgrade`, `keyholders`, `changingroom`, `inventorylocation`, `items`, `furniture`, `price`, `buyeridentifier`, `buyercharidentifier`, `motel`, `taxledger`) VALUES
	(56, 3, '[{"y":-2364.12890625,"z":62.64009475708008,"x":-2354.70947265625}]', '[]', 30, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(57, 3, '[{"y":-2375.883056640625,"z":62.5806655883789,"x":-2342.733642578125}]', '[]', 30, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(58, 0, '[{"objYaw1":-0.00245725456625,"doorhash":2140469041,"y":-2380.882080078125,"z":60.24148941040039,"objYaw3":-109.7459945678711,"entit":9140483,"x":-2392.529052734375,"doorname":"p_door_val_barn03","locked":true,"objYaw2":0.00122485146857,"q":61.0414894104004,"o":-2394.629052734373,"objc":1857124294,"p":-2380.882080078125}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 500, 0, 5000, 0, '[]', '[]', '[]', '[]', '[]', 100000, '0', 0, '0', 0),
	(59, 3, '[{"y":-2381.2412109375,"z":61.1755485534668,"x":-2404.831787109375}]', '[]', 30, 0, 'steam:11000013527d62e', 0, 0, 500, 0, 5000, 0, '[]', '[]', '[]', '[]', '[]', 100000, '0', 0, '0', 0),
	(60, 0, '[{"objYaw1":0.00330931670032,"doorhash":381701909,"y":-3035.43115234375,"z":-10.6360855102539,"objYaw3":19.62731170654297,"entit":4705028,"x":-2024.5302734375,"doorname":"p_door_vanhorne_l_01x","locked":true,"objYaw2":0.00052323489217,"q":-10.6360855102539,"o":-2024.5302734375,"objc":752062586,"p":-3035.43115234375}]', '[]', 0, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 15000, '0', 0, '0', 0),
	(61, 0, '[{"objYaw1":0.00375616061501,"doorhash":-494116837,"y":-3302.110595703125,"z":-5.3948917388916,"objYaw3":165.0208740234375,"entit":5433348,"x":-3400.035400390625,"doorname":"p_door35x","locked":true,"objYaw2":-0.00222451961599,"q":-5.3948917388916,"o":-3400.035400390625,"objc":3045682143,"p":-3302.110595703125}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 300, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(62, 0, '[{"objYaw1":0.0,"doorhash":-494116837,"y":0.0,"z":0.0,"objYaw3":0.0,"entit":5433348,"x":0.0,"doorname":"p_door35x","locked":true,"objYaw2":0.0,"q":0.0,"o":0.0,"objc":3045682143,"p":0.0}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 300, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 5000, '0', 0, '0', 0),
	(63, 0, '[{"objYaw1":0.0,"doorhash":-494116837,"y":0.0,"z":0.0,"objYaw3":0.0,"entit":5433348,"x":0.0,"doorname":"p_door35x","locked":true,"objYaw2":0.0,"q":0.0,"o":0.0,"objc":3045682143,"p":0.0}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 300, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 5000, '0', 0, '0', 0),
	(64, 3, '[{"y":-2076.773193359375,"z":-13.11700820922851,"x":-3563.580078125}]', '[]', 15, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 150, 0, '[]', '[]', '[]', '[]', '[]', 800, '0', 0, '0', 0),
	(65, 0, '[{"objYaw1":0.00415064627304,"doorhash":381701909,"y":-2129.394775390625,"z":-5.23546171188354,"objYaw3":-37.90860366821289,"entit":8806404,"x":-3958.39013671875,"doorname":"p_door_vanhorne_l_01x","locked":true,"objYaw2":-0.00059013243298,"q":-5.23546171188354,"o":-3958.39013671875,"objc":4164042403,"p":-2129.394775390625}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 400, 0, 2000, 0, '[]', '[]', '[]', '[]', '[]', 40000, '0', 0, '0', 0),
	(66, 3, '[{"y":-2781.662109375,"z":-14.43531608581543,"x":-3947.797607421875}]', '[]', 15, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 200, 0, '[]', '[]', '[]', '[]', '[]', 800, '0', 0, '0', 0),
	(67, 3, '[{"y":-2778.91455078125,"z":-15.12116336822509,"x":-3919.136474609375}]', '[]', 20, 0, 'steam:11000013527d62e', 0, 0, 300, 0, 200, 0, '[]', '[]', '[]', '[]', '[]', 850, '0', 0, '0', 0),
	(68, 0, '[{"objYaw1":0.0,"doorhash":381701909,"y":0.0,"z":0.0,"objYaw3":0.0,"entit":8806404,"x":0.0,"doorname":"p_door_vanhorne_l_01x","locked":true,"objYaw2":0.0,"q":0.0,"o":0.0,"objc":4164042403,"p":0.0}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(69, 3, '[{"y":-2753.123291015625,"z":-10.00943183898925,"x":-4575.00634765625}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(70, 3, '[{"y":-3338.604248046875,"z":26.77538681030273,"x":-4642.72802734375}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(71, 3, '[{"y":-3749.7734375,"z":12.96320724487304,"x":-4691.02685546875}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 250, 0, '[]', '[]', '[]', '[]', '[]', 1000, '0', 0, '0', 0),
	(72, 3, '[{"y":-3861.230712890625,"z":-2.92754626274108,"x":-5241.232421875}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 100, 0, '[]', '[]', '[]', '[]', '[]', 500, '0', 0, '0', 0),
	(73, 3, '[{"y":-2757.935791015625,"z":-4.20621919631958,"x":-5877.380859375}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(74, 3, '[{"y":-2721.59765625,"z":74.62751007080078,"x":-2513.275146484375}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 5000, '0', 0, '0', 0),
	(75, 0, '[{"objYaw1":0.0,"doorhash":381701909,"y":0.0,"z":0.0,"objYaw3":0.0,"entit":8806404,"x":0.0,"doorname":"p_door_vanhorne_l_01x","locked":true,"objYaw2":0.0,"q":0.0,"o":0.0,"objc":4164042403,"p":0.0}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(76, 3, '[{"y":-2309.12109375,"z":44.51511764526367,"x":-1446.344482421875}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(77, 0, '[{"objYaw1":0.00068209390155,"doorhash":-198436444,"y":-2297.09423828125,"z":42.52842712402344,"objYaw3":92.63249206542969,"entit":6620165,"x":-1396.64501953125,"doorname":"p_door02x","locked":true,"objYaw2":-0.00276186992414,"q":42.52842712402344,"o":-1396.64501953125,"objc":3015951957,"p":-2297.09423828125}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 400, 0, 2000, 0, '[]', '[]', '[]', '[]', '[]', 40000, '0', 0, '0', 0),
	(78, 3, '[{"y":-1122.9620361328126,"z":43.09983444213867,"x":-373.3589782714844}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 400, 0, 2000, 0, '[]', '[]', '[]', '[]', '[]', 40000, '0', 0, '0', 0),
	(79, 3, '[{"y":-1073.923095703125,"z":76.51075744628906,"x":-1397.1680908203126}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 300, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(80, 0, '[{"objYaw1":-0.00212365319021,"doorhash":-1896437095,"y":-1665.6856689453126,"z":117.19026184082031,"objYaw3":-138.6486053466797,"entit":1182470,"x":-1976.21044921875,"doorname":"p_doorsgl02x","locked":true,"objYaw2":-0.00009243514796,"q":117.19026184082031,"o":-1976.21044921875,"objc":3268076220,"p":-1665.6856689453126}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 400, 0, 2000, 0, '[]', '[]', '[]', '[]', '[]', 40000, '0', 0, '0', 0),
	(81, 3, '[{"y":-1335.501708984375,"z":134.79222106933595,"x":-2195.924072265625}]', '[]', 10, 0, 'steam:11000013527d62e', 0, 0, 100, 0, 50, 0, '[]', '[]', '[]', '[]', '[]', 300, '0', 0, '0', 0),
	(82, 3, '[{"y":-1151.6146240234376,"z":132.1136016845703,"x":-2135.019287109375}]', '[]', 10, 0, 'steam:11000013527d62e', 0, 0, 200, 0, 80, 0, '[]', '[]', '[]', '[]', '[]', 500, '0', 0, '0', 0),
	(83, 3, '[{"y":-1341.753662109375,"z":133.0936737060547,"x":-2250.7705078125}]', '[]', 10, 0, 'steam:11000013527d62e', 0, 0, 300, 0, 100, 0, '[]', '[]', '[]', '[]', '[]', 600, '0', 0, '0', 0),
	(84, 3, '[{"y":-1847.677490234375,"z":117.79009246826172,"x":-1949.5438232421876}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(85, 3, '[{"y":-1563.5872802734376,"x":-2195.7734375,"z":150.57151794433595}]', '[]', 10, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 100, 0, '[]', '[]', '[]', '[]', '[]', 500, '0', 0, '0', 0),
	(86, 0, '[{"y":-1385.151611328125,"x":-2578.885009765625,"z":148.26223754882813,"objc":663425326,"o":-2578.885009765625,"objYaw2":0.00399518152698,"entit":2037762,"doorhash":-559000589,"doorname":"p_door_wornbarn_l","objYaw1":-0.00123351521324,"objYaw3":86.99998474121094,"p":-1385.151611328125,"q":148.26223754882813,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 400, 0, 2000, 0, '[]', '[]', '[]', '[]', '[]', 40000, '0', 0, '0', 0),
	(87, 3, '[{"y":563.81884765625,"x":-2547.285400390625,"z":140.58082580566407}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(88, 3, '[{"y":602.263916015625,"x":-1708.4283447265626,"z":118.86161041259766}]', '[]', 10, 0, 'steam:11000013527d62e', 0, 0, 300, 0, 100, 0, '[]', '[]', '[]', '[]', '[]', 700, '0', 0, '0', 0),
	(89, 3, '[{"y":494.8358459472656,"x":-1577.7430419921876,"z":114.88043212890625}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 300, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(90, 3, '[{"y":487.900634765625,"x":-1341.701171875,"z":96.7171401977539}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 300, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(91, 3, '[{"y":320.74945068359377,"x":-1188.5546875,"z":43.99455261230469}]', '[]', 15, 0, 'steam:11000013527d62e', 0, 0, 300, 0, 150, 0, '[]', '[]', '[]', '[]', '[]', 1000, '0', 0, '0', 0),
	(92, 3, '[{"y":-304.90264892578127,"x":-1528.5645751953126,"z":142.42771911621095}]', '[]', 10, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 100, 0, '[]', '[]', '[]', '[]', '[]', 650, '0', 0, '0', 0),
	(93, 0, '[{"y":-666.0537109375,"x":347.2471618652344,"z":41.8227653503418,"objc":3238637478,"o":347.2471618652344,"objYaw2":-0.00041079256334,"entit":2888963,"doorhash":-542955242,"doorname":"p_door04x","objYaw1":0.00055469613289,"objYaw3":-119.85211181640625,"p":-666.0537109375,"q":41.8227653503418,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 600, 0, 4000, 0, '[]', '[]', '[]', '[]', '[]', 55000, '0', 0, '0', 0),
	(94, 3, '[{"y":-924.9415283203125,"x":756.8377075195313,"z":51.49743270874023}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(95, 3, '[{"y":-997.9549560546875,"x":682.7130126953125,"z":53.42073822021484}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(96, 3, '[{"y":-1236.9859619140626,"x":813.802734375,"z":41.54409027099609}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 400, 0, 2000, 0, '[]', '[]', '[]', '[]', '[]', 40000, '0', 0, '0', 0),
	(97, 0, '[{"y":-1762.0413818359376,"x":1012.202880859375,"z":46.59971618652344,"objc":1595076728,"o":1012.202880859375,"objYaw2":0.00051821937086,"entit":4677379,"doorhash":-1242609382,"doorname":"p_doorbrafrench01rx","objYaw1":-0.00081050797598,"objYaw3":0.15932136774063,"p":-1762.0413818359376,"q":46.59971618652344,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 1000, 0, 10000, 0, '[]', '[]', '[]', '[]', '[]', 250000, '0', 0, '0', 0),
	(98, 3, '[{"y":-1924.3880615234376,"x":902.9920043945313,"z":46.29098892211914}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(99, 3, '[{"y":-1929.994384765625,"x":877.575927734375,"z":46.5369987487793}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(100, 3, '[{"y":-1926.7509765625,"x":862.1304321289063,"z":44.83073425292969}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(101, 3, '[{"y":-1906.92578125,"x":856.387451171875,"z":44.55820846557617}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(102, 3, '[{"y":-1898.716796875,"x":882.17626953125,"z":45.7829704284668}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(103, 3, '[{"y":-1911.792236328125,"x":827.9852905273438,"z":42.50057601928711}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(104, 0, '[{"y":-1989.71923828125,"x":1115.8668212890626,"z":54.37628936767578,"objc":3921310299,"o":1115.8668212890626,"objYaw2":-0.00104172015562,"entit":6447619,"doorhash":1064769829,"doorname":"p_doorbrait01bx","objYaw1":0.0011052271584,"objYaw3":115.28375244140625,"p":-1989.71923828125,"q":54.37628936767578,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(105, 3, '[{"y":-2115.17822265625,"x":947.900390625,"z":44.98806762695312}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(106, 3, '[{"y":-2183.244140625,"x":1177.6839599609376,"z":55.13246536254883}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(108, 0, '[{"y":-2279.413330078125,"x":1322.451171875,"z":49.52224349975586,"objc":3184160386,"o":1322.451171875,"objYaw2":-0.00117967661935,"entit":7328259,"doorhash":-542955242,"doorname":"p_door04x","objYaw1":-0.00172525155358,"objYaw3":-55.42268753051758,"p":-2279.413330078125,"q":49.52224349975586,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 500, 0, 4000, 0, '[]', '[]', '[]', '[]', '[]', 55000, '0', 0, '0', 0),
	(109, 3, '[{"y":-2050.328369140625,"x":1557.4727783203126,"z":48.47686386108398}]', '[]', 5, 0, 'steam:11000013527d62e', 0, 0, 100, 0, 50, 0, '[]', '[]', '[]', '[]', '[]', 500, '0', 0, '0', 0),
	(110, 3, '[{"y":-2004.68798828125,"x":1702.9815673828126,"z":44.69564437866211}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(111, 0, '[{"y":-1859.18701171875,"x":1890.6436767578126,"z":42.14753723144531,"objc":560870147,"o":1890.6436767578126,"objYaw2":0.0,"entit":8665347,"doorhash":-832187622,"doorname":"p_door_sha_man01x","objYaw1":0.0,"objYaw3":49.99995803833008,"p":-1859.18701171875,"q":42.14753723144531,"locked":true}]', '[]', 100, 0, 'steam:11000013527d62e', 0, 0, 800, 0, 6000, 0, '[]', '[]', '[]', '[]', '[]', 100000, '0', 0, '0', 0),
	(112, 0, '[{"y":-1820.0478515625,"x":2085.89990234375,"z":41.93658828735351,"objc":576237455,"o":2085.89990234375,"objYaw2":-0.00033514277311,"entit":9000963,"doorhash":-312814636,"doorname":"p_door44x","objYaw1":0.00045405293349,"objYaw3":-45.39992904663086,"p":-1820.0478515625,"q":41.93658828735351,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(113, 3, '[{"y":-1655.5894775390626,"x":1623.887939453125,"z":57.10466003417969}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(114, 3, '[{"y":-754.5220336914063,"x":1877.475341796875,"z":41.87331008911133}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(115, 3, '[{"y":-731.2496948242188,"x":1935.4884033203126,"z":43.93386459350586}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(116, 3, '[{"y":-774.185791015625,"x":2023.72314453125,"z":42.83605575561523}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(117, 3, '[{"y":-555.293701171875,"x":2119.366455078125,"z":42.70928955078125}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(118, 3, '[{"y":-589.645263671875,"x":2122.697265625,"z":42.5920181274414}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(119, 3, '[{"y":-611.2444458007813,"x":2097.802978515625,"z":41.87373352050781}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(120, 3, '[{"y":-639.9622802734375,"x":2138.279296875,"z":42.64064025878906}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(121, 3, '[{"y":-619.8999633789063,"x":2162.307861328125,"z":42.88368225097656}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(122, 0, '[{"y":-781.6597290039063,"x":2252.362060546875,"z":43.16554260253906,"objc":3419719645,"o":2252.362060546875,"objYaw2":0.00015412544598,"entit":2260484,"doorhash":-1013636887,"doorname":"p_door64b","objYaw1":-0.00005175632395,"objYaw3":178.5775604248047,"p":-781.6597290039063,"q":43.16554260253906,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 400, 0, 2000, 0, '[]', '[]', '[]', '[]', '[]', 40000, '0', 0, '0', 0),
	(123, 0, '[{"y":-774.4063720703125,"x":2235.05029296875,"z":42.52364730834961,"objc":675165849,"o":2235.05029296875,"objYaw2":0.00020734763529,"entit":2616068,"doorhash":-2087217357,"doorname":"p_doorsgl01x","objYaw1":0.0030222502537,"objYaw3":71.18513488769531,"p":-774.4063720703125,"q":42.52364730834961,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 400, 0, 2000, 0, '[]', '[]', '[]', '[]', '[]', 40000, '0', 0, '0', 0),
	(124, 0, '[{"y":-420.4801940917969,"x":2493.847412109375,"z":43.35696411132812,"objc":97826448,"o":2493.847412109375,"objYaw2":-0.00095143419457,"entit":3099908,"doorhash":724635024,"doorname":"p_doorsglw01x","objYaw1":-0.00079324527177,"objYaw3":35.29582214355469,"p":-420.4801940917969,"q":43.35696411132812,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 400, 0, 2000, 0, '[]', '[]', '[]', '[]', '[]', 40000, '0', 0, '0', 0),
	(126, 0, '[{"y":-1095.56494140625,"x":2402.51416015625,"z":46.4254150390625,"objc":3763675028,"o":2402.51416015625,"objYaw2":-0.00209755892865,"entit":8012036,"doorhash":2081678501,"doorname":"p_doornbd26x","objYaw1":-0.0005856603384,"objYaw3":179.61880493164063,"p":-1095.56494140625,"q":46.4254150390625,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 1000, 0, 10000, 0, '[]', '[]', '[]', '[]', '[]', 250000, '0', 0, '0', 0),
	(127, 0, '[{"y":-1217.3890380859376,"x":2387.641845703125,"z":46.15700531005859,"objc":1291327218,"o":2387.641845703125,"objYaw2":0.0005055090296,"entit":8721924,"doorhash":-101383214,"doorname":"p_doornbd39bx","objYaw1":-0.00161161529831,"objYaw3":89.7908935546875,"p":-1217.3890380859376,"q":46.15700531005859,"locked":true}]', '[]', 100, 0, 'steam:11000013527d62e', 0, 0, 1000, 0, 10000, 0, '[]', '[]', '[]', '[]', '[]', 250000, '0', 0, '0', 0),
	(128, 0, '[{"y":-864.4381103515625,"x":2370.87158203125,"z":42.04008865356445,"objc":862008394,"o":2370.87158203125,"objYaw2":-0.00138618354685,"entit":2266629,"doorhash":1064769829,"doorname":"p_doorbrait01bx","objYaw1":0.00025816910783,"objYaw3":19.61510276794433,"p":-864.4381103515625,"q":42.04008865356445,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(129, 0, '[{"y":-332.542236328125,"x":2307.081787109375,"z":40.892578125,"objc":3108731901,"o":2307.081787109375,"objYaw2":-0.00219132285565,"entit":3329029,"doorhash":381701909,"doorname":"p_door_vanhorne_l_01x","objYaw1":0.00227600918151,"objYaw3":-40.1596565246582,"p":-332.542236328125,"q":40.892578125,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(130, 3, '[{"y":-382.03118896484377,"x":2274.736328125,"z":42.2156867980957}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(131, 3, '[{"y":-70.70096588134766,"x":2559.044921875,"z":50.32414627075195}]', '[]', 5, 0, 'steam:11000013527d62e', 0, 0, 200, 0, 50, 0, '[]', '[]', '[]', '[]', '[]', 300, '0', 0, '0', 0),
	(132, 0, '[{"y":278.9087829589844,"x":2820.560546875,"z":50.09118270874023,"objc":1431398235,"o":2820.560546875,"objYaw2":-0.00185151107143,"entit":3997701,"doorhash":-1800129672,"doorname":"p_door36x","objYaw1":-0.0022645459976,"objYaw3":-135.1540069580078,"p":278.9087829589844,"q":50.09118270874023,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 500, 0, 4000, 0, '[]', '[]', '[]', '[]', '[]', 55000, '0', 0, '0', 0),
	(133, 3, '[{"y":536.2284545898438,"x":2796.240966796875,"z":67.80451965332031}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 400, 0, 2000, 0, '[]', '[]', '[]', '[]', '[]', 40000, '0', 0, '0', 0),
	(134, 3, '[{"y":1428.788330078125,"x":3406.966064453125,"z":50.19422149658203}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(135, 3, '[{"y":2006.25244140625,"x":2795.33642578125,"z":165.11878967285157}]', '[]', 10, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 100, 0, '[]', '[]', '[]', '[]', '[]', 300, '0', 0, '0', 0),
	(136, 0, '[{"y":1195.0826416015626,"x":1981.9656982421876,"z":170.4177703857422,"objc":784290387,"o":1981.9656982421876,"objYaw2":-0.00118990102782,"entit":9609733,"doorhash":-198436444,"doorname":"p_door02x","objYaw1":0.0001525436819,"objYaw3":-124.95770263671875,"p":1195.0826416015626,"q":170.4177703857422,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 400, 0, 2000, 0, '[]', '[]', '[]', '[]', '[]', 40000, '0', 0, '0', 0),
	(137, 0, '[{"y":1508.237548828125,"x":1697.4677734375,"z":146.8824005126953,"objc":868379185,"o":1697.4677734375,"objYaw2":-0.00078823731746,"entit":676614,"doorhash":-2080420985,"doorname":"p_door41x","objYaw1":-0.00061422347789,"objYaw3":100.04795837402344,"p":1508.237548828125,"q":146.8824005126953,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 500, 0, 4000, 0, '[]', '[]', '[]', '[]', '[]', 55000, '0', 0, '0', 0),
	(138, 0, '[{"y":1949.030517578125,"x":1933.5963134765626,"z":265.1184997558594,"objc":1981171235,"o":1933.5963134765626,"objYaw2":0.00010901765926,"entit":630534,"doorhash":-1497029950,"doorname":"p_door37x","objYaw1":-0.00010894297884,"objYaw3":-175.27951049804688,"p":1949.030517578125,"q":265.1184997558594,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 500, 0, 4000, 0, '[]', '[]', '[]', '[]', '[]', 55000, '0', 0, '0', 0),
	(139, 3, '[{"y":1323.1285400390626,"x":1394.640869140625,"z":164.9693603515625}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(140, 3, '[{"y":1411.246826171875,"x":108.62953186035156,"z":167.68048095703126}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(141, 0, '[{"y":0.0,"x":0.0,"z":0.0,"objc":1981171235,"o":0.0,"objYaw2":0.0,"entit":630534,"doorhash":-1497029950,"doorname":"p_door37x","objYaw1":0.0,"objYaw3":0.0,"p":0.0,"q":0.0,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(142, 0, '[{"y":2174.03173828125,"x":-950.0465087890625,"z":341.2434997558594,"objc":415985340,"o":-950.0465087890625,"objYaw2":-0.00128735217731,"entit":2999302,"doorhash":-2087217357,"doorname":"p_doorsgl01x","objYaw1":0.00012734542542,"objYaw3":-131.7228240966797,"p":2174.03173828125,"q":341.2434997558594,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(143, 0, '[{"y":2160.2041015625,"x":-1959.185302734375,"z":326.5538024902344,"objc":943176298,"o":-1959.185302734375,"objYaw2":-0.93879055976867,"entit":3480070,"doorhash":-58075500,"doorname":"p_doorsnow01x","objYaw1":0.04276575148105,"objYaw3":-92.44914245605469,"p":2160.2041015625,"q":326.5538024902344,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(144, 3, '[{"y":-86.36605072021485,"x":-1724.813720703125,"z":181.68812561035157}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 500, 0, 4000, 0, '[]', '[]', '[]', '[]', '[]', 55000, '0', 0, '0', 0),
	(145, 3, '[{"y":-792.1021118164063,"x":-1504.0986328125,"z":104.43543243408203}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(146, 0, '[{"y":1042.918701171875,"x":-692.4357299804688,"z":134.02398681640626,"objc":1434140379,"o":-692.4357299804688,"objYaw2":-0.00073577411239,"entit":5603846,"doorhash":-1896437095,"doorname":"p_doorsgl02x","objYaw1":-0.00088774744654,"objYaw3":-54.83114624023437,"p":1042.918701171875,"q":134.02398681640626,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 400, 0, 2000, 0, '[]', '[]', '[]', '[]', '[]', 40000, '0', 0, '0', 0),
	(147, 0, '[{"y":1235.8369140625,"x":-67.30318450927735,"z":169.76470947265626,"objc":202296518,"o":-67.30318450927735,"objYaw2":-0.00009583241626,"entit":6451206,"doorhash":-312814636,"doorname":"p_door44x","objYaw1":-0.00005367494668,"objYaw3":-59.51001358032226,"p":1235.8369140625,"q":169.76470947265626,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 500, 0, 4000, 0, '[]', '[]', '[]', '[]', '[]', 55000, '0', 0, '0', 0),
	(148, 0, '[{"y":581.261474609375,"x":1867.089599609375,"z":112.83411407470703,"objc":4152022251,"o":1867.089599609375,"objYaw2":0.0000531849073,"entit":7343622,"doorhash":-312814636,"doorname":"p_door44x","objYaw1":-0.00003116136576,"objYaw3":159.01197814941407,"p":581.261474609375,"q":112.83411407470703,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(149, 3, '[{"y":622.3104858398438,"x":2015.2802734375,"z":158.71701049804688}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(150, 0, '[{"y":298.04620361328127,"x":1888.1182861328126,"z":76.07588958740235,"objc":2821676992,"o":1888.1182861328126,"objYaw2":0.00034091676934,"entit":7883014,"doorhash":-1896437095,"doorname":"p_doorsgl02x","objYaw1":0.00159994501154,"objYaw3":91.68618774414063,"p":298.04620361328127,"q":76.07588958740235,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 500, 0, 4000, 0, '[]', '[]', '[]', '[]', '[]', 55000, '0', 0, '0', 0),
	(151, 3, '[{"y":-1131.8751220703126,"x":1296.4688720703126,"z":81.96015930175781}]', '[]', 25, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(152, 3, '[{"y":-1144.59521484375,"x":1296.9976806640626,"z":82.18096923828125}]', '[]', 15, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(153, 0, '[{"y":-2085.1904296875,"x":1385.132568359375,"z":51.58380889892578,"objc":2813949612,"o":1385.132568359375,"objYaw2":0.00053729163482,"entit":9984518,"doorhash":1346688635,"doorname":"p_dooraberdeen01x","objYaw1":-0.00172941060736,"objYaw3":-1.1971526145935,"p":-2085.1904296875,"q":51.58380889892578,"locked":true}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 20000, '0', 0, '0', 0),
	(154, 3, '[{"y":-885.5498046875,"x":702.5982055664063,"z":49.26187515258789}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(155, 3, '[{"y":1156.2412109375,"x":1251.3984375,"z":151.20701599121095}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(156, 3, '[{"z":143.83621215820313,"y":-241.10565185546876,"x":498.8106689453125}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 250, 0, 500, 0, '[]', '[]', '[]', '[]', '[]', 10000, '0', 0, '0', 0),
	(157, 0, '[{"z":113.81051635742188,"y":251.39247131347657,"x":-1556.2320556640626,"objYaw2":-0.00034630074515,"objYaw1":0.00095760507974,"locked":true,"objc":3221874820,"q":113.81051635742188,"p":251.39247131347657,"doorname":"p_door55x","objYaw3":109.60302734375,"doorhash":1288759240,"entit":9412354,"o":-1556.2320556640626}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 5000, 0, '[]', '[]', '[]', '[]', '[]', 55000, '0', 0, '0', 0),
	(161, 0, '[{"q":189.90150451660157,"o":215.7074432373047,"doorhash":-198436444,"objYaw2":0.00009209362178,"objc":3598523785,"doorname":"p_door02x","z":189.90150451660157,"y":988.0584716796875,"objYaw1":-0.01682535558938,"p":988.0584716796875,"objYaw3":169.98158264160157,"entit":5448962,"x":215.7074432373047,"locked":true}]', '[]', 350, 0, '0', 0, 0, 350, 0, 5000, 0, '[]', '{"z":190.9001007080078,"x":218.52798461914066,"y":984.56201171875}', '{"z":190.9043731689453,"x":221.05999755859376,"y":987.2465209960938}', '[{"name":"apple","label":"Maçã","type":"item_standard","count":4,"metadata":[],"group":1,"limit":30}]', '[]', 10000, '0', 0, '0', 0),
	(163, 0, '[{"objc":2061942857,"objYaw3":134.7337646484375,"entit":8106754,"o":2472.5888671875,"z":167.22593688964845,"y":2001.875,"p":2002.3749999999996,"doorname":"p_doorsgl02x","x":2472.5888671875,"doorhash":-1896437095,"locked":true,"q":168.32593688964838,"objYaw1":0.03287952765822,"objYaw2":-0.00733053777366}]', '[]', 350, 0, 'steam:11000013527d62e', 0, 0, 150, 0, 1500, 0, '[]', '[]', '[]', '[]', '[]', 1, '0', 0, '0', 0),
	(164, 0, '[{"entit":4250114,"objc":4123766266,"q":117.9155502319336,"objYaw1":0.00528296688571,"o":779.0606689453125,"p":849.5362548828125,"doorname":"p_door_rho_doctor","locked":true,"objYaw3":17.66626167297363,"x":779.0606689453125,"y":849.5362548828125,"z":117.9155502319336,"objYaw2":-0.00007664770237,"doorhash":-1480058065}]', '[]', 450, 0, 'steam:11000013527d62e', 0, 0, 350, 0, 4000, 0, '[]', '[]', '[]', '[]', '[]', 100000, '0', 0, '0', 0),
	(167, 3, '[{"y":-2177.220703125,"z":43.61596298217773,"x":-1415.0660400390626}]', '[]', 100, 0, 'steam:11000013527d62e', 0, 0, 100, 0, 1000, 0, '[]', '[]', '[]', '[]', '[]', 0, '0', 0, '0', 0),
	(173, 3, '[{"y":-7421.79150390625,"z":178.41554260253907,"x":656.319091796875}]', '[]', 50, 0, 'steam:11000013527d62e', 0, 0, 800, 0, 5000, 0, '[]', '[]', '[]', '[]', '[]', 35000, '0', 0, '0', 0),
	(177, 0, '[{"objYaw1":0.00235201278701,"q":46.62643814086914,"p":-141.64300537109376,"objYaw3":-139.03125,"entit":1194242,"o":2237.07470703125,"objYaw2":0.00180673645809,"objc":1762076266,"doorname":"p_door41x","locked":true,"x":2237.07470703125,"y":-141.64300537109376,"doorhash":-2080420985,"z":46.62643814086914}]', '[]', 100, 0, 'steam:11000013527d62e', 22, 0, 0, 0, 500, 0, '[]', '[]', '[]', '[{"name":"trigo","group":1,"metadata":[],"label":"trigo","type":"item_standard","count":1,"limit":100}]', '[]', 1000, '0', 0, '0', 0);

-- Copiando estrutura para tabela baseexclusivav2.playerhousing_sold_home_ledger
CREATE TABLE IF NOT EXISTS `playerhousing_sold_home_ledger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.playerhousing_sold_home_ledger: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.playershops
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
  `ledger` float DEFAULT 0,
  `level` int(255) DEFAULT 0,
  `taxledger` double DEFAULT 0,
  `repo` int(11) DEFAULT 0,
  `buyitems` longtext DEFAULT '{}',
  `webhook` longtext DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `items` (`items`(768)),
  KEY `weapons` (`weapons`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.playershops: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.player_ranch
CREATE TABLE IF NOT EXISTS `player_ranch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `price` float DEFAULT NULL,
  `coords` longtext DEFAULT '[]',
  `owned` int(11) DEFAULT 0,
  `herdtrail` longtext DEFAULT '[]',
  `cattle` longtext DEFAULT '[]',
  `q_cattle` longtext DEFAULT '[]',
  `dist` int(11) DEFAULT NULL,
  `chores` longtext DEFAULT '[]',
  `cows` longtext DEFAULT '[]',
  `chickens` longtext DEFAULT '[]',
  `milk` int(11) DEFAULT 0,
  `eggs` int(11) DEFAULT 0,
  `ledger` float DEFAULT 0,
  `dog` varchar(50) DEFAULT '0',
  `q_ranch` int(11) DEFAULT 0,
  `repoed` int(11) DEFAULT 0,
  `herding` int(11) DEFAULT 0,
  `selling` int(11) DEFAULT 0,
  `milking` int(11) DEFAULT 0,
  `checking` int(11) DEFAULT 0,
  `tax` int(11) DEFAULT 0,
  `hired` longtext DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.player_ranch: ~50 rows (aproximadamente)
INSERT IGNORE INTO `player_ranch` (`id`, `identifier`, `charidentifier`, `name`, `price`, `coords`, `owned`, `herdtrail`, `cattle`, `q_cattle`, `dist`, `chores`, `cows`, `chickens`, `milk`, `eggs`, `ledger`, `dog`, `q_ranch`, `repoed`, `herding`, `selling`, `milking`, `checking`, `tax`, `hired`) VALUES
	(6, NULL, NULL, 'Fazenda 4', 300000, '{"x":2244.526611328125,"y":-149.67286682128907,"z":46.5038948059082}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 450, '[]'),
	(7, NULL, NULL, 'Fazenda 5', 350000, '{"x":2958.015869140625,"y":800.7172241210938,"z":51.40822219848633}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 450, '[]'),
	(8, NULL, NULL, 'Fazenda 6', 500000, '{"x":2047.5906982421876,"y":-820.240966796875,"z":43.0424575805664}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 500, '[]'),
	(9, NULL, NULL, 'Fazenda 7', 200000, '{"x":1614.2017822265626,"y":-371.255859375,"z":75.25733184814453}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 350, '[]'),
	(10, NULL, NULL, 'Fazenda 8', 600000, '{"x":1804.82080078125,"y":-85.1991958618164,"z":55.58770370483398}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 500, '[]'),
	(11, NULL, NULL, 'Fazenda 9', 600000, '{"x":1368.21533203125,"y":-865.8508911132813,"z":69.34090423583985}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 500, '[]'),
	(12, NULL, NULL, 'Fazenda 10', 400000, '{"x":1266.981201171875,"y":-391.6149597167969,"z":97.57037353515625}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 400, '[]'),
	(13, NULL, NULL, 'Fazenda 11', 500000, '{"x":1198.9051513671876,"y":-177.67767333984376,"z":100.4051742553711}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 400, '[]'),
	(14, NULL, NULL, 'Fazenda 12', 600000, '{"x":1124.955078125,"y":-964.9602661132813,"z":69.18817901611328}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 500, '[]'),
	(15, NULL, NULL, 'Fazenda 13', 600000, '{"x":1052.168701171875,"y":-1123.1236572265626,"z":67.88909912109375}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 500, '[]'),
	(16, NULL, NULL, 'Fazenda 14', 300000, '{"x":1131.0311279296876,"y":-1309.8712158203126,"z":65.18576049804688}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 350, '[]'),
	(17, NULL, NULL, 'Fazenda 15', 600000, '{"x":1470.8939208984376,"y":-1583.5279541015626,"z":72.1843032836914}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 500, '[]'),
	(18, NULL, NULL, 'Fazenda 16', 500000, '{"x":1801.131591796875,"y":446.0923767089844,"z":112.67002868652344}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 450, '[]'),
	(19, NULL, NULL, 'Fazenda 17', 600000, '{"x":1409.1741943359376,"y":275.8341979980469,"z":89.52936553955078}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 550, '[]'),
	(20, NULL, NULL, 'Fazenda 18', 600000, '{"x":1138.06982421875,"y":498.80047607421877,"z":96.25555419921875}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 550, '[]'),
	(21, NULL, NULL, 'Fazenda 19', 400000, '{"x":898.017822265625,"y":275.13690185546877,"z":116.20159149169922}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 400, '[]'),
	(23, NULL, NULL, 'Fazenda 21', 500000, '{"x":-395.2670593261719,"y":654.1812744140625,"z":114.5974349975586}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 450, '[]'),
	(24, NULL, NULL, 'Fazenda 22', 600000, '{"x":-396.53021240234377,"y":935.5770874023438,"z":117.94832611083985}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 500, '[]'),
	(25, NULL, NULL, 'Fazenda 23', 700000, '{"x":-1600.4742431640626,"y":-1403.956787109375,"z":81.921630859375}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 550, '[]'),
	(26, NULL, NULL, 'Fazenda 24', 700000, '{"x":-1337.3905029296876,"y":-1103.916748046875,"z":75.43144226074219}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 550, '[]'),
	(27, NULL, NULL, 'Fazenda 25', 200000, '{"x":-4353.56689453125,"y":-2428.674072265625,"z":18.70262336730957}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 300, '[]'),
	(28, NULL, NULL, 'Fazenda 26', 500000, '{"x":-4752.990234375,"y":-2721.380859375,"z":-13.56444835662841}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 350, '[]'),
	(29, NULL, NULL, 'Fazenda 27', 300000, '{"x":-3561.062255859375,"y":-3028.49072265625,"z":11.76895904541015}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 350, '[]'),
	(30, NULL, NULL, 'Fazenda 28', 600000, '{"x":-958.35693359375,"y":-1325.62109375,"z":51.84170532226562}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 450, '[]'),
	(31, NULL, NULL, 'Fazenda 29', 450000, '{"x":-5616.35595703125,"y":-2974.80908203125,"z":4.58318996429443}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 300, '[]'),
	(32, NULL, NULL, 'Fazenda 30', 600000, '{"x":2554.912841796875,"y":-764.4423217773438,"z":42.47332382202148}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 400, '[]'),
	(33, NULL, NULL, 'Fazenda 31', 500000, '{"x":2605.639404296875,"y":-759.92333984375,"z":42.36027908325195}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 400, '[]'),
	(34, NULL, NULL, 'Fazenda 32', 600000, '{"x":2546.730712890625,"y":-915.848388671875,"z":42.22944641113281}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 500, '[]'),
	(35, NULL, NULL, 'Fazenda 33', 600000, '{"x":-854.3648681640625,"y":330.6564025878906,"z":96.00035095214844}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 500, '[]'),
	(36, NULL, NULL, 'Fazenda 34', 600000, '{"x":-607.9966430664063,"y":-53.12618637084961,"z":84.37187957763672}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 500, '[]'),
	(37, NULL, NULL, 'Fazenda 35', 350000, '{"x":-2413.41943359375,"y":-2435.5234375,"z":60.17566299438476}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(38, NULL, NULL, 'Fazenda 36', 350000, '{"x":-5198.8212890625,"y":-2153.664794921875,"z":12.15850257873535}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(39, NULL, NULL, 'Fazenda 37', 350000, '{"x":-5829.048828125,"y":-3724.005126953125,"z":-25.699312210083}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(40, NULL, NULL, 'Fazenda 38', 350000, '{"x":-5559.23046875,"y":-2393.745849609375,"z":-8.88760375976562}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(41, NULL, NULL, 'Fazenda 39', 350000, '{"x":-1404.53466796875,"y":-2186.59619140625,"z":43.78867721557617}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(42, NULL, NULL, 'Fazenda 40', 350000, '{"x":-1996.096435546875,"y":-1621.783203125,"z":117.90301513671875}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(43, NULL, NULL, 'Fazenda 41', 500000, '{"x":-2225.901611328125,"y":720.2225341796875,"z":122.64099884033203}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 1000, '[]'),
	(44, NULL, NULL, 'Fazenda 42', 150000, '{"x":-1818.011962890625,"y":652.0139770507813,"z":131.24569702148438}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(45, NULL, NULL, 'Fazenda 43', 150000, '{"x":-866.3345336914063,"y":-734.4613647460938,"z":59.6973876953125}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(46, NULL, NULL, 'Fazenda 44', 150000, '{"x":-65.6021728515625,"y":-388.7532043457031,"z":72.00064086914063}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(47, NULL, NULL, 'Fazenda 45', 150000, '{"x":3030.010498046875,"y":1770.491943359375,"z":83.26366424560547}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(48, NULL, NULL, 'Fazenda 46', 150000, '{"x":2983.661376953125,"y":2203.939697265625,"z":166.23330688476563}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(49, NULL, NULL, 'Fazenda 47', 150000, '{"x":2837.794921875,"y":1676.607421875,"z":129.3952178955078}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(50, NULL, NULL, 'Fazenda 48', 150000, '{"x":2638.986083984375,"y":1696.047607421875,"z":116.64288330078125}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(51, NULL, NULL, 'Fazenda 49', 150000, '{"x":2472.2353515625,"y":2006.4061279296876,"z":168.4084014892578}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(52, NULL, NULL, 'Fazenda 50', 150000, '{"x":-410.5913391113281,"y":1747.861572265625,"z":216.2506866455078}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(53, NULL, NULL, 'Fazenda 51', 150000, '{"x":-541.57421875,"y":2671.986083984375,"z":318.9338073730469}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 850, '[]'),
	(54, NULL, NULL, 'Fazenda 52', 150000, '{"x":-2515.052001953125,"y":426.7919616699219,"z":147.87220764160157}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 1000, '[]'),
	(55, NULL, NULL, 'Fazenda 53', 150000, '{"x":203.3406524658203,"y":985.8958740234375,"z":190.27862548828126}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 1000, '[]'),
	(57, NULL, NULL, 'Fazenda 54', 100000, '{"x":793.2129516601563,"y":872.043212890625,"z":119.51619720458985}', 0, '[]', '[]', '[]', NULL, '[]', '[]', '[]', 0, 0, 0, '0', 0, 0, 0, 0, 0, 0, 450, '[]');

-- Copiando estrutura para tabela baseexclusivav2.player_trains
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

-- Copiando dados para a tabela baseexclusivav2.player_trains: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.player_transformations
CREATE TABLE IF NOT EXISTS `player_transformations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `charid` int(11) NOT NULL,
  `transform_end` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `animal_model` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.player_transformations: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.posters
CREATE TABLE IF NOT EXISTS `posters` (
  `poster_link` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT '',
  `date` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `icName` varchar(500) DEFAULT NULL,
  KEY `poster_link` (`poster_link`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.posters: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.ranch
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela baseexclusivav2.ranch: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.real_logic_horses
CREATE TABLE IF NOT EXISTS `real_logic_horses` (
  `update_time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.real_logic_horses: ~1 rows (aproximadamente)
INSERT IGNORE INTO `real_logic_horses` (`update_time`) VALUES
	(0);

-- Copiando estrutura para tabela baseexclusivav2.real_logic_pets
CREATE TABLE IF NOT EXISTS `real_logic_pets` (
  `update_time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.real_logic_pets: ~1 rows (aproximadamente)
INSERT IGNORE INTO `real_logic_pets` (`update_time`) VALUES
	(66);

-- Copiando estrutura para tabela baseexclusivav2.real_logic_ranch
CREATE TABLE IF NOT EXISTS `real_logic_ranch` (
  `update_time` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.real_logic_ranch: ~1 rows (aproximadamente)
INSERT IGNORE INTO `real_logic_ranch` (`update_time`) VALUES
	(0);

-- Copiando estrutura para tabela baseexclusivav2.ricx_waterpumps
CREATE TABLE IF NOT EXISTS `ricx_waterpumps` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id2` int(10) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `charid` int(5) NOT NULL,
  `coords` longtext NOT NULL DEFAULT '[]',
  `rotate` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.ricx_waterpumps: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.robbery
CREATE TABLE IF NOT EXISTS `robbery` (
  `name_robbery` varchar(50) DEFAULT '0',
  `time_robbery` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.robbery: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.rooms
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interiorId` int(11) NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `identifier` varchar(60) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela baseexclusivav2.rooms: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.societa
CREATE TABLE IF NOT EXISTS `societa` (
  `id` int(1) NOT NULL AUTO_INCREMENT,
  `nomesocieta` longtext NOT NULL,
  `soldi` int(11) NOT NULL DEFAULT 0,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}' CHECK (json_valid(`items`)),
  `percentualem` int(10) unsigned NOT NULL DEFAULT 0,
  `latte` int(10) unsigned NOT NULL DEFAULT 0,
  `percentualep` int(11) NOT NULL DEFAULT 0,
  `lana` int(11) NOT NULL DEFAULT 0,
  `percentualeg` int(11) NOT NULL DEFAULT 0,
  `uova` int(11) NOT NULL DEFAULT 0,
  `percentualepig` int(11) NOT NULL DEFAULT 0,
  `salamelle` int(11) NOT NULL DEFAULT 0,
  UNIQUE KEY `id` (`id`),
  KEY `nomesocieta` (`nomesocieta`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.societa: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.society
CREATE TABLE IF NOT EXISTS `society` (
  `job` longtext DEFAULT NULL,
  `jobgrade` int(11) DEFAULT NULL,
  `salary` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.society: ~21 rows (aproximadamente)
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
	('horsetrainer', 4, 0);

-- Copiando estrutura para tabela baseexclusivav2.society_ledger
CREATE TABLE IF NOT EXISTS `society_ledger` (
  `job` longtext DEFAULT NULL,
  `ledger` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.society_ledger: ~86 rows (aproximadamente)
INSERT IGNORE INTO `society_ledger` (`job`, `ledger`) VALUES
	('Fazenda08', 0),
	('doctor', 0),
	('ArmariaAN', 0),
	('ArmariaVL', 0),
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
	('police', 0);

-- Copiando estrutura para tabela baseexclusivav2.society_shops
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

-- Copiando dados para a tabela baseexclusivav2.society_shops: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.stables
CREATE TABLE IF NOT EXISTS `stables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
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

-- Copiando dados para a tabela baseexclusivav2.stables: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.stagecoaches
CREATE TABLE IF NOT EXISTS `stagecoaches` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `stagecoach` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando dados para a tabela baseexclusivav2.stagecoaches: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.storelimits
CREATE TABLE IF NOT EXISTS `storelimits` (
  `store` varchar(255) DEFAULT NULL,
  `count` varchar(255) DEFAULT NULL,
  `item` varchar(255) DEFAULT NULL,
  KEY `store` (`store`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.storelimits: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.stores
CREATE TABLE IF NOT EXISTS `stores` (
  `city_name` varchar(50) DEFAULT NULL,
  `tax_for_price` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.stores: ~10 rows (aproximadamente)
INSERT IGNORE INTO `stores` (`city_name`, `tax_for_price`) VALUES
	('Valentine store', '10.0'),
	('Blackwater store', '10.0'),
	('Valentine butcher', '10.0'),
	('Saint Denise butcher', '10.0'),
	('Saint Denis store', '10.0'),
	('Rhodes store', '10.0'),
	('SaintDenis_Store', '100'),
	('Valentine_Butcher', '100'),
	('Valentine_Store', '100'),
	('Sell_Ecology_Spot', '100');

-- Copiando estrutura para tabela baseexclusivav2.storesplayer
CREATE TABLE IF NOT EXISTS `storesplayer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `identifier` varchar(100) NOT NULL,
  `charid` int(255) NOT NULL,
  `coords` longtext NOT NULL DEFAULT '{}',
  `money` longtext NOT NULL DEFAULT '0',
  `items` longtext NOT NULL DEFAULT '{}',
  `payment` datetime DEFAULT NULL,
  `prepayed` double(11,0) DEFAULT 0,
  `shared` longtext NOT NULL DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.storesplayer: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.telegrams
CREATE TABLE IF NOT EXISTS `telegrams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipient` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `sentTime` varchar(25) NOT NULL,
  `message` varchar(455) NOT NULL,
  `status` varchar(1) NOT NULL DEFAULT '0',
  `postoffice` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela baseexclusivav2.telegrams: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.undead
CREATE TABLE IF NOT EXISTS `undead` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `killed` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.undead: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.underground
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

-- Copiando dados para a tabela baseexclusivav2.underground: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.underground_animals
CREATE TABLE IF NOT EXISTS `underground_animals` (
  `ranchid` int(11) NOT NULL,
  `animalid` int(11) NOT NULL,
  `animaltype` varchar(255) NOT NULL,
  `animalmodel` varchar(255) NOT NULL,
  `animalcolor` varchar(255) NOT NULL,
  `animalname` varchar(255) NOT NULL,
  `animalgender` varchar(255) NOT NULL,
  `animalage` int(11) NOT NULL,
  `collectAmount` int(11) NOT NULL,
  `lastProductTime` int(11) NOT NULL,
  `animalhunger` int(11) NOT NULL,
  `animalthirst` int(11) NOT NULL,
  `animalHealth` int(11) NOT NULL,
  `breedingState` int(11) NOT NULL,
  `breedingTime` int(11) NOT NULL,
  `animalPosStatus` int(11) NOT NULL,
  PRIMARY KEY (`ranchid`,`animalid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela baseexclusivav2.underground_animals: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.underground_employees
CREATE TABLE IF NOT EXISTS `underground_employees` (
  `ranchid` int(11) NOT NULL,
  `position` varchar(255) NOT NULL,
  `steamid` varchar(255) NOT NULL,
  `charid` int(11) NOT NULL,
  `tasksperformed` int(11) NOT NULL,
  `salary` int(11) NOT NULL,
  PRIMARY KEY (`ranchid`,`position`,`steamid`,`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela baseexclusivav2.underground_employees: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.underground_objects
CREATE TABLE IF NOT EXISTS `underground_objects` (
  `ranchid` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `z` int(11) NOT NULL,
  `h` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `hash` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `ownersteamid` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `lastupdated` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `data` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela baseexclusivav2.underground_objects: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.underground_ranches
CREATE TABLE IF NOT EXISTS `underground_ranches` (
  `ranchid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `ownercharid` int(11) NOT NULL,
  `ownersteamid` varchar(255) NOT NULL,
  PRIMARY KEY (`ranchid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Copiando dados para a tabela baseexclusivav2.underground_ranches: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `group` varchar(50) DEFAULT 'user',
  `warnings` int(11) DEFAULT 0,
  `banned` tinyint(1) DEFAULT NULL,
  `banneduntil` int(10) DEFAULT 0,
  `char` varchar(50) NOT NULL DEFAULT 'false',
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.users: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.user_jobs
CREATE TABLE IF NOT EXISTS `user_jobs` (
  `user_id` int(11) NOT NULL,
  `job` varchar(50) DEFAULT NULL,
  `job_grade` int(11) DEFAULT NULL,
  `second_job` varchar(50) DEFAULT NULL,
  `second_job_grade` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.user_jobs: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.wagons
CREATE TABLE IF NOT EXISTS `wagons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `selected` int(11) NOT NULL DEFAULT 0,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `items` longtext NOT NULL DEFAULT '{}',
  `weapons` longtext NOT NULL DEFAULT '{}',
  `comp_extras` varchar(500) DEFAULT '{"1":"1","10":"1","20":"1","8":"1","6":"1","11":"1","7":"1","15":"1","18":"1","19":"1","16":"1","17":"1","3":"1","2":"1","5":"1","4":"1","13":"1","12":"1","9":"1","14":"1"}',
  `comp_lantern` varchar(255) DEFAULT 'none',
  `comp_liveries` varchar(255) DEFAULT '-1',
  `cityPosition` int(11) NOT NULL DEFAULT 0,
  `spotPosition` int(11) NOT NULL DEFAULT 0,
  `housePosition` int(11) NOT NULL DEFAULT 0,
  `interiorPosition` int(11) NOT NULL DEFAULT 0,
  `comp_tints` varchar(255) DEFAULT '-1',
  `comp_propset` varchar(200) NOT NULL DEFAULT 'none',
  `horses` varchar(200) NOT NULL DEFAULT '0',
  `addonArray` longtext DEFAULT NULL,
  `addon_ability` bigint(20) DEFAULT 0,
  `damage_wheel` longtext DEFAULT '[]',
  `health_cart` int(11) NOT NULL DEFAULT 1000,
  `animals` longtext DEFAULT NULL,
  `buildState` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_horses_characters` (`charid`),
  KEY `model` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.wagons: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.wagon_water
CREATE TABLE IF NOT EXISTS `wagon_water` (
  `identifier` varchar(255) DEFAULT '0',
  `charid` varchar(255) DEFAULT '0',
  `wagon` varchar(255) DEFAULT '0',
  `water` varchar(255) DEFAULT '0',
  `wagon_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs;

-- Copiando dados para a tabela baseexclusivav2.wagon_water: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `firstconnection` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE,
  CONSTRAINT `FK_characters_whitelist` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela baseexclusivav2.whitelist: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela baseexclusivav2.xxx_dogs
CREATE TABLE IF NOT EXISTS `xxx_dogs` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id2` int(6) NOT NULL DEFAULT 0,
  `identifier` varchar(70) NOT NULL,
  `charid` int(5) NOT NULL,
  `selected` int(2) NOT NULL DEFAULT 0,
  `data` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela baseexclusivav2.xxx_dogs: ~0 rows (aproximadamente)

-- Copiando estrutura para trigger baseexclusivav2.add_mdg_horses_stats
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `add_mdg_horses_stats` AFTER INSERT ON `mdg_horses` FOR EACH ROW INSERT INTO mdg_horses_stats (horseid) VALUES (NEW.id)//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger baseexclusivav2.delete_mdg_horses_stats
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `delete_mdg_horses_stats` AFTER DELETE ON `mdg_horses` FOR EACH ROW DELETE FROM mdg_horses_stats WHERE horseid = OLD.id//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger baseexclusivav2.delete_mdg_stable_color
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `delete_mdg_stable_color` AFTER DELETE ON `mdg_stable_bought` FOR EACH ROW DELETE FROM `mdg_stable_color` WHERE id = OLD.id//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Copiando estrutura para trigger baseexclusivav2.update_mdg_stable_equiped_component
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `update_mdg_stable_equiped_component` AFTER DELETE ON `mdg_horses` FOR EACH ROW UPDATE `mdg_stable_bought` SET equiped_on = 0 WHERE equiped_on = OLD.id//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
