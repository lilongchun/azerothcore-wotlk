INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639429763496903700');

DELETE FROM `gossip_menu` WHERE `menuid` IN (5844,5843,5842,5841);
INSERT INTO `gossip_menu` VALUES
(5844,7002),
(5843,7003),
(5842,7004),
(5841,7005);
