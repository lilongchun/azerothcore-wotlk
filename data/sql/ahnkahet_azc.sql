-- Amanitar encounter
DELETE FROM `spell_script_names` WHERE `spell_id`=57283;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(57283, 'spell_amanitar_remove_mushroom_power');
DELETE FROM `spell_script_names` WHERE `spell_id`=56648;
DELETE FROM `spell_group_stack_rules` WHERE `group_id`=1113;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES
(1113, 8, 'Ahn\'kahet - Potent Fogus and Mini');
DELETE FROM `spell_group` WHERE `id`=1113;
INSERT INTO `spell_group` (`id`, `spell_id`, `special_flag`) VALUES
(1113, 57055, 0),
(1113, 56648, 0);

-- Teldaram
DELETE FROM `spell_script_names` WHERE `spell_id` IN (55931, 55895, 59511, 59512);
INSERT INTO `spell_script_names` (`spell_id` ,`ScriptName`) VALUES
(55931, 'spell_prince_taldaram_conjure_flame_sphere'),
(55895, 'spell_prince_taldaram_flame_sphere_summon'),
(59511, 'spell_prince_taldaram_flame_sphere_summon'),
(59512, 'spell_prince_taldaram_flame_sphere_summon');
UPDATE `creature_text` SET `TextRange`='3',`comment`='prince taldaram SAY_SPHERE_ACTIVATED' WHERE  `CreatureID`=29308 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `TextRange`='3',`comment`='prince taldaram SAY_REMOVE_PRISON'  WHERE  `CreatureID`=29308 AND `GroupID`=1 AND `ID`=0;
update creature_template set flags_extra=flags_extra&~512 where entry in (29308, 31469);
update creature_template set modelid2=19725, flags_extra=flags_extra|64|128 where entry in (30106, 31458);

