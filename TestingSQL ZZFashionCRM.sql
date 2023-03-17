Create Database ZZFashionCRM
Go

Use ZZFashionCRM
GO

/***************************************************************/
/***           Delete tables before creating                 ***/
/***************************************************************/

/* Table: dbo.Response */
if exists (select * from sysobjects 
  where id = object_id('dbo.Response') and sysstat & 0xf = 3)
  drop table dbo.Response
GO

/* Table: dbo.Feedback */
if exists (select * from sysobjects 
  where id = object_id('dbo.Feedback') and sysstat & 0xf = 3)
  drop table dbo.Feedback
GO

/* Table: dbo.CashVoucher */
if exists (select * from sysobjects 
  where id = object_id('dbo.CashVoucher') and sysstat & 0xf = 3)
  drop table dbo.CashVoucher
GO

/* Table: dbo.TransactionItem */
if exists (select * from sysobjects 
  where id = object_id('dbo.TransactionItem') and sysstat & 0xf = 3)
  drop table dbo.TransactionItem
GO

/* Table: dbo.SalesTransaction */
if exists (select * from sysobjects 
  where id = object_id('dbo.SalesTransaction') and sysstat & 0xf = 3)
  drop table dbo.SalesTransaction
GO

/* Table: dbo.Product */
if exists (select * from sysobjects 
  where id = object_id('dbo.Product') and sysstat & 0xf = 3)
  drop table dbo.Product
GO

/* Table: dbo.Customer */
if exists (select * from sysobjects 
  where id = object_id('dbo.Customer') and sysstat & 0xf = 3)
  drop table dbo.Customer
GO

/* Table: dbo.Staff */
if exists (select * from sysobjects 
  where id = object_id('dbo.Staff') and sysstat & 0xf = 3)
  drop table dbo.Staff
GO

/* Table: dbo.Store */
if exists (select * from sysobjects 
  where id = object_id('dbo.Store') and sysstat & 0xf = 3)
  drop table dbo.Store
GO

/***************************************************************/
/***                     Creating tables                     ***/
/***************************************************************/

/* Table: dbo.Store */
CREATE TABLE dbo.Store 
(
  StoreID 			varchar(25),
  Address			varchar(255) 	NOT NULL,
  Country			varchar(50) 	NOT NULL,
  PostalCode		varchar(10) 	NOT NULL,	
  DateOpened		datetime		NOT NULL,
  CONSTRAINT PK_Store PRIMARY KEY CLUSTERED (StoreID)
)
GO

/* Table: dbo.Staff */
CREATE TABLE dbo.Staff
(
  StaffID 	    varchar(20),
  StoreID   	varchar(25) 	NULL,
  SName			varchar(50) 	NOT NULL,
  SGender		char(1) 		NOT NULL	CHECK (SGender IN ('M','F')),
  SAppt			varchar(50) 	NOT NULL,	
  STelNo		varchar(20)		NOT NULL,
  SEmailAddr	varchar(50) 	NOT NULL,	
  SPassword		varchar(20)		NOT NULL,
  CONSTRAINT PK_Staff PRIMARY KEY CLUSTERED (StaffID),
  CONSTRAINT FK_Staff_StoreID FOREIGN KEY (StoreID) REFERENCES dbo.Store(StoreID)
)
GO

/* Table: dbo.Customer */
CREATE TABLE dbo.Customer
(
  MemberID 			char(9),
  MName				varchar(50) 	NOT NULL,
  MGender			char(1) 		NOT NULL	CHECK (MGender IN ('M','F')),
  MBirthDate		datetime		NOT NULL,
  MAddress			varchar(250)	NULL,
  MCountry			varchar(50)		NOT NULL,
  MTelNo			varchar(20)		NULL,
  MEmailAddr		varchar(50)		NULL,
  MPassword			varchar(20)		NOT NULL	DEFAULT ('AbC@123#'),
  CONSTRAINT PK_Customer PRIMARY KEY CLUSTERED (MemberID)
)
GO

