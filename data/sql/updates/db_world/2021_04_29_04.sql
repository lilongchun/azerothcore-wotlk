-- DB update 2021_04_29_03 -> 2021_04_29_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_29_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_29_03 2021_04_29_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619604388715021734'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619604388715021734');

SET
@POOL            = 11654,
@POOLSIZE        = 10,
@POOLDESC        = 'Treasures - Stranglethorn Vale',
@RESPAWN         = 900,
@GUID = '11651,11676,11693,11695,11704,11806,12157,12185,29256,85723,85724,85725,85726,85730,85732,85873,85875,87388';

-- Create pool(s)
DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (@POOL,@POOLSIZE,@POOLDESC);

-- Add gameobjects to pools
DELETE FROM `pool_gameobject` WHERE FIND_IN_SET (`guid`,@GUID);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(11651,@POOL,0,@POOLDESC),
(11676,@POOL,0,@POOLDESC),
(11693,@POOL,0,@POOLDESC),
(11695,@POOL,0,@POOLDESC),
(11704,@POOL,0,@POOLDESC),
(11806,@POOL,0,@POOLDESC),
(12157,@POOL,0,@POOLDESC),
(12185,@POOL,0,@POOLDESC),
(29256,@POOL,0,@POOLDESC),
(85723,@POOL,0,@POOLDESC),
(85724,@POOL,0,@POOLDESC),
(85725,@POOL,0,@POOLDESC),
(85726,@POOL,0,@POOLDESC),
(85730,@POOL,0,@POOLDESC),
(85732,@POOL,0,@POOLDESC),
(85873,@POOL,0,@POOLDESC),
(85875,@POOL,0,@POOLDESC),
(87388,@POOL,0,@POOLDESC);


-- Respawn rates of gameobjects
UPDATE `gameobject` SET `spawntimesecs`=@RESPAWN WHERE FIND_IN_SET (`guid`,@GUID);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
