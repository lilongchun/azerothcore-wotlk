INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587384652743501400');

-- Boss Money Loot
UPDATE `creature_template` SET `mingold` = 4255, `maxgold` = 7025 WHERE `entry` = 26763; -- Anomalus (Normal)
UPDATE `creature_template` SET `mingold` = 8410, `maxgold` = 13950 WHERE `entry` = 30529; -- Anomalus (Heroic)
UPDATE `creature_template` SET `mingold` = 4355, `maxgold` = 7125 WHERE `entry` = 26794; -- Ormok (Normal)
UPDATE `creature_template` SET `mingold` = 8510, `maxgold` = 14050 WHERE `entry` = 30532; -- Ormok (Heroic)
UPDATE `creature_template` SET `mingold` = 4745, `maxgold` = 7515 WHERE `entry` = 26723; -- Keristrasza (Normal)
UPDATE `creature_template` SET `mingold` = 8900, `maxgold` = 14440 WHERE `entry` = 26723; -- Keristrasza (Heroic)

-- Berinand's Research
UPDATE `gameobject` SET `spawntimesecs` = 2 WHERE `guid` = 65527;

-- Crazed Mana-Wyrm
UPDATE `creature_template` SET `inhabittype`=`inhabittype`|2|4, `hoverheight` = 0 WHERE `entry` IN (26761,30521);
DELETE FROM `creature` WHERE `guid` IN (126584,126585,126586,126587,126588,126589,126590,126591,126592,126593,126594,126595,126596,126597,126598);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(126584, 26761, 576, 0, 0, 3, 1, 23329, 0, 691.668, -302.82, 11.865, 2.37365, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126585, 26761, 576, 0, 0, 3, 1, 23329, 0, 594.595, -311.187, 29.2439, 0.558505, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126586, 26761, 576, 0, 0, 3, 1, 23329, 0, 630.482, -370.674, -8.66542, 1.27409, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126587, 26761, 576, 0, 0, 3, 1, 23329, 0, 647.448, -32.3824, -5.87999, 0.645772, 3600, 0, 0, 951, 0, 0, 0, 537166592, 32, '', 0),
(126588, 26761, 576, 0, 0, 3, 1, 23329, 0, 663.072, -129.598, -28.8962, 2.72271, 3600, 0, 0, 951, 0, 0, 0, 537166592, 32, '', 0),
(126589, 26761, 576, 0, 0, 3, 1, 23329, 0, 657.006, -189.476, 8.18023, 0.396343, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126590, 26761, 576, 0, 0, 3, 1, 23329, 0, 663.308, -133.131, -0.291385, 0.597949, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126591, 26761, 576, 0, 0, 3, 1, 23329, 0, 582.847, -243.893, 11.1783, 2.48474, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126592, 26761, 576, 0, 0, 3, 1, 23329, 0, 589.976, -249.407, -14.5806, 2.48295, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126593, 26761, 576, 0, 0, 3, 1, 23329, 0, 601.652, -258.436, 12.8359, 2.48331, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126594, 26761, 576, 0, 0, 3, 1, 23329, 0, 657.785, -139.797, -1.68196, 1.08627, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126595, 26761, 576, 0, 0, 3, 1, 23329, 0, 618.397, -270.862, 13.0714, 2.59897, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126596, 26761, 576, 0, 0, 3, 1, 23329, 0, 627.119, -201.979, 10.2202, 0.396935, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126597, 26761, 576, 0, 0, 3, 1, 23329, 0, 662.315, -133.811, -0.233998, 0.603995, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126598, 26761, 576, 0, 0, 3, 1, 23329, 0, 610.738, -265.435, 13.5687, 2.48741, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0);

UPDATE `creature` SET `unit_flags`=`unit_flags`|33554432 WHERE `guid` IN (126587,126588);

-- Azure Enforcer
UPDATE `creature` SET `unit_flags` = 570721024, `dynamicflags` = 32 WHERE `guid` IN (126484,126483,126485);

DELETE FROM `creature_addon` WHERE `guid` IN (126484,126483,126485);
INSERT INTO `creature_addon` (`guid`, `isLarge`, `auras`) VALUES
(126484, 1, '29266'),
(126483, 1, '29266'),
(126485, 1, '29266');

