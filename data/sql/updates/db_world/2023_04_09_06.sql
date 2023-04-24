-- DB update 2023_04_09_05 -> 2023_04_09_06
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=18794 AND `source_type`=0 AND `id`=16;

DELETE FROM `script_waypoint` WHERE `entry`=18731;
DELETE FROM `waypoint_data` WHERE `id` IN (1873100,1873101);
INSERT INTO `waypoint_data` VALUES
(1873100,1,-159.51387,-2.139098,8.073091,NULL,0,0,0,100,0),
(1873100,2,-163.44856,-7.553354,8.073133,NULL,0,0,0,100,0),
(1873100,3,-168.17548,-9.746803,8.073169,NULL,0,0,0,100,0),
(1873100,4,-171.3253,-13.198364,8.073106,NULL,0,0,0,100,0),
(1873100,5,-172.78348,-25.986193,8.073088,NULL,0,0,0,100,0),
(1873100,6,-173.66841,-54.100628,8.073081,NULL,0,0,0,100,0),
(1873100,7,-168.93939,-66.52654,8.073219,NULL,0,0,0,100,0),
(1873100,8,-157.49812,-73.04389,8.077904,NULL,0,0,0,100,0),
(1873100,9,-145.8215,-67.855865,8.063689,NULL,0,0,0,100,0),
(1873100,10,-141.28224,-56.002922,8.073066,NULL,0,0,0,100,0),
(1873100,11,-142.33768,-25.135996,8.073035,NULL,0,0,0,100,0),
(1873100,12,-143.23366,-14.373271,8.073031,NULL,0,0,0,100,0),
(1873100,13,-147.05266,-10.097949,8.0730295,NULL,0,0,0,100,0),
(1873100,14,-152.87035,-5.490992,8.073108,NULL,0,0,0,100,0),
(1873100,15,-156.7587,4.856207,8.073061,4.660028934478759765,0,0,0,100,0),

(1873101,16,-156.31073,24.4289,8.072962,NULL,0,0,0,100,0),
(1873101,17,-153.34592,40.90819,6.877141,NULL,0,0,0,100,0),
(1873101,18,-144.48116,52.74748,5.6318674,NULL,0,0,0,100,0),
(1873101,19,-130.80013,60.605686,4.2999473,NULL,0,0,0,100,0),
(1873101,20,-91.258835,61.131367,3.2408845,NULL,0,0,0,100,0),
(1873101,22,-73.11457,51.921284,1.4783795,2.705260276794433593,30000,0,0,100,0),
(1873101,23,-89.108116,61.20221,3.026778,NULL,0,0,0,100,0),
(1873101,24,-108.00966,63.536663,3.4476438,NULL,0,0,0,100,0),
(1873101,25,-130.86102,60.57378,4.3055944,NULL,0,0,0,100,0),
(1873101,26,-143.99977,52.971825,5.5921054,NULL,0,0,0,100,0),
(1873101,27,-152.94989,41.38679,6.888551,NULL,0,0,0,100,0),
(1873101,28,-156.86404,25.838596,8.125509,NULL,30000,0,0,100,0),
(1873101,29,-156.68945,2.408526,8.073063,NULL,20000,0,0,100,0);

UPDATE `creature_text` SET `Emote`=15 WHERE `CreatureID`=18731 AND `GroupID`=0;

UPDATE `creature_template` SET `unit_flags`=32832 WHERE `entry` IN (18731,20636);
DELETE FROM `creature_template_addon` WHERE `entry`=18731;
