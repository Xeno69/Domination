USE `domination`;
ALTER TABLE `players`
	ADD COLUMN `distar` VARCHAR(240) NOT NULL COLLATE 'utf8mb4_bin' AFTER `revives`;
