DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1540201) AND (`source_type` = 9) AND (`id` IN (4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1540201, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 15958, 4, 15000, 0, 0, 0, 8, 0, 0, 0, 0, 8750.1, -7129.7, 35.2976, 3.8041, 'Apprentice Mirveda - Actionlist - Summon Creature \'Gharsul the Remorseless\''),
(1540201, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 15656, 4, 15000, 0, 0, 0, 8, 0, 0, 0, 0, 8753.61, -7133.15, 35, 3.8576, 'Apprentice Mirveda - Actionlist - Summon Creature \'Angershade\''),
(1540201, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 15656, 4, 15000, 0, 0, 0, 8, 0, 0, 0, 0, 8747.14, -7125.71, 35.848, 3.8576, 'Apprentice Mirveda - Actionlist - Summon Creature \'Angershade\'');
