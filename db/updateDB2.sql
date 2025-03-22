CREATE TABLE Cards (
    cardNumber BIGINT PRIMARY KEY,
    blance INT NOT NULL
);
go
ALTER TABLE Users
ADD cardNumber BIGINT
go
alter table Products
add price smallmoney
go
ALTER TABLE Orders
ADD paymentStatus NVARCHAR(10) DEFAULT 'Unpaid' 
CHECK (paymentStatus IN ('Paid', 'Unpaid'));

go
ALTER TABLE Users
ADD FOREIGN KEY (cardNumber) REFERENCES Cards(cardNumber);



GO
CREATE PROCEDURE AddUserWithCard
    @username NVARCHAR(50),
    @password NVARCHAR(255),
    @email NVARCHAR(100),
    @role NVARCHAR(20),
    @blance INT = 1000
AS
BEGIN
    DECLARE @cardNumber BIGINT;

    -- Generate random 10-digit cardNumber using NEWID()
    SET @cardNumber = CAST((ABS(CHECKSUM(NEWID())) % 9000000000) + 1000000000 AS BIGINT);

    -- Ensure cardNumber is unique
    WHILE EXISTS (SELECT 1 FROM Cards WHERE cardNumber = @cardNumber)
    BEGIN
        SET @cardNumber = CAST((ABS(CHECKSUM(NEWID())) % 9000000000) + 1000000000 AS BIGINT);
    END

    -- Insert card
    INSERT INTO Cards (cardNumber, blance)
    VALUES (@cardNumber, @blance);

    -- Insert user
    INSERT INTO Users (username, password, email, cardNumber, role)
    VALUES (@username, @password, @email, @cardNumber, @role);
END;


CREATE TABLE TransferHistory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT,
    orderId INT,
    transacsion VARCHAR(20),
    date DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_TransferHistory_Users FOREIGN KEY (userId) REFERENCES Users(id),
    CONSTRAINT FK_TransferHistory_Orders FOREIGN KEY (orderId) REFERENCES Orders(id)
);
GO
CREATE TRIGGER trg_UpdateProductQuantity
ON Orders
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Kiểm tra nếu số lượng sản phẩm đủ để đặt hàng
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Products p ON i.productId = p.id
        WHERE p.quantity < i.quantity
    )
    BEGIN
        -- Nếu không đủ, rollback giao dịch
        RAISERROR ('Not enough product quantity available.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- Giảm số lượng sản phẩm sau khi đơn hàng được tạo
    UPDATE Products
    SET quantity = p.quantity - i.quantity
    FROM Products p
    JOIN inserted i ON p.id = i.productId;
END;
GO




if OBJECT_ID('PayOrder','P') is not null 
drop proc PayOrder;
go
CREATE PROCEDURE PayOrder
    @sellerId INT,
    @buyerId INT,
    @quantity INT,
    @price smallmoney,
    @orderId int
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @totalPrice FLOAT;
    DECLARE @buyerCard BIGINT, @buyerBalance INT;
    DECLARE @sellerCard BIGINT, @sellerBalance INT;
    DECLARE @productId INT;


    -- Tính tổng tiền
    SET @totalPrice = @quantity * @price;

    -- Lấy thông tin thẻ và số dư của người mua
    SELECT @buyerCard = u.cardNumber, @buyerBalance = c.blance
    FROM Users u
    JOIN Cards c ON u.cardNumber = c.cardNumber
    WHERE u.id = @buyerId;

    -- Kiểm tra số dư người mua
    IF @buyerBalance < @totalPrice
    BEGIN
        RAISERROR ('Buyer does not have enough balance.', 16, 1);
        RETURN;
    END;

    -- Lấy thông tin thẻ và số dư của người bán
    SELECT @sellerCard = u.cardNumber, @sellerBalance = c.blance
    FROM Users u
    JOIN Cards c ON u.cardNumber = c.cardNumber
    WHERE u.id = @sellerId;

    -- Kiểm tra sản phẩm có tồn tại và đủ số lượng hay không
    SELECT @productId = id
    FROM Products
    WHERE sellerId = @sellerId AND quantity >= @quantity;

    IF @productId IS NULL
    BEGIN
        RAISERROR ('Seller does not have enough stock.', 16, 1);
        RETURN;
    END;

    -- Bắt đầu transaction
    BEGIN TRANSACTION;

    -- Trừ tiền người mua
    UPDATE Cards
    SET blance = blance - @totalPrice
    WHERE cardNumber = @buyerCard;

    -- Cộng tiền cho người bán
    UPDATE Cards
    SET blance = blance + @totalPrice
    WHERE cardNumber = @sellerCard;

    -- Giảm số lượng sản phẩm trong kho
    UPDATE Products
    SET quantity = quantity - @quantity
    WHERE id = @productId;
    UPDATE Orders
    SET paymentStatus = 'Paid' 
    where id = @orderId
    -- Ghi vào lịch sử giao dịch
    INSERT INTO TransferHistory (userId, orderId, transacsion)
    VALUES (@buyerId, @orderId, 'Payment'); -- Không có orderId vì đây là giao dịch trực tiếp

    -- Hoàn tất giao dịch
    COMMIT TRANSACTION;
END;

