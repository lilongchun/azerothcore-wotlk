-- DB update 2022_06_28_02 -> 2022_06_28_03
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30886;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30886);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30886, 0, 0, 0, 25, 0, 100, 513, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugated Iskalder - In Combat - Set Flag Immune To NPC\'s'),
(30886, 0, 1, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 29, 0, 0, 30232, 0, 1, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugated Iskalder - Out of Combat - Start Follow Invoker'),
(30886, 0, 2, 0, 65, 0, 100, 0, 0, 0, 0, 0, 0, 11, 25729, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Subjugated Iskalder - On Follow Complete - Cast \'Find the Ancient Hero: Kill Credit\'');
