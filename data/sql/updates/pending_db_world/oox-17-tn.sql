DELETE FROM `smart_scripts` WHERE `entryorguid` = 7784 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (778400, 778401, 778402) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7784, 0, 0, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Respawn - Set Flag Standstate Dead'),
(7784, 0, 1, 0, 4, 0, 25, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Aggro - Say Line 1'),
(7784, 0, 2, 0, 19, 0, 100, 512, 648, 0, 0, 0, 0, 0, 80, 778400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Quest \'Rescue OOX-17/TN!\' Taken - Run Script'),
(7784, 0, 3, 0, 40, 0, 100, 512, 16, 0, 0, 0, 0, 0, 80, 778401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Waypoint 16 Reached - Run Script'),
(7784, 0, 4, 0, 1, 1, 100, 512, 500, 500, 500, 500, 0, 0, 80, 778402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - Out of Combat - Run Script (Phase 1)'),
(7784, 0, 5, 0, 40, 0, 100, 512, 19, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Waypoint 19 Reached - Despawn Instant'),
(7784, 0, 6, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 6, 648, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Death - Fail Quest \'Rescue OOX-17/TN!\''),
(778400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Say Line 0'),
(778400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 7784, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Start Waypoint'),
(778400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 113, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Set Faction 113'),
(778400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Remove Flag Immune To NPC\'s'),
(778400, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Remove Flag Standstate Dead'),
(778400, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Remove NPC Flag Questgiver'),
(778401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 54, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Pause Waypoint'),
(778401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Say Line 2'),
(778401, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 107, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Summon Group 0'),
(778401, 9, 3, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Set Event Phase 1'),
(778402, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Set Event Phase 1'),
(778402, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Say Line 3'),
(778402, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Set Run On'),
(778402, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Set Active'),
(778402, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 68499, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Cast \'OOX Lift Off\''),
(778402, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 648, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Quest Credit \'Rescue OOX-17/TN!\''),
(778402, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Add Flag Immune To NPC\'s'),
(778402, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 60, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Set Fly On'),
(778402, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Resume Waypoint');
