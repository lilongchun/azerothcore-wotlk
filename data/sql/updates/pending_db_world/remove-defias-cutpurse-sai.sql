--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 94 AND `source_type` = 0;
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 94;