/* Table: dbo.Product*/
CREATE TABLE dbo.Product
(
  ProductID 		int IDENTITY (1,1),
  ProductTitle  	varchar(255) 	NOT NULL,
  ProductImage		varchar(255) 	NULL,
  Price				money			NOT NULL,
  EffectiveDate	  	datetime		NOT NULL,
  Obsolete			char(1)			NOT NULL	DEFAULT ('1')	
					CHECK (Obsolete IN ('0','1')),
  CONSTRAINT PK_Product PRIMARY KEY CLUSTERED (ProductID)
)
GO

/* Table: dbo.SalesTransaction */
CREATE TABLE dbo.SalesTransaction
(
 TransactionID		int IDENTITY (1,1),
 StoreID 			varchar(25)	NOT NULL,
 MemberID 			char(9)		NULL,
 SubTotal			money		NOT NULL DEFAULT (0),
 Tax				money		NOT NULL DEFAULT (0),
 DiscountPercent	float		NOT NULL DEFAULT (0),
 DiscountAmt		money		NOT NULL DEFAULT (0),
 Total				money		NOT NULL DEFAULT (0),
 DateCreated	 	datetime 	NOT NULL DEFAULT (getdate()),
 CONSTRAINT PK_SalesTransaction PRIMARY KEY CLUSTERED (TransactionID),
 CONSTRAINT FK_SalesTransaction_StoreID  FOREIGN KEY (StoreID) 
 REFERENCES dbo.Store(StoreID),
 CONSTRAINT FK_SalesTransaction_MemberID  FOREIGN KEY (MemberID) 
 REFERENCES dbo.Customer(MemberID)
)
GO

/* Table: dbo.TransactionItem */
CREATE TABLE dbo.TransactionItem
(
  TransactionID		int  	NOT NULL,
  ProductID			int		NOT NULL,
  Price 			money	NOT NULL,
  Quantity 			int		NOT NULL,
  CONSTRAINT FK_TransactionItem_TransactionID FOREIGN KEY (TransactionID) 
  REFERENCES dbo.SalesTransaction(TransactionID),
  CONSTRAINT FK_TransactionItem_ProductID  FOREIGN KEY (ProductID) 
  REFERENCES dbo.Product(ProductID)
)
GO

/* Table: dbo.CashVoucher */
CREATE TABLE dbo.CashVoucher
(
  IssuingID			int IDENTITY (1,1),
  MemberID 			char(9)		NOT NULL, 
  Amount			money		NOT NULL	DEFAULT (20.0),
  MonthIssuedFor	int			NOT NULL,
  YearIssuedFor		int			NOT NULL,
  DateTimeIssued	datetime	NOT NULL	DEFAULT (getdate()),
  VoucherSN			varchar(30)	NULL,
  [Status]			char(1)		NOT NULL	DEFAULT ('0')
					CHECK ([Status] IN ('0','1','2')),  
  DateTimeRedeemed	datetime	NULL,
  CONSTRAINT PK_CashVoucher PRIMARY KEY CLUSTERED (IssuingID),
  CONSTRAINT FK_CashVoucher_MemberID FOREIGN KEY (MemberID) 
  REFERENCES dbo.Customer(MemberID)
)
GO

/* Table: dbo.Feedback */
CREATE TABLE dbo.Feedback
(
  FeedbackID		int IDENTITY (1,1),
  MemberID 			char(9)			NOT NULL, 
  DateTimePosted	datetime		NOT NULL 	DEFAULT (getdate()),
  Title				varchar (255)	NOT NULL,	  
  [Text] 			text 			NULL,
  ImageFileName		varchar (255)	NULL,
  CONSTRAINT PK_Feedback PRIMARY KEY CLUSTERED (FeedbackID),
  CONSTRAINT FK_Feedback_MemberID FOREIGN KEY (MemberID) 
  REFERENCES dbo.Customer(MemberID)
)
GO

