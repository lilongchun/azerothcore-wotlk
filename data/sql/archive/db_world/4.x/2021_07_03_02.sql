-- DB update 2021_07_03_01 -> 2021_07_03_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_03_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_03_01 2021_07_03_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624669484085082860'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624669484085082860');

-- Despawn the summoned creatures/corpses 5 minutes after being killed instead of 1 minute after not being in combat.
UPDATE `creature_summon_groups` SET `summonType`=6, `summonTime`=300000 WHERE `summonerId` IN (21118, 21119, 21120, 21121);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_03_02' WHERE sql_rev = '1624669484085082860';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
