--
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_porung' WHERE `entry` = 20923;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (20923, 17461) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2092300, 1746100) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17461, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 19, 17693, 100, 0, 0, 0, 0, 0, 0, 'Shattered Hand Blood Guard - On Just Died - Set Data 2 0');
