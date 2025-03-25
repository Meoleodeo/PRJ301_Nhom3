# Requirement:
- Make sure u Have [this](#databaseconfig) & [this](#apikey), cuz we ignore to push.

## Make sure you have the following installed:

[Java Development Kit (JDK)](https://www.oracle.com/java/technologies/downloads/) (version 17 or later)

[Apache Tomcat](https://tomcat.apache.org/download-90.cgi) (version 9 or later)

[SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) (2019 or later recommended)

[JDBC jre11](https://learn.microsoft.com/vi-vn/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server?view=sql-server-ver15#download) (12.8 or later recommended)

[gson](https://mvnrepository.com/artifact/com.google.code.gson/gson/2.12.1) (2.12.1 later recommended)

### To get template boostrap:
```bash
git clone https://github.com/startbootstrap/startbootstrap-shop-homepage
```
use bootstrap 5.1.3 in assets
```html
<link rel="stylesheet" href="assets/bootstrap.min.css">
```
or
```html
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
```


### DatabaseConfig:
```java
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DatabaseConfig {
     public static String DRIVERNAME="com.microsoft.sqlserver.jdbc.SQLServerDriver";
    public static String URL="jdbc:sqlserver://127.0.0.1:urPort;databaseName=BlackShope;encrypt=true;trustServerCertificate=true;loginTimeout=30;";
    public static String USER="urUName";
    public static String PASSWORD="urPass";
     public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVERNAME);
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("SQL Server JDBC Driver not found", e);
        }
    }
    // main test
     public static void main(String[] args) {
         try {
             getConnection();
         } catch (SQLException ex) {
             Logger.getLogger(DatabaseConfig.class.getName()).log(Level.SEVERE, null, ex);
         }
    }
}
```
### APIKey:
```java
package controller;

public class APIKey {

    public static final String GEMINI_API_KEY = "ur_APIKey_From_Gemini_2.0";
}
```