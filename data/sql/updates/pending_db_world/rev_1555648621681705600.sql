INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555648621681705600');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (63644, 63645, 1515);
INSERT INTO `spell_script_names` VALUES
(63644, 'spell_activate_talent'),
(63645, 'spell_activate_talent'),
(1515, 'spell_tame_beast');
