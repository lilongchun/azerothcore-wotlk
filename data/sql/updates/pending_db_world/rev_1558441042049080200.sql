INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558441042049080200');

-- Monument of Franclorn - On quest complete https://wotlk.evowow.com/quest=3802 equip Ironfel hammer. Despawn in 2,5 minutes.
UPDATE `gameobject_template` SET `AIName`="SmartGameObjectAI" WHERE `entry`=164689;
DELETE FROM `smart_scripts` WHERE `entryorguid`=164689 AND `id`=0 AND `source_type`=1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(164689,1,0,0,20,0,100,0,3802,0,0,0,50,164688,150,0,0,0,0,1,0,0,0,0.0,0.0,0.0,0.0,"Monument of Franclorn - On quest complete equip Ironfel hammer");