-- Azure Skyrazor
UPDATE `creature_template` SET `inhabittype`=`inhabittype`|2|4, `hoverheight` = 0 WHERE `entry` IN (26736,30518);
DELETE FROM `creature` WHERE `guid` IN (126501,126502,126503,126504,126505,126506);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(126501, 26736, 576, 0, 0, 3, 1, 28080, 0, 721.425, -65.2332, -7.0575, 4.29351, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126502, 26736, 576, 0, 0, 3, 1, 28080, 0, 578.682, -196.834, 3.08437, 4.69494, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126503, 26736, 576, 0, 0, 3, 1, 28080, 0, 592.485, -58.6556, 13.7837, 5.34164, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126504, 26736, 576, 0, 0, 3, 1, 28080, 0, 690.186, -166.806, 0.7982, 3.64774, 3600, 5, 0, 951, 0, 1, 0, 0, 0, '', 0),
(126505, 26736, 576, 0, 0, 3, 1, 28080, 0, 721.486, -189.85, -27.5382, 4.39823, 3600, 0, 0, 951, 0, 0, 0, 537166592, 32, '', 0),
(126506, 26736, 576, 0, 0, 3, 1, 28080, 0, 591.549, -158.816, -19.9489, 2.33874, 3600, 0, 0, 951, 0, 0, 0, 537166592, 32, '', 0);

UPDATE `creature` SET `unit_flags`=`unit_flags`|33554432 WHERE `guid` IN (126506,126505);

-- Chaotic Rift
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26918;

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 26918;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26918, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 48019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Reset - Cast \'Arcaneform\''),
(26918, 0, 1, 0, 60, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 11, 47737, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Update - Cast \'Charged Chaotic Energy Burst\''),
(26918, 0, 2, 0, 60, 0, 100, 0, 5000, 5000, 5000, 10000, 0, 12, 26746, 4, 1000, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Update - Summon Creature \'Crazed Mana-Wraith\'');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-126438,-126437,-126436,-126434,-126439,-126435) AND `source_type` = 0 AND `id` IN (0, 1, 2);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-126438, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 48019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Reset - Cast \'Arcaneform\''),
(-126438, 0, 1, 0, 60, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 11, 47688, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Update - Cast \'Chaotic Energy Burst\''),
(-126438, 0, 2, 0, 60, 0, 100, 0, 10000, 10000, 10000, 10000, 0, 12, 26746, 4, 1000, 0, 1, 0, 8, 0, 0, 0, 0, 626.38501, -109.863998, -15.1531, 0.575959, 'Chaotic Rift - On Update - Summon Creature \'Crazed Mana-Wraith\''),
(-126437, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 48019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Reset - Cast \'Arcaneform\''),
(-126437, 0, 1, 0, 60, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 11, 47688, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Update - Cast \'Chaotic Energy Burst\''),
(-126437, 0, 2, 0, 60, 0, 100, 0, 10000, 10000, 10000, 10000, 0, 12, 26746, 4, 1000, 0, 1, 0, 8, 0, 0, 0, 0, 572.52, -119.983, -26.5417, 4.85202, 'Chaotic Rift - On Update - Summon Creature \'Crazed Mana-Wraith\''),
(-126436, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 48019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Reset - Cast \'Arcaneform\''),
(-126436, 0, 1, 0, 60, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 11, 47688, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Update - Cast \'Chaotic Energy Burst\''),
(-126436, 0, 2, 0, 60, 0, 100, 0, 10000, 10000, 10000, 10000, 0, 12, 26746, 4, 1000, 0, 1, 0, 8, 0, 0, 0, 0, 557.735, -198.446, -23.4018, 4.85202, 'Chaotic Rift - On Update - Summon Creature \'Crazed Mana-Wraith\''),
(-126434, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 48019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Reset - Cast \'Arcaneform\''),
(-126434, 0, 1, 0, 60, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 11, 47688, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Update - Cast \'Chaotic Energy Burst\''),
(-126434, 0, 2, 0, 60, 0, 100, 0, 10000, 10000, 10000, 10000, 0, 12, 26746, 4, 1000, 0, 1, 0, 8, 0, 0, 0, 0, 689.774, -140.804, -28.8962, 4.85202, 'Chaotic Rift - On Update - Summon Creature \'Crazed Mana-Wraith\''),
(-126439, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 48019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Reset - Cast \'Arcaneform\''),
(-126439, 0, 1, 0, 60, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 11, 47688, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Update - Cast \'Chaotic Energy Burst\''),
(-126439, 0, 2, 0, 60, 0, 100, 0, 10000, 10000, 10000, 10000, 0, 12, 26746, 4, 1000, 0, 1, 0, 8, 0, 0, 0, 0, 722.098, -147.022, -28.8962, 3.03687, 'Chaotic Rift - On Update - Summon Creature \'Crazed Mana-Wraith\''),
(-126435, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 48019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Reset - Cast \'Arcaneform\''),
(-126435, 0, 1, 0, 60, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 11, 47688, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Chaotic Rift - On Update - Cast \'Chaotic Energy Burst\''),
(-126435, 0, 2, 0, 60, 0, 100, 0, 10000, 10000, 10000, 10000, 0, 12, 26746, 4, 1000, 0, 1, 0, 8, 0, 0, 0, 0, 635.917, -206.815, -15.1531, 3.76991, 'Chaotic Rift - On Update - Summon Creature \'Crazed Mana-Wraith\'');

