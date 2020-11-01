USE `domination`;
ALTER TABLE `missionsave`
	CHANGE COLUMN `d_bonus_vecs_db` `d_bonus_vecs_db` VARCHAR(4000) NOT NULL AFTER `d_searchintel`,
	ADD COLUMN `d_vrespawn_vecs` VARCHAR(4000) NOT NULL AFTER `d_retaken_farpspos`;
