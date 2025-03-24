# BlackShope - Java Web Project

##  Decription:
BlackShope is an e-commerce web application built with Java Servlet/JSP, running on Apache Tomcat, and integrated with SQL Server. The platform supports both buyers and sellers: [do it.](#main-fearture)

### Pleas read docs before working: [here.](https://github.com/Meoleodeo/PRJ301_Nhom3/blob/main/docs/)

### Erd db at: [here.](https://dbdiagram.io/d/PRJ301_Nhom3-67cb213d263d6cf9a09dfb71)

### Work flow at: [here.](https://trello.com/b/cFKPxPlx/projectnhom3)

### To clone prj:
```bash
git clone https://github.com/Meoleodeo/PRJ301_Nhom3
```
## Folder Structer:
```
BlackShope/
├───build
│   ├───empty
│   ├───generated-sources
│   │   └───ap-source-output
│   └───web
│       ├───assets
│       │   ├───css
│       │   ├───image
│       │   │   ├───banner
│       │   │   └───product
│       │   └───themify-icons
│       │       ├───demo-files
│       │       ├───fonts
│       │       └───SVG
│       ├───includes
│       ├───META-INF
│       └───WEB-INF
│           ├───classes
│           │   ├───controller
│           │   ├───dao
│           │   └───model
│           ├───lib
│           └───tlds
├───chatgpt
│   └───__pycache__
├───db
├───dist
├───docs
├───nbproject
│   └───private
├───src
│   ├───conf
│   └───java
│       ├───controller
│       ├───dao
│       └───model
├───test
└───web
    ├───assets
    │   ├───css
    │   ├───image
    │   │   ├───banner
    │   │   └───product
    │   └───themify-icons
    │       ├───demo-files
    │       ├───fonts
    │       └───SVG
    ├───includes
    ├───META-INF
    └───WEB-INF
        └───tlds
```

## Setup and Running:
### 1️ Generate Database:
script: [here](https://github.com/Meoleodeo/PRJ301_Nhom3/blob/main/db/)

### 2️ Config `DatabaseConfig.java`

### 3️ Build:
- Open **Apache Tomcat** (phiên bản 9 trở lên).
- Deploy on Tomcat.
- curl `http://localhost:8080/BlackShope/`.

## Account samples:
| role | Username  | Mật khẩu   |
|---------------|-----------|------------|
| buyer    | buyer1    | password123 |
| seller    | seller1   | password123 |

## Main Fearture
- Chat with AI.
- Login, Logout, Register,...
### Buyer
- View Products List.
- Order and manager Order (add, remove).
- Payment.
### Seller
- Manager Products (add, remove, update).
- View Order (any product of self.seller).
- Manager Order (update status).
- Update Later.
