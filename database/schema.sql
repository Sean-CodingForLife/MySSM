CREATE DATABASE IF NOT EXISTS HM DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE HM;

CREATE TABLE IF NOT EXISTS AdminUser (
  no INT AUTO_INCREMENT PRIMARY KEY,
  account VARCHAR(64) NOT NULL UNIQUE,
  password VARCHAR(128) NOT NULL,
  name VARCHAR(64) NOT NULL,
  status VARCHAR(32),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS User (
  no INT AUTO_INCREMENT PRIMARY KEY,
  account VARCHAR(64) NOT NULL UNIQUE,
  password VARCHAR(128) NOT NULL,
  name VARCHAR(64) NOT NULL,
  status VARCHAR(32),
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS Department (
  no INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64) NOT NULL UNIQUE,
  description VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS Job (
  no INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(64) NOT NULL UNIQUE,
  description VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS Employee (
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

CREATE TABLE IF NOT EXISTS Notice (
  no INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(128) NOT NULL,
  content TEXT,
  created_date DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS Employee_Job_Relate (
  no INT AUTO_INCREMENT PRIMARY KEY,
  employee_no INT NOT NULL,
  job_no INT NOT NULL,
  UNIQUE KEY uk_employee_job (employee_no),
  CONSTRAINT fk_employee_job_employee FOREIGN KEY (employee_no) REFERENCES Employee(no) ON DELETE CASCADE,
  CONSTRAINT fk_employee_job_job FOREIGN KEY (job_no) REFERENCES Job(no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS Employee_Department_Relate (
  no INT AUTO_INCREMENT PRIMARY KEY,
  employee_no INT NOT NULL,
  department_no INT NOT NULL,
  UNIQUE KEY uk_employee_department (employee_no),
  CONSTRAINT fk_employee_department_employee FOREIGN KEY (employee_no) REFERENCES Employee(no) ON DELETE CASCADE,
  CONSTRAINT fk_employee_department_department FOREIGN KEY (department_no) REFERENCES Department(no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS AdminUser_Notice_Relate (
  no INT AUTO_INCREMENT PRIMARY KEY,
  adminUser_no INT NOT NULL,
  notice_no INT NOT NULL,
  UNIQUE KEY uk_notice_admin (notice_no),
  CONSTRAINT fk_admin_notice_admin FOREIGN KEY (adminUser_no) REFERENCES AdminUser(no),
  CONSTRAINT fk_admin_notice_notice FOREIGN KEY (notice_no) REFERENCES Notice(no) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO AdminUser (account, password, name, status)
SELECT 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', 'on-line'
WHERE NOT EXISTS (SELECT 1 FROM AdminUser WHERE account = 'admin');
