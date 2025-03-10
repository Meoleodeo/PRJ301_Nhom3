# Setup and Development

-   [Setup and Development](#setup-and-development)
    -   [First-time Setup](#first-time-setup)
    -   [Installation](#installation)
        -   [Database](#database)
        -   [Configuration](#configuration)
        -   [Application Server](#application-server)
    -   [Docker](#docker)
        -   [Docker Installation](#docker-installation)
        -   [Docker-compose Installation](#docker-compose-installation)
        -   [Run](#run)

## First-time Setup

Make sure you have the following installed:

-   [Java Development Kit (JDK)](https://www.oracle.com/java/technologies/downloads/) (version 17 or later)
-   [Apache Tomcat](https://tomcat.apache.org/download-90.cgi) (version 9 or later)
-   [SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) (2019 or later recommended)

## Installation

### Database

> Note: This project uses JDBC 11+ for database connectivity with Microsoft SQL Server using the traditional DAO pattern.

### Configuration

Before starting, install SQL Server and configure the database connection in `src/main/resources/application.properties`:

```properties
db.url=jdbc:sqlserver://localhost:1433;databaseName=your_database;encrypt=true;trustServerCertificate=true
db.username=sa
db.password=1234567
db.driver=com.microsoft.sqlserver.jdbc.SQLServerDriver
```

Database Management Scripts:

```sql
-- Create database
CREATE DATABASE your_database;
GO

-- Use database
USE your_database;
GO

-- Run schema scripts
-- Execute from SQL Server Management Studio or sqlcmd:
-- sqlcmd -S localhost -U sa -P YourStrongPassword123 -d your_database -i src/main/resources/sql/schema.sql
-- sqlcmd -S localhost -U sa -P YourStrongPassword123 -d your_database -i src/main/resources/sql/data.sql
```

### Application Server

1. Download and install Apache Tomcat 9+ from the [official website](https://tomcat.apache.org/download-90.cgi)

2. Configure Tomcat:
   - Set `CATALINA_HOME` environment variable to your Tomcat installation directory
   - Configure server port in `conf/server.xml` (default: 8080)

3. Deploy the application:
   - Copy the WAR file to Tomcat's `webapps` directory
   - Or configure the IDE to deploy directly to Tomcat

4. Start Tomcat:
```bash
# Windows
%CATALINA_HOME%\bin\startup.bat

# Linux/Mac
$CATALINA_HOME/bin/startup.sh
```

The application will be available at `http://localhost:8080/your-application`

## Docker

If you are familiar with [Docker](https://www.docker.com/) and [docker-compose](https://docs.docker.com/compose), you can use the provided Docker configuration.

### Docker Installation

Download Docker from the official website:

-   Mac: https://docs.docker.com/docker-for-mac/install/
-   Windows: https://docs.docker.com/docker-for-windows/install/
-   Ubuntu: https://docs.docker.com/install/linux/docker-ce/ubuntu/

### Docker-compose Installation

Download docker-compose from the [official website](https://docs.docker.com/compose/install)

### Run

Open terminal, navigate to the project directory, and run:

```bash
PORT=8080 docker-compose up
```

> Note: The application will run on port 8080 (http://localhost:8080)

Database Configuration:
```text
host: sqlserver
user: sa
pass: YourStrongPassword123
```

Create database `your_database` and the application will be ready to use.

## Development Tips

1. IDE Configuration:
   - Ensure your IDE is configured to use JDK 17+
   - Configure Tomcat server integration in your IDE
   - Set up SQL Server connection in your IDE's database tools
   - Install SQL Server Management Studio (SSMS) or Azure Data Studio for database management

2. Debugging:
   - Use IDE's debug configuration with Tomcat
   - Enable remote debugging by adding these options to Tomcat's startup:
     ```
     -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005
     ```

3. Hot Reload:
   - Configure IDE for hot reload support
   - Use Tomcat's manager application for quick redeployment

4. SQL Server Specific Tips:
   - Enable SQL Server Authentication mode (Mixed Mode)
   - Configure SQL Server to accept remote connections if needed
   - Ensure SQL Server Browser service is running for named instances
   - Configure firewall rules to allow SQL Server connections (default port: 1433)