/* Table: dbo.Response*/
CREATE TABLE dbo.Response
(
  ResponseID		int IDENTITY (1,1),
  FeedbackID 		int			NOT NULL, 
  MemberID 			char(9)		NULL,
  StaffID 			varchar(20)	NULL,
  DateTimePosted	datetime	NOT NULL	DEFAULT (getdate()),
  [Text] 			text 		NOT NULL,
  CONSTRAINT PK_Response PRIMARY KEY CLUSTERED (ResponseID),
  CONSTRAINT FK_Response_FeedbackID FOREIGN KEY (FeedbackID) 
  REFERENCES dbo.Feedback(FeedbackID),
  CONSTRAINT FK_Response_MemberID FOREIGN KEY (MemberID) 
  REFERENCES dbo.Customer(MemberID),
  CONSTRAINT FK_Response_StaffID FOREIGN KEY (StaffID) 
  REFERENCES dbo.Staff(StaffID)
)
GO


/***************************************************************/
/***              Load the tables with sample data           ***/
/***************************************************************/

/*****  Create records in Store Table *****/
INSERT [dbo].[Store] ([StoreID], [Address], [Country], [PostalCode], [DateOpened]) VALUES ('SG-Orchard', '10, Orchard Road', 'Singapore', '238810', '1-Jan-1990')
INSERT [dbo].[Store] ([StoreID], [Address], [Country], [PostalCode], [DateOpened]) VALUES ('SG-Jurong', '1 Jurong West Central 2, Jurong Point #01-20 ', 'Singapore', '648886', '01-Jun-2005')
INSERT [dbo].[Store] ([StoreID], [Address], [Country], [PostalCode], [DateOpened]) VALUES ('SG-Bishan', '9 Bishan Place Junction 8 Shopping Centre #03-88', 'Singapore', '579837', '01-Aug-2008')

/*****  Create records in Staff Table *****/
INSERT [dbo].[Staff] ([StaffID], [StoreID], [SName], [SGender], [SAppt], [STelNo], [SEmailAddr], [SPassword]) VALUES ('SG-Orchard', 'SG-Orchard', 'Samatha Tan', 'F', 'Sales Personnel', '64561234', 'st@zzf.com.sg', 'passSales')
INSERT [dbo].[Staff] ([StaffID], [StoreID], [SName], [SGender], [SAppt], [STelNo], [SEmailAddr], [SPassword]) VALUES ('SG-Jurong', 'SG-Jurong', 'Pinky Pander', 'F', 'Sales Personnel', '64561235', 'pp@zzf.com.sg', 'passSales')
INSERT [dbo].[Staff] ([StaffID], [StoreID], [SName], [SGender], [SAppt], [STelNo], [SEmailAddr], [SPassword]) VALUES ('SG-Bishan', 'SG-Bishan', 'Edward Lee', 'M', 'Sales Personnel', '64561236', 'el@zzf.com.sg', 'passSales')
INSERT [dbo].[Staff] ([StaffID], [StoreID], [SName], [SGender], [SAppt], [STelNo], [SEmailAddr], [SPassword]) VALUES ('ProductManager', NULL, 'Jenifer Greenspan', 'F', 'Product Manager', '64561237', 'jg@zzf.com.sg', 'passProduct')
INSERT [dbo].[Staff] ([StaffID], [StoreID], [SName], [SGender], [SAppt], [STelNo], [SEmailAddr], [SPassword]) VALUES ('Marketing', NULL, 'Ali Imran', 'M', 'Marketing Personnel', '64561238', 'ai@zzf.com.sg', 'passMarketing')