-- Crazed Mana-Surge
UPDATE `creature_template` SET `faction` = 1693 WHERE `entry` IN (26737,30519);

-- Crazed Mana-Wraith
UPDATE `creature_template` SET `faction` = 1693 WHERE `entry` IN (26746,30520);

DELETE FROM `creature` WHERE `GUID` IN (126522, 126523, 126524, 126525, 126526, 126527, 126528, 126529, 126530, 126531, 126532, 126533, 126534, 126535, 126536, 126537, 126538, 126539, 126540, 126541, 126542, 126543, 126544, 126545, 126546, 126547, 126548, 126549, 126550, 126551, 126552, 126553, 126554, 126555, 126556, 126557, 126558, 126559, 126560, 126561, 126562, 126563, 126564, 126565, 126566, 126567, 126568, 126569, 126570, 126571, 126572, 126573, 126574, 126575, 126576, 126577, 126578, 126579, 126580, 126581, 126582, 126583);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(126522, 26746, 576, 0, 0, 3, 1, 27810, 0, 595.397, -178.336, -27.6075, 4.01015, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126523, 26746, 576, 0, 0, 3, 1, 27810, 0, 601.954, -183.935, -28.414, 0.697214, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126524, 26746, 576, 0, 0, 3, 1, 27810, 0, 587.247, -171.544, -27.5525, 5.26858, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126525, 26746, 576, 0, 0, 3, 1, 27810, 0, 589.867, -199.939, -27.1005, 6.1825, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126526, 26746, 576, 0, 0, 3, 1, 27810, 0, 588.003, -183.893, -27.3824, 4.31364, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126527, 26746, 576, 0, 0, 3, 1, 27810, 0, 697.255, -175.627, -28.9902, 2.38792, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126528, 26746, 576, 0, 0, 3, 1, 27810, 0, 690.537, -162.307, -28.9796, 2.14748, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126529, 26746, 576, 0, 0, 3, 1, 27810, 0, 677.544, -190.058, -25.213, 1.45003, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126530, 26746, 576, 0, 0, 3, 1, 27810, 0, 560.815, -95.704, -28.9796, 4.0124, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126531, 26746, 576, 0, 0, 3, 1, 27810, 0, 596.551, -132.962, -28.5882, 6.20321, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126532, 26746, 576, 0, 0, 3, 1, 27810, 0, 646.77, -153.253, -29.724, 2.13809, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126533, 26746, 576, 0, 0, 3, 1, 27810, 0, 627.393, -151.941, -28.9796, 3.17306, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126534, 26746, 576, 0, 0, 3, 1, 27810, 0, 629.136, -167.085, -30.2922, 2.11216, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126535, 26746, 576, 0, 0, 3, 1, 27810, 0, 630.379, -163.046, -30.2922, 4.54592, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126536, 26746, 576, 0, 0, 3, 1, 27810, 0, 641.192, -166.133, -30.2922, 4.23657, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126537, 26746, 576, 0, 0, 3, 1, 27810, 0, 559.094, -161.072, -24.8939, 4.70379, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126538, 26746, 576, 0, 0, 3, 1, 27810, 0, 619.866, -107.192, -15.2364, 5.79857, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126539, 26746, 576, 0, 0, 3, 1, 27810, 0, 633.886, -109.421, -15.2364, 0.301053, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126540, 26746, 576, 0, 0, 3, 1, 27810, 0, 683.284, -138.184, -28.9796, 2.60799, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126541, 26746, 576, 0, 0, 3, 1, 27810, 0, 573.993, -123.708, -26.7355, 1.51051, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126542, 26746, 576, 0, 0, 3, 1, 27810, 0, 630.909, -96.7552, -15.2364, 3.48712, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126543, 26746, 576, 0, 0, 3, 1, 27810, 0, 680.403, -138.456, -28.3314, 2.06212, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126544, 26746, 576, 0, 0, 3, 1, 27810, 0, 582.112, -118.285, -27.8665, 1.51198, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126545, 26746, 576, 0, 0, 3, 1, 27810, 0, 625.443, -111.809, -15.2364, 5.21144, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126546, 26746, 576, 0, 0, 3, 1, 27810, 0, 685.061, -146.904, -28.9796, 2.81257, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126547, 26746, 576, 0, 0, 3, 1, 27810, 0, 575.917, -115.456, -27.4311, 4.03884, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126548, 26746, 576, 0, 0, 3, 1, 27810, 0, 626.868, -110.713, -15.2364, 3.04725, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126549, 26746, 576, 0, 0, 3, 1, 27810, 0, 719.255, -143.783, -28.9796, 6.15639, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126550, 26746, 576, 0, 0, 3, 1, 27810, 0, 691.543, -141.628, -28.9796, 1.09544, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126551, 26746, 576, 0, 0, 3, 1, 27810, 0, 577.232, -125.048, -27.0134, 3.47331, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126552, 26746, 576, 0, 0, 3, 1, 27810, 0, 626.327, -108.456, -15.2364, 1.10571, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126553, 26746, 576, 0, 0, 3, 1, 27810, 0, 715.108, -146.022, -28.9796, 3.72483, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126554, 26746, 576, 0, 0, 3, 1, 27810, 0, 691.182, -148.848, -28.9796, 5.80994, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126555, 26746, 576, 0, 0, 3, 1, 27810, 0, 628.087, -217.011, -15.2364, 4.85063, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126556, 26746, 576, 0, 0, 3, 1, 27810, 0, 558.3, -201.423, -23.7025, 3.80745, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126557, 26746, 576, 0, 0, 3, 1, 27810, 0, 574.941, -128.601, -26.5539, 3.76439, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126558, 26746, 576, 0, 0, 3, 1, 27810, 0, 612.516, -112.802, -15.9454, 4.2997, 3600, 0, 0, 5574, 29328, 0, 0, 0, 0, '', 0),
(126559, 26746, 576, 0, 0, 3, 1, 27810, 0, 728.518, -147.739, -28.9796, 5.71663, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126560, 26746, 576, 0, 0, 3, 1, 27810, 0, 688.349, -148.142, -28.9796, 6.0253, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126561, 26746, 576, 0, 0, 3, 1, 27810, 0, 636.937, -216.704, -15.2364, 0.056719, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126562, 26746, 576, 0, 0, 3, 1, 27810, 0, 558.95, -207.996, -23.6997, 4.74948, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126563, 26746, 576, 0, 0, 3, 1, 27810, 0, 581.685, -122.093, -27.5863, 2.9073, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126564, 26746, 576, 0, 0, 3, 1, 27810, 0, 624.328, -111.521, -15.2364, 5.73971, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126565, 26746, 576, 0, 0, 3, 1, 27810, 0, 727.196, -150.067, -28.9796, 6.20428, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126566, 26746, 576, 0, 0, 3, 1, 27810, 0, 634.448, -210.778, -15.2364, 1.46423, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126567, 26746, 576, 0, 0, 3, 1, 27810, 0, 547.744, -197.98, -20.6549, 0.235288, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126568, 26746, 576, 0, 0, 3, 1, 27810, 0, 624.994, -106.453, -15.2364, 3.00959, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126569, 26746, 576, 0, 0, 3, 1, 27810, 0, 726.554, -150.906, -28.9796, 5.63863, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126570, 26746, 576, 0, 0, 3, 1, 27810, 0, 686.596, -145.713, -28.9796, 3.63982, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126571, 26746, 576, 0, 0, 3, 1, 27810, 0, 634.31, -211.894, -15.2364, 1.714, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126572, 26746, 576, 0, 0, 3, 1, 27810, 0, 551.966, -194.496, -21.8676, 6.26889, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126573, 26746, 576, 0, 0, 3, 1, 27810, 0, 576.239, -124.797, -26.919, 3.10624, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126574, 26746, 576, 0, 0, 3, 1, 27810, 0, 627.612, -111.93, -15.2364, 6.06641, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126575, 26746, 576, 0, 0, 3, 1, 27810, 0, 728.04, -152.463, -28.9796, 0.27262, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126576, 26746, 576, 0, 0, 3, 1, 27810, 0, 690.769, -142.984, -28.9796, 2.14072, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126577, 26746, 576, 0, 0, 3, 1, 27810, 0, 637.343, -209.122, -15.2364, 4.14214, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126578, 26746, 576, 0, 0, 3, 1, 27810, 0, 557.026, -193.741, -23.6532, 1.89913, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126579, 26746, 576, 0, 0, 3, 1, 27810, 0, 717.811, -149.64, -28.9796, 2.86631, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126580, 26746, 576, 0, 0, 3, 1, 27810, 0, 691.117, -140.718, -28.9796, 1.58886, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126581, 26746, 576, 0, 0, 3, 1, 27810, 0, 634.375, -215.797, -15.2364, 4.69788, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126582, 26746, 576, 0, 0, 3, 1, 27810, 0, 565.023, -200.056, -24.2981, 2.20734, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0),
(126583, 26746, 576, 0, 0, 3, 1, 27810, 0, 718.619, -144.892, -28.9796, 1.60012, 3600, 5, 0, 5574, 29328, 1, 0, 0, 0, '', 0);

