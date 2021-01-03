-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server Version:               10.4.13-MariaDB - mariadb.org binary distribution
-- Server Betriebssystem:        Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Exportiere Datenbank Struktur für domination
CREATE DATABASE IF NOT EXISTS `domination` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `domination`;

-- Exportiere Struktur von Tabelle domination.dom_params2
CREATE TABLE IF NOT EXISTS `dom_params2` (
  `params_title` varchar(80) COLLATE utf8mb4_bin NOT NULL,
  `param_name` varchar(80) COLLATE utf8mb4_bin NOT NULL,
  `param_value` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Exportiere Struktur von Tabelle domination.dom_settings
CREATE TABLE IF NOT EXISTS `dom_settings` (
  `name` varchar(80) COLLATE utf8mb4_bin DEFAULT NULL,
  `value` varchar(400) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Exportiere Daten aus Tabelle domination.dom_settings: ~13 rows (ungefähr)
/*!40000 ALTER TABLE `dom_settings` DISABLE KEYS */;
INSERT IGNORE INTO `dom_settings` (`name`, `value`) VALUES
	('d_use_sql_settings', 'true'),
	('d_db_auto_save', 'true'),
	('d_reserved_slot', '[]'),
	('d_uid_reserved_slots', '[]'),
	('d_uids_for_reserved_slots', '[]'),
	('d_tt_points', '[30,7,15,5,10,5,10,4,2]'),
	('d_cas_available_time', '600'),
	('d_ranked_a', '[20,[3,2,1,0],10,3,10,10,20,3,["Corporal","Sergeant","Lieutenant","Lieutenant","Sergeant","Corporal"],30,400,10,200,20,10,5,20,4,1,20,20,10,20]'),
	('d_addscore_a', '[5,5,5,5,5,30,10,10,[3,2,1,0],5,3,1,1,20]'),
	('d_points_needed', '[20,50,90,140,200,270,500]'),
	('d_points_needed_db', '[500,2000,5000,9000,14000,20000,30000]'),
	('d_ai_groups_respawn_time', '[250,150,320,170]'),
	('d_set_pl_score_db', 'true'),
	('d_launcher_cooldown', '120'),
	('d_number_attack_planes', '1'),
	('d_number_attack_choppers', '1'),
	('d_number_light_attack_choppers', '1'),
	('d_number_attack_uavs', '1'),
	('d_noambient_bf_sounds', 'false'),
	('d_time_until_next_sidemission', '[[10,300],[20,400],[30,500],[500,600]]'),
	('d_airai_respawntime', '120');
/*!40000 ALTER TABLE `dom_settings` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle domination.missionsave
CREATE TABLE IF NOT EXISTS `missionsave` (
  `name` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `d_maintargets` int(11) NOT NULL,
  `d_maintargets_list` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `d_current_target_index` int(11) NOT NULL,
  `d_cur_sm_idx` int(11) NOT NULL,
  `d_resolved_targets` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `d_recapture_indices` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `d_side_missions_random` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `d_current_mission_counter` int(11) NOT NULL,
  `d_searchintel` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `d_bonus_vecs_db` varchar(4000) COLLATE utf8mb4_bin NOT NULL,
  `d_worldname` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `d_combiname` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `missionname` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `d_retaken_farpspos` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `d_vrespawn_vecs` varchar(4000) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Exportiere Daten aus Tabelle domination.missionsave: ~0 rows (ungefähr)
/*!40000 ALTER TABLE `missionsave` DISABLE KEYS */;
/*!40000 ALTER TABLE `missionsave` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle domination.missionsavett
CREATE TABLE IF NOT EXISTS `missionsavett` (
  `name` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `d_maintargets` int(11) NOT NULL,
  `d_maintargets_list` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `d_current_target_index` int(11) NOT NULL,
  `d_cur_sm_idx` int(11) NOT NULL,
  `d_resolved_targets` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `d_recapture_indices` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `d_side_missions_random` varchar(1000) COLLATE utf8mb4_bin NOT NULL,
  `d_current_mission_counter` int(11) NOT NULL,
  `d_searchintel` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `d_bonus_vecs_db_w` varchar(2000) COLLATE utf8mb4_bin NOT NULL,
  `d_bonus_vecs_db_e` varchar(2000) COLLATE utf8mb4_bin NOT NULL,
  `d_worldname` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `d_points_blufor` int(11) NOT NULL,
  `d_points_opfor` int(11) NOT NULL,
  `d_kill_points_blufor` int(11) NOT NULL,
  `d_kill_points_opfor` int(11) NOT NULL,
  `d_points_array` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `d_combiname` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `missionname` varchar(200) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Exportiere Daten aus Tabelle domination.missionsavett: ~0 rows (ungefähr)
/*!40000 ALTER TABLE `missionsavett` DISABLE KEYS */;
/*!40000 ALTER TABLE `missionsavett` ENABLE KEYS */;

-- Exportiere Struktur von Tabelle domination.players
CREATE TABLE IF NOT EXISTS `players` (
  `uid` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `playerid` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `playtime` int(11) NOT NULL DEFAULT 0,
  `infkills` int(11) NOT NULL DEFAULT 0,
  `softveckills` int(11) NOT NULL DEFAULT 0,
  `armorkills` int(11) NOT NULL DEFAULT 0,
  `airkills` int(11) NOT NULL DEFAULT 0,
  `deaths` int(11) NOT NULL DEFAULT 0,
  `totalscore` int(11) NOT NULL DEFAULT 0,
  `radiotowerkills` int(11) NOT NULL DEFAULT 0,
  `numplayedonserver` int(11) NOT NULL DEFAULT 1,
  `campscaptured` int(11) NOT NULL DEFAULT 0,
  `mtsmkills` int(11) NOT NULL DEFAULT 0,
  `teamkills` int(11) NOT NULL DEFAULT 0,
  `revives` int(11) NOT NULL DEFAULT 0,
  `distar` varchar(240) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `playerid` (`playerid`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
