USE [master]
GO
/****** Object:  Database [ZZFashionCRM]    Script Date: 17/03/2023 15:46:50 ******/
CREATE DATABASE [ZZFashionCRM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ZZFashionCRM', FILENAME = N'C:\Users\jinka\ZZFashionCRM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ZZFashionCRM_log', FILENAME = N'C:\Users\jinka\ZZFashionCRM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ZZFashionCRM] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ZZFashionCRM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ZZFashionCRM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET ARITHABORT OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ZZFashionCRM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ZZFashionCRM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ZZFashionCRM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ZZFashionCRM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ZZFashionCRM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ZZFashionCRM] SET  MULTI_USER 
GO
ALTER DATABASE [ZZFashionCRM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ZZFashionCRM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ZZFashionCRM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ZZFashionCRM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ZZFashionCRM] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ZZFashionCRM] SET QUERY_STORE = OFF
GO
USE [ZZFashionCRM]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [ZZFashionCRM]
GO
/****** Object:  Table [dbo].[CashVoucher]    Script Date: 17/03/2023 15:46:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CashVoucher](
	[IssuingID] [int] IDENTITY(1,1) NOT NULL,
	[MemberID] [char](9) NOT NULL,
	[Amount] [money] NOT NULL,
	[MonthIssuedFor] [int] NOT NULL,
	[YearIssuedFor] [int] NOT NULL,
	[DateTimeIssued] [datetime] NOT NULL,
	[VoucherSN] [varchar](30) NULL,
	[Status] [char](1) NOT NULL,
	[DateTimeRedeemed] [datetime] NULL,
 CONSTRAINT [PK_CashVoucher] PRIMARY KEY CLUSTERED 
(
	[IssuingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 17/03/2023 15:46:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[MemberID] [char](9) NOT NULL,
	[MName] [varchar](50) NOT NULL,
	[MGender] [char](1) NOT NULL,
	[MBirthDate] [datetime] NOT NULL,
	[MAddress] [varchar](250) NULL,
	[MCountry] [varchar](50) NOT NULL,
	[MTelNo] [varchar](20) NULL,
	[MEmailAddr] [varchar](50) NULL,
	[MPassword] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 17/03/2023 15:46:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[FeedbackID] [int] IDENTITY(1,1) NOT NULL,
	[MemberID] [char](9) NOT NULL,
	[DateTimePosted] [datetime] NOT NULL,
	[Title] [varchar](255) NOT NULL,
	[Text] [text] NULL,
	[ImageFileName] [varchar](255) NULL,
 CONSTRAINT [PK_Feedback] PRIMARY KEY CLUSTERED 
(
	[FeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 17/03/2023 15:46:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductTitle] [varchar](255) NOT NULL,
	[ProductImage] [varchar](255) NULL,
	[Price] [money] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[Obsolete] [char](1) NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Response]    Script Date: 17/03/2023 15:46:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Response](
	[ResponseID] [int] IDENTITY(1,1) NOT NULL,
	[FeedbackID] [int] NOT NULL,
	[MemberID] [char](9) NULL,
	[StaffID] [varchar](20) NULL,
	[DateTimePosted] [datetime] NOT NULL,
	[Text] [text] NOT NULL,
 CONSTRAINT [PK_Response] PRIMARY KEY CLUSTERED 
(
	[ResponseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesTransaction]    Script Date: 17/03/2023 15:46:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesTransaction](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [varchar](25) NOT NULL,
	[MemberID] [char](9) NULL,
	[SubTotal] [money] NOT NULL,
	[Tax] [money] NOT NULL,
	[DiscountPercent] [float] NOT NULL,
	[DiscountAmt] [money] NOT NULL,
	[Total] [money] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesTransaction] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 17/03/2023 15:46:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[StaffID] [varchar](20) NOT NULL,
	[StoreID] [varchar](25) NULL,
	[SName] [varchar](50) NOT NULL,
	[SGender] [char](1) NOT NULL,
	[SAppt] [varchar](50) NOT NULL,
	[STelNo] [varchar](20) NOT NULL,
	[SEmailAddr] [varchar](50) NOT NULL,
	[SPassword] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[StaffID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Store]    Script Date: 17/03/2023 15:46:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[StoreID] [varchar](25) NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[Country] [varchar](50) NOT NULL,
	[PostalCode] [varchar](10) NOT NULL,
	[DateOpened] [datetime] NOT NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionItem]    Script Date: 17/03/2023 15:46:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionItem](
	[TransactionID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[Quantity] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CashVoucher] ADD  DEFAULT ((20.0)) FOR [Amount]
GO
ALTER TABLE [dbo].[CashVoucher] ADD  DEFAULT (getdate()) FOR [DateTimeIssued]
GO
ALTER TABLE [dbo].[CashVoucher] ADD  DEFAULT ('0') FOR [Status]
GO
ALTER TABLE [dbo].[Customer] ADD  DEFAULT ('AbC@123#') FOR [MPassword]
GO
ALTER TABLE [dbo].[Feedback] ADD  DEFAULT (getdate()) FOR [DateTimePosted]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ('1') FOR [Obsolete]
GO
ALTER TABLE [dbo].[Response] ADD  DEFAULT (getdate()) FOR [DateTimePosted]
GO
ALTER TABLE [dbo].[SalesTransaction] ADD  DEFAULT ((0)) FOR [SubTotal]
GO
ALTER TABLE [dbo].[SalesTransaction] ADD  DEFAULT ((0)) FOR [Tax]
GO
ALTER TABLE [dbo].[SalesTransaction] ADD  DEFAULT ((0)) FOR [DiscountPercent]
GO
ALTER TABLE [dbo].[SalesTransaction] ADD  DEFAULT ((0)) FOR [DiscountAmt]
GO
ALTER TABLE [dbo].[SalesTransaction] ADD  DEFAULT ((0)) FOR [Total]
GO
ALTER TABLE [dbo].[SalesTransaction] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[CashVoucher]  WITH CHECK ADD  CONSTRAINT [FK_CashVoucher_MemberID] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Customer] ([MemberID])
GO
ALTER TABLE [dbo].[CashVoucher] CHECK CONSTRAINT [FK_CashVoucher_MemberID]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_MemberID] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Customer] ([MemberID])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_MemberID]
GO
ALTER TABLE [dbo].[Response]  WITH CHECK ADD  CONSTRAINT [FK_Response_FeedbackID] FOREIGN KEY([FeedbackID])
REFERENCES [dbo].[Feedback] ([FeedbackID])
GO
ALTER TABLE [dbo].[Response] CHECK CONSTRAINT [FK_Response_FeedbackID]
GO
ALTER TABLE [dbo].[Response]  WITH CHECK ADD  CONSTRAINT [FK_Response_MemberID] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Customer] ([MemberID])
GO
ALTER TABLE [dbo].[Response] CHECK CONSTRAINT [FK_Response_MemberID]
GO
ALTER TABLE [dbo].[Response]  WITH CHECK ADD  CONSTRAINT [FK_Response_StaffID] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([StaffID])
GO
ALTER TABLE [dbo].[Response] CHECK CONSTRAINT [FK_Response_StaffID]
GO
ALTER TABLE [dbo].[SalesTransaction]  WITH CHECK ADD  CONSTRAINT [FK_SalesTransaction_MemberID] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Customer] ([MemberID])
GO
ALTER TABLE [dbo].[SalesTransaction] CHECK CONSTRAINT [FK_SalesTransaction_MemberID]
GO
ALTER TABLE [dbo].[SalesTransaction]  WITH CHECK ADD  CONSTRAINT [FK_SalesTransaction_StoreID] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([StoreID])
GO
ALTER TABLE [dbo].[SalesTransaction] CHECK CONSTRAINT [FK_SalesTransaction_StoreID]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_StoreID] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([StoreID])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_StoreID]
GO
ALTER TABLE [dbo].[TransactionItem]  WITH CHECK ADD  CONSTRAINT [FK_TransactionItem_ProductID] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[TransactionItem] CHECK CONSTRAINT [FK_TransactionItem_ProductID]
GO
ALTER TABLE [dbo].[TransactionItem]  WITH CHECK ADD  CONSTRAINT [FK_TransactionItem_TransactionID] FOREIGN KEY([TransactionID])
REFERENCES [dbo].[SalesTransaction] ([TransactionID])
GO
ALTER TABLE [dbo].[TransactionItem] CHECK CONSTRAINT [FK_TransactionItem_TransactionID]
GO
ALTER TABLE [dbo].[CashVoucher]  WITH CHECK ADD CHECK  (([Status]='2' OR [Status]='1' OR [Status]='0'))
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD CHECK  (([MGender]='F' OR [MGender]='M'))
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD CHECK  (([Obsolete]='1' OR [Obsolete]='0'))
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD CHECK  (([SGender]='F' OR [SGender]='M'))
GO
USE [master]
GO
ALTER DATABASE [ZZFashionCRM] SET  READ_WRITE 
GO
