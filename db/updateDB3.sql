USE [BlackShope]
GO
INSERT [dbo].[Cards] ([cardNumber], [blance]) VALUES (1829610572, 1015)
INSERT [dbo].[Cards] ([cardNumber], [blance]) VALUES (3007310431, 985)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [username], [password], [email], [role], [cardNumber]) VALUES (1, N'tan', N'090204', N'conan7aa@gmail.com', N'buyer', 3007310431)
INSERT [dbo].[Users] ([id], [username], [password], [email], [role], [cardNumber]) VALUES (2, N'tantran', N'090204', N'bob@example.com', N'seller', 1829610572)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([id], [buyerId], [productId], [quantity], [status], [orderDate], [paymentStatus]) VALUES (1, 1, 4, 1, N'Pending', CAST(N'2025-03-24T18:32:14.337' AS DateTime), N'Paid')
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[TransferHistory] ON 

INSERT [dbo].[TransferHistory] ([id], [userId], [orderId], [transacsion], [date]) VALUES (1, 1, 1, N'Payment', CAST(N'2025-03-24T18:32:19.297' AS DateTime))
SET IDENTITY_INSERT [dbo].[TransferHistory] OFF
GO
