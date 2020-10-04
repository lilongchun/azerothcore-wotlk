INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827483251961900');
/*
 * Raid: Vault of Archavon
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */
UPDATE `creature_template` SET `mindmg` = 3162, `maxdmg` = 4399, `DamageModifier` = 1.03 WHERE `entry` = 32353;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7624, `DamageModifier` = 1.03 WHERE `entry` = 32368;
UPDATE `creature_template` SET `mindmg` = 2902, `maxdmg` = 4170, `DamageModifier` = 1.03 WHERE `entry` = 35143;
UPDATE `creature_template` SET `mindmg` = 5951, `maxdmg` = 8217, `DamageModifier` = 1.03 WHERE `entry` = 35359;
UPDATE `creature_template` SET `mindmg` = 3337, `maxdmg` = 4676, `DamageModifier` = 1.03 WHERE `entry` = 34015;
UPDATE `creature_template` SET `mindmg` = 5853, `maxdmg` = 8179, `DamageModifier` = 1.03 WHERE `entry` = 34016;
UPDATE `creature_template` SET `mindmg` = 3438, `maxdmg` = 4724, `DamageModifier` = 1.03 WHERE `entry` = 33998;
UPDATE `creature_template` SET `mindmg` = 5327, `maxdmg` = 7426, `DamageModifier` = 1.03 WHERE `entry` = 34200;
UPDATE `creature_template` SET `mindmg` = 3433, `maxdmg` = 4738, `DamageModifier` = 1.03 WHERE `entry` = 38482;
UPDATE `creature_template` SET `mindmg` = 5962, `maxdmg` = 8186, `DamageModifier` = 1.03 WHERE `entry` = 38483;

/* BOSS */ 
UPDATE `creature_template` SET `mindmg` = 16420, `maxdmg` = 22618, `DamageModifier` = 1.01 WHERE `entry` = 35013;
UPDATE `creature_template` SET `mindmg` = 32840, `maxdmg` = 45236, `DamageModifier` = 1.01 WHERE `entry` = 35306;
UPDATE `creature_template` SET `mindmg` = 16636, `maxdmg` = 22546, `DamageModifier` = 1.01 WHERE `entry` = 33993;
UPDATE `creature_template` SET `mindmg` = 32671, `maxdmg` = 45192, `DamageModifier` = 1.01 WHERE `entry` = 33994;
UPDATE `creature_template` SET `mindmg` = 16352, `maxdmg` = 22576, `DamageModifier` = 1.01 WHERE `entry` = 31125;
UPDATE `creature_template` SET `mindmg` = 32768, `maxdmg` = 45194, `DamageModifier` = 1.01 WHERE `entry` = 31722;
UPDATE `creature_template` SET `mindmg` = 16434, `maxdmg` = 22627, `DamageModifier` = 1.01 WHERE `entry` = 38433;
UPDATE `creature_template` SET `mindmg` = 32832, `maxdmg` = 45238, `DamageModifier` = 1.01 WHERE `entry` = 38462;
