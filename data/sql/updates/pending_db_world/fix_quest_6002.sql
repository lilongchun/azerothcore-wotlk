-- Update SAI NPC Lunaclaw
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12138) AND (`source_type` = 0) AND (`id` IN (5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12138, 0, 5, 0, 101, 0, 100, 0, 1, 10, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 10, 0, 0, 0, 0, 0, 0, 0, 'Lunaclaw - Prevent Despawn - Attack Start Player');
-- Update CompletionText (Progress text)
DELETE FROM `quest_request_items` WHERE (`ID` = 6002);
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(6002, 1, 0, 'When you have faced the challenge that lies before you, your understanding of strength of body and strength of heart will be fully realized.  Until that time, I cannot help you further.', 12340);
