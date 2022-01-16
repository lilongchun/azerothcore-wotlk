-- DB update 2022_01_14_02 -> 2022_01_14_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_14_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_14_02 2022_01_14_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641742341291500600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641742341291500600');

UPDATE `quest_template_addon` SET `SpecialFlags`=0 WHERE `ID`=6983;
UPDATE `quest_template` SET `AllowableRaces`=690 WHERE `ID` IN (6983,6984,6963);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_14_03' WHERE sql_rev = '1641742341291500600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
