-- fix Woodlands Walker gossip
UPDATE `creature_template` SET `npcflag`=`npcflag` + 1 WHERE `entry` = 26421
