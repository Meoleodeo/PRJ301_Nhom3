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

-- Bảng Product
CREATE TABLE Products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(1000),
    quantity INT CHECK (quantity >= 0) NOT NULL,
    imageUrl NVARCHAR(255),
    sellerId INT FOREIGN KEY REFERENCES Users(id) ON DELETE CASCADE
);
-- Bảng Orders với điều chỉnh ON DELETE NO ACTION
CREATE TABLE Orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    buyerId INT FOREIGN KEY REFERENCES Users(id) ON DELETE NO ACTION,
    productId INT FOREIGN KEY REFERENCES Products(id) ON DELETE NO ACTION,
    quantity INT CHECK (quantity > 0) NOT NULL,
    status NVARCHAR(20) CHECK (status IN ('Pending', 'Completed', 'Cancelled')) NOT NULL DEFAULT 'Pending',
    orderDate DATETIME DEFAULT GETDATE()
);


-- Thêm dữ liệu mẫu
INSERT INTO Users (username, password, email, role) VALUES
('buyer1', 'password123', 'buyer1@example.com', 'buyer'),
('seller1', 'password123', 'seller1@example.com', 'seller');

INSERT INTO Products (name, description, quantity, imageUrl, sellerId) VALUES
('Laptop', 'Laptop gaming mạnh mẽ', 5, 'laptop.jpg', 2),
('Smartphone', 'Điện thoại thông minh', 10, 'phone.jpg', 2);

-- Thêm đơn hàng mẫu
INSERT INTO Orders (buyerId, productId, quantity, status) VALUES
(1, 1, 1, 'Pending'),   -- Người mua 1 đặt 1 Laptop
(1, 2, 2, 'Completed'), -- Người mua 1 đặt 2 Smartphone
(1, 1, 1, 'Cancelled'); -- Người mua 1 đặt thêm 1 Laptop nhưng đã hủy đơn
