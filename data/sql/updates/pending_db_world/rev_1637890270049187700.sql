INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637890270049187700');

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 179666;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 179666);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(179666, 1, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fire Elemental Rift - On Respawn - Set Event Phase 1'),
(179666, 1, 1, 2, 60, 1, 100, 0, 0, 1000, 30000, 30000, 0, 12, 14460, 6, 120000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fire Elemental Rift - On Update - Summon Creature \'Blazing Invader\' (Phase 1)'),
(179666, 1, 2, 0, 61, 0, 100, 0, 14460, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fire Elemental Rift - On Summoned Unit - Increase counter by 1'),
(179666, 1, 3, 0, 77, 0, 100, 0, 1, 3, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'When 3 Invaders have been summoned - Set Event Phase 2'),
(179666, 1, 4, 0, 77, 0, 100, 0, 1, 2, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'When there\'s 2 Invaders left - Set Event Phase 1');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 14460;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 14460);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14460, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 89, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blazing Invader - On Just Summoned - Start Random Movement'),
(14460, 0, 1, 0, 0, 0, 100, 0, 0, 11000, 10000, 16000, 0, 11, 23113, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blazing Invader - In Combat - Cast \'Blast Wave\''),
(14460, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 1, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Blazing Invader - On Just Died - Missing comment for action_type 63');
