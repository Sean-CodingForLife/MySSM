CREATE DATABASE IF NOT EXISTS myssm_admin DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE myssm_admin;

CREATE TABLE IF NOT EXISTS sys_user (
  id INT AUTO_INCREMENT PRIMARY KEY,
  account VARCHAR(64) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(64) NOT NULL,
  role VARCHAR(32) NOT NULL,
  status VARCHAR(32),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO sys_user (account, password, name, role, status)
SELECT 'admin', '$2a$12$SFRaAdyZd5WUifZaTJ8jNuMNC5yxvswmGJjc21.n9qpTSxydqr5ka', 'admin', 'ADMIN', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_user WHERE account = 'admin');
