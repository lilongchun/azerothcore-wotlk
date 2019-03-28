INSERT INTO version_db_world (`sql_rev`) VALUES ('1537830795157301100');

-- Shattered Sun Marksman SAI
SET @ENTRY := 24938;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,11,0,100,1,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shattered Sun Marksman - On Respawn - Disable Combat Movement (No Repeat)"),
(@ENTRY,0,1,0,10,0,100,1,0,70,4500,8000,11,74414,0,0,0,0,0,9,25192,0,50,0,0,0,0,"Shattered Sun Marksman - Within 0-70 Range Out of Combat LoS - Cast 'Shoot' (No Repeat)"),
(@ENTRY,0,2,0,25,0,100,0,0,0,0,0,40,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Shattered Sun Marksman - On Reset - Set Sheath Ranged");
UPDATE `smart_scripts` SET `action_param1` = 42580 WHERE `entryorguid` IN (-65694, -65695, -65696, -65697, -65698, -65699, -65700, -65702) AND `source_type` = 0;
