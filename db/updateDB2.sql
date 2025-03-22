CREATE TABLE Cards (
    cardNumber BIGINT PRIMARY KEY,
    blance INT NOT NULL
);

ALTER TABLE Users
ADD cardNumber BIGINT

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

INSERT INTO Cards (cardNumber, blance)
VALUES (100000002, 0),
(1000000003, 0),
(1000000004, 0)

CREATE TABLE TransferHistory (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT,
    orderId INT,
    transacsion VARCHAR(20),
    date DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_TransferHistory_Users FOREIGN KEY (userId) REFERENCES Users(id),
    CONSTRAINT FK_TransferHistory_Orders FOREIGN KEY (orderId) REFERENCES Orders(id)
);
