INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620443413425226200');

DROP TABLE IF EXISTS `spellvisual_dbc`; 
CREATE TABLE `spellvisual_dbc`
(
  `ID` INT NOT NULL DEFAULT 0,
  `PrecastKit` INT NOT NULL DEFAULT 0,
  `CastKit` INT NOT NULL DEFAULT 0,
  `ImpactKit` INT NOT NULL DEFAULT 0,
  `StateKit` INT NOT NULL DEFAULT 0,
  `StateDoneKit` INT NOT NULL DEFAULT 0,
  `ChannelKit` INT NOT NULL DEFAULT 0,
  `HasMissile` INT NOT NULL DEFAULT 0,
  `MissileModel` INT NOT NULL DEFAULT 0,
  `MissilePathType` INT NOT NULL DEFAULT 0,
  `MissileDestinationAttachment` INT NOT NULL DEFAULT 0,
  `MissileSound` INT NOT NULL DEFAULT 0,
  `AnimEventSoundID` INT NOT NULL DEFAULT 0,
  `Flags` INT NOT NULL DEFAULT 0,
  `CasterImpactKit` INT NOT NULL DEFAULT 0,
  `TargetImpactKit` INT NOT NULL DEFAULT 0,
  `MissileAttachment` INT NOT NULL DEFAULT 0,
  `MissileFollowGroundHeight` INT NOT NULL DEFAULT 0,
  `MissileFollowGroundDropSpeed` INT NOT NULL DEFAULT 0,
  `MissileFollowGroundApproach` INT NOT NULL DEFAULT 0,
  `MissileFollowGroundFlags` INT NOT NULL DEFAULT 0,
  `MissileMotion` INT NOT NULL DEFAULT 0,
  `MissileTargetingKit` INT NOT NULL DEFAULT 0,
  `InstantAreaKit` INT NOT NULL DEFAULT 0,
  `ImpactAreaKit` INT NOT NULL DEFAULT 0,
  `PersistentAreaKit` INT NOT NULL DEFAULT 0,
  `MissileCastOffsetX` FLOAT NOT NULL DEFAULT 0,
  `MissileCastOffsetY` FLOAT NOT NULL DEFAULT 0,
  `MissileCastOffsetZ` FLOAT NOT NULL DEFAULT 0,
  `MissileImpactOffsetX` FLOAT NOT NULL DEFAULT 0,
  `MissileImpactOffsetY` FLOAT NOT NULL DEFAULT 0,
  `MissileImpactOffsetZ` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=UTF8MB4; 
