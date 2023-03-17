-- Update engine, row format, charset and collation
ALTER TABLE `account` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `account_access` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `account_banned` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `account_muted` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `autobroadcast` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `build_info` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `ip_banned` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `logs` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `logs_ip_actions` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `motd` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `realmcharacters` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `realmlist` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `secret_digest` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `updates` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `updates_include` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
ALTER TABLE `uptime` ENGINE InnoDB ROW_FORMAT=DEFAULT, CONVERT TO CHARSET utf8mb4 COLLATE 'utf8mb4_unicode_ci';
