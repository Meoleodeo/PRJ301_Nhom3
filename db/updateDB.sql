CREATE DATABASE BlackShope;
GO

USE BlackShope;
GO

-- Bảng User
CREATE TABLE Users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    role NVARCHAR(10) CHECK (role IN ('buyer', 'seller')) NOT NULL
);
GO
-- Bảng Product
CREATE TABLE Products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(1000),
    quantity INT CHECK (quantity >= 0) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    imageUrl NVARCHAR(255),
    sellerId INT FOREIGN KEY REFERENCES Users(id) ON DELETE CASCADE
);
GO
-- Bảng Orders với điều chỉnh ON DELETE NO ACTION
CREATE TABLE Orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    buyerId INT FOREIGN KEY REFERENCES Users(id) ON DELETE NO ACTION,
    productId INT FOREIGN KEY REFERENCES Products(id) ON DELETE NO ACTION,
    quantity INT CHECK (quantity > 0) NOT NULL,
    status NVARCHAR(20) CHECK (status IN ('Pending', 'Completed', 'Cancelled')) NOT NULL DEFAULT 'Pending',
    paymentStatus NVARCHAR(20) CHECK (paymentStatus IN ('Paid', 'Unpaid')) NOT NULL DEFAULT 'Unpaid',
    orderDate DATETIME DEFAULT GETDATE()
);
GO
-- Bảng Cards
CREATE TABLE Cards (
    userId INT FOREIGN KEY REFERENCES Users(id) ON DELETE CASCADE,
    cardNumber BIGINT PRIMARY KEY,
    balance INT NOT NULL
);
GO
-- Bảng ChatHistory
CREATE TABLE ChatHistory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT FOREIGN KEY REFERENCES Users(id) ON DELETE CASCADE,
    contents NVARCHAR(2000),
    chatDate DATETIME DEFAULT GETDATE()
);
GO
-- Thêm dữ liệu mẫu
INSERT INTO Users (username, password, email, role) VALUES
('buyer1', 'password123', 'buyer1@example.com', 'buyer'),
('seller1', 'password123', 'seller1@example.com', 'seller');
go
INSERT INTO Products (name, description, quantity, price, imageUrl, sellerId) VALUES
('Laptop', 'Laptop gaming mạnh mẽ', 5, 1500.00, 'laptop.jpg', 2),
('Smartphone', 'Điện thoại thông minh', 10, 800.00, 'phone.jpg', 2);
GO
-- Thêm đơn hàng mẫu
INSERT INTO Orders (buyerId, produGOctId, quantity, status, paymentStatus) VALUES
(1, 1, 1, 'Pending', 'Unpaid'), GO  -- Người mua 1 đặt 1 Laptop chưa thanh toán
(1, 2, 2, 'Completed', 'Paid'), --GO Người mua 1 đặt 2 Smartphone và đã thanh toán
(1, 1, 1, 'Cancelled', 'Unpaid'); -- Người mua 1 đặt thêm 1 Laptop nhưng đã hủy đơn
GO
-- Thêm dữ liệu vào bảng Cards
INSERT INTO Cards (userId, cardNumber, balance) VALUES
(1, 1234567890123456, 5000),
(2, 9876543210987654, 7000);
GO
-- Thêm dữ liệu vào bảng ChatHistory
INSERT INTO ChatHistory (userId, contents) VALUES
(1, 'Xin chào AI, tôi cần mua laptop.'),
(2, 'Làm thế nào để đăng sản phẩm mới?');

select * from ChatHistory;
select * from Orders;
select * from Users;
select * from Products;
select * from Cards;