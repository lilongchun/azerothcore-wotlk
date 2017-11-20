-- DB update 2017_02_03_20 -> 2017_02_03_21
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_02_03_20';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_02_03_20 2017_02_03_21 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1485431827424263900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1485431827424263900');
-- Zalduun <Priest Trainer>
SET @NPC := 57213;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@NPC,@PATH,0,0,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -4113.68, -13762, 73.5694, 5.80705, 0),
(@PATH, 2, -4110.51, -13765.2, 73.6102, 5.19209, 0),
(@PATH, 3, -4107.71, -13772.5, 74.6982, 5.80705, 0),
(@PATH, 4, -4102.51, -13772.3, 74.7185, 0.511104, 0),
(@PATH, 5, -4099.89, -13768, 74.7256, 1.36954, 0),
(@PATH, 6, -4102.44, -13763.8, 74.5717, 2.63796, 0),
(@PATH, 7, -4125.6, -13762, 74.1406, 3.4807, 0),
(@PATH, 8, -4129.88, -13764.2, 74.5865, 3.28513, 0),
(@PATH, 9, -4135.57, -13762.7, 74.657, 2.14081, 0),
(@PATH, 10, -4137.16, -13760, 74.6108, 1.35698, 0),
(@PATH, 11, -4135.66, -13756.6, 74.5907, 0.545662, 0),
(@PATH, 12, -4131.3, -13754.6, 74.6109, 6.14319, 0),
(@PATH, 13, -4127.9, -13756.6, 74.2825, 5.30675, 0),
(@PATH, 14, -4127.08, -13760.8, 74.2562, 5.74265, 0),
(@PATH, 15, -4121.58, -13761.4, 73.5881, 0.0354084, 0),
(@PATH, 16, -4113.68, -13762, 73.5694, 5.80705, 0),
(@PATH, 17, -4110.51, -13765.2, 73.6102, 5.19209, 0),
(@PATH, 18, -4107.71, -13772.5, 74.6982, 5.80705, 0),
(@PATH, 19, -4102.51, -13772.3, 74.7185, 0.511104, 0),
(@PATH, 20, -4099.89, -13768, 74.7256, 1.36954, 0),
(@PATH, 21, -4102.44, -13763.8, 74.5717, 2.63796, 12000),
(@PATH, 22, -4125.6, -13762, 74.1406, 3.4807, 0),
(@PATH, 23, -4129.88, -13764.2, 74.5865, 3.28513, 0),
(@PATH, 24, -4135.57, -13762.7, 74.657, 2.14081, 0),
(@PATH, 25, -4137.16, -13760, 74.6108, 1.35698, 0),
(@PATH, 26, -4135.66, -13756.6, 74.5907, 0.545662, 0),
(@PATH, 27, -4131.3, -13754.6, 74.6109, 6.14319, 0),
(@PATH, 28, -4127.9, -13756.6, 74.2825, 5.30675, 0),
(@PATH, 29, -4127.08, -13760.8, 74.2562, 5.74265, 0),
(@PATH, 30, -4121.58, -13761.4, 73.5881, 0.0354084, 0),
(@PATH, 31, -4113.68, -13762, 73.5694, 5.80705, 0),
(@PATH, 32, -4110.51, -13765.2, 73.6102, 5.19209, 0),
(@PATH, 33, -4107.71, -13772.5, 74.6982, 5.80705, 0),
(@PATH, 34, -4102.51, -13772.3, 74.7185, 0.511104, 0),
(@PATH, 35, -4099.89, -13768, 74.7256, 1.36954, 0),
(@PATH, 36, -4102.44, -13763.8, 74.5717, 2.63796, 0),
(@PATH, 37, -4125.6, -13762, 74.1406, 3.4807, 0),
(@PATH, 38, -4129.88, -13764.2, 74.5865, 3.28513, 0),
(@PATH, 39, -4135.57, -13762.7, 74.657, 2.14081, 0),
(@PATH, 40, -4137.16, -13760, 74.6108, 1.35698, 0),
(@PATH, 41, -4135.66, -13756.6, 74.5907, 0.545662, 0),
(@PATH, 42, -4131.3, -13754.6, 74.6109, 6.14319, 0),
(@PATH, 43, -4127.9, -13756.6, 74.2825, 5.30675, 0),
(@PATH, 44, -4127.08, -13760.8, 74.2562, 5.74265, 0),
(@PATH, 45, -4121.58, -13761.4, 73.5881, 0.0354084, 0),
(@PATH, 46, -4113.68, -13762, 73.5694, 5.80705, 0),
(@PATH, 47, -4110.51, -13765.2, 73.6102, 5.19209, 0),
(@PATH, 48, -4107.71, -13772.5, 74.6982, 5.80705, 0),
(@PATH, 49, -4102.51, -13772.3, 74.7185, 0.511104, 0),
(@PATH, 50, -4099.89, -13768, 74.7256, 1.36954, 0),
(@PATH, 51, -4102.44, -13763.8, 74.5717, 2.63796, 0),
(@PATH, 52, -4125.6, -13762, 74.1406, 3.4807, 0),
(@PATH, 53, -4129.88, -13764.2, 74.5865, 3.28513, 0),
(@PATH, 54, -4135.57, -13762.7, 74.657, 2.14081, 0),
(@PATH, 55, -4137.16, -13760, 74.6108, 1.35698, 0),
(@PATH, 56, -4135.66, -13756.6, 74.5907, 0.545662, 0),
(@PATH, 57, -4131.3, -13754.6, 74.6109, 6.14319, 0),
(@PATH, 58, -4127.9, -13756.6, 74.2825, 5.30675, 0),
(@PATH, 59, -4127.08, -13760.8, 74.2562, 5.74265, 0),
(@PATH, 60, -4121.58, -13761.4, 73.5881, 0.0354084, 0),
(@PATH, 61, -4113.68, -13762, 73.5694, 5.80705, 0),
(@PATH, 62, -4110.51, -13765.2, 73.6102, 5.19209, 0),
(@PATH, 63, -4107.71, -13772.5, 74.6982, 5.80705, 0),
(@PATH, 64, -4102.51, -13772.3, 74.7185, 0.511104, 0),
(@PATH, 65, -4099.89, -13768, 74.7256, 1.36954, 0),
(@PATH, 66, -4102.44, -13763.8, 74.5717, 2.63796, 0),
(@PATH, 67, -4125.6, -13762, 74.1406, 3.4807, 0),
(@PATH, 68, -4129.88, -13764.2, 74.5865, 3.28513, 12000),
(@PATH, 69, -4135.57, -13762.7, 74.657, 2.14081, 0),
(@PATH, 70, -4137.16, -13760, 74.6108, 1.35698, 0),
(@PATH, 71, -4135.66, -13756.6, 74.5907, 0.545662, 0),
(@PATH, 72, -4131.3, -13754.6, 74.6109, 6.14319, 0),
(@PATH, 73, -4127.9, -13756.6, 74.2825, 5.30675, 0),
(@PATH, 74, -4127.08, -13760.8, 74.2562, 5.74265, 0),
(@PATH, 75, -4121.58, -13761.4, 73.5881, 0.0354084, 0),
(@PATH, 76, -4113.68, -13762, 73.5694, 5.80705, 0),
(@PATH, 77, -4110.51, -13765.2, 73.6102, 5.19209, 0),
(@PATH, 78, -4107.71, -13772.5, 74.6982, 5.80705, 0),
(@PATH, 79, -4102.51, -13772.3, 74.7185, 0.511104, 0),
(@PATH, 80, -4099.89, -13768, 74.7256, 1.36954, 0),
(@PATH, 81, -4102.44, -13763.8, 74.5717, 2.63796, 0),
(@PATH, 82, -4125.6, -13762, 74.1406, 3.4807, 0),
(@PATH, 83, -4129.88, -13764.2, 74.5865, 3.28513, 0),
(@PATH, 84, -4135.57, -13762.7, 74.657, 2.14081, 0),
(@PATH, 85, -4137.16, -13760, 74.6108, 1.35698, 0),
(@PATH, 86, -4135.66, -13756.6, 74.5907, 0.545662, 0),
(@PATH, 87, -4131.3, -13754.6, 74.6109, 6.14319, 0),
(@PATH, 88, -4127.9, -13756.6, 74.2825, 5.30675, 0),
(@PATH, 89, -4127.08, -13760.8, 74.2562, 5.74265, 0),
(@PATH, 90, -4121.58, -13761.4, 73.5881, 0.0354084, 0),
(@PATH, 91, -4113.68, -13762, 73.5694, 5.80705, 0),
(@PATH, 92, -4110.51, -13765.2, 73.6102, 5.19209, 0),
(@PATH, 93, -4107.71, -13772.5, 74.6982, 5.80705, 0),
(@PATH, 94, -4102.51, -13772.3, 74.7185, 0.511104, 0),
(@PATH, 95, -4099.89, -13768, 74.7256, 1.36954, 0),
(@PATH, 96, -4102.44, -13763.8, 74.5717, 2.63796, 0),
(@PATH, 97, -4125.6, -13762, 74.1406, 3.4807, 0),
(@PATH, 98, -4129.88, -13764.2, 74.5865, 3.28513, 0),
(@PATH, 99, -4135.57, -13762.7, 74.657, 2.14081, 0),
(@PATH, 100, -4137.16, -13760, 74.6108, 1.35698, 0),
(@PATH, 101, -4135.66, -13756.6, 74.5907, 0.545662, 0),
(@PATH, 102, -4131.3, -13754.6, 74.6109, 6.14319, 0),
(@PATH, 103, -4127.9, -13756.6, 74.2825, 5.30675, 0),
(@PATH, 104, -4127.08, -13760.8, 74.2562, 5.74265, 0),
(@PATH, 105, -4121.58, -13761.4, 73.5881, 0.0354084, 0);