/*****  Create records in Customer Table *****/
INSERT [dbo].[Customer] ([MemberID], [MName], [MGender], [MBirthDate], [MAddress], [MCountry], [MTelNo], [MEmailAddr], [MPassword]) VALUES ('M00000001', 'Benjamin Bean', 'M', '05-May-1970', NULL, 'United Kingdom', '94609901', NULL, 'pass1234')
INSERT [dbo].[Customer] ([MemberID], [MName], [MGender], [MBirthDate], [MAddress], [MCountry], [MTelNo], [MEmailAddr], [MPassword]) VALUES ('M00000002', 'Fatimah Bte Ahmad', 'F', '21-Jun-1992', '100, Bukit Timah Road', 'Singapore', '91234567', 'fa92@yahoo.com', 'AbC@123#')
INSERT [dbo].[Customer] ([MemberID], [MName], [MGender], [MBirthDate], [MAddress], [MCountry], [MTelNo], [MEmailAddr], [MPassword]) VALUES ('M00000003', 'Peter Ghim', 'M', '31-Aug-1991', '203, Jalan Wong Ah Fok, Johor Bahru', 'Malaysia', '98765432', 'pg91@hotmail.com', 'pgPass')
INSERT [dbo].[Customer] ([MemberID], [MName], [MGender], [MBirthDate], [MAddress], [MCountry], [MTelNo], [MEmailAddr], [MPassword]) VALUES ('M00000004', 'Xu Yazhi', 'F', '25-Dec-1980', NULL, 'China', NULL, 'xyz@np.edu.sg', 'xyz')
INSERT [dbo].[Customer] ([MemberID], [MName], [MGender], [MBirthDate], [MAddress], [MCountry], [MTelNo], [MEmailAddr], [MPassword]) VALUES ('M00000005', 'Eliza Wong', 'F', '24-Jul-1993', 'Blk 123, #10-321, Hougang Ave 2', 'Singapore', NULL, NULL, 'pass1234')
INSERT [dbo].[Customer] ([MemberID], [MName], [MGender], [MBirthDate], [MAddress], [MCountry], [MTelNo], [MEmailAddr], [MPassword]) VALUES ('M00000006', 'K Kannan', 'M', '12-Sep-1990', NULL, 'India', NULL, '20100134@np.edu.sg', 'pass1234')

/*****  Create records in Product Table *****/
SET IDENTITY_INSERT [dbo].[Product] ON 
INSERT [dbo].[Product] ([ProductID], [ProductTitle], [ProductImage], [Price], [EffectiveDate], [Obsolete]) VALUES (1, 'EMBROIDERED DRESS', '1381043712_1_1_3.jpg', 139.0000, '02-May-2022', '1')
INSERT [dbo].[Product] ([ProductID], [ProductTitle], [ProductImage], [Price], [EffectiveDate], [Obsolete]) VALUES (2, 'FLORAL PRINT PENCIL SKIRT', '2705273400_1_1_3.jpg', 79.9000, '01-Jun-2022', '1')
INSERT [dbo].[Product] ([ProductID], [ProductTitle], [ProductImage], [Price], [EffectiveDate], [Obsolete]) VALUES (3, 'BLUE TIGER SWEATSHIRT', '5644031413_1_1_3.jpg', 69.9000, '15-May-2021', '1')
INSERT [dbo].[Product] ([ProductID], [ProductTitle], [ProductImage], [Price], [EffectiveDate], [Obsolete]) VALUES (4, 'BLAZER WITH ROLL-UP CUFFS ', '2070239550_1_1_3.jpg', 109.0000, '01-Apr-2022', '1')
INSERT [dbo].[Product] ([ProductID], [ProductTitle], [ProductImage], [Price], [EffectiveDate], [Obsolete]) VALUES (5, 'PARROTS T-SHIRT ', '0722437052_1_1_3.jpg', 45.9000, '12-Jun-2022', '1')
INSERT [dbo].[Product] ([ProductID], [ProductTitle], [ProductImage], [Price], [EffectiveDate], [Obsolete]) VALUES (6, 'COLORED STRIPED COTTON SWEATER ', '0367420800_1_1_3.jpg', 69.9000, '01-Jul-2022', '1')
INSERT [dbo].[Product] ([ProductID], [ProductTitle], [ProductImage], [Price], [EffectiveDate], [Obsolete]) VALUES (7, 'NEON JACKET', '9815401617_1_1_3.jpg', 139.0000, '07-Jul-2022', '1')
INSERT [dbo].[Product] ([ProductID], [ProductTitle], [ProductImage], [Price], [EffectiveDate], [Obsolete]) VALUES (8, 'PRINTED CAMOUFLAGE BERMUDAS', '6917485615_1_1_3.jpg', 79.9000, '01-Mar-2021', '0')
INSERT [dbo].[Product] ([ProductID], [ProductTitle], [ProductImage], [Price], [EffectiveDate], [Obsolete]) VALUES (9, 'TOP WITH ASYMMETRIC HEM ', '2669795710_1_1_3.jpg', 79.9000, '27-May-2022', '1')
SET IDENTITY_INSERT [dbo].[Product] OFF

