-- DB update 2022_10_21_01 -> 2022_10_22_00
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=6740 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6740,0,0,1,62,0,100,0,342,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Innkeeper Allison - On Gossip Option 0 Selected - Close Gossip'),
(6740,0,1,0,61,0,100,0,0,0,0,0,0,85,24751,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Innkeeper Allison - On Gossip Option 0 Selected - Invoker Cast Trick or Treat'),
(6740,0,2,3,22,0,100,0,41,0,0,0,0,33,6740,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Innkeeper Allison - Received Emote 41 - Quest Credit Flexing for Nougat'),
(6740,0,3,0,61,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Innkeeper Allison - Received Emote 41 - Talk 0');
