INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637421845365439100');

UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` IN (1642, 1646);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceGroup`=0 AND `SourceEntry`=1643 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 1643, 0, 0, 47, 0, 1642, 64, 0, 0, 0, 0, '', 'Quest The Tome of Divinity (Human) available if quest The Tome of Divinity (book) has been rewarded.');
