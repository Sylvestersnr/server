INSERT INTO `migrations` VALUES ('20170816025732'); 

-- Implement new progression system.
ALTER TABLE `areatrigger_teleport`
	ADD COLUMN `patch` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `id`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`id`, `patch`);
	
-- Hall of Legends
UPDATE `areatrigger_teleport` SET `patch`=2 WHERE `id`=2527;

-- Champions Hall
UPDATE `areatrigger_teleport` SET `patch`=2 WHERE `id`=2532;

-- Dire Maul
UPDATE `areatrigger_teleport` SET `patch`=1 WHERE `id` IN (3190, 3191, 3193, 3194, 3195, 3196, 3197, 3183, 3184, 3185, 3186, 3187, 3189);

-- Blackwing Lair
UPDATE `areatrigger_teleport` SET `patch`=4 WHERE `id`=3726;

-- Zul Gurub
UPDATE `areatrigger_teleport` SET `patch`=5 WHERE `id`=3928;

-- Ahn Qiraj
UPDATE `areatrigger_teleport` SET `patch`=7, `required_level`=60 WHERE `id` IN (4008, 4010);

-- Naxxramas
UPDATE `areatrigger_teleport` SET `patch`=9 WHERE `id`=4055;
	
ALTER TABLE `game_event`
	ADD COLUMN `patch_min` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `disabled`,
	ADD COLUMN `patch_max` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10' AFTER `patch_min`;
	
ALTER TABLE `creature`
	ADD COLUMN `patch_min` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `spawnFlags`,
	ADD COLUMN `patch_max` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10' AFTER `patch_min`;

ALTER TABLE `creature_template`
	ADD COLUMN `patch` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `entry`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`entry`, `patch`);
	
ALTER TABLE `creature_addon`
	ADD COLUMN `patch` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `guid`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`guid`, `patch`);
	
ALTER TABLE `creature_template_addon`
	ADD COLUMN `patch` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `entry`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`entry`, `patch`);
	
ALTER TABLE `creature_equip_template`
	ADD COLUMN `patch` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `entry`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`entry`, `patch`);

ALTER TABLE `creature_equip_template_raw`
	ADD COLUMN `patch` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `entry`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`entry`, `patch`);
	
ALTER TABLE `item_template`
	ADD COLUMN `patch` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `entry`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`entry`, `patch`);
	
ALTER TABLE `quest_template`
	ADD COLUMN `patch` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `entry`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`entry`, `patch`);
	
