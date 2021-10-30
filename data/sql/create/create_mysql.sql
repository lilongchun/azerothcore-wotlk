DROP USER IF EXISTS 'root'@'localhost';
CREATE USER 'root'@'localhost' IDENTIFIED BY 'root' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0;

GRANT ALL PRIVILEGES ON * . * TO 'root'@'localhost' WITH GRANT OPTION;

CREATE DATABASE `acore_world` DEFAULT CHARACTER SET UTF8MB4 COLLATE utf8mb4_general_ci;

CREATE DATABASE `acore_characters` DEFAULT CHARACTER SET UTF8MB4 COLLATE utf8mb4_general_ci;

CREATE DATABASE `acore_auth` DEFAULT CHARACTER SET UTF8MB4 COLLATE utf8mb4_general_ci;

GRANT ALL PRIVILEGES ON `acore_world` . * TO 'root'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `acore_characters` . * TO 'root'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON `acore_auth` . * TO 'root'@'localhost' WITH GRANT OPTION;
