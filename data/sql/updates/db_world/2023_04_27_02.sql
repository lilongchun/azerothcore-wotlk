-- DB update 2023_04_27_01 -> 2023_04_27_02
DROP TABLE IF EXISTS `chrraces_dbc`; 
CREATE TABLE `chrraces_dbc` ( `ID` INT NOT NULL DEFAULT '0', `Flags` INT NOT NULL DEFAULT '0', `FactionID` INT NOT NULL DEFAULT '0', `ExplorationSoundID` INT NOT NULL DEFAULT '0', `MaleDisplayId` INT NOT NULL DEFAULT '0', `FemaleDisplayId` INT NOT NULL DEFAULT '0', `ClientPrefix` TEXT NULL, `BaseLanguage` INT NOT NULL DEFAULT '0', `CreatureType` INT NOT NULL DEFAULT '0', `ResSicknessSpellID` INT NOT NULL DEFAULT '0', `SplashSoundID` INT NOT NULL DEFAULT '0', `ClientFilestring` TEXT NULL, `CinematicSequenceID` INT NOT NULL DEFAULT '0', `Alliance` INT NOT NULL DEFAULT '0', `Name_Lang_enUS` TEXT NULL, `Name_Lang_enGB` TEXT NULL, `Name_Lang_koKR` TEXT NULL, `Name_Lang_frFR` TEXT NULL, `Name_Lang_deDE` TEXT NULL, `Name_Lang_enCN` TEXT NULL, `Name_Lang_zhCN` TEXT NULL, `Name_Lang_enTW` TEXT NULL, `Name_Lang_zhTW` TEXT NULL, `Name_Lang_esES` TEXT NULL, `Name_Lang_esMX` TEXT NULL, `Name_Lang_ruRU` TEXT NULL, `Name_Lang_ptPT` TEXT NULL, `Name_Lang_ptBR` TEXT NULL, `Name_Lang_itIT` TEXT NULL, `Name_Lang_Unk` TEXT NULL, `Name_Lang_Mask` INT UNSIGNED NOT NULL DEFAULT '0', `Name_Female_Lang_enUS` TEXT NULL, `Name_Female_Lang_enGB` TEXT NULL, `Name_Female_Lang_koKR` TEXT NULL, `Name_Female_Lang_frFR` TEXT NULL, `Name_Female_Lang_deDE` TEXT NULL, `Name_Female_Lang_enCN` TEXT NULL, `Name_Female_Lang_zhCN` TEXT NULL, `Name_Female_Lang_enTW` TEXT NULL, `Name_Female_Lang_zhTW` TEXT NULL, `Name_Female_Lang_esES` TEXT NULL, `Name_Female_Lang_esMX` TEXT NULL, `Name_Female_Lang_ruRU` TEXT NULL, `Name_Female_Lang_ptPT` TEXT NULL, `Name_Female_Lang_ptBR` TEXT NULL, `Name_Female_Lang_itIT` TEXT NULL, `Name_Female_Lang_Unk` TEXT NULL, `Name_Female_Lang_Mask` INT UNSIGNED NOT NULL DEFAULT '0', `Name_Male_Lang_enUS` TEXT NULL, `Name_Male_Lang_enGB` TEXT NULL, `Name_Male_Lang_koKR` TEXT NULL, `Name_Male_Lang_frFR` TEXT NULL, `Name_Male_Lang_deDE` TEXT NULL, `Name_Male_Lang_enCN` TEXT NULL, `Name_Male_Lang_zhCN` TEXT NULL, `Name_Male_Lang_enTW` TEXT NULL, `Name_Male_Lang_zhTW` TEXT NULL, `Name_Male_Lang_esES` TEXT NULL, `Name_Male_Lang_esMX` TEXT NULL, `Name_Male_Lang_ruRU` TEXT NULL, `Name_Male_Lang_ptPT` TEXT NULL, `Name_Male_Lang_ptBR` TEXT NULL, `Name_Male_Lang_itIT` TEXT NULL, `Name_Male_Lang_Unk` TEXT NULL, `Name_Male_Lang_Mask` INT UNSIGNED NOT NULL DEFAULT '0', `FacialHairCustomization_1` TEXT NULL, `FacialHairCustomization_2` TEXT NULL, `HairCustomization` TEXT NULL, `Required_Expansion` INT NOT NULL DEFAULT '0', PRIMARY KEY (`ID`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; 