CREATE TABLE IF NOT EXISTS `forbidden_items` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `patch` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `AfterOrBefore` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dumping structure for table mangos.battleground_template
DROP TABLE IF EXISTS `battleground_template`;
CREATE TABLE IF NOT EXISTS `battleground_template` (
  `id` mediumint(8) unsigned NOT NULL,
  `patch` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MinPlayersPerTeam` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MaxPlayersPerTeam` smallint(5) unsigned NOT NULL DEFAULT '0',
  `MinLvl` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `MaxLvl` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `AllianceStartLoc` mediumint(8) unsigned NOT NULL,
  `AllianceStartO` float NOT NULL,
  `HordeStartLoc` mediumint(8) unsigned NOT NULL,
  `HordeStartO` float NOT NULL,
  PRIMARY KEY (`id`,`patch`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- All battlegrounds disabled until 1.5.
INSERT INTO `battleground_template` (`id`, `patch`, `MinPlayersPerTeam`, `MaxPlayersPerTeam`, `MinLvl`, `MaxLvl`, `AllianceStartLoc`, `AllianceStartO`, `HordeStartLoc`, `HordeStartO`) VALUES
	(1, 0, 20, 40, 61, 61, 611, 2.72532, 610, 2.27452);
INSERT INTO `battleground_template` (`id`, `patch`, `MinPlayersPerTeam`, `MaxPlayersPerTeam`, `MinLvl`, `MaxLvl`, `AllianceStartLoc`, `AllianceStartO`, `HordeStartLoc`, `HordeStartO`) VALUES
	(2, 0, 4, 10, 61, 61, 769, 3.14159, 770, 3.14159);
INSERT INTO `battleground_template` (`id`, `patch`, `MinPlayersPerTeam`, `MaxPlayersPerTeam`, `MinLvl`, `MaxLvl`, `AllianceStartLoc`, `AllianceStartO`, `HordeStartLoc`, `HordeStartO`) VALUES
	(3, 0, 6, 15, 61, 61, 890, 3.40156, 889, 0.263892);

-- World of Warcraft Client Patch 1.5.0 (2005-06-07)
-- "Battlegrounds arrive!
-- The Warsong Gulch and Alterac Valley battlegrounds are now available."
INSERT INTO `battleground_template` (`id`, `patch`, `MinPlayersPerTeam`, `MaxPlayersPerTeam`, `MinLvl`, `MaxLvl`, `AllianceStartLoc`, `AllianceStartO`, `HordeStartLoc`, `HordeStartO`) VALUES
	(2, 3, 4, 10, 21, 60, 769, 3.14159, 770, 3.14159);
INSERT INTO `battleground_template` (`id`, `patch`, `MinPlayersPerTeam`, `MaxPlayersPerTeam`, `MinLvl`, `MaxLvl`, `AllianceStartLoc`, `AllianceStartO`, `HordeStartLoc`, `HordeStartO`) VALUES
	(1, 3, 30, 40, 51, 60, 611, 2.72532, 610, 2.27452);

-- World of Warcraft Client Patch 1.7.0 (2005-09-13)
-- Arathi Basin added to the game.
INSERT INTO `battleground_template` (`id`, `patch`, `MinPlayersPerTeam`, `MaxPlayersPerTeam`, `MinLvl`, `MaxLvl`, `AllianceStartLoc`, `AllianceStartO`, `HordeStartLoc`, `HordeStartO`) VALUES
	(3, 5, 6, 15, 20, 60, 890, 3.40156, 889, 0.263892);
-- "Warsong Gulch and Arathi Basin will now be level-banded as follows: 20-29, 30-39, 40-49, 50-59, 60."
-- http://pc.gamespy.com/pc/world-of-warcraft/625886p4.html <- Mentions that 50s play against 60s in WSG.
INSERT INTO `battleground_template` (`id`, `patch`, `MinPlayersPerTeam`, `MaxPlayersPerTeam`, `MinLvl`, `MaxLvl`, `AllianceStartLoc`, `AllianceStartO`, `HordeStartLoc`, `HordeStartO`) VALUES
	(2, 5, 4, 10, 20, 60, 769, 3.14159, 770, 3.14159);
	
-- World of Warcraft Client Patch 1.8.0 (2005-10-11)
-- "Players of levels 10 - 19 will now be able to participate in the battle for Warsong Gulch."
-- Minimum level for WSG was 20 previously, 21 before 1.7.0.
INSERT INTO `battleground_template` (`id`, `patch`, `MinPlayersPerTeam`, `MaxPlayersPerTeam`, `MinLvl`, `MaxLvl`, `AllianceStartLoc`, `AllianceStartO`, `HordeStartLoc`, `HordeStartO`) VALUES
	(2, 6, 4, 10, 10, 60, 769, 3.14159, 770, 3.14159);
-- "The minimum number of players required to start a battle in Alterac Valley has been lowered to 20 (the maximum is still 40)."
INSERT INTO `battleground_template` (`id`, `patch`, `MinPlayersPerTeam`, `MaxPlayersPerTeam`, `MinLvl`, `MaxLvl`, `AllianceStartLoc`, `AllianceStartO`, `HordeStartLoc`, `HordeStartO`) VALUES
	(1, 6, 20, 40, 51, 60, 611, 2.72532, 610, 2.27452);

