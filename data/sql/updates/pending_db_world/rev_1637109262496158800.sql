INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637109262496158800');

-- Alliance part
SET @QUESTID := 7168;
SET @FACTIONID := 730;

UPDATE `quest_template` SET `RequiredFactionId1` = @FACTIONID, `RequiredFactionValue1` = 3000 WHERE `ID` = @QUESTID;
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = @FACTIONID, `RequiredMinRepValue` = 3000 WHERE `ID` = @QUESTID;

UPDATE `quest_template` SET `RequiredFactionId1` = @FACTIONID, `RequiredFactionValue1` = 9000 WHERE `ID` = @QUESTID + 1;
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = @FACTIONID, `RequiredMinRepValue` = 9000 WHERE `ID` = @QUESTID + 1;

UPDATE `quest_template` SET `RequiredFactionId1` = @FACTIONID, `RequiredFactionValue1` = 21000 WHERE `ID` = @QUESTID + 2;
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = @FACTIONID, `RequiredMinRepValue` = 21000 WHERE `ID` = @QUESTID + 2;

UPDATE `quest_template` SET `RequiredFactionId1` = @FACTIONID, `RequiredFactionValue1` = 42000 WHERE `ID` = @QUESTID + 3;
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = @FACTIONID, `RequiredMinRepValue` = 42000 WHERE `ID` = @QUESTID + 3;

UPDATE `quest_template` SET `RequiredFactionId1` = @FACTIONID, `RequiredFactionValue1` = 42999 WHERE `ID` = @QUESTID + 4;
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = @FACTIONID, `RequiredMinRepValue` = 42999 WHERE `ID` = @QUESTID + 4;

-- Horde part
SET @QUESTID := 7163;
SET @FACTIONID := 729;

UPDATE `quest_template` SET `RequiredFactionId1` = @FACTIONID, `RequiredFactionValue1` = 3000 WHERE `ID` = @QUESTID;
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = @FACTIONID, `RequiredMinRepValue` = 3000 WHERE `ID` = @QUESTID;

UPDATE `quest_template` SET `RequiredFactionId1` = @FACTIONID, `RequiredFactionValue1` = 9000 WHERE `ID` = @QUESTID + 1;
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = @FACTIONID, `RequiredMinRepValue` = 9000, `PrevQuestID` = @QUESTID WHERE `ID` = @QUESTID + 1;

UPDATE `quest_template` SET `RequiredFactionId1` = @FACTIONID, `RequiredFactionValue1` = 21000 WHERE `ID` = @QUESTID + 2;
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = @FACTIONID, `RequiredMinRepValue` = 21000, `PrevQuestID` = @QUESTID + 1 WHERE `ID` = @QUESTID + 2;

UPDATE `quest_template` SET `RequiredFactionId1` = @FACTIONID, `RequiredFactionValue1` = 42000 WHERE `ID` = @QUESTID + 3;
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = @FACTIONID, `RequiredMinRepValue` = 42000 WHERE `ID` = @QUESTID + 3;

UPDATE `quest_template` SET `RequiredFactionId1` = @FACTIONID, `RequiredFactionValue1` = 42999 WHERE `ID` = @QUESTID + 4;
UPDATE `quest_template_addon` SET `RequiredMinRepFaction` = @FACTIONID, `RequiredMinRepValue` = 42999 WHERE `ID` = @QUESTID + 4;

-- Remove wrong repeatable flag
UPDATE `quest_template_addon` SET `SpecialFlags` = 0 WHERE `ID` IN (7164, 7166, 7167, 7170, 7171, 7172);
