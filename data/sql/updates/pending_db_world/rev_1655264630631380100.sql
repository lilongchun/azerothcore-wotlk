--
DELETE FROM `creature_addon` WHERE `guid`=144632;
INSERT INTO `creature_addon` (`guid`, `auras`) VALUES 
(144632, '8876'); -- Triggers SPELL_THRASH = 3391

-- Immune to Taunt
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|256 WHERE `entry` IN 
(15339, -- Ossirian
15370, -- Buru
15369); -- Ayamiss

-- Disable exp on Buru egg / Hive'zara hatchling
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|64 WHERE `entry` IN (15514,15521);

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=15521;
DELETE FROM `smart_scripts` WHERE `entryorguid`= 15521 AND `source_type`= 0 AND `id`= 0;
INSERT INTO `smart_scripts` (`entryorguid`, `event_type`, `event_flags`, `event_param1`, `event_param2`, `action_type`, `action_param1`, `target_type`, `comment`) VALUES 
(15521, 1, 1, 10000, 10000, 41, 500, 1, 'Hive\'Zara Hatchling - Out of Combat - Despawn (No Repeat)');

