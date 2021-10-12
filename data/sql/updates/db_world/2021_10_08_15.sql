-- DB update 2021_10_08_14 -> 2021_10_08_15
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_08_14';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_08_14 2021_10_08_15 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633435634247708496'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633435634247708496');

-- Giant Clam(2264) Vile reef loot fixes

-- Increased the loot chance for Blue Pearl(4611) to 100%
UPDATE `gameobject_loot_template` SET `Chance` = 100 WHERE (`Entry` = 2264) AND (`Item` = 4611);
-- Increased the loot chance for Giant Clam Meat(4655) to 35% and moved to another group id as the groupid 2 is always Blue Pearl
UPDATE `gameobject_loot_template` SET `Chance` = 35, `GroupId` = 1 WHERE (`Entry` = 2264) AND (`Item` = 4655);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_08_15' WHERE sql_rev = '1633435634247708496';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
