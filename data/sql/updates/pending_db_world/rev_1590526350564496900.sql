INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590526350564496900');

DELETE FROM `spell_group_stack_rules` WHERE `group_id` = 1112;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES
(1112, 8);
DELETE FROM `spell_group` WHERE `id` = 1112;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
(1112, 8219),
(1112, 8220),
(1112, 8221),
(1112, 8222);