/*****  Create records in SalesTransaction Table *****/
SET IDENTITY_INSERT [dbo].[SalesTransaction] ON
INSERT [dbo].[SalesTransaction] ([TransactionID], [StoreID], [MemberID], [SubTotal], [Tax], [DiscountPercent], [DiscountAmt], [Total],[DateCreated]) VALUES (1, 'SG-Orchard', 'M00000004', 536.7000, 37.5700, 10.0, 57.4300, 516.8400, '24-Apr-2022')
INSERT [dbo].[SalesTransaction] ([TransactionID], [StoreID], [MemberID], [SubTotal], [Tax], [DiscountPercent], [DiscountAmt], [Total],[DateCreated]) VALUES (2, 'SG-Bishan', 'M00000005', 218.0000, 15.2600, 10.0, 23.3300, 209.9300, '25-Apr-2022')
INSERT [dbo].[SalesTransaction] ([TransactionID], [StoreID], [MemberID], [SubTotal], [Tax], [DiscountPercent], [DiscountAmt], [Total],[DateCreated]) VALUES (3, 'SG-Orchard', 'M00000001', 357.0000, 24.9900, 25.0, 95.5000, 286.4900, '10-May-2022')
INSERT [dbo].[SalesTransaction] ([TransactionID], [StoreID], [MemberID], [SubTotal], [Tax], [DiscountPercent], [DiscountAmt], [Total],[DateCreated]) VALUES (4, 'SG-Jurong', 'M00000002', 566.7000, 39.6700, 10.0, 60.6400, 545.6300, '15-May-2022')
INSERT [dbo].[SalesTransaction] ([TransactionID], [StoreID], [MemberID], [SubTotal], [Tax], [DiscountPercent], [DiscountAmt], [Total],[DateCreated]) VALUES (5, 'SG-Jurong', 'M00000002', -69.9000, -4.8900, 10.0, -7.4800, -67.3100, '16-May-2022')
INSERT [dbo].[SalesTransaction] ([TransactionID], [StoreID], [MemberID], [SubTotal], [Tax], [DiscountPercent], [DiscountAmt], [Total],[DateCreated]) VALUES (6, 'SG-Bishan', 'M00000001', 319.6000, 22.3700, 25.0, 85.4900, 256.4800, '27-May-2022')
INSERT [dbo].[SalesTransaction] ([TransactionID], [StoreID], [MemberID], [SubTotal], [Tax], [DiscountPercent], [DiscountAmt], [Total],[DateCreated]) VALUES (7, 'SG-Orchard', NULL, 79.9000, 5.5900, 0.0, 0.0000, 85.4900, '27-May-2022')
INSERT [dbo].[SalesTransaction] ([TransactionID], [StoreID], [MemberID], [SubTotal], [Tax], [DiscountPercent], [DiscountAmt], [Total],[DateCreated]) VALUES (8, 'SG-Orchard', 'M00000003', 218.9000, 15.3200, 10.0, 23.4200, 210.8000, '30-May-2022')
INSERT [dbo].[SalesTransaction] ([TransactionID], [StoreID], [MemberID], [SubTotal], [Tax], [DiscountPercent], [DiscountAmt], [Total],[DateCreated]) VALUES (9, 'SG-Orchard', 'M00000006', 79.9000, 5.5900, 10.0, 8.5500, 76.9400, '02-Jun-2022')
INSERT [dbo].[SalesTransaction] ([TransactionID], [StoreID], [MemberID], [SubTotal], [Tax], [DiscountPercent], [DiscountAmt], [Total],[DateCreated]) VALUES (10, 'SG-Jurong', 'M00000002', 251.6000, 17.6100, 25.0, 67.3000, 201.9100, '12-Jun-2022')
SET IDENTITY_INSERT [dbo].[SalesTransaction] OFF

/*****  Create records in TransactionItem Table *****/
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (1, 3, 69.9000, 3)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (1, 4, 109.0000, 3)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (2, 4, 109.0000, 2)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (3, 1, 139.0000, 1)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (3, 4, 109.0000, 2)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (4, 1, 139.0000, 1)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (4, 3, 69.9000, 2)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (4, 4, 109.0000, 2)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (6, 9, 79.9000, 4)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (7, 9, 79.9000, 1)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (8, 9, 79.9000, 1)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (8, 1, 139.0000, 1)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (9, 2, 79.9000, 1)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (10, 5, 45.9000, 2)
INSERT [dbo].[TransactionItem] ([TransactionID], [ProductID], [Price], [Quantity]) VALUES (10, 2, 79.9000, 2)

