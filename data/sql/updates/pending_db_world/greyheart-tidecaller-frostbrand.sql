--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 21229 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21229, 0, 0, 0, 0, 0, 100, 0, 10900, 21200, 120000, 120000, 0, 0, 11, 39027, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Tidecaller - In Combat - Cast Poison Shield'),
(21229, 0, 1, 0, 0, 0, 100, 0, 5200, 11900, 35150, 35150, 0, 0, 11, 38624, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Tidecaller - In Combat - Cast Water Elemental Totem'),
(21229, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 38620, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greyheart Tidecaller - On respawn - Cast Frostbrand Weapon (proc)');
