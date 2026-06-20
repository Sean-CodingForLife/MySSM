# MySSM

MySSM is a legacy SSM learning project reorganized as a standard Maven Web application. It now targets a general-purpose backend management system instead of a fixed business domain.

The project keeps the original Spring MVC, Spring, MyBatis, JSP, and MySQL architecture while removing domain-specific HR modules. It is useful as a small admin-system learning project and as a stepping stone toward a future Spring Boot + Vue migration.

## Features

- Unified login with admin/user roles
- User registration
- User management
- User profile, message, and settings pages
- Basic admin/user route interception
- `zh-CN` and `en-US` language switching
- JSP pages with jQuery-based AJAX requests
- General landing page and role-aware dashboard

## Tech Stack

- Java 8 source/target compatibility
- Spring Framework 5.3.39
- Spring MVC
- MyBatis 3.5.16
- MyBatis-Spring 2.1.2
- Spring Security Crypto
- Jackson 2.13.5
- SLF4J 1.7 + Logback 1.2
- JSP + JSTL
- MySQL
- Maven
- Tomcat 8.5/9

> Do not run this project on Tomcat 10 or 11. The project uses `javax.servlet.*`, while Tomcat 10+ uses `jakarta.servlet.*`.

## Project Structure

```text
MySSM/
  database/
    schema.sql
  src/main/java/
    com/
      controller/
      dao/
      interceptor/
      message/
      myTool/
      po/
      responseData/
      service/
  src/main/resources/
    applicationContext.xml
    jdbc.properties
    logback.xml
    com/mybatis/
  src/main/webapp/
    WEB-INF/
    css/
    images/
    js/
    index.jsp
  pom.xml
  README.md
```

## Requirements

- JDK 8 or later
- Maven 3.x
- MySQL 5.7 or compatible
- Tomcat 8.5 or Tomcat 9
- IntelliJ IDEA with Smart Tomcat, or IDEA Ultimate with built-in Tomcat support

If port `8080` is occupied, change Tomcat to `8081` or stop the process using that port.

## Database Setup

Create the database and tables:

```sql
source database/schema.sql;
```

If your MySQL client does not support `source`, open `database/schema.sql` in DataGrip, Navicat, MySQL Workbench, or IDEA Database Tools and execute the script manually.

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

The schema script inserts a default admin account:

```text
account: admin
password: admin
```

Passwords are stored as BCrypt hashes generated on the server. Existing MD5 password data from older versions must be reset or recreated.
Public registration creates regular `USER` accounts only. New `ADMIN` accounts are created from the admin user management page after an administrator logs in.

## Run In IntelliJ IDEA With Smart Tomcat

1. Open the project root directory in IDEA.
2. Let IDEA import the project as a Maven project.
3. Install the Smart Tomcat plugin if you are using IDEA Community Edition.
4. Create a Smart Tomcat run configuration.
5. Set Tomcat Server to Tomcat 8.5/9.
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

Main routes:

```text
GET    /
POST   /api/session
DELETE /api/session
GET    /dashboard
GET    /admin/users
GET    /api/admin/users
POST   /api/admin/users
DELETE /api/admin/users
GET    /user/register
GET    /user/profile
GET    /user/messages
GET    /user/settings
POST   /api/public/users
```

`/dashboard` is shared by both admin and user logins. Accounts are stored in `sys_user` and authorization is role based. Admin users see admin management entries; regular users see only user-facing entries. Admin pages are under `/admin/...`; user pages are under `/user/...`; admin JSON APIs are under `/api/admin/...`.

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

Use Tomcat 8.5 or 9. This project depends on `javax.servlet`.

### Database connection failed

Check:

- MySQL is running
- Database `myssm_admin` exists
- `jdbc.username` and `jdbc.password` are correct
- `database/schema.sql` has been executed

### Dependency version mismatch

Reload Maven after pulling dependency changes. This project intentionally stays on Spring 5.x and `javax.servlet.*` for Tomcat 8.5/9 compatibility. Do not mix in Spring 6.x or `jakarta.servlet.*` dependencies unless the whole project is migrated to Tomcat 10+.

## Notes

This is still a legacy SSM/JSP project. The current goal is to keep it reproducible, generic, and easy to run. A future migration path could be:

- Convert to Spring Boot
- Replace JSP with Vue 3 + Vite + Element Plus
- Replace custom JSON utilities with Jackson completely
- Improve authentication and authorization
- Add reusable business modules on top of the generic admin foundation
