-- Step 1: Create Database
create DATABASE Shope;
GO
USE Shope;
GO

-- Step 2: Create Users Table (Customers & Admins)
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) CHECK (Role IN ('Customer', 'Admin')) DEFAULT 'Customer',
    Address NVARCHAR(255),
    Phone NVARCHAR(15),
    RegistrationDate DATETIME DEFAULT GETDATE()
);
GO

-- Step 3: Create Categories Table
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL UNIQUE
);
GO

-- Step 4: Create Products Table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    Price DECIMAL(10,2) CHECK (Price > 0),
    StockQuantity INT CHECK (StockQuantity >= 0),
    ProductImage NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Step 5: Create Orders Table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    OrderDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')) DEFAULT 'Pending'
);
GO

-- Step 6: Create Order Details Table
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT CHECK (Quantity > 0),
    Subtotal AS (Quantity * (SELECT Price FROM Products WHERE Products.ProductID = OrderDetails.ProductID))
);
GO

-- Step 7: Create Payments Table
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    PaymentDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod NVARCHAR(50) CHECK (PaymentMethod IN ('Credit Card', 'PayPal', 'Bank Transfer', 'Cash on Delivery'))
);
GO

-- Step 8: Insert Sample Data into Users
INSERT INTO Users (Username, Email, PasswordHash, Role, Address, Phone)
VALUES 
('admin', 'admin@shope.com', 'hashedpassword', 'Admin', NULL, NULL),
('john_doe', 'john@example.com', 'hashedpassword', 'Customer', '123 Street, City', '1234567890');
GO

-- Step 9: Insert Sample Data into Categories
INSERT INTO Categories (CategoryName)
VALUES 
('Electronics'),
('Clothing'),
('Home Appliances');
GO

-- Step 10: Insert Sample Data into Products
INSERT INTO Products (ProductName, Description, CategoryID, Price, StockQuantity, ProductImage)
VALUES 
('iPhone 13', 'Latest Apple iPhone with A15 Bionic chip', 1, 999.99, 50, '/images/iphone13.jpg'),
('T-shirt', '100% Cotton T-shirt', 2, 19.99, 200, '/images/tshirt.jpg'),
('Microwave Oven', '800W Microwave for quick heating', 3, 149.99, 30, '/images/microwave.jpg');
GO

-- Step 11: Insert Sample Order
INSERT INTO Orders (UserID, Status)
VALUES (2, 'Pending');
GO

-- Step 12: Insert Sample Order Details
INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES (1, 1, 2); -- John bought 2 iPhones
GO

-- Step 13: Insert Sample Payment
INSERT INTO Payments (OrderID, Amount, PaymentMethod)
VALUES (1, 1999.98, 'Credit Card'); -- John paid for 2 iPhones
GO

-- Step 14: Useful Queries

-- Get All Orders with User Details
SELECT O.OrderID, U.Username, U.Email, O.OrderDate, O.Status
FROM Orders O
JOIN Users U ON O.UserID = U.UserID;
GO

-- Get Order Details for a Specific Order
SELECT OD.OrderDetailID, P.ProductName, OD.Quantity, OD.Subtotal
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
WHERE OD.OrderID = 1;
GO

-- Check Stock of a Product
SELECT ProductName, StockQuantity FROM Products WHERE ProductID = 1;
GO

-- Total Revenue from Orders
SELECT SUM(Amount) AS TotalRevenue FROM Payments;
GO
