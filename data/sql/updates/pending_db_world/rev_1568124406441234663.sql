INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1568124406441234663');

-- Set MovementType to 0 as Ruul is not using the default waypoint movement (table "waypoint_data") but SAI (table "waypoints")
UPDATE `creature_template` SET `MovementType` = 0 WHERE `entry` = 21315;

-- Ruul the Darkener SAI
DELETE FROM `smart_scripts` WHERE `entryorguid` = 21315 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2131500 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(21315,0,0,1,11,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - On Respawn - Set Active On'),
(21315,0,1,2,61,0,100,0,0,0,0,0,0,60,1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - Linked - Set Fly On'),
(21315,0,2,0,61,0,100,0,0,0,0,0,0,53,0,2131500,1,0,0,2,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - Linked - Start WP Movement (Repeat)'),
(21315,0,3,4,40,0,100,0,7,2131500,0,0,0,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - On WP 7 Reached - Pause WP For 5 Seconds'),
(21315,0,4,0,61,0,100,0,0,0,0,0,0,48,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - Linked - Set Active Off'),
(21315,0,5,6,40,0,100,0,60,2131500,0,0,0,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - On WP 60 Reached - Pause WP For 5 Seconds'),
(21315,0,6,0,61,0,100,0,0,0,0,0,0,48,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - Linked - Set Active Off'),
(21315,0,7,8,40,0,100,0,113,2131500,0,0,0,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - On WP 113 Reached - Pause WP For 5 Seconds'),
(21315,0,8,0,61,0,100,0,0,0,0,0,0,48,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - Linked - Set Active Off'),
(21315,0,9,10,40,0,100,0,120,2131500,0,0,0,54,5000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - On WP 120 Reached - Pause WP For 5 Seconds'),
(21315,0,10,0,61,0,100,0,0,0,0,0,0,48,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - Linked - Set Active Off'),
(21315,0,11,0,56,0,100,0,0,2131500,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - On WP Resumed - Set Active On'),
(21315,0,12,0,4,0,100,0,0,0,0,0,0,80,2131500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - On Aggro - Call Action List'),
(21315,0,13,0,6,0,100,0,0,0,0,0,0,11,38343,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - On Death - Cast ''Summon Ruul''s Netherdrake'''),
(21315,0,14,0,0,0,100,0,3000,3000,6000,6000,0,11,36073,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Ruul the Darkener - IC - Cast ''Spellbreaker'''),
(21315,0,15,0,0,0,100,0,5000,5000,5000,5000,0,11,39153,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Ruul the Darkener - IC - Cast ''Darkfury'''),
(21315,0,16,0,0,0,100,0,1000,1000,4000,4000,0,11,15284,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Ruul the Darkener - IC - Cast ''Cleave'''),

(2131500,9,0,0,0,0,100,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - On Script - Say Line 1'),
(2131500,9,1,0,0,0,100,0,5000,5000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul the Darkener - On Script - Say Line 0');

-- Ruul's Netherdrake
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22106 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(22106,0,0,0,0,0,100,0,3000,3000,5000,5000,0,11,38344,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Ruul''s Netherdrake - IC - Cast ''Arcane Blast'''),
(22106,0,1,0,0,0,100,0,3000,3000,10000,10000,0,11,36513,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul''s Netherdrake - IC - Cast ''Intangible Presence'''),
(22106,0,2,3,54,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,0,'Ruul''s Netherdrake - Just Summoned - Attack Closest Player Within 50 Yards'),
(22106,0,3,0,61,0,100,0,0,0,0,0,0,41,300000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ruul''s Netherdrake - Linked - Force Despawn After 5 Minutes');

-- Waypoints for Ruul the Darkener
DELETE FROM `waypoints` WHERE `entry` IN (21315,2131500);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`)
VALUES
(2131500,1,-3810.77,1074.14,125.56,'Ruul the Darkener'),
(2131500,2,-3839.98,1071.58,118.499,''),
(2131500,3,-3867.75,1062.55,106.879,''),
(2131500,4,-3896.48,1041.89,85.963,''),
(2131500,5,-3923.94,1020.87,60.165,''),
(2131500,6,-3946.8,1009.01,42.2177,''),
(2131500,7,-3981.31,987.115,15.5192,''),
(2131500,8,-3988.65,978.964,14.183,''),
(2131500,9,-3994.63,970.492,13.4223,''),
(2131500,10,-3999.27,963.359,11.8978,''),
(2131500,11,-4002.65,956.702,13.1709,''),
(2131500,12,-4006.13,948.931,14.0756,''),
(2131500,13,-4009.08,941.564,13.9254,''),
(2131500,14,-4012.38,932.841,12.7417,''),
(2131500,15,-4015.21,924.932,11.9336,''),
(2131500,16,-4018.21,916.585,11.4392,''),
(2131500,17,-4021.09,908.568,9.90932,''),
(2131500,18,-4023.53,901.509,8.09585,''),
(2131500,19,-4025.94,893.223,6.46008,''),
(2131500,20,-4027.94,885.911,6.6277,''),
(2131500,21,-4030.02,878.134,5.05458,''),
(2131500,22,-4031.69,871.699,4.27596,''),
(2131500,23,-4033.41,864.072,4.70797,''),
(2131500,24,-4034.91,855.929,4.55505,''),
(2131500,25,-4036.04,849.376,3.86906,''),
(2131500,26,-4037.32,842.018,2.85057,''),
(2131500,27,-4038.59,834.424,1.48921,''),
(2131500,28,-4039.96,825.306,1.31322,''),
(2131500,29,-4041.57,816.706,2.23125,''),
(2131500,30,-4043.16,808.102,2.51651,''),
(2131500,31,-4044.74,799.141,2.17118,''),
(2131500,32,-4046.31,789.718,2.22293,''),
(2131500,33,-4048.57,778.75,2.56021,''),
(2131500,34,-4050.58,769.518,2.58665,''),
(2131500,35,-4052.51,760.737,2.30316,''),
(2131500,36,-4054.78,751.808,1.35838,''),
(2131500,37,-4059.46,742.17,0.61918,''),
(2131500,38,-4065.09,733.178,0.61918,''),
(2131500,39,-4071.71,723.998,0.71151,''),
(2131500,40,-4077.79,715.879,1.83836,''),
(2131500,41,-4084.31,706.928,2.53091,''),
(2131500,42,-4090.45,698.544,2.5732,''),
(2131500,43,-4096.37,690.448,2.95817,''),
(2131500,44,-4102.31,681.796,2.67915,''),
(2131500,45,-4108.59,672.95,1.73231,''),
(2131500,46,-4115.71,663.703,2.73044,''),
(2131500,47,-4122.24,655.339,3.09841,''),
(2131500,48,-4128.94,646.224,4.00574,''),
(2131500,49,-4134.55,637.621,3.6254,''),
(2131500,50,-4139.81,628.014,4.27954,''),
(2131500,51,-4143,617.558,3.6599,''),
(2131500,52,-4145,609.041,4.80565,''),
(2131500,53,-4147.11,597.93,6.45364,''),
(2131500,54,-4149.08,586.674,8.64551,''),
(2131500,55,-4152.33,575.23,9.68845,''),
(2131500,56,-4156.26,563.385,11.2971,''),
(2131500,57,-4160.94,552.97,13.1934,''),
(2131500,58,-4165.42,542.826,15.6237,''),
(2131500,59,-4171.16,531.23,19.8849,''),
(2131500,60,-4174.9,523.848,22.9552,''),
(2131500,61,-4171.16,531.23,19.8849,''),
(2131500,62,-4165.42,542.826,15.6237,''),
(2131500,63,-4160.94,552.97,13.1934,''),
(2131500,64,-4156.26,563.385,11.2971,''),
(2131500,65,-4152.33,575.23,9.68845,''),
(2131500,66,-4149.08,586.674,8.64551,''),
(2131500,67,-4147.11,597.93,6.45364,''),
(2131500,68,-4145,609.041,4.80565,''),
(2131500,69,-4143,617.558,3.6599,''),
(2131500,70,-4139.81,628.014,4.27954,''),
(2131500,71,-4134.55,637.621,3.6254,''),
(2131500,72,-4128.94,646.224,4.00574,''),
(2131500,73,-4122.24,655.339,3.09841,''),
(2131500,74,-4115.71,663.703,2.73044,''),
(2131500,75,-4108.59,672.95,1.73231,''),
(2131500,76,-4102.31,681.796,2.67915,''),
(2131500,77,-4096.37,690.448,2.95817,''),
(2131500,78,-4090.45,698.544,2.5732,''),
(2131500,79,-4084.31,706.928,2.53091,''),
(2131500,80,-4077.79,715.879,1.83836,''),
(2131500,81,-4071.71,723.998,0.71151,''),
(2131500,82,-4065.09,733.178,0.61918,''),
(2131500,83,-4059.46,742.17,0.61918,''),
(2131500,84,-4054.78,751.808,1.35838,''),
(2131500,85,-4052.51,760.737,2.30316,''),
(2131500,86,-4050.58,769.518,2.58665,''),
(2131500,87,-4048.57,778.75,2.56021,''),
(2131500,88,-4046.31,789.718,2.22293,''),
(2131500,89,-4044.74,799.141,2.17118,''),
(2131500,90,-4043.16,808.102,2.51651,''),
(2131500,91,-4041.57,816.706,2.23125,''),
(2131500,92,-4039.96,825.306,1.31322,''),
(2131500,93,-4038.59,834.424,1.48921,''),
(2131500,94,-4037.32,842.018,2.85057,''),
(2131500,95,-4036.04,849.376,3.86906,''),
(2131500,96,-4034.91,855.929,4.55505,''),
(2131500,97,-4033.41,864.072,4.70797,''),
(2131500,98,-4031.69,871.699,4.27596,''),
(2131500,99,-4030.02,878.134,5.05458,''),
(2131500,100,-4027.94,885.911,6.6277,''),
(2131500,101,-4025.94,893.223,6.46008,''),
(2131500,102,-4023.53,901.509,8.09585,''),
(2131500,103,-4021.09,908.568,9.90932,''),
(2131500,104,-4018.21,916.585,11.4392,''),
(2131500,105,-4015.21,924.932,11.9336,''),
(2131500,106,-4012.38,932.841,12.7417,''),
(2131500,107,-4009.08,941.564,13.9254,''),
(2131500,108,-4006.13,948.931,14.0756,''),
(2131500,109,-4002.65,956.702,13.1709,''),
(2131500,110,-3999.27,963.359,11.8978,''),
(2131500,111,-3994.63,970.492,13.4223,''),
(2131500,112,-3988.65,978.964,14.183,''),
(2131500,113,-3981.31,987.115,15.5192,''),
(2131500,114,-3946.8,1009.01,42.2177,''),
(2131500,115,-3923.94,1020.87,60.165,''),
(2131500,116,-3896.48,1041.89,85.963,''),
(2131500,117,-3867.75,1062.55,106.879,''),
(2131500,118,-3839.98,1071.58,118.499,''),
(2131500,119,-3810.77,1074.14,125.56,''),
(2131500,120,-3761.74,1081.67,125.316,'');
