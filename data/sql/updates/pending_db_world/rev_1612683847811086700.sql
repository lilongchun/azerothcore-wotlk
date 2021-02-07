INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612683847811086700');

-- Remove skinning from Critter, Totem, Non-Combat Pet
UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` IN (1512,721,883,890,1933,2098,2442,2620,4166,5951,10780,12296,12297,12298,12299,13916,17467,7380,7381,7382,7383,7384,7385,7386,7387,7389,7390,7391,7392,7394,7395,7543,7544,7545,7549,7550,7553,7555,7560,7562,7565,7566,7567,7568,7569,9662,9937,10259,10598,11236,11325,11326,11327,12419,14878);

-- Remove unused loot template
DELETE FROM `skinning_loot_template` WHERE `entry` IN (1933,12299,100000);

-- Remove lootid that does not exist
UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` IN (240,246,3388)
