-- DB update 2021_12_26_01 -> 2022_01_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_characters' AND COLUMN_NAME = '2021_12_26_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_characters CHANGE COLUMN 2021_12_26_01 2022_01_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_characters WHERE sql_rev = '1642821969869259834'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1642821969869259834');

-- column `type` contains type of logged action
ALTER TABLE `log_money` ADD COLUMN `type` TINYINT NOT NULL COMMENT '1=COD,2=AH,3=GB DEPOSIT,4=GB WITHDRAW,5=MAIL,6=TRADE' AFTER `date`;

--
-- END UPDATING QUERIES
--
UPDATE version_db_characters SET date = '2022_01_25_00' WHERE sql_rev = '1642821969869259834';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
