INSERT INTO version_db_world (`sql_rev`) VALUES ('1488923537207948700');
-- Burning Skeleton SAI
SET @ENTRY := 31048;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,23,0,100,0,58627,0,0,0,11,58627,0,0,0,0,0,1,0,0,0,0,0,0,0,"Burning Skeleton - On Has Aura 'Immolation' - Cast 'Immolation'"),
(@ENTRY,0,1,0,61,0,100,0,58627,0,0,0,11,58594,0,0,0,0,0,1,0,0,0,0,0,0,0,"Burning Skeleton - On Has Aura 'Immolation' - Cast 'Skeleton Check Master'"),
(@ENTRY,0,2,3,31,0,100,0,58593,0,0,0,86,58599,2,23,0,0,0,1,0,0,0,0,0,0,0,"Burning Skeleton - On Target Spellhit 'Skeleton Check' - Cross Cast 'Abom Credit'"),
(@ENTRY,0,3,4,61,0,100,0,58593,0,0,0,28,58594,0,0,0,0,0,1,0,0,0,0,0,0,0,"Burning Skeleton - On Target Spellhit 'Skeleton Check' - Remove Aura 'Skeleton Check Master'"),
(@ENTRY,0,4,0,61,0,100,0,58593,0,0,0,11,58596,0,0,0,0,0,1,0,0,0,0,0,0,0,"Burning Skeleton - On Target Spellhit 'Skeleton Check' - Cast 'Abomination Explosion'");



