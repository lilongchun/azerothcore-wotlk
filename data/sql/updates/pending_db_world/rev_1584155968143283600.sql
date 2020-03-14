INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584155968143283600');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceEntry` = 3142 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 4442;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 1, 3142, 0, 0, 8, 0, 4442, 0, 0, 0, 0, 0, '', 'Eridan Bluewind - Gossip Option 0 available if Purified! is rewarded');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9116;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 9116 AND `id` IN (0, 1);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9116, 0, 0, 1, 62, 0, 100, 0, 3142, 0, 0, 0, 0, 11, 47043, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Eridan Bluewind - On Gossip Option 0 Selected - Cast \'Flute of the Ancients\''),
(9116, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Eridan Bluewind - On Gossip Option 0 Selected - Close Gossip');