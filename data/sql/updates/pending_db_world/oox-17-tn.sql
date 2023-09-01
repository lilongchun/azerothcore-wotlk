--
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (778400, 778401, 778402) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(778400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Store Targetlist'),
(778400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Say Line 0'),
(778400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 7784, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ranger Lilatha - On Script - Start Waypoint'),
(778400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 113, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Set Faction 113'),
(778400, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Remove Flag Immune To NPC\'s'),
(778400, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Remove Flag Standstate Dead'),
(778400, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Remove NPC Flag Questgiver'),
(778401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 54, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Pause Waypoint'),
(778401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Say Line 2'),
(778401, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 107, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Summon Group 0'),
(778401, 9, 3, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Set Event Phase 1'),
(778402, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Set Event Phase 1'),
(778402, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Say Line 3'),
(778402, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Set Run On'),
(778402, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Set Active'),
(778402, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 68499, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Cast \'OOX Lift Off\''),
(778402, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 648, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Quest Credit \'Rescue OOX-17/TN!\''),
(778402, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Add Flag Immune To NPC\'s'),
(778402, 9, 7, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 60, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Set Fly On'),
(778402, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Homing Robot OOX-17/TN - On Script - Resume Waypoint');
