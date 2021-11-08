INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636407148113092900');

UPDATE `smart_scripts` SET `action_param2`=7, `action_param3`=0 WHERE `entryorguid`=17558400 AND `id`=17;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17558400 AND `id`=18;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (10601) AND `id`>2;
INSERT INTO `smart_scripts` VALUES
(10601,0,3,0,54,0,100,0,0,0,0,0,0,11,12980,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Urok Enforcer - on just summoned - cast Simple Teleport'),
(10601,0,4,0,25,0,100,0,0,0,0,0,0,69,1,0,0,2,0,0,20,175621,30,0,0,0,0,0,0,'Urok Enforcer - on reset - move to Urok Pike'),
(10601,0,5,0,34,0,100,0,8,1,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Urok Enforcer - on pos 1 - set event phase to 2'),
(10601,0,6,7,1,2,100,0,1500,1500,2500,3500,0,5,37,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Urok Enforcer - OOC (phase 2) - play emote 37'),
(10601,0,7,0,61,2,100,0,0,0,0,0,0,63,1,1,0,0,0,0,20,175621,10,0,0,0,0,0,0,'Urok Enforcer - OOC (phase 2) - set counter 1 Urok Pike'),
(10601,0,8,0,4,0,100,0,0,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Urok Enforcer - on aggro - set phase to 0');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (10602) AND `id`>4;
INSERT INTO `smart_scripts` VALUES
(10602,0,5,0,54,0,100,0,0,0,0,0,0,11,12980,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Urok Ogre Magus - on just summoned - cast Simple Teleport'),
(10602,0,6,0,25,0,100,0,0,0,0,0,0,69,1,0,0,2,0,0,20,175621,30,0,0,0,0,0,0,'Urok Ogre Magus - on reset - move to Urok Pike'),
(10602,0,7,0,34,0,100,0,8,1,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Urok Ogre Magus - on pos 1 - set event phase to 2'),
(10602,0,8,9,1,2,100,0,1500,1500,2500,3500,0,5,37,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Urok Ogre Magus - OOC (phase 2) - play emote 37'),
(10602,0,9,0,61,2,100,0,0,0,0,0,0,63,1,1,0,0,0,0,20,175621,10,0,0,0,0,0,0,'Urok Ogre Magus - OOC (phase 2) - set counter 1 Urok Pike'),
(10602,0,10,0,4,0,100,0,0,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Urok Ogre Magus - on aggro - set phase to 0');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (175621) AND `id`>1;
INSERT INTO `smart_scripts` VALUES
(175621,1,2,3,77,0,100,0,1,20,5000,5000,0,34,4,2,0,0,0,0,1,0,0,0,0,0,0,0,0, 'Ur\'s Tribute Pile - on 20 count - fail event'),
(175621,1,3,0,61,0,100,0,0,0,0,0,0,41,0,180,0,0,0,0,1,0,0,0,0,0,0,0,0, 'Ur\'s Tribute Pile - on 20 count - despawn');
