INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1579213352894781043');

-- ADD NEW COLUMN
ALTER TABLE `account_access` ADD COLUMN `comment` VARCHAR(255) DEFAULT '';

-- UPDATE ACCOUNTS
LOCK TABLES `account_access` WRITE;
/*!40000 ALTER TABLE `account_access` DISABLE KEYS */;

-- UPDATE ACCOUNTS test1 test2
UPDATE `account`
INNER JOIN `account_access`
ON `account`.`id` = `account_access`.`id`
WHERE (`account`.`username` = 'test1' AND `account`.`sha_pass_hash` = '047ce22643f9b0bd6baeb18d51bf1075a4d43fc6') OR
(`account`.`username` = 'test2' AND `account`.`sha_pass_hash` = '10eb1ff16cf5380147e8281cd8080a210ecb3c53')
SET `account_access`.`comment` = 'Test account - Console Admin';

-- UPDATE ACCOUNTS test3 test4
UPDATE `account`
INNER JOIN `account_access`
ON `account`.`id` = `account_access`.`id`
WHERE (`account`.`username` = 'test3' AND `account`.`sha_pass_hash` = 'e546bbf9ca93ae5291f0b441bb9ea2fa0c466176') OR
(`account`.`username` = 'test4' AND `account`.`sha_pass_hash` = '61015d83b456a9c6a7defdff07f55265f24097af')
SET `account_access`.`comment` = 3, `account_access`.`comment` = 'Test account - Ingame Admin';

-- UPDATE ACCOUNTS test5 test6
UPDATE `account`
INNER JOIN `account_access`
ON `account`.`id` = `account_access`.`id`
WHERE (`account`.`username` = 'test5' AND `account`.`sha_pass_hash` = 'dddeac4ffe5f286ec57b7a1ed63bf3a859debe1e') OR
(`account`.`username` = 'test6' AND `account`.`sha_pass_hash` = 'f1f94cdffd83c8c4182d66689077f92c807ab579')
SET `account_access`.`comment` = 2, `account_access`.`comment` = 'Test account - Major Game Master';

-- UPDATE ACCOUNTS test7 test8
UPDATE `account`
INNER JOIN `account_access`
ON `account`.`id` = `account_access`.`id`
WHERE (`account`.`username` = 'test7' AND `account`.`sha_pass_hash` = '6fcd35c35b127be1d9ca040b2b478eb366506ce2') OR
(`account`.`username` = 'test8' AND `account`.`sha_pass_hash` = '484332ccb02e284e4e0a04573c3fa417f4745fdf')
SET `account_access`.`comment` = 1, `account_access`.`comment` = 'Test account - Minor Game Master';

-- UPDATE ACCOUNTS test9 test10
UPDATE `account`
INNER JOIN `account_access`
ON `account`.`id` = `account_access`.`id`
WHERE (`account`.`username` = 'test9' AND `account`.`sha_pass_hash` = '4fce15ed251721f02754d5381ae9d0137b6a6a30') OR
(`account`.`username` = 'test10' AND `account`.`sha_pass_hash` = 'b22d249228e84ab493b39a2bd765bee9b7c0b350')
SET `account_access`.`comment` = 0, `account_access`.`comment` = 'Test account - Player';

/*!40000 ALTER TABLE `account_access` ENABLE KEYS */;
UNLOCK TABLES;
