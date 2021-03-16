INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613941609619938749');

-- Fix party credit for burning The Scarlet Archive
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 176245) AND (`source_type` = 1) AND (`id` IN (0, 1, 2, 3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(176245, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 9, 176245, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Archive - On Gossip Hello - Activate Gameobject'),
(176245, 1, 1, 2, 61, 0, 100, 0, 1, 0, 0, 0, 0, 50, 176747, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3452.85, -3104.82, 136.54, 0, 'Scarlet Archive - On Gossip Hello - Summon Gameobject \'Small Barracks Flame\''),
(176245, 1, 2, 3, 61, 0, 100, 0, 1, 0, 0, 0, 0, 50, 176747, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3454.96, -3106.9, 136.54, 0, 'Scarlet Archive - On Gossip Hello - Summon Gameobject \'Small Barracks Flame\''),
(176245, 1, 3, 4, 61, 0, 100, 0, 1, 0, 0, 0, 0, 50, 176747, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3459.3, -3108.7, 136.54, 0, 'Scarlet Archive - On Gossip Hello - Summon Gameobject \'Small Barracks Flame\''),
(176245, 1, 4, 5, 61, 0, 100, 0, 1, 0, 0, 0, 0, 50, 176747, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3462.52, -3105.03, 136.54, 0, 'Scarlet Archive - On Gossip Hello - Summon Gameobject \'Small Barracks Flame\''),
(176245, 1, 5, 0, 61, 0, 100, 0, 1, 0, 0, 0, 0, 50, 176747, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3459.64, -3100.89, 136.54, 0, 'Scarlet Archive - On Gossip Hello - Summon Gameobject \'Small Barracks Flame\'');
