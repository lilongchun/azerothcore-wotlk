ALTER TABLE `reputation_spillover_template`
    ADD COLUMN `faction5` SMALLINT UNSIGNED NOT NULL DEFAULT '0',
    ADD COLUMN `rate_5` FLOAT NOT NULL DEFAULT '0',
    ADD COLUMN `rank_5` TINYINT UNSIGNED NOT NULL DEFAULT '0',
    ADD COLUMN `faction6` SMALLINT UNSIGNED NOT NULL DEFAULT '0',
    ADD COLUMN `rate_6` FLOAT NOT NULL DEFAULT '0',
    ADD COLUMN `rank_6` TINYINT UNSIGNED NOT NULL DEFAULT '0';
