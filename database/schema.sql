CREATE DATABASE IF NOT EXISTS myssm_personnel DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE myssm_personnel;

CREATE TABLE IF NOT EXISTS admin_user (
  no INT AUTO_INCREMENT PRIMARY KEY,
  account VARCHAR(64) NOT NULL UNIQUE,
  password VARCHAR(128) NOT NULL,
  name VARCHAR(64) NOT NULL,
  status VARCHAR(32),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS app_user (
  no INT AUTO_INCREMENT PRIMARY KEY,
  account VARCHAR(64) NOT NULL UNIQUE,
  password VARCHAR(128) NOT NULL,
  name VARCHAR(64) NOT NULL,
  status VARCHAR(32),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS department (
  no INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64) NOT NULL UNIQUE,
  description VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS job (
  no INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64) NOT NULL UNIQUE,
  description VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS employee (
  no INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64) NOT NULL,
  id VARCHAR(64),
  address VARCHAR(255),
  mail VARCHAR(64),
  phone VARCHAR(32),
  qq VARCHAR(32),
  email VARCHAR(128),
  sex VARCHAR(16),
  political_status VARCHAR(64),
  birthday VARCHAR(32),
  nation VARCHAR(64),
  education VARCHAR(64),
  major VARCHAR(64),
  hobby VARCHAR(255),
  description VARCHAR(255),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS notice (
  no INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(128) NOT NULL,
  content TEXT,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS employee_job (
  no INT AUTO_INCREMENT PRIMARY KEY,
  employee_no INT NOT NULL,
  job_no INT NOT NULL,
  UNIQUE KEY uk_employee_job (employee_no),
  CONSTRAINT fk_employee_job_employee FOREIGN KEY (employee_no) REFERENCES employee(no) ON DELETE CASCADE,
  CONSTRAINT fk_employee_job_job FOREIGN KEY (job_no) REFERENCES job(no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS employee_department (
  no INT AUTO_INCREMENT PRIMARY KEY,
  employee_no INT NOT NULL,
  department_no INT NOT NULL,
  UNIQUE KEY uk_employee_department (employee_no),
  CONSTRAINT fk_employee_department_employee FOREIGN KEY (employee_no) REFERENCES employee(no) ON DELETE CASCADE,
  CONSTRAINT fk_employee_department_department FOREIGN KEY (department_no) REFERENCES department(no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS admin_user_notice (
  no INT AUTO_INCREMENT PRIMARY KEY,
  admin_user_no INT NOT NULL,
  notice_no INT NOT NULL,
  UNIQUE KEY uk_notice_admin (notice_no),
  CONSTRAINT fk_admin_notice_admin FOREIGN KEY (admin_user_no) REFERENCES admin_user(no),
  CONSTRAINT fk_admin_notice_notice FOREIGN KEY (notice_no) REFERENCES notice(no) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO admin_user (account, password, name, status)
SELECT 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', 'on-line'
WHERE NOT EXISTS (SELECT 1 FROM admin_user WHERE account = 'admin');
