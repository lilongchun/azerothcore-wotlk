-- DB update 2021_11_29_01 -> 2021_11_29_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_29_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_29_01 2021_11_29_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637594598317103800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637594598317103800');
UPDATE `creature_template` SET `ScriptName`='npc_ouro_spawner' WHERE  `entry`=15957;
UPDATE `creature_template` SET `flags_extra`='128' WHERE  `entry`=15957;
UPDATE `creature_template` SET `InhabitType`='9' WHERE  `entry`=15957;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_29_02' WHERE sql_rev = '1637594598317103800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
