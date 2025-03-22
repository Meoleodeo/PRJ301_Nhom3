create DATABASE BlackShope;
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
go

-- Bảng Product
CREATE TABLE Products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(1000),
    quantity INT CHECK (quantity >= 0) NOT NULL,
    imageUrl NVARCHAR(255),
    sellerId INT FOREIGN KEY REFERENCES Users(id) ON DELETE CASCADE
);
go
-- Bảng Orders với điều chỉnh ON DELETE NO ACTION
CREATE TABLE Orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    buyerId INT FOREIGN KEY REFERENCES Users(id) ON DELETE NO ACTION,
    productId INT FOREIGN KEY REFERENCES Products(id) ON DELETE NO ACTION,
    quantity INT CHECK (quantity > 0) NOT NULL,
    status NVARCHAR(20) CHECK (status IN ('Pending', 'Completed', 'Cancelled')) NOT NULL DEFAULT 'Pending',
    orderDate DATETIME DEFAULT GETDATE()
);
go

