INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631721215836008000');

-- Add UNIT_FLAG_NON_ATTACKABLE and UNIT_FLAG_NOT_SELECTABLE to Ironaya
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|2|33554432 WHERE `entry` = 7228;

-- Text & remov unit flags from Ironaya based on gob "keystone" activation
DELETE FROM `smart_scripts` WHERE `entryorguid`=124371 AND `source_type`=1 AND `id` IN (4,5,6);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(124371, 1, 4, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 19, 33554434, 0, 0, 0, 0, 0, 11, 7228, 100, 1, 0, 0, 0, 0, 0, 'Keystone - On Gossip Hello - Remove unit flags of Ironaya'),
(124371, 1, 5, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 11, 7228, 100, 1, 0, 0, 0, 0, 0, 'Keystone - On Gossip Hello - Ironaya Say Line 0'),
(124371, 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 201, 0, 0, 0, 0, 0, 0, 11, 7228, 100, 1, 0, -232.941, 245.955, -49.171, 4.92, 'Keystone - On Gossip Hello - Ironaya move to pos');

-- Refactor & cleaning
DELETE FROM `smart_scripts` WHERE `entryorguid`=7228 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `id`=0 WHERE `entryorguid`=7228 AND `source_type`=0 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `id`=1 WHERE `entryorguid`=7228 AND `source_type`=0 AND `id`=2 AND `link`=0;
UPDATE `smart_scripts` SET `id`=2 WHERE `entryorguid`=7228 AND `source_type`=0 AND `id`=3 AND `link`=0;

