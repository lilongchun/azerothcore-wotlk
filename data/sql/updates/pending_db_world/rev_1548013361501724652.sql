INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1548013361501724652');

UPDATE `smart_scripts` SET `action_param2`=1 WHERE `action_type`=7;
UPDATE `smart_scripts` SET `action_param2`=0 WHERE `source_type`=0 AND `entryorguid`=11216 AND `id`=3;
