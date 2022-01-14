-- DB update 2022_01_14_00 -> 2022_01_14_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_14_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_14_00 2022_01_14_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641673336160991900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641673336160991900');

DELETE FROM `game_event_gameobject` WHERE `guid` IN (91326,91328,91481,91482,91487,91488,91489,91490,91491,91492,91494,92045,92047,92048,92051,92052);
INSERT INTO `game_event_gameobject`(`eventEntry`, `guid`) VALUES
-- Midsummer Fire Festival
(1, 91326),
(1, 91328),
(1, 91481),
(1, 91482),
(1, 91487),
(1, 91488),
(1, 91489),
(1, 91490),
(1, 91491),
(1, 91492),
(1, 91494),
(1, 92045),
(1, 92047),
(1, 92048),
(1, 92051),
(1, 92052),
-- New Year's Eve 
(6, 91326), 
(6, 91328), 
(6, 91481), 
(6, 91482), 
(6, 91487), 
(6, 91488),
(6, 91489),
(6, 91490),
(6, 91491),
(6, 91492),
(6, 91494),
(6, 92045),
(6, 92047),
(6, 92048),
(6, 92051),
(6, 92052),
-- Brewfest
(24, 91326),
(24, 91328),
(24, 91481),
(24, 91482),
(24, 91487),
(24, 91488),
(24, 91489),
(24, 91490),
(24, 91491),
(24, 91492),
(24, 91494),
(24, 92045),
(24, 92047),
(24, 92048),
(24, 92051),
(24, 92052);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_14_01' WHERE sql_rev = '1641673336160991900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
