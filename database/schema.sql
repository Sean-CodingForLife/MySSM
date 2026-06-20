CREATE DATABASE IF NOT EXISTS myssm_admin DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE myssm_admin;

CREATE TABLE IF NOT EXISTS sys_user (
  id INT AUTO_INCREMENT PRIMARY KEY,
  account VARCHAR(64) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(64) NOT NULL,
  status VARCHAR(32) NOT NULL DEFAULT 'ACTIVE',
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS sys_role (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(64) NOT NULL UNIQUE,
  name VARCHAR(64) NOT NULL,
  status VARCHAR(32) NOT NULL DEFAULT 'ACTIVE',
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS sys_permission (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(128) NOT NULL UNIQUE,
  name VARCHAR(128) NOT NULL,
  method VARCHAR(16) NOT NULL,
  path VARCHAR(255) NOT NULL,
  status VARCHAR(32) NOT NULL DEFAULT 'ACTIVE',
  UNIQUE KEY uk_permission_request (method, path)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS sys_menu (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(64) NOT NULL UNIQUE,
  name VARCHAR(64) NOT NULL,
  path VARCHAR(255) NOT NULL,
  permission_code VARCHAR(128) NOT NULL,
  sort INT NOT NULL DEFAULT 0,
  status VARCHAR(32) NOT NULL DEFAULT 'ACTIVE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS sys_user_role (
  user_id INT NOT NULL,
  role_id INT NOT NULL,
  PRIMARY KEY (user_id, role_id),
  CONSTRAINT fk_user_role_user FOREIGN KEY (user_id) REFERENCES sys_user(id) ON DELETE CASCADE,
  CONSTRAINT fk_user_role_role FOREIGN KEY (role_id) REFERENCES sys_role(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS sys_role_permission (
  role_id INT NOT NULL,
  permission_id INT NOT NULL,
  PRIMARY KEY (role_id, permission_id),
  CONSTRAINT fk_role_permission_role FOREIGN KEY (role_id) REFERENCES sys_role(id) ON DELETE CASCADE,
  CONSTRAINT fk_role_permission_permission FOREIGN KEY (permission_id) REFERENCES sys_permission(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS sys_login_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  account VARCHAR(64),
  status VARCHAR(32) NOT NULL,
  ip VARCHAR(64),
  message VARCHAR(255),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS sys_operation_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  account VARCHAR(64),
  method VARCHAR(16) NOT NULL,
  path VARCHAR(255) NOT NULL,
  status VARCHAR(32) NOT NULL,
  message VARCHAR(255),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS sys_config (
  id INT AUTO_INCREMENT PRIMARY KEY,
  config_key VARCHAR(128) NOT NULL UNIQUE,
  config_value VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  status VARCHAR(32) NOT NULL DEFAULT 'ACTIVE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO sys_role (code, name, status)
SELECT 'ADMIN', 'Administrator', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_role WHERE code = 'ADMIN');

INSERT INTO sys_role (code, name, status)
SELECT 'USER', 'User', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_role WHERE code = 'USER');

INSERT INTO sys_user (account, password, name, status)
SELECT 'admin', '$2a$12$SFRaAdyZd5WUifZaTJ8jNuMNC5yxvswmGJjc21.n9qpTSxydqr5ka', 'admin', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_user WHERE account = 'admin');

INSERT IGNORE INTO sys_user_role (user_id, role_id)
SELECT u.id, r.id FROM sys_user u, sys_role r WHERE u.account = 'admin' AND r.code = 'ADMIN';

INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.users.page', 'User management page', 'GET', '/admin/users', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.users.page');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.users.query', 'Query users', 'GET', '/api/admin/users', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.users.query');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.users.create', 'Create users', 'POST', '/api/admin/users', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.users.create');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.users.delete', 'Delete users', 'DELETE', '/api/admin/users', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.users.delete');

INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.roles.page', 'Role management page', 'GET', '/admin/roles', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.roles.page');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.roles.query', 'Query roles', 'GET', '/api/admin/roles', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.roles.query');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.roles.create', 'Create roles', 'POST', '/api/admin/roles', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.roles.create');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.roles.delete', 'Delete roles', 'DELETE', '/api/admin/roles', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.roles.delete');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.roles.permissions.query', 'Query role permissions', 'GET', '/api/admin/roles/permissions', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.roles.permissions.query');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.roles.permissions.save', 'Save role permissions', 'POST', '/api/admin/roles/permissions', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.roles.permissions.save');

INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.loginLogs.page', 'Login log page', 'GET', '/admin/login-logs', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.loginLogs.page');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.loginLogs.query', 'Query login logs', 'GET', '/api/admin/login-logs', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.loginLogs.query');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.operationLogs.page', 'Operation log page', 'GET', '/admin/operation-logs', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.operationLogs.page');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.operationLogs.query', 'Query operation logs', 'GET', '/api/admin/operation-logs', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.operationLogs.query');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.configs.page', 'System config page', 'GET', '/admin/configs', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.configs.page');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.configs.query', 'Query system configs', 'GET', '/api/admin/configs', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.configs.query');

INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.menus.page', 'Menu management page', 'GET', '/admin/menus', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.menus.page');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.menus.query', 'Query menus', 'GET', '/api/admin/menus', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.menus.query');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.permissions.page', 'Permission management page', 'GET', '/admin/permissions', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.permissions.page');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'admin.permissions.query', 'Query permissions', 'GET', '/api/admin/permissions', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'admin.permissions.query');

INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'user.profile.page', 'Profile page', 'GET', '/user/profile', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'user.profile.page');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'user.messages.page', 'Messages page', 'GET', '/user/messages', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'user.messages.page');
INSERT INTO sys_permission (code, name, method, path, status)
SELECT 'user.settings.page', 'Settings page', 'GET', '/user/settings', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_permission WHERE code = 'user.settings.page');

INSERT INTO sys_menu (code, name, path, permission_code, sort, status)
SELECT 'users', 'Users', '/admin/users', 'admin.users.page', 10, 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE code = 'users');
INSERT INTO sys_menu (code, name, path, permission_code, sort, status)
SELECT 'roles', 'Roles', '/admin/roles', 'admin.roles.page', 20, 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE code = 'roles');
INSERT INTO sys_menu (code, name, path, permission_code, sort, status)
SELECT 'menus', 'Menus', '/admin/menus', 'admin.menus.page', 30, 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE code = 'menus');
INSERT INTO sys_menu (code, name, path, permission_code, sort, status)
SELECT 'permissions', 'Permissions', '/admin/permissions', 'admin.permissions.page', 40, 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE code = 'permissions');
INSERT INTO sys_menu (code, name, path, permission_code, sort, status)
SELECT 'login-logs', 'Login Logs', '/admin/login-logs', 'admin.loginLogs.page', 50, 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE code = 'login-logs');
INSERT INTO sys_menu (code, name, path, permission_code, sort, status)
SELECT 'operation-logs', 'Operation Logs', '/admin/operation-logs', 'admin.operationLogs.page', 60, 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE code = 'operation-logs');
INSERT INTO sys_menu (code, name, path, permission_code, sort, status)
SELECT 'configs', 'Configs', '/admin/configs', 'admin.configs.page', 70, 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE code = 'configs');
INSERT INTO sys_menu (code, name, path, permission_code, sort, status)
SELECT 'profile', 'Profile', '/user/profile', 'user.profile.page', 10, 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE code = 'profile');
INSERT INTO sys_menu (code, name, path, permission_code, sort, status)
SELECT 'messages', 'Messages', '/user/messages', 'user.messages.page', 20, 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE code = 'messages');
INSERT INTO sys_menu (code, name, path, permission_code, sort, status)
SELECT 'settings', 'Settings', '/user/settings', 'user.settings.page', 30, 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE code = 'settings');

INSERT IGNORE INTO sys_role_permission (role_id, permission_id)
SELECT r.id, p.id FROM sys_role r, sys_permission p WHERE r.code = 'ADMIN';

INSERT IGNORE INTO sys_role_permission (role_id, permission_id)
SELECT r.id, p.id
FROM sys_role r, sys_permission p
WHERE r.code = 'USER'
  AND p.code IN ('user.profile.page', 'user.messages.page', 'user.settings.page');

INSERT INTO sys_config (config_key, config_value, description, status)
SELECT 'site.name', 'MySSM', 'Application display name', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_config WHERE config_key = 'site.name');
INSERT INTO sys_config (config_key, config_value, description, status)
SELECT 'security.captcha.enabled', 'true', 'Enable login captcha', 'ACTIVE'
WHERE NOT EXISTS (SELECT 1 FROM sys_config WHERE config_key = 'security.captcha.enabled');
