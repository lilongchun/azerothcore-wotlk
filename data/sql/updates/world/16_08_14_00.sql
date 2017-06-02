ALTER TABLE world_db_version CHANGE COLUMN 2016_08_14_00 2016_08_14_02 bit;

UPDATE `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (14508, 0, 0, 0, 0, 0, 14561, 0, 0, 0, 'Short John Mithril', NULL, NULL, 5921, 47, 47, 0, 35, 3, 1.1, 1.14286, 1, 0, 79, 105, 0, 192, 1, 2000, 2000, 1, 768, 2048, 0, 0, 0, 0, 0, 0, 54, 80, 18, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 1.25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_short_john_mirthil', 12340);

DELETE FROM 'waypoints' Where entry = '14508'

Insert into 'waypoints' VALUES
(14508, 33, -13184.5, 332.671, 40.3299, 'Short John Mithril');
(14508, 32, -13184.8, 329.885, 37.955, 'Short John Mithril');
(14508, 31, -13188.3, 320.076, 33.2348, 'Short John Mithril');
(14508, 30, -13199.4, 323.398, 33.2425, 'Short John Mithril');
(14508, 29, -13216, 322.76, 33.2444, 'Short John Mithril');
(14508, 28, -13233.8, 314.316, 33.2081, 'Short John Mithril');
(14508, 27, -13248.9, 298.446, 33.2419, 'Short John Mithril');
(14508, 26, -13255.3, 282.627, 33.2429, 'Short John Mithril');
(14508, 25, -13255.2, 264.038, 33.2444, 'Short John Mithril');
(14508, 24, -13250, 248.904, 33.2329, 'Short John Mithril');
(14508, 23, -13237.5, 232.776, 33.2308, 'Short John Mithril');
(14508, 22, -13233.6, 238.16, 33.3501, 'Short John Mithril');
(14508, 21, -13239, 245.371, 29.2373, 'Short John Mithril');
(14508, 20, -13243.4, 254.911, 23.8869, 'Short John Mithril');
(14508, 19, -13244, 261.878, 21.933, 'Short John Mithril');
(14508, 18, -13240.6, 268.921, 21.933, 'Short John Mithril');
(14508, 17, -13240.6, 268.921, 21.933, 'Short John Mithril');
(14508, 16, -13219.2, 275.451, 21.9821, 'Short John Mithril');
(14508, 15, -13204.1, 277.168, 21.9821, 'Short John Mithril');
(14508, 14, -13241.2, 261.35, 21.933, 'Short John Mithril');
(14508, 13, -13244.5, 256.393, 22.6305, 'Short John Mithril');
(14508, 12, -13239.7, 247.561, 29.2974, 'Short John Mithril');
(14508, 11, -13234.5, 239.465, 33.3607, 'Short John Mithril');
(14508, 10, -13235.3, 231.821, 33.2323, 'Short John Mithril');
(14508, 9, -13233.3, 231.889, 33.2352, 'Short John Mithril');
(14508, 8, -13237.6, 231.746, 33.2374, 'Short John Mithril');
(14508, 7, -13247.6, 243.589, 33.2082, 'Short John Mithril');
(14508, 6, -13255.6, 264.58, 33.245, 'Short John Mithril');
(14508, 5, -13254.9, 284.07, 33.2425, 'Short John Mithril');
(14508, 4, -13248.8, 299.046, 33.2264, 'Short John Mithril');
(14508, 3, -13234.3, 314.129, 33.2076, 'Short John Mithril');
(14508, 2, -13215.1, 322.781, 33.2446, 'Short John Mithril');
(14508, 1, -13187.1, 319.775, 33.2346, 'Short John Mithril');

DELETE FROM 'smart_scripts' where entryorguild = '14508'

INSERT INTO 'smart_scripts VALUES

(14508, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 50, 179697, 10740, 0, 0, 0, 0, 8, 0, 0, 0, -13202.9, 276.757, 21.8571, 2.77507, 'Short John Mithril - On Reached WP19 - Spawn Chest');
(14508, 0, 2, 3, 40, 0, 100, 0, 16, 14508, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Short John Mithril - On Reached WP16 - Say');
(14508, 0, 1, 0, 40, 0, 100, 0, 1, 14508, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Short John Mithril - On Reached WP1 - Say');
(14508, 0, 0, 0, 68, 0, 100, 0, 16, 0, 0, 0, 53, 0, 14508, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Short John Mithril - On Event Start - Start WP');
(14508, 0, 4, 0, 40, 0, 100, 0, 33, 14508, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 4.41568, 'Short John Mithril - On Reached WP33 - Set orientation');
