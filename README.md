# BlackShope - Java Web Project

##  Giới thiệu
BlackShope là một ứng dụng web bán hàng trực tuyến được xây dựng bằng **Java Servlet/JSP**, sử dụng **Apache Tomcat** và kết nối với **SQL Server**. Ứng dụng hỗ trợ **người mua** và **người bán**, cho phép đăng ký, đăng nhập, quản lý sản phẩm, đặt hàng, và quản lý đơn hàng.

## Công nghệ sử dụng
- **Ngôn ngữ**: Java (Servlet/JSP)
- **Cơ sở dữ liệu**: Microsoft SQL Server
- **Máy chủ ứng dụng**: Apache Tomcat
- **Giao diện**: Bootstrap, HTML, CSS
- **Kết nối CSDL**: JDBC

template boostrap:
```bash
git clone https://github.com/startbootstrap/startbootstrap-shop-homepage
```
### erd db at: [here](https://dbdiagram.io/d/PRJ301_Nhom3-67cb213d263d6cf9a09dfb71)

### to clone prj:
```bash
git clone https://github.com/Meoleodeo/PRJ301_Nhom3
```
### to pull:
```bash
git pull https://github.com/Meoleodeo/PRJ301_Nhom3
```
### to push:
```bash
git add .
git commit -m "ur mesg"
git push
```
... `docs/git-lifecycle.md`



## Cấu trúc thư mục
```
BlackShope/
│── src/
│   ├── controller/   # Servlets xử lý logic
│   ├── dao/          # Data Access Object (DAO)
│   ├── model/        # Lớp dữ liệu
│   ├── config/       # Cấu hình database
│── WebContent/
│   ├── assets/       # CSS, JS, hình ảnh
│   ├── includes/     # Navbar, Footer, Header
│   ├── index.jsp     # Trang chủ
│   ├── login.jsp     # Đăng nhập
│   ├── register.jsp  # Đăng ký
│   ├── dashboard.jsp # Trang quản lý của người bán
│   ├── order.jsp     # Danh sách đơn hàng của người mua
│── web.xml           # Cấu hình Servlet
│── README.md         # Hướng dẫn sử dụng
```

## 🛠 Cài đặt và chạy dự án
### 1️ Cấu hình database
- Tạo cơ sở dữ liệu `BlackShope` trong SQL Server.
- Chạy file `setupDbBlackShope.sql` để tạo bảng và thêm dữ liệu mẫu.

### 2️ Cấu hình `DatabaseConfig.java`
Cập nhật thông tin kết nối trong `config/DatabaseConfig.java`:
```java
public static String URL = "jdbc:sqlserver://127.0.0.1:1434;databaseName=BlackShope;encrypt=false;";
public static String USER = "sa";
public static String PASSWORD = "your_password";
```

### 3️ Chạy ứng dụng
- Mở **Apache Tomcat** (phiên bản 9 trở lên).
- Triển khai ứng dụng trên Tomcat.
- Truy cập `http://localhost:8080/BlackShope/`.

## Các tài khoản mẫu
| Loại tài khoản | Username  | Mật khẩu   |
|---------------|-----------|------------|
| Người mua    | buyer1    | password123 |
| Người bán    | seller1   | password123 |

## Chức năng chính
### Người mua (Buyer)
- Đăng ký, đăng nhập, đăng xuất.
- Xem danh sách sản phẩm.
- Đặt hàng và quản lý đơn hàng.

### Người bán (Seller)
- Quản lý sản phẩm (thêm, sửa, xóa).
- Quản lý đơn hàng của khách.
