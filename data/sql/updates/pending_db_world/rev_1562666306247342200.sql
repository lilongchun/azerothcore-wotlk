INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1562666306247342200');

DELETE FROM `smart_scripts` WHERE `entryorguid`=17071 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(17071,0,0,0,20,0,100,0,9312,0,0,0,80,1707100,2,0,0,0,0,1,0,0,0,0,0,0,0,"Technician Zhanaa - On Quest 'The Emitter' Finished - Run Script");
