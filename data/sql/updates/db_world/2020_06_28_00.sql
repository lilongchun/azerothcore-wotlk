-- DB update 2020_06_27_01 -> 2020_06_28_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_27_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_27_01 2020_06_28_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1587839068992670400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587839068992670400');

DELETE FROM `spell_script_names` WHERE `spell_id`=21149 AND `ScriptName`="spell_item_eggnog";
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(21149,'spell_item_eggnog');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
