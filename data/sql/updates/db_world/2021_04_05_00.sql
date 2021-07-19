-- DB update 2021_04_04_04 -> 2021_04_05_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_04_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_04_04 2021_04_05_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1617560127573531400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617560127573531400');

-- Pirate's Footlocker
UPDATE `item_loot_template` SET `Chance`=10 WHERE `Entry`=9276 AND `Item`=9249; -- was 21.6%

-- Southsea Swashbuckler
UPDATE `creature_loot_template` SET `Chance`=0.02 WHERE `Entry`=7858 AND `Item`=9249; -- was 100%


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