-- Halls of Stasis
DELETE FROM `creature` WHERE `guid` IN (116017,116016,115899,115933,115900,115965,115952);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(115899, 26800, 576, 4265, 0, 3, 1, 0, 1, 443.366, 183.462, -34.9374, 4.31096, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(115900, 26800, 576, 4265, 0, 3, 1, 0, 1, 450.258, 175.462, -34.9375, 4.11898, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(115933, 26802, 576, 4265, 0, 3, 1, 0, 1, 442.812, 176.398, -34.9374, 4.27606, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(115952, 26802, 576, 4265, 0, 3, 1, 0, 1, 460.961, 147.602, -34.9378, 3.45575, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(115965, 26802, 576, 4265, 0, 3, 1, 0, 1, 460.826, 162.661, -34.9377, 3.76991, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(116016, 26805, 576, 4265, 0, 3, 1, 0, 1, 428.6, 189.332, -34.9369, 4.60767, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723),
(116017, 26805, 576, 4265, 0, 3, 1, 0, 1, 420.703, 189.507, -34.9366, 4.7822, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 11723);

DELETE FROM `creature_addon` WHERE `guid` IN (116017,116016,115899,115933,115900,115965,115952);
INSERT INTO `creature_addon` (`guid`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(115899, 1, 33, 1, '47543'),
(115900, 1, 33, 1, '47543'),
(115933, 1, 376, 1, '47543'),
(115952, 1, 376, 1, '47543'),
(115965, 1, 376, 1, '47543'),
(116016, 1, 375, 1, '47543'),
(116017, 1, 375, 1, '47543');

DELETE FROM `creature_template_addon` WHERE `entry` IN (26800,26802,26805,27949);
INSERT INTO `creature_template_addon` (`entry`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(26800, 1, 333, 1, '47543'),
(26802, 1, 376, 1, '47543'),
(26805, 1, 375, 1, '47543'),
(27949, 1, 333, 1, '47543');

-- The Singing Grove
DELETE FROM `creature` WHERE `guid` IN (126600,126601,126602,126603,126604,126605,126606,126607,126608,126609,1266090,126440,126441,126442,126443,126444,126445,126446,126447);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(126600, 26782, 576, 0, 0, 3, 1, 27469, 0, 356.128, -179.167, -14.2759, 3.80705, 3600, 1, 0, 37164, 0, 1, 0, 0, 0, '', 0),
(126601, 26782, 576, 0, 0, 3, 1, 27469, 0, 383.348, -184.97, -14.0888, 2.91584, 3600, 1, 0, 37164, 0, 1, 0, 0, 0, '', 0),
(126602, 26782, 576, 0, 0, 3, 1, 27469, 0, 387.443, -184.48, -14.0888, 2.63267, 3600, 1, 0, 37164, 0, 1, 0, 0, 0, '', 0),
(126603, 26782, 576, 0, 0, 3, 1, 27469, 0, 458.056, -177.292, -14.0888, 5.79238, 3600, 1, 0, 37164, 0, 1, 0, 0, 0, '', 0),
(126604, 26782, 576, 0, 0, 3, 1, 27469, 0, 453.272, -178.744, -14.0888, 5.79238, 3600, 1, 0, 37164, 0, 1, 0, 0, 0, '', 0),
(126605, 26782, 576, 0, 0, 3, 1, 27469, 0, 247.919, -235.086, -8.48918, 2.34172, 3600, 1, 0, 37164, 0, 1, 0, 0, 0, '', 0),
(126606, 26782, 576, 0, 0, 3, 1, 27469, 0, 251.404, -238.64, -8.25408, 2.34654, 3600, 1, 0, 37164, 0, 1, 0, 0, 0, '', 0),
(126607, 26782, 576, 0, 0, 3, 1, 27469, 0, 403.166, -313.62, -14.0888, 0.612719, 3600, 1, 0, 37164, 0, 1, 0, 0, 0, '', 0),
(126608, 26782, 576, 0, 0, 3, 1, 27469, 0, 397.014, -322.266, -14.0888, 0.174134, 3600, 1, 0, 37164, 0, 1, 0, 0, 0, '', 0),
(126609, 26782, 576, 0, 0, 3, 1, 27469, 0, 431.531, -273.502, -14.0888, 2.62032, 3600, 1, 0, 37164, 0, 1, 0, 0, 0, '', 0),
(1266090, 26782, 576, 0, 0, 3, 1, 27469, 0, 431.531, -273.502, -14.0888, 2.62032, 3600, 1, 0, 37164, 0, 1, 0, 0, 0, '', 0),
(126440, 28231, 576, 0, 0, 3, 1, 27609, 1, 356.727, -174.203, -14.0888, 3.80708, 3600, 0, 0, 37164, 3231, 2, 0, 0, 0, '', 0),
(126441, 28231, 576, 0, 0, 3, 1, 27609, 1, 383.407, -184.995, -14.0888, 2.74376, 3600, 0, 0, 37164, 3231, 2, 0, 0, 0, '', 0),
(126442, 28231, 576, 0, 0, 3, 1, 27609, 1, 385.189, -183.384, -14.0888, 2.64964, 3600, 0, 0, 37164, 3231, 2, 0, 0, 0, '', 0),
(126443, 28231, 576, 0, 0, 3, 1, 27609, 1, 456.604, -172.507, -14.0888, 5.79238, 3600, 0, 0, 37164, 3231, 2, 0, 0, 0, '', 0),
(126444, 28231, 576, 0, 0, 3, 1, 27609, 1, 252.187, -239.48, -8.25408, 2.34172, 3600, 5, 0, 37164, 3231, 1, 0, 0, 0, '', 0),
(126445, 28231, 576, 0, 0, 3, 1, 27609, 1, 253.398, -238.519, -8.36484, 2.58196, 3600, 0, 0, 37164, 3231, 2, 0, 0, 0, '', 0),
(126446, 28231, 576, 0, 0, 3, 1, 27609, 1, 392.948, -316.481, -14.0888, 0.118064, 3600, 0, 0, 37164, 3231, 2, 0, 0, 0, '', 0),
(126447, 28231, 576, 0, 0, 3, 1, 27609, 1, 436.391, -274.338, -14.0888, 2.46728, 3600, 0, 0, 37164, 3231, 2, 0, 0, 0, '', 0);

DELETE FROM `creature_formations` WHERE `memberGUID` IN (126442,126602,126601,126441,126447,126609,1266090);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(126442, 126442, 0, 0, 0, 0, 0),
(126442, 126602, 6, 170, 2, 0, 0),
(126442, 126601, 6, 30, 2, 0, 0),
(126442, 126441, 4, 90, 2, 0, 0),
(126447, 126447, 0 , 0, 0, 0, 0),
(126447, 126609, 6, 45, 2, 0, 0),
(126447, 1266090, 6, 135, 2, 0, 0);