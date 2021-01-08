USE `domination`;
ALTER TABLE `players`
	ADD COLUMN `distar` VARCHAR(120) NOT NULL DEFAULT '[]' COLLATE 'utf8mb4_bin' AFTER `revives`,
	ADD COLUMN `headshots` INT(11) NOT NULL DEFAULT '0' AFTER `distar`,
	ADD COLUMN `rounds` INT(11) NOT NULL DEFAULT '0' AFTER `headshots`;
