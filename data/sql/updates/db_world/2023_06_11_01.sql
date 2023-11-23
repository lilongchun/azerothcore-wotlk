-- DB update 2023_06_11_00 -> 2023_06_11_01
--
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (36275, 36279, 36278, 36277);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(36275, 36275, 38533),
(36279, 38534, 38533),
(36278, 38536, 38533),
(36277, 38535, 38533);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (21104, 21148, 17839, 21140));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21104, 0, 0, 0, 11, 0, 20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - On Respawn - Say Line 0'),
(21104, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - On Aggro - Say Line 1'),
(21104, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - On Just Died - Say Line 2'),
(21104, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8269, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - Between 0-30% Health - Cast \'Frenzy\''),
(21104, 0, 4, 0, 0, 0, 100, 0, 12400, 26300, 16900, 25300, 0, 11, 12542, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast \'Fear\''),
(21104, 0, 5, 0, 0, 0, 100, 0, 7200, 12000, 11100, 29600, 0, 11, 36275, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast \'Shadow Bolt Volley\''),
(21104, 0, 6, 0, 0, 0, 100, 2, 7300, 19500, 20300, 45900, 0, 11, 36276, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast \'Curse of Vulnerability\' (Normal Dungeon)'),
(21104, 0, 7, 0, 0, 0, 100, 4, 6200, 21500, 12000, 21700, 0, 11, 36276, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast \'Curse of Vulnerability\' (Heroic Dungeon)'),
(21148, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - On Respawn - Say Line 0'),
(21148, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - On Aggro - Say Line 1'),
(21148, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - On Just Died - Say Line 2'),
(21148, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8269, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - Between 0-30% Health - Cast \'Frenzy\''),
(21148, 0, 4, 0, 0, 0, 100, 4, 13300, 34500, 21500, 27500, 0, 11, 13323, 64, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast \'Polymorph\' (Heroic Dungeon)'),
(21148, 0, 5, 0, 0, 0, 100, 0, 12400, 18200, 13900, 21200, 0, 11, 36277, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast \'Pyroblast\''),
(21148, 0, 6, 0, 9, 0, 100, 0, 0, 9, 9800, 18400, 1, 11, 36278, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - Within 0-9 Range - Cast \'Blast Wave\''),
(21148, 0, 7, 0, 0, 0, 100, 0, 0, 0, 2400, 3600, 0, 11, 36279, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Keeper - In Combat - Cast \'Frostbolt\''),
(17839, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - On Respawn - Say Line 0'),
(17839, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - On Aggro - Say Line 1'),
(17839, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - On Just Died - Say Line 2'),
(17839, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8269, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - Between 0-30% Health - Cast \'Frenzy\''),
(17839, 0, 4, 0, 0, 0, 100, 2, 6100, 18000, 10800, 15800, 0, 11, 15708, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast \'Mortal Strike\' (Normal Dungeon)'),
(17839, 0, 5, 0, 0, 0, 100, 4, 4900, 17700, 10300, 14500, 0, 11, 35054, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast \'Mortal Strike\' (Heroic Dungeon)'),
(17839, 0, 6, 0, 0, 0, 100, 2, 4800, 18800, 18100, 38500, 0, 11, 11428, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast \'Knockdown\' (Normal Dungeon)'),
(17839, 0, 7, 0, 0, 0, 100, 4, 6200, 18800, 13300, 19100, 0, 11, 11428, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast \'Knockdown\' (Heroic Dungeon)'),
(17839, 0, 8, 0, 0, 0, 100, 2, 7200, 11800, 15500, 26500, 0, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast \'Hamstring\' (Normal Dungeon)'),
(17839, 0, 9, 0, 0, 0, 100, 4, 4600, 15700, 11600, 18100, 0, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast \'Hamstring\' (Heroic Dungeon)'),
(21140, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - On Respawn - Say Line 0'),
(21140, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - On Aggro - Say Line 1'),
(21140, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - On Just Died - Say Line 2'),
(21140, 0, 3, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8269, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - Between 0-30% Health - Cast \'Frenzy\''),
(21140, 0, 4, 0, 0, 0, 100, 0, 5900, 9600, 5900, 9600, 0, 11, 16145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast \'Sunder Armor\''),
(21140, 0, 5, 0, 0, 0, 100, 2, 5100, 27600, 10900, 26600, 0, 11, 36214, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast \'Thunderclap\' (Normal Dungeon)'),
(21140, 0, 6, 0, 0, 0, 100, 4, 5100, 19100, 11800, 16900, 0, 11, 38537, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rift Lord - In Combat - Cast \'Thunderclap\' (Heroic Dungeon)');

DELETE FROM `creature_text` WHERE `CreatureID` IN (21104, 21148, 17839, 21140);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(21104, 0, 0, 'The sands of time shall be scattered to the winds!', 14, 0, 100, 0, 0, 0, 15179, 0, 'Rift Keeper'),
(21104, 0, 1, 'History is about to be rewritten!', 14, 0, 100, 0, 0, 0, 15180, 0, 'Rift Keeper'),
(21104, 0, 2, 'Let the siege begin!', 14, 0, 100, 0, 0, 0, 15181, 0, 'Rift Keeper'),
(21104, 1, 0, 'The rift must be protected!', 12, 0, 100, 0, 0, 0, 15182, 0, 'Rift Keeper'),
(21104, 1, 1, 'You are running out of time!', 12, 0, 100, 0, 0, 0, 15183, 0, 'Rift Keeper'),
(21104, 1, 2, 'Victory or death!', 12, 0, 100, 0, 0, 0, 15184, 0, 'Rift Keeper'),
(21104, 2, 0, 'You will never defeat us all!', 12, 0, 100, 0, 0, 0, 15185, 0, 'Rift Keeper'),
(21104, 2, 1, 'You will accomplish nothing!', 12, 0, 100, 0, 0, 0, 15186, 0, 'Rift Keeper'),
(21104, 2, 2, 'No! The rift...', 12, 0, 100, 0, 0, 0, 15187, 0, 'Rift Keeper'),
(21148, 0, 0, 'The sands of time shall be scattered to the winds!', 14, 0, 100, 0, 0, 0, 15179, 0, 'Rift Keeper'),
(21148, 0, 1, 'History is about to be rewritten!', 14, 0, 100, 0, 0, 0, 15180, 0, 'Rift Keeper'),
(21148, 0, 2, 'Let the siege begin!', 14, 0, 100, 0, 0, 0, 15181, 0, 'Rift Keeper'),
(21148, 1, 0, 'The rift must be protected!', 12, 0, 100, 0, 0, 0, 15182, 0, 'Rift Keeper'),
(21148, 1, 1, 'You are running out of time!', 12, 0, 100, 0, 0, 0, 15183, 0, 'Rift Keeper'),
(21148, 1, 2, 'Victory or death!', 12, 0, 100, 0, 0, 0, 15184, 0, 'Rift Keeper'),
(21148, 2, 0, 'You will never defeat us all!', 12, 0, 100, 0, 0, 0, 15185, 0, 'Rift Keeper'),
(21148, 2, 1, 'You will accomplish nothing!', 12, 0, 100, 0, 0, 0, 15186, 0, 'Rift Keeper'),
(21148, 2, 2, 'No! The rift...', 12, 0, 100, 0, 0, 0, 15187, 0, 'Rift Keeper'),
(17839, 0, 0, 'The sands of time shall be scattered to the winds!', 14, 0, 100, 0, 0, 0, 15179, 0, 'Rift Lord'),
(17839, 0, 1, 'History is about to be rewritten!', 14, 0, 100, 0, 0, 0, 15180, 0, 'Rift Lord'),
(17839, 0, 2, 'Let the siege begin!', 14, 0, 100, 0, 0, 0, 15181, 0, 'Rift Lord'),
(17839, 1, 0, 'The rift must be protected!', 12, 0, 100, 0, 0, 0, 15182, 0, 'Rift Lord'),
(17839, 1, 1, 'You are running out of time!', 12, 0, 100, 0, 0, 0, 15183, 0, 'Rift Lord'),
(17839, 1, 2, 'Victory or death!', 12, 0, 100, 0, 0, 0, 15184, 0, 'Rift Lord'),
(17839, 2, 0, 'You will never defeat us all!', 12, 0, 100, 0, 0, 0, 15185, 0, 'Rift Lord'),
(17839, 2, 1, 'You will accomplish nothing!', 12, 0, 100, 0, 0, 0, 15186, 0, 'Rift Lord'),
(17839, 2, 2, 'No! The rift...', 12, 0, 100, 0, 0, 0, 15187, 0, 'Rift Lord'),
(21140, 0, 0, 'The sands of time shall be scattered to the winds!', 14, 0, 100, 0, 0, 0, 15179, 0, 'Rift Lord'),
(21140, 0, 1, 'History is about to be rewritten!', 14, 0, 100, 0, 0, 0, 15180, 0, 'Rift Lord'),
(21140, 0, 2, 'Let the siege begin!', 14, 0, 100, 0, 0, 0, 15181, 0, 'Rift Lord'),
(21140, 1, 0, 'The rift must be protected!', 12, 0, 100, 0, 0, 0, 15182, 0, 'Rift Lord'),
(21140, 1, 1, 'You are running out of time!', 12, 0, 100, 0, 0, 0, 15183, 0, 'Rift Lord'),
(21140, 1, 2, 'Victory or death!', 12, 0, 100, 0, 0, 0, 15184, 0, 'Rift Lord'),
(21140, 2, 0, 'You will never defeat us all!', 12, 0, 100, 0, 0, 0, 15185, 0, 'Rift Lord'),
(21140, 2, 1, 'You will accomplish nothing!', 12, 0, 100, 0, 0, 0, 15186, 0, 'Rift Lord'),
(21140, 2, 2, 'No! The rift...', 12, 0, 100, 0, 0, 0, 15187, 0, 'Rift Lord');

-- Double Attack Aura on entry 21140 (Rift Lord)
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '19818' WHERE (`entry` = 21140);
