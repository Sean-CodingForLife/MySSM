# MySSM

MySSM is a legacy SSM learning project that has been reorganized into a generic backend management system template.

It keeps the current Spring MVC + Spring + MyBatis + JSP stack for now. The goal of this stage is to make the old project clean, runnable, permission-aware, and suitable for pushing to GitHub. The Spring Boot + Vue 3 migration is intentionally left for a later phase.

## Features

- Unified login page for all accounts
- Public user registration
- BCrypt password storage
- Login captcha based on EasyCaptcha
- Session based authentication
- RBAC authorization with users, roles, permissions, and menus
- Dynamic dashboard and sidebar based on the logged-in user's permissions
- Admin user management, including creating admin or normal user accounts
- Role management and role-permission assignment
- Menu and permission list pages
- Login log and operation log pages
- System config list page
- `zh-CN` and `en-US` language switching
- Bootstrap 5 based JSP UI with loading, toast, confirm, table, and pagination helpers

## Tech Stack

- Java 8 source/target compatibility
- Spring Framework 5.3.x
- Spring MVC
- MyBatis 3.5.x
- MyBatis-Spring
- Spring Security Crypto
- EasyCaptcha
- Jackson
- SLF4J + Logback
- JSP + JSTL
- Bootstrap 5 WebJar
- MySQL
- Maven
- Tomcat 8.5 or Tomcat 9

> Do not run this project on Tomcat 10 or 11. The project uses `javax.servlet.*`, while Tomcat 10+ uses `jakarta.servlet.*`.

## Project Structure

```text
MySSM/
  database/
    schema.sql
  src/main/java/com/
    controller/
    dao/
    interceptor/
    message/
    myTool/
    po/
    responseData/
    security/
    service/
  src/main/resources/
    applicationContext.xml
    jdbc.properties
    logback.xml
    i18n/
    com/mybatis/
  src/main/webapp/
    WEB-INF/jsp/
    css/
    images/
    js/
  pom.xml
  README.md
```

## Requirements

- JDK 8 or later
- Maven 3.x
- MySQL 5.7 or compatible
- Tomcat 8.5 or Tomcat 9
- IntelliJ IDEA with Smart Tomcat, or IDEA Ultimate with built-in Tomcat support

If port `8080` is occupied, change Tomcat to another port such as `8081`, or stop the process using that port.

## Database Setup

Create the database and tables:

```sql
source database/schema.sql;
```

If your MySQL client does not support `source`, open `database/schema.sql` in DataGrip, Navicat, MySQL Workbench, or IDEA Database Tools and execute it manually.

The script creates the database:

```text
myssm_admin
```

Then update:

```text
src/main/resources/jdbc.properties
```

Example:

```properties
jdbc.driver=com.mysql.cj.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/myssm_admin?characterEncoding=utf8
jdbc.username=root
jdbc.password=your_password
jdbc.maxTotal=30
jdbc.maxIdle=10
jdbc.initialSize=5
```

The schema script inserts a default administrator:

```text
account: admin
password: admin
```

Passwords are stored as BCrypt hashes. Old plain text or MD5 password data from earlier versions should be reset or recreated.

Public registration only creates normal `USER` accounts. New administrator accounts should be created from the admin user management page after logging in as an administrator.

## Run In IntelliJ IDEA With Smart Tomcat

1. Open the project root directory in IDEA.
2. Let IDEA import it as a Maven project.
3. Install the Smart Tomcat plugin if you use IDEA Community Edition.
4. Create a Smart Tomcat run configuration.
5. Set Tomcat Server to Tomcat 8.5 or Tomcat 9.
6. Set Deployment Directory to:

   ```text
   E:\MyProgram\MySSM\src\main\webapp
   ```

7. Set Context Path to:

   ```text
   /myssm
   ```

8. Use port `8080`, or change to `8081` if `8080` is occupied.
9. Start Tomcat and visit:

   ```text
   http://localhost:8080/myssm
   ```

## Main Routes

```text
GET    /
GET    /dashboard

GET    /user/register
POST   /api/public/users

POST   /api/session
DELETE /api/session
GET    /api/captcha

GET    /user/profile
GET    /user/messages
GET    /user/settings

GET    /admin/users
GET    /api/admin/users
POST   /api/admin/users
DELETE /api/admin/users

GET    /admin/roles
GET    /api/admin/roles
POST   /api/admin/roles
DELETE /api/admin/roles
GET    /api/admin/roles/permissions
POST   /api/admin/roles/permissions

GET    /admin/menus
GET    /api/admin/menus

GET    /admin/permissions
GET    /api/admin/permissions

GET    /admin/login-logs
GET    /api/admin/login-logs

GET    /admin/operation-logs
GET    /api/admin/operation-logs

GET    /admin/configs
GET    /api/admin/configs
```

## Authorization Model

The application uses RBAC tables:

- `sys_user`
- `sys_role`
- `sys_permission`
- `sys_menu`
- `sys_user_role`
- `sys_role_permission`

After login, the user's menus and permissions are loaded into the session. Admin and user accounts enter the same site, but the dashboard, sidebar, pages, and APIs are filtered by permission.

Admin routes use `/admin/...` and `/api/admin/...`. User routes use `/user/...`. Public routes are limited to login, captcha, registration, and static assets.

## Current System Pages

- Users: create normal users or administrators
- Roles: create/delete roles and assign permissions
- Menus: view SQL-defined menu entries
- Permissions: view SQL-defined route permissions
- Login Logs: view login success/failure records
- Operation Logs: view non-GET admin API operation records
- Configs: view SQL-defined system config entries

Menus, permissions, and configs are currently SQL-driven list pages. They are intentionally visible and standardized, but full CRUD for these tables can be added later if needed.

## Build With Maven

```bash
mvn clean package
```

The generated WAR file is:

```text
target/myssm.war
```

Deploy it to Tomcat's `webapps` directory if you prefer manual deployment.

## Common Issues

### Address already in use: bind

Port `8080` is already used.

Check the process:

```powershell
netstat -ano | findstr :8080
```

Then either stop that process or change Tomcat to another port such as `8081`.

### Tomcat 10/11 does not work

Use Tomcat 8.5 or Tomcat 9. This project depends on `javax.servlet.*`.

### Database connection failed

Check:

- MySQL is running
- Database `myssm_admin` exists
- `jdbc.username` and `jdbc.password` are correct
- `database/schema.sql` has been executed

### Permission page redirects to login

Make sure the latest `database/schema.sql` has been executed. Route access depends on `sys_permission` and `sys_role_permission`.

## Notes

This is still a legacy SSM/JSP project. The current stage focuses on a clean generic admin foundation. A future migration path can be:

- Convert the backend to Spring Boot
- Replace JSP with Vue 3 + Vite + Element Plus
- Replace the remaining custom JSON utilities with Jackson
- Expand system configuration, menu management, and permission management into full CRUD modules
