--
DELETE FROM `acore_string` WHERE `entry` IN (283,298,300,301,11003);
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(283, "%s has disabled %s's chat for %s, effective at the player's next login. Reason: %s.", NULL, NULL, "Ihr habt dem Spieler %s das chatten für %s gesperrt, beginnend mit dem nächsten Login des Spielers. Grund: %s.", "你已经被 %s 禁言 %s，将在下一次登陆时生效。原因: %s。", NULL, "%s ha deshabilitado el chat de %s por %s, efectivo en el próximo ingreso del jugador. Razón: %s.", "%s ha deshabilitado el chat de %s por %s, efectivo en el próximo ingreso del jugador. Razón: %s.", NULL),
(298, "Spawn time changed to: %s", NULL, NULL, "Spawnzeit wurde auf: %s abgeändert", "复生时间改变为: %s", NULL, "Tiempo de desove cambiado a: %s", "Tiempo de desove cambiado a: %s", NULL),
(300, "Your chat has been disabled for %s. By: %s, Reason: %s.", NULL, NULL, "Euer Chat wurde für %s abgeschaltet. Von: %s, Grund: %s", "你将被禁言 %s.", NULL, "Tu chat ha sido desactivado durante %u. Por: %s ,Razón: %s.", "Tu chat ha sido desactivado durante %u. Por: %s ,Razón: %s.", NULL),
(301, "%s has disabled %s's chat for %s. Reason: %s.", NULL, NULL, "Ihr hab den Chat von %s für %s abgeschaltet. Von: %s, Grund: %s", NULL, NULL, "%s ha desactivado el chat de %s durante %s. Razón: %s.", "%s ha desactivado el chat de %s durante %s. Razón: %s.", NULL),
(11003, "Server: %s has muted %s for %s, reason: %s", NULL, NULL, NULL, "系统公告: %s has muted %s for %s, 原因: %s", NULL, NULL, NULL, "Server: %s замутил %s на %s, причина: %s");

DELETE FROM `command` WHERE `name` IN ("mute","npc set spawntime");
INSERT INTO `command` (`name`, `security`, `help`) VALUES
("mute", 2, "Syntax: .mute [$playerName] $mutetime [$reason]\r\nDisible chat messaging for any character from account of character $playerName (or currently selected) at $mutetime time. Player can be offline.\n$mutetime: use a timestring like \"1d15h33s\"."),
("npc set spawntime", 3, "Syntax: .npc set spawntime $time\r\nAdjust spawntime of selected creature to time.\n$time: use a timestring like \"10m30s\".");