INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609119138728662700');

/* Anub'Rekhan */

-- Fix enrage for Crypt Guard
UPDATE `smart_scripts` SET `event_phase_mask`=0, `event_flags`=1, `event_param2`=29, `event_param3`=0, `event_param4`=0, `comment`='Crypt Guard - On 30% HP - CastSelf Frenzy' WHERE `entryorguid`=16573 AND `source_type`=0 AND `id`=3 AND `link`=0;
-- Add Frenzy emote for Crypt Guard
DELETE FROM `smart_scripts` WHERE `entryorguid`= 16573 AND `source_type`= 0 AND `id`= 5;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(16573, 0, 5, 0, 2, 0, 100, 1, 0, 29, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crypt Guard - On 30% HP - Say EMOTE_FRENZY');


/* Heigan the Unclean */

-- Enable random movement and adjust orientation
UPDATE `creature` SET `orientation`=2.40, `wander_distance`=4, `MovementType`=1 WHERE `guid`=127789;
-- Fix EMOTE_DEATH
UPDATE `creature_text` SET `Text`='%s takes his last breath.', `Type`=16, `BroadcastTextId`=13044, `comment`='heigan EMOTE_DEATH' WHERE `CreatureID`=15936 AND `GroupID`=3 AND `ID`=0;


/* Loatheb */

-- Useless, workaround implemented in boss_loatheb.cpp
DELETE FROM `spell_script_names` WHERE `spell_id`=59481;
-- Adjust movement speed for Spores
UPDATE `creature_template` SET `speed_walk`=0.4, `speed_run`=0.4 WHERE `entry` IN (16286, 30068);


/* Instructor Razuvious */

-- Fix all emotes / texts / dialogues / sound files
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(16061, 0, 0, 'Do as I taught you!', 14, 0, 25, 0, 0, 8855, 13075, 3, 'Razuvious SAY_AGGRO #1');
(16061, 0, 1, 'The time for practice is over! Show me what you have learned!', 14, 0, 25, 0, 0, 8859, 13078, 3, 'Razuvious SAY_AGGRO #2');
(16061, 0, 2, 'Show them no mercy!', 14, 0, 25, 0, 0, 8856, 13076, 3, 'Razuvious SAY_AGGRO #3');
(16061, 0, 3, 'Sweep the leg... Do you have a problem with that?', 14, 0, 25, 0, 0, 8861, 13080, 3, 'Razuvious SAY_AGGRO #4');
(16061, 1, 0, '%s lets loose a triumphant shout.', 16, 0, 50, 0, 0, 8863, 13082, 3, 'Razuvious SAY_SLAY #1');
(16061, 1, 1, 'You should have stayed home.', 14, 0, 50, 0, 0, 8862, 13081, 3, 'Razuvious SAY_SLAY #2');
(16061, 2, 0, 'Hah hah, I\'m just getting warmed up!', 14, 0, 20, 0, 0, 8852, 13072, 3, 'Razuvious SAY_TAUNTED #1');
(16061, 2, 1, 'Stand and fight!', 14, 0, 20, 0, 0, 8853, 13073, 3, 'Razuvious SAY_TAUNTED #2');
(16061, 2, 2, 'Show me what you\'ve got!', 14, 0, 20, 0, 0, 8854, 13074, 3, 'Razuvious SAY_TAUNTED #3');
(16061, 2, 3, 'You disappoint me, students!', 14, 0, 20, 0, 0, 8858, 13077, 3, 'Razuvious SAY_TAUNTED #4');
(16061, 2, 4, 'You should have stayed home.', 14, 0, 20, 0, 0, 8862, 13081, 3, 'Razuvious SAY_TAUNTED #5');
(16061, 3, 0, 'An honorable... death.', 14, 0, 100, 0, 0, 8860, 13079, 3, 'Razuvious SAY_DEATH');
-- Fix translation
UPDATE `broadcast_text_locale` SET `MaleText`='%s suelta un grito triunfal.' WHERE `ID`=13082 AND `locale` IN ('esES', 'esMX');

