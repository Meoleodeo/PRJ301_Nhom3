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


INSERT INTO Users (Username, Email, PasswordHash, Role, Address, Phone)
VALUES 
('admin', 'admin@shope.com', 'hashedpassword1', 'Admin', NULL, NULL),
('john_doe', 'john@example.com', 'hashedpassword2', 'Customer', '123 Main St, City', '1234567890'),
('jane_smith', 'jane@example.com', 'hashedpassword3', 'Customer', '456 Elm St, City', '0987654321'),
('alice_jones', 'alice@example.com', 'hashedpassword4', 'Customer', '789 Pine St, City', '1122334455'),
('bob_brown', 'bob@example.com', 'hashedpassword5', 'Customer', '101 Maple St, City', '6677889900'),
('charlie_white', 'charlie@example.com', 'hashedpassword6', 'Customer', '202 Birch St, City', '3344556677'),
('dave_black', 'dave@example.com', 'hashedpassword7', 'Customer', '303 Oak St, City', '2233445566'),
('emma_green', 'emma@example.com', 'hashedpassword8', 'Customer', '404 Cedar St, City', '7788990011'),
('frank_yellow', 'frank@example.com', 'hashedpassword9', 'Customer', '505 Spruce St, City', '8899001122'),
('grace_purple', 'grace@example.com', 'hashedpassword10', 'Customer', '606 Willow St, City', '9900112233');
GO
INSERT INTO Products (ProductName, Description, CategoryID, Price, StockQuantity, ProductImage)
VALUES 
('iPhone 13', 'Latest Apple iPhone with A15 Bionic chip', 1, 999.99, 50, '/images/iphone13.jpg'),
('Samsung Galaxy S22', 'Flagship Android phone with high-end specs', 1, 899.99, 40, '/images/s22.jpg'),
('T-shirt', '100% Cotton T-shirt', 2, 19.99, 200, '/images/tshirt.jpg'),
('Jeans', 'Comfortable denim jeans', 2, 39.99, 150, '/images/jeans.jpg'),
('Microwave Oven', '800W Microwave for quick heating', 3, 149.99, 30, '/images/microwave.jpg'),
('Refrigerator', 'Large capacity fridge with freezer', 3, 799.99, 25, '/images/fridge.jpg'),
('The Great Gatsby', 'Classic novel by F. Scott Fitzgerald', 4, 14.99, 100, '/images/gatsby.jpg'),
('Ergonomic Chair', 'Comfortable office chair', 5, 129.99, 50, '/images/chair.jpg'),
('Laptop - Dell XPS 13', 'Powerful laptop for work and gaming', 1, 1299.99, 30, '/images/laptop.jpg'),
('Smartwatch - Apple Watch', 'Track fitness and receive notifications', 1, 349.99, 80, '/images/watch.jpg');
GO
INSERT INTO Orders (UserID, Status)
VALUES 
(2, 'Pending'),   -- John Doe
(3, 'Shipped'),   -- Jane Smith
(4, 'Delivered'), -- Alice Jones
(5, 'Cancelled'), -- Bob Brown
(6, 'Pending'),   -- Charlie White
(7, 'Shipped'),   -- Dave Black
(8, 'Delivered'), -- Emma Green
(9, 'Pending'),   -- Frank Yellow
(10, 'Cancelled'),-- Grace Purple
(2, 'Shipped');   -- John Doe (Another order)
GO
INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES 
(1, 1, 2),  -- John bought 2 iPhones
(1, 3, 1),  -- John bought 1 T-shirt
(2, 2, 1),  -- Jane bought 1 Samsung Galaxy
(3, 4, 2),  -- Alice bought 2 Jeans
(4, 5, 1),  -- Bob bought 1 Microwave Oven (but cancelled)
(5, 6, 1),  -- Charlie bought 1 Refrigerator
(6, 7, 3),  -- Dave bought 3 Books
(7, 8, 2),  -- Emma bought 2 Chairs
(8, 9, 1),  -- Frank bought 1 Laptop
(9, 10, 2); -- Grace bought 2 Smartwatches (but cancelled)
GO

