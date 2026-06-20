# MySSM

MySSM is a legacy SSM learning project that has been reorganized as a standard Maven Web application. It uses Spring MVC, Spring, MyBatis, JSP, and MySQL to implement a simple personnel management system.

The project was originally written as an Eclipse/Tomcat style Java Web project. This repository keeps the original SSM/JSP architecture, while moving generated files and MyBatis resources into a Maven-friendly layout.

## Features

- Admin and user login
- User registration
- Employee management
- Department management
- Job/position management
- Notice management
- Basic login interception
- JSP pages with jQuery-based AJAX requests

## Tech Stack

- Java 8 source/target compatibility
- Spring Framework 5.0.2
- Spring MVC
- MyBatis 3.4.5
- MyBatis-Spring 1.3.1
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
    log4j.properties
    com/mybatis/
  src/main/webapp/
    WEB-INF/
    css/
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

This project has been tested with Tomcat 9 after migration. If port `8080` is occupied, change Tomcat to `8081` or stop the process using that port.

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
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/HM?characterEncoding=utf8
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

The password is stored as an MD5 value because the original login page hashes the password before submitting it.

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
   /xpf
   ```

8. Use port `8080`, or change to `8081` if `8080` is occupied.
9. Start Tomcat and visit:

   ```text
   http://localhost:8080/xpf
   ```

If using port `8081`, visit:

```text
http://localhost:8081/xpf
```

## Build With Maven

```bash
mvn clean package
```

The generated WAR file is:

```text
target/xpf.war
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
- Database `HM` exists
- `jdbc.username` and `jdbc.password` are correct
- `database/schema.sql` has been executed

### SLF4J StaticLoggerBinder warning

The project currently includes `slf4j-api` but no SLF4J binding. This warning does not block startup. The legacy project still uses Log4j 1.x.

## Notes

This is still a legacy SSM/JSP project. The current goal is to make it reproducible and easy to run. A future migration path could be:

- Upgrade dependencies
- Replace custom JSON utilities with Jackson completely
- Improve authentication and authorization
- Convert to Spring Boot
- Split frontend and backend

