--
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |256|512 WHERE `entry` IN (15910, 15904, 15896);
UPDATE `creature_model_info` SET `CombatReach` = 20 WHERE displayID = 15556;
