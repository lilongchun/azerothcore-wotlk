INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626635521387129200');

-- Changed the event_type from CAST to UPDATE_IC so they only can cast shoot while on combat.
-- Changed the action_param2 from 66 to 64. 66 does nothing, and 64 will take into account LOS, being stunned so they cant cast it
UPDATE `smart_scripts` SET `event_type` = 0, `action_param2` = 64, `action_param3` = 1 WHERE (`entryorguid` = 7856) AND (`source_type` = 0) AND (`id` = 0);
-- Changed the Fleeing skill to have 7-action invoker instead of Self as the rest of fleeing actions in the database.
UPDATE `smart_scripts` SET  `target_type` = 7 WHERE (`entryorguid` = 7856) AND (`source_type` = 0) AND (`id` = 1);