-- Zalduun SAI
SET @ENTRY := 16502;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,74,0,100,0,0,40,120000,120000,11,29170,0,0,0,0,0,9,0,0,0,0,0,0,0,"Zalduun - On Friendly Between 0-40% Health - Cast 'Lesser Heal'"),
(@ENTRY,0,1,0,34,0,100,0,2,20,0,0,80,@ENTRY*100+00,0,0,0,0,0,1,0,0,0,0,0,0,0,"Zalduun - On Reached Point 20 - Run Script"),
(@ENTRY,0,2,0,34,0,100,0,2,67,0,0,80,@ENTRY*100+01,0,0,0,0,0,1,0,0,0,0,0,0,0,"Zalduun - On Reached Point 67 - Run Script");

-- Actionlist SAI
SET @ENTRY := 1650200;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,1,0,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Zalduun - On Script - Say Line 0"),
(@ENTRY,9,1,0,0,0,100,0,2000,2000,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,4.31173,"Zalduun - On Script - Set Orientation 4.31173"),
(@ENTRY,9,2,0,0,0,100,0,2000,2000,0,0,11,29170,0,0,0,0,0,10,59238,16971,0,0,0,0,0,"Zalduun - On Script - Cast 'Lesser Heal'");

-- Actionlist SAI
SET @ENTRY := 1650201;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,1,0,5000,0,0,0,0,1,0,0,0,0,0,0,0,"Zalduun - On Script - Say Line 0"),
(@ENTRY,9,1,0,0,0,100,0,2000,2000,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0.157151,"Zalduun - On Script - Set Orientation 0.157151"),
(@ENTRY,9,2,0,0,0,100,0,2000,2000,0,0,11,29170,0,0,0,0,0,10,59240,16971,0,0,0,0,0,"Zalduun - On Script - Cast 'Lesser Heal'");

DELETE FROM `creature_text` WHERE `entry`=16502;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `comment`) VALUES 
(16502, 0, 0, 'Oh no!  I\'m losing this one!', 12, 7, 100, 0, 0, 0, 13113, 'Zalduun');--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
