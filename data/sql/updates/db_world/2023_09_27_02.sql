-- DB update 2023_09_27_01 -> 2023_09_27_02
--
ALTER TABLE `quest_template` MODIFY COLUMN `AllowableRaces` INT UNSIGNED NOT NULL DEFAULT 0;