/*****  Create records in CashVoucher Table *****/
SET IDENTITY_INSERT [dbo].[CashVoucher] ON
INSERT [dbo].[CashVoucher] ([IssuingID], [MemberID], [Amount], [MonthIssuedFor], [YearIssuedFor], [DateTimeIssued], [VoucherSN], [Status], [DateTimeRedeemed]) VALUES (1, 'M00000004', 20.0000, 4, 2022, '01-May-2022', '2022-05-000001', '2', '21-May-2022')
INSERT [dbo].[CashVoucher] ([IssuingID], [MemberID], [Amount], [MonthIssuedFor], [YearIssuedFor], [DateTimeIssued], [VoucherSN], [Status], [DateTimeRedeemed]) VALUES (2, 'M00000004', 20.0000, 4, 2022, '01-May-2022', '2022-05-000002', '1', NULL)
INSERT [dbo].[CashVoucher] ([IssuingID], [MemberID], [Amount], [MonthIssuedFor], [YearIssuedFor], [DateTimeIssued], [VoucherSN], [Status], [DateTimeRedeemed]) VALUES (3, 'M00000005', 20.0000, 4, 2022, '01-May-2022', NULL, '0', NULL)
SET IDENTITY_INSERT [dbo].[CashVoucher] OFF

/*****  Create records in Feedback Table *****/
SET IDENTITY_INSERT [dbo].[Feedback] ON
INSERT [dbo].[Feedback] ([FeedbackID], [MemberID], [DateTimePosted], [Title], [Text], [ImageFileName]) 
VALUES (1, 'M00000005', '25-Apr-2022', 'Good Customer Service', 'Sales Personnel Mr Edward Lee at Bishan Bramch was excellent in providing customer service.  He had good knowledge in explaining the design ideas of various fashions, as well as maintaining patient and always wears a smiling face even though I had been fussy in choosing the right fashion for me.', NULL)
INSERT [dbo].[Feedback] ([FeedbackID], [MemberID], [DateTimePosted], [Title], [Text], [ImageFileName]) 
VALUES (2, 'M00000002', '15-May-2022', 'Flaw in Product', 'One out of the three Blue Tiger Sweatshirts I bought today seemed to have the colour of the design faded off after washing.', NULL)
SET IDENTITY_INSERT [dbo].[Feedback] OFF

/*****  Create records in Response Table *****/
SET IDENTITY_INSERT [dbo].[Response] ON
INSERT [dbo].[Response] ([ResponseID], [FeedbackID], [MemberID], [StaffID], [DateTimePosted], [Text]) 
VALUES (1, 1, NULL, 'Marketing', '27-Apr-2022', 'Thanks for your compliment, I have already share your feedback to Mr Edward Lee and all of our sales staff. Your valuable feedback will help to motivate our staff members in providing excellent customer service.')
INSERT [dbo].[Response] ([ResponseID], [FeedbackID], [MemberID], [StaffID], [DateTimePosted], [Text]) 
VALUES (2, 2, NULL, 'Marketing', '15-May-2022', 'We are sorry that you had purchased a flawed product that had went through our quality control system.  We will investigate this matter and hope to prevent this type of cases in future.  You can bring the flawed product (with receipt) to any of our branches to get a refund.')
INSERT [dbo].[Response] ([ResponseID], [FeedbackID], [MemberID], [StaffID], [DateTimePosted], [Text]) 
VALUES (3, 2, 'M00000002', NULL, '16-May-2022', 'I had returned the flawed product to ZZ Fashion Jurong Branch and got full refund. I am impressed with the good customer service provided by your staff.')
SET IDENTITY_INSERT [dbo].[Response] OFF


Select * from Customer
Select * from Store
Select * from Staff
Select * from Product
Select * from SalesTransaction
Select * from TransactionItem
Select * from CashVoucher
Select * from Feedback
Select * from Response


