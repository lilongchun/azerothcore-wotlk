-- DB update 2021_12_17_13 -> 2021_12_17_14
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_17_13';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_17_13 2021_12_17_14 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639513345844433900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639513345844433900');

UPDATE `creature_template` SET `type_flags`=`type_flags`|0x08000000 WHERE `entry` IN (233,277,384,483,491,514,812,836,925,927,1103,1218,1243,1257,1261,1275,1285,
1286,1287,1289,1292,1294,1295,1297,1298,1299,1301,1302,1303,1304,1305,1307,1308,1309,1310,1311,1312,1313,1314,1315,1317,1318,1319,1320,1321,1323,1324,1325,1326,
1333,1339,1341,1346,1347,1348,1349,1350,1351,1430,1458,1460,1470,1632,1651,1676,1680,1681,1683,1699,1701,2326,2327,2329,2357,2367,2485,2489,2492,2627,2670,2798,
2834,2837,2998,3001,3013,3048,3060,3067,3069,3087,3136,3137,3174,3179,3181,3314,3332,3345,3347,3355,3357,3362,3363,3365,3373,3399,3404,3413,3478,3483,3484,3489,
3494,3518,3523,3605,3607,3685,3690,3703,3704,4156,4159,4160,4165,4200,4210,4211,4213,4241,4254,4256,4552,4573,4576,4588,4591,4596,4598,4611,4614,4616,4730,4731,
4732,4752,4753,4772,4773,4885,4900,4981,5127,5137,5150,5153,5161,5174,5177,5392,5483,5493,5494,5499,5503,5505,5509,5510,5511,5512,5513,5514,5518,5519,5564,5565,
5566,5594,5695,5759,5939,5943,5957,5958,6094,6286,6568,7230,7683,7879,7948,7952,7953,7954,7955,8125,8146,8359,8403,8736,9099,9584,10118,10618,11025,11031,11052,
11097,11146,12245,12246,12384,13418,14437,14450,14624,14637,14739,14844,14845,14846,14860,15011,15012,15175,15179,15350,15351,15501,16015,16187,16191,16224,16263,
16264,16268,16272,16277,16280,16376,16388,16442,16444,16528,16633,16640,16642,16644,16654,16662,16663,16667,16669,16676,16688,16692,16719,16725,16726,16729,16731,
16752,16755,16763,16774,16780,16860,17005,17214,17215,17277,17441,17442,17446,17487,17488,17490,17518,17584,17585,17655,17656,17844,18005,18006,18009,18010,18011,
18015,18017,18267,18484,18542,18748,18755,18776,18777,18779,18822,18897,18947,18997,18998,19011,19012,19014,19017,19021,19045,19046,19047,19227,19315,19340,19352,
19370,19478,19571,19617,19664,19678,19679,19775,19778,20080,20081,20082,20092,20112,20194,20463,20510,20511,20791,20914,21088,21172,21494,22099,22208,22212,22213,
22264,22266,22270,22271,22479,23110,23112,23208,23363,23373,23396,23428,23482,23483,23484,23489,23510,23511,23533,23699,23732,23734,23737,24501,24975,25032,25034,
25046,25206,25314,25736,25950,26110,26564,26898,26905,26914,26915,26953,26960,26964,26969,26972,26982,26985,26989,26997,27001,27037,27267,27291,27478,27489,27703,
27705,27806,27810,27811,27812,27813,27814,27815,27816,27817,27818,27819,27820,28046,28589,28705,28746,28760,29156,29244,29478,29631,29688,29744,30345,30825,31051,
31084,31101,31247,32329,32540,33307,33310,33553,33554,33555,33556,33557,33650,33653,33657,33970,33971,34885,37688,37696,37991,37992,37993,37997,37998,37999,38054,
38181,38182,38283,38284,38840,38841);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_17_14' WHERE sql_rev = '1639513345844433900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