-- Jedoga encounter
DELETE FROM `creature_summon_groups` WHERE `summonerId`=29310 AND `summonerType`=0;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`) VALUES
-- non combat
(29310, 0, 0, 30114, 362.458, -714.166, -16.0964, 0.977384, 8, 0),
(29310, 0, 0, 30114, 368.781, -713.932, -16.0964, 1.46608, 8, 0),
(29310, 0, 0, 30114, 364.937, -716.11, -16.0964, 1.25664, 8, 0),
(29310, 0, 0, 30114, 362.02, -719.828, -16.0964, 1.20428, 8, 0),
(29310, 0, 0, 30114, 368.151, -719.763, -16.0964, 1.53589, 8, 0),
(29310, 0, 0, 30114, 392.276, -695.895, -16.0964, 3.40339, 8, 0),
(29310, 0, 0, 30114, 387.224, -698.006, -16.0964, 3.36848, 8, 0),
(29310, 0, 0, 30114, 389.626, -702.3, -16.0964, 3.07178, 8, 0),
(29310, 0, 0, 30114, 383.812, -700.41, -16.0964, 3.15905, 8, 0),
(29310, 0, 0, 30114, 385.693, -694.376, -16.0964, 3.59538, 8, 0),
(29310, 0, 0, 30114, 379.204, -716.697, -16.0964, 2.1293, 8, 0),
(29310, 0, 0, 30114, 375.4, -711.434, -16.0964, 2.09439, 8, 0),
(29310, 0, 0, 30114, 382.583, -711.713, -16.0964, 2.53073, 8, 0),
(29310, 0, 0, 30114, 379.049, -712.899, -16.0964, 2.28638, 8, 0),
(29310, 0, 0, 30114, 378.424, -708.388, -16.0964, 2.58309, 8, 0),
-- combat
(29310, 0, 1, 30114, 394.197, -701.164, -16.1797, 4.09901, 8, 0),
(29310, 0, 1, 30114, 391.003, -697.814, -16.1797, 4.11079, 8, 0),
(29310, 0, 1, 30114, 386.5, -694.973, -16.1797, 4.12649, 8, 0),
(29310, 0, 1, 30114, 381.762, -692.405, -16.1797, 4.12257, 8, 0),
(29310, 0, 1, 30114, 377.411, -691.198, -16.1797, 4.6095, 8, 0),
(29310, 0, 1, 30114, 395.122, -686.975, -16.1797, 2.72063, 8, 0),
(29310, 0, 1, 30114, 398.823, -692.51, -16.1797, 2.72063, 8, 0),
(29310, 0, 1, 30114, 399.819, -698.815, -16.1797, 2.72455, 8, 0),
(29310, 0, 1, 30114, 395.996, -705.291, -16.1309, 0.376213, 8, 0),
(29310, 0, 1, 30114, 391.505, -710.883, -16.0589, 0.376213, 8, 0),
(29310, 0, 1, 30114, 387.872, -716.186, -16.1797, 0.376213, 8, 0),
(29310, 0, 1, 30114, 383.276, -722.431, -16.1797, 0.376213, 8, 0),
(29310, 0, 1, 30114, 377.175, -730.652, -16.1797, 0.376213, 8, 0),
(29310, 0, 1, 30114, 371.625, -735.5, -16.1797, 0.376213, 8, 0),
(29310, 0, 1, 30114, 364.932, -735.808, -16.1797, 0.376213, 8, 0),
(29310, 0, 1, 30114, 358.966, -733.199, -16.1797, 0.376213, 8, 0),
(29310, 0, 1, 30114, 376.348, -725.037, -16.1797, 5.65409, 8, 0),
(29310, 0, 1, 30114, 371.435, -723.892, -16.1797, 5.65409, 8, 0),
(29310, 0, 1, 30114, 366.861, -721.702, -16.1797, 5.65409, 8, 0),
(29310, 0, 1, 30114, 362.343, -718.019, -16.1797, 5.51665, 8, 0),
(29310, 0, 1, 30114, 358.906, -714.357, -16.1797, 5.35957, 8, 0);

-- Trash npcs
-- Eye of Teldaram
DELETE FROM `creature_template_addon` WHERE `entry`=31457;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(31457, 0, 0, 0, 0, 0, 0, '56572');

-- Visuals
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry` IN (56711, 56713);
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(0, 56711, 64, '', '', 'Disable LOS for Image Channel'),
(0, 56713, 64, '', '', 'Disable LOS for Image Channel');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (56711,56713);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,56711,0,0,31,0,3,30413,132012,0,0,0,"","Group 0: Spell 'Image Channel' targets creature 'Channel Image Target'"),
(13,1,56711,0,1,31,0,3,30413,132013,0,0,0,"","Group 0: Spell 'Image Channel' targets creature 'Channel Image Target'"),
(13,1,56713,0,0,31,0,3,30413,132012,0,0,0,"","Group 0: Spell 'Image Channel' targets creature 'Channel Image Target'"),
(13,1,56713,0,1,31,0,3,30413,132013,0,0,0,"","Group 0: Spell 'Image Channel' targets creature 'Channel Image Target'");
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30111 AND `source_type` = 0 AND `id` IN (4,5);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30179 AND `source_type` = 0 AND `id` IN (4,5);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30319 AND `source_type` = 0 AND `id` IN (5,6);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(30111,0,4,0,1,0,100,1,1000,1000,0,0,0,11,56711,32,0,0,0,0,19,30413,5,0,0,0,0,0,0,"Twilight Worshipper - Out of Combat - Cast 'Image Channel' (No Repeat)"),
(30111,0,5,0,1,0,100,1,1000,1000,0,0,0,11,56713,32,0,0,0,0,19,30413,5,0,0,0,0,0,0,"Twilight Worshipper - Out of Combat - Cast 'Image Channel' (No Repeat)"),
(30179,0,4,0,1,0,100,1,1000,1000,0,0,0,11,56711,32,0,0,0,0,19,30413,5,0,0,0,0,0,0,"Twilight Apostle - Out of Combat - Cast 'Image Channel' (No Repeat)"),
(30179,0,5,0,1,0,100,1,1000,1000,0,0,0,11,56713,32,0,0,0,0,19,30413,5,0,0,0,0,0,0,"Twilight Apostle - Out of Combat - Cast 'Image Channel' (No Repeat)"),
(30319,0,5,0,1,0,100,1,1000,1000,0,0,0,11,56711,32,0,0,0,0,19,30413,5,0,0,0,0,0,0,"Twilight Darkcaster - Out of Combat - Cast 'Image Channel' (No Repeat)"),
(30319,0,6,0,1,0,100,1,1000,1000,0,0,0,11,56713,32,0,0,0,0,19,30413,5,0,0,0,0,0,0,"Twilight Darkcaster - Out of Combat - Cast 'Image Channel' (No Repeat)");
