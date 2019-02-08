INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1549656664508341873');

-- From: https://github.com/TrinityCore/TrinityCore/commit/96f90381e3ed696861354ea4ddf4ac0c495031c5

-- Set "execute event while charmed" flag on all events except:
-- 1) movement actions
-- 2) nontriggered cast actions
-- 3) talk/emote/sound actions
-- 4) ally summon actions
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=0 AND
  (`action_type` not in (1,4,5,10,11,12,17,25,27,38,39,40,49,62,69,84,85,86,89,92,97,103,107,114) OR
   (`action_type` in (11,86) AND (`action_param2`&2)=2));


-- QUEST FIXES:

-- Seeds of Chaos (13172)
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=0 AND `entryorguid`=31157;
UPDATE `smart_scripts` SET `event_type`=29, `comment`='Skeletal Assault Gryphon - On Charmed - Start Waypoint'
  WHERE `source_type`=0 AND `entryorguid`=31157 AND `id`=0;

-- Generosity Abounds (13146)
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=0 AND `entryorguid`=30894;

-- Battling the Elements (12967)
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=0 AND `entryorguid`=30124;

-- Krolmir, Hammer of Storms (13010)
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=0 AND `entryorguid`=30331;
UPDATE `smart_scripts` SET `event_type`=29 WHERE `source_type`=0 AND `entryorguid`=30331 AND `id`=0;
UPDATE `smart_scripts` SET `target_type`=23 WHERE `source_type`=0 AND `entryorguid`=30331 AND `id`=1;
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=9 AND `entryorguid`=3033100;

-- Spy Hunter (12994)
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=0 AND `entryorguid`=30219;
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `source_type`=9 AND `entryorguid` IN (3021900,3021901,3021902);


-- From: 0f7efc86d066ed614fa7b192da81c48d586f8b85
-- Fix Jewelcrafting stone statues for charm SAI changes
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18372,18738) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`event_type`,`event_chance`,`action_type`,`action_param1`,`target_type`,`comment`) VALUES
(18372,0,1,100,11,32253,23,'Rough Stone Statue - OOC - Cast "Stone Healing"'),
(18738,0,1,100,11,32792,23,'Primal Stone Statue - OOC - Cast "Stone Healing"');
UPDATE `creature_template` SET `AIName`='SmartAI',`ScriptName`='' WHERE `entry` IN (18372,18738);
UPDATE `smart_scripts` SET `event_flags`=(`event_flags`|0x200) WHERE `entryorguid` IN (18372,18734,18735,18736,18737,18738) AND `source_type`=0;

-- Always for SMART_EVENT_JUST_SUMMONED (Creature can be summoned already charmed by player ie TempSummons)
UPDATE `smart_scripts` SET `event_flags`=`event_flags`|0x200 WHERE `source_type` = 0 AND `event_type`=54;


-- From: https://github.com/TrinityCore/TrinityCore/commit/3e596376a7fae9fd585fac12e5122fd8f1b7ce14

-- Event linked actions (Many levels of linked calls, do 8 times)
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;
UPDATE `smart_scripts` `ss` LEFT JOIN `smart_scripts` `ssl` ON `ss`.`entryorguid` = `ssl`.`entryorguid` AND `ss`.`source_type` = `ssl`.`source_type` AND `ss`.`id` = `ssl`.`link` SET `ss`.`event_flags`=`ss`.`event_flags`|0x200 WHERE `ss`.`source_type`=0 AND
    `ss`.`event_type` = 61 AND (`ssl`.`event_flags` & 0x200) != 0;

-- Vehicles
UPDATE `smart_scripts` SET `event_flags`=`event_flags`|0x200 WHERE `source_type` = 0 AND `entryorguid` IN (SELECT `entry` FROM `creature_template` WHERE `AIName` = "SmartAI" AND `VehicleId` != 0);
