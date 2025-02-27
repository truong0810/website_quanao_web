USE [master]
GO
/****** Object:  Database [PnpWeb]    Script Date: 18/02/2025 10:13:20 CH ******/
CREATE DATABASE [PnpWeb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PnpWeb', FILENAME = N'D:\SQL\MSSQL15.SQLEXPRESS\MSSQL\DATA\PnpWeb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PnpWeb_log', FILENAME = N'D:\SQL\MSSQL15.SQLEXPRESS\MSSQL\DATA\PnpWeb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PnpWeb] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PnpWeb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PnpWeb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PnpWeb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PnpWeb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PnpWeb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PnpWeb] SET ARITHABORT OFF 
GO
ALTER DATABASE [PnpWeb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PnpWeb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PnpWeb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PnpWeb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PnpWeb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PnpWeb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PnpWeb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PnpWeb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PnpWeb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PnpWeb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PnpWeb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PnpWeb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PnpWeb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PnpWeb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PnpWeb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PnpWeb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PnpWeb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PnpWeb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PnpWeb] SET  MULTI_USER 
GO
ALTER DATABASE [PnpWeb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PnpWeb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PnpWeb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PnpWeb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PnpWeb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PnpWeb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PnpWeb] SET QUERY_STORE = OFF
GO
USE [PnpWeb]
GO
/****** Object:  User [pnp]    Script Date: 18/02/2025 10:13:20 CH ******/
CREATE USER [pnp] FOR LOGIN [pnp] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [pnp]
GO
/****** Object:  UserDefinedFunction [dbo].[Func_GetProductPricePrecent]    Script Date: 18/02/2025 10:13:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Func_GetProductPricePrecent]
(
	@ProductId uniqueidentifier
)
RETURNS decimal
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Price decimal = 0
	select top 1 @Price = PP.Price from ProductPrice PP
	where PP.ProductId = @ProductId and PP.StartDate < GETDATE() and PP.EndDate > GETDATE()
	return @Price
END
GO
/****** Object:  Table [dbo].[BlogImage]    Script Date: 18/02/2025 10:13:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogImage](
	[Id] [uniqueidentifier] NOT NULL,
	[BlogId] [uniqueidentifier] NULL,
	[BlogImageId] [uniqueidentifier] NULL,
	[SortIndex] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogOfCategory]    Script Date: 18/02/2025 10:13:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogOfCategory](
	[Id] [uniqueidentifier] NOT NULL,
	[BlogId] [uniqueidentifier] NULL,
	[BlogCategoryId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_BlogOfCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 18/02/2025 10:13:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Text] [nvarchar](max) NULL,
	[BlogDate] [datetime] NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
	[UpdatedDate] [datetime] NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogTag]    Script Date: 18/02/2025 10:13:20 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogTag](
	[Id] [uniqueidentifier] NOT NULL,
	[BlogId] [uniqueidentifier] NULL,
	[TagId] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Blog]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create VIew [dbo].[View_Blog]
As select
b.*,
bi.BlogImageId,
bt.TagId,
bc.BlogCategoryId
from 
Blog b
left join 
BlogImage bi on bi.BlogId = b.Id
left join 
BlogOfCategory bc on bc.BlogId = b.Id
left join 
BlogTag bt on bt.BlogId = b.Id
GO
/****** Object:  Table [dbo].[Product]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](200) NULL,
	[Description] [nvarchar](max) NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[BrandId] [uniqueidentifier] NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
	[UpdatedAt] [datetime] NULL,
	[Title] [nvarchar](500) NULL,
	[IsHot] [bit] NULL,
	[PrimaryImageId] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brand](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Product]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Product]
AS
SELECT        P.*, B.Name as BrandName, dbo.Func_GetProductPricePrecent(P.Id) as PricePrecent, C.Name as CategoryName
FROM            dbo.Product P
left join Brand B on B.Id = P.BrandId
left join Category C on C.Id = P.CategoryId;
GO
/****** Object:  Table [dbo].[Banner]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banner](
	[Id] [uniqueidentifier] NOT NULL,
	[ImageId] [uniqueidentifier] NULL,
	[Name] [nvarchar](max) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
	[UpdatedDate] [datetime] NULL,
	[SortIndex] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Banner] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogCategory]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogCategory](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
	[UpdatedDate] [datetime] NULL,
	[AvataId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_BlogCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogComment]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogComment](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_BlogComment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[Id] [uniqueidentifier] NOT NULL,
	[CustomerId] [uniqueidentifier] NULL,
	[OrderDate] [datetime] NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[FinalAmount] [decimal](18, 2) NULL,
	[OrderStatus] [int] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
	[Notes] [nvarchar](500) NULL,
	[PaymentStatus] [int] NULL,
	[Address] [nvarchar](max) NULL,
	[Receiver] [nvarchar](max) NULL,
	[Email] [nvarchar](200) NULL,
	[Phone] [varchar](15) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderPayment]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderPayment](
	[Id] [uniqueidentifier] NOT NULL,
	[OrderId] [uniqueidentifier] NULL,
	[Amount] [decimal](18, 2) NULL,
	[PaymentDate] [datetime] NULL,
	[PaymentMethod] [int] NULL,
	[Notes] [nvarchar](500) NULL,
	[PayerName] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderProduct]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProduct](
	[Id] [uniqueidentifier] NOT NULL,
	[OrderId] [uniqueidentifier] NULL,
	[ProductId] [uniqueidentifier] NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderPromotion]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderPromotion](
	[Id] [uniqueidentifier] NOT NULL,
	[PromotionId] [uniqueidentifier] NULL,
	[OrderProductId] [uniqueidentifier] NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[GetQuantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partner]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partner](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[NumberPhone] [nvarchar](50) NULL,
	[Address] [nvarchar](max) NULL,
	[ImageId] [uniqueidentifier] NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[UpdatedAt] [datetime] NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_Partner] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImage]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImage](
	[Id] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NULL,
	[ResourceId] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductPrice]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductPrice](
	[Id] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NULL,
	[Price] [decimal](10, 2) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promotion]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion](
	[Id] [uniqueidentifier] NOT NULL,
	[PromotionName] [nvarchar](200) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[BuyQuantity] [int] NULL,
	[GetQuantity] [int] NULL,
	[DiscountAmount] [decimal](10, 2) NULL,
	[DiscountPercentage] [decimal](10, 2) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedBy] [uniqueidentifier] NULL,
	[UpdatedAt] [datetime] NULL,
	[PromotionType] [int] NULL,
	[IsApplyAll] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PromotionImage]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PromotionImage](
	[Id] [uniqueidentifier] NOT NULL,
	[PromotionId] [uniqueidentifier] NULL,
	[ResourceId] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PromotionProduct]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PromotionProduct](
	[Id] [uniqueidentifier] NOT NULL,
	[PromotionId] [uniqueidentifier] NULL,
	[ProductId] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RefreshToken]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshToken](
	[Id] [uniqueidentifier] NOT NULL,
	[RefreshCode] [nvarchar](max) NULL,
	[RefreshCodeExpire] [datetime] NULL,
	[RefreshCodeCreated] [datetime] NULL,
	[Token] [nvarchar](max) NULL,
	[TokenCreated] [datetime] NULL,
	[UserId] [uniqueidentifier] NULL,
	[UpdatePassword] [datetime] NULL,
	[IsBlock] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resource]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resource](
	[Id] [uniqueidentifier] NOT NULL,
	[FileName] [nvarchar](250) NULL,
	[Extension] [nvarchar](100) NULL,
	[FileType] [nvarchar](100) NULL,
	[FilePath] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Resource] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tag]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tag](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 18/02/2025 10:13:21 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [uniqueidentifier] NOT NULL,
	[Username] [nvarchar](200) NULL,
	[Password] [nvarchar](max) NULL,
	[RoleId] [uniqueidentifier] NULL,
	[IsStaff] [bit] NULL,
	[FullName] [nvarchar](max) NULL,
	[Phone] [nvarchar](150) NULL,
	[Address] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[Actived] [bit] NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK__User__3214EC07C739F52D] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Banner] ([Id], [ImageId], [Name], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [SortIndex]) VALUES (N'cbbcc66e-cc32-428b-a7d8-4d4b503bf7ba', N'7b3eef9c-686c-44c2-b340-5bd7d8242e46', N'banner 4', NULL, CAST(N'2024-12-18T11:10:05.663' AS DateTime), NULL, CAST(N'2025-01-15T22:22:53.827' AS DateTime), CAST(4 AS Decimal(18, 0)))
INSERT [dbo].[Banner] ([Id], [ImageId], [Name], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [SortIndex]) VALUES (N'5d9b158f-fd16-4370-94d1-7d1fdd1dabf8', N'523380ed-a438-449d-b40e-be3a47be05d2', N'banner 1', NULL, CAST(N'2025-01-16T15:53:28.767' AS DateTime), NULL, NULL, CAST(1 AS Decimal(18, 0)))
INSERT [dbo].[Banner] ([Id], [ImageId], [Name], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [SortIndex]) VALUES (N'def452b0-2f29-40ea-95f4-7f28281d2aac', N'a9ba7582-2165-4251-be6f-e491c5ec7669', N'banner 1', NULL, CAST(N'2024-12-18T10:27:14.833' AS DateTime), NULL, CAST(N'2025-01-16T15:53:35.740' AS DateTime), CAST(2 AS Decimal(18, 0)))
INSERT [dbo].[Banner] ([Id], [ImageId], [Name], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [SortIndex]) VALUES (N'913cbaba-d2ba-4c08-8bb0-a03bbbe62fe7', N'a42fae49-e4ff-4b8b-98a7-fd0182359543', N'Banner 3', NULL, CAST(N'2024-12-18T10:27:47.420' AS DateTime), NULL, CAST(N'2025-01-15T22:22:41.390' AS DateTime), CAST(3 AS Decimal(18, 0)))
GO
INSERT [dbo].[Blog] ([Id], [Title], [Text], [BlogDate], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [Description]) VALUES (N'6b75c1fc-e78c-4a96-a1b3-2ab4ac375b77', N'Bài 5', N'abc', CAST(N'2024-12-16T17:00:00.000' AS DateTime), NULL, CAST(N'2024-12-16T17:20:11.967' AS DateTime), NULL, CAST(N'2024-12-16T17:23:24.810' AS DateTime), N'<p>Hello</p><p><br></p><p><img src="http://localhost:5258/api/Resource/get-link-image/6f749b4b-b419-4f65-a000-2c5e82081fe1"></p>')
INSERT [dbo].[Blog] ([Id], [Title], [Text], [BlogDate], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [Description]) VALUES (N'3049eee0-0e6f-4afc-80d4-464673f74a29', N'bài viết 1', N'Bìa viết về sản phẩm', CAST(N'2024-12-09T17:00:00.000' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', CAST(N'2024-12-03T15:43:17.880' AS DateTime), NULL, CAST(N'2024-12-05T09:01:16.173' AS DateTime), N'<h1>Bài viết này về công ty Pnp_Solution</h1><p><br></p><ol><li>Công ty đang trong đà phát triển, mở rộng thêm các dịch vụ</li></ol><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat […]</p><p><br></p><p><br></p><p><img src="http://localhost:5258/api/Resource/get-link-image/cad4fb25-f214-4e7d-97ac-9baf22aabb1e"></p><p><br></p><p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat […]</p>')
INSERT [dbo].[Blog] ([Id], [Title], [Text], [BlogDate], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [Description]) VALUES (N'7ea6206e-2dfd-44d8-922d-71cd9185c794', N'Tài liệu 3', NULL, CAST(N'2024-12-15T17:00:00.000' AS DateTime), NULL, CAST(N'2024-12-06T15:01:20.760' AS DateTime), NULL, CAST(N'2024-12-06T16:30:39.760' AS DateTime), NULL)
INSERT [dbo].[Blog] ([Id], [Title], [Text], [BlogDate], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [Description]) VALUES (N'448ddb9f-33dd-4a94-ab40-a38cc5aadabd', N'Các bài viết giới thiệu công ty ấn tượng nhất', N'Lời giới thiệu đóng vai trò quan trọng vì nó thể hiện rõ nét bộ mặt và sự chuyên nghiệp của một tổ chức. Để giúp bạn có thêm kinh nghiệm trong việc xây dựng nội dung, tạo được sự tin tưởng nơi khách hàng, hãy tham khảo 2 mẫu bài viết giới thiệu về công ty sau đây:', CAST(N'2024-12-15T17:00:00.000' AS DateTime), NULL, CAST(N'2024-12-06T16:35:27.007' AS DateTime), NULL, CAST(N'2024-12-17T09:57:58.387' AS DateTime), N'<h1><strong>Content giới thiệu sơ lược về công ty xây dựng</strong></h1><p><br></p><p>Công ty X là đơn vị hoạt động trong lĩnh vực tư vấn, cung cấp các giải pháp thiết kế và thi công các loạt đá ốp lát cao cấp (marble, granite, nhân tạo…) cho những dự án bất động sản, biệt thự, nhà phố, chung cư, trụ sở công ty…</p><p>Mỗi công trình mà chúng tôi hoàn thành luôn đáp ứng trọn vẹn sự hài lòng từ phía khách hàng. Bởi tất cả đều được thực thi từ sự phối hợp hoàn hảo giữa công năng sử dụng và tính mỹ thuật cao. Chúng tôi cam kết mang đến sự thành công hơn cả mong đợi.</p><p>Từ một doanh nghiệp trẻ được thành lập từ năm 2012, bằng sự nỗ lực không ngừng các cán bộ lãnh đạo kỹ sư và công ngân của công X đã đồng hành cùng nhau đưa doanh nghiệp trở thành đơn vị tư vấn/cung cấp/thiết kế/lắp đặt thi công đá ốp nội ngoại thất chuyên nghiệp bậc nhất thị trường hiện nay.</p><p>Quý khách hàng/ Chủ đầu tư có nhu cầu hợp tác vui lòng liên hệ theo:</p><p><br></p><p><br></p><p><br></p><ul><li>Tên công ty: Công ty cổ phần đầu tư phát triển xây dựng X</li><li>Người đại diện: Giám đốc Nguyễn Văn A</li><li>Địa chỉ văn phòng: Số nhà…, đường…, phố…, quận…, tỉnh/thành phố…</li><li>Website:&nbsp;<a href="https://vn4u.vn/cdn-cgi/l/email-protection" rel="noopener noreferrer" target="_blank">[email&nbsp;protected]</a></li><li>Số điện thoại: 09xxxxxxxx</li></ul><p><img src="http://localhost:5258/api/Resource/get-link-image/6e1feefb-5062-471e-84aa-54c41773c622"></p>')
INSERT [dbo].[Blog] ([Id], [Title], [Text], [BlogDate], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [Description]) VALUES (N'b5425965-2cc3-4b3a-ae4f-b3f310de4f11', N'Bài 3', NULL, NULL, NULL, CAST(N'2024-12-06T15:01:08.353' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Blog] ([Id], [Title], [Text], [BlogDate], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [Description]) VALUES (N'cdf2b6ee-ea2a-4fde-9e35-b9a04a598fbb', N'bài viết 11', N'ok1', CAST(N'2024-12-09T17:00:00.000' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', CAST(N'2024-12-03T11:55:40.450' AS DateTime), NULL, CAST(N'2024-12-04T11:56:45.800' AS DateTime), N'<ul><li>ok1</li></ul>')
INSERT [dbo].[Blog] ([Id], [Title], [Text], [BlogDate], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [Description]) VALUES (N'a92fae90-6f9b-4aaf-9c4b-f30077ebdb4a', N'bài viết 2', NULL, NULL, NULL, CAST(N'2024-12-06T14:58:21.680' AS DateTime), NULL, NULL, NULL)
GO
INSERT [dbo].[BlogCategory] ([Id], [Name], [Description], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [AvataId]) VALUES (N'3bb1280b-5a1b-4e15-9fbf-3b8d9175594c', N'thẻ 5', N'555555', NULL, CAST(N'2024-12-02T13:42:57.767' AS DateTime), NULL, CAST(N'2024-12-11T09:38:27.513' AS DateTime), N'45ed6d2d-264d-4190-a389-eb7936c27ab4')
INSERT [dbo].[BlogCategory] ([Id], [Name], [Description], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [AvataId]) VALUES (N'14210e1e-009e-40ed-af29-c004050b7a58', N'danh mục 3', N'111', NULL, CAST(N'2024-12-02T13:51:04.807' AS DateTime), NULL, CAST(N'2024-12-18T10:26:29.467' AS DateTime), N'899ccd16-df5b-47fa-b4f6-9ce5b0880ede')
INSERT [dbo].[BlogCategory] ([Id], [Name], [Description], [CreatedBy], [CreatedDate], [UpdatedBy], [UpdatedDate], [AvataId]) VALUES (N'741d1a0d-5951-44b4-8433-c35e8e0c6b38', N'danh mục 2', N'ok', NULL, CAST(N'2024-12-02T13:50:42.983' AS DateTime), NULL, CAST(N'2024-12-18T10:26:42.613' AS DateTime), N'325d5fd9-8bcd-43df-9053-ceb8b921ff65')
GO
INSERT [dbo].[BlogImage] ([Id], [BlogId], [BlogImageId], [SortIndex]) VALUES (N'6dae10d9-de68-47f9-a164-07782ed4a77a', N'7ea6206e-2dfd-44d8-922d-71cd9185c794', N'0981cd2c-7db0-41a0-a011-4d3aedd7af9c', NULL)
INSERT [dbo].[BlogImage] ([Id], [BlogId], [BlogImageId], [SortIndex]) VALUES (N'9bb35df1-8d6a-4b95-bdee-7abfc1737318', N'448ddb9f-33dd-4a94-ab40-a38cc5aadabd', N'47155224-d4ed-4de2-ad38-634166b2878c', NULL)
INSERT [dbo].[BlogImage] ([Id], [BlogId], [BlogImageId], [SortIndex]) VALUES (N'8f3f97b4-52c8-4468-a539-b400fb6846fd', N'3049eee0-0e6f-4afc-80d4-464673f74a29', N'7a03c8b3-6e15-41c0-a78d-ec230c1339a6', NULL)
INSERT [dbo].[BlogImage] ([Id], [BlogId], [BlogImageId], [SortIndex]) VALUES (N'3f67e5db-9ea6-4d46-98a5-b843ef5898c3', N'6b75c1fc-e78c-4a96-a1b3-2ab4ac375b77', N'efb433ad-4fee-4e08-a0ad-cfad78d3e7f4', NULL)
INSERT [dbo].[BlogImage] ([Id], [BlogId], [BlogImageId], [SortIndex]) VALUES (N'a2407081-c094-4468-aa05-b844da5fc2fa', N'cdf2b6ee-ea2a-4fde-9e35-b9a04a598fbb', N'50ec61cc-e557-48a2-8f6e-610911967461', NULL)
GO
INSERT [dbo].[BlogOfCategory] ([Id], [BlogId], [BlogCategoryId]) VALUES (N'3935375c-6220-4b15-9359-2213a78f03aa', N'cdf2b6ee-ea2a-4fde-9e35-b9a04a598fbb', N'3bb1280b-5a1b-4e15-9fbf-3b8d9175594c')
INSERT [dbo].[BlogOfCategory] ([Id], [BlogId], [BlogCategoryId]) VALUES (N'41badba9-04df-4010-a748-4ccb709bee72', N'3049eee0-0e6f-4afc-80d4-464673f74a29', N'14210e1e-009e-40ed-af29-c004050b7a58')
INSERT [dbo].[BlogOfCategory] ([Id], [BlogId], [BlogCategoryId]) VALUES (N'30f39f60-d130-4004-91ee-80b538565e5d', N'7ea6206e-2dfd-44d8-922d-71cd9185c794', N'14210e1e-009e-40ed-af29-c004050b7a58')
INSERT [dbo].[BlogOfCategory] ([Id], [BlogId], [BlogCategoryId]) VALUES (N'fd0812aa-dc9a-416e-a573-9b0d0f76ffa0', N'b5425965-2cc3-4b3a-ae4f-b3f310de4f11', N'741d1a0d-5951-44b4-8433-c35e8e0c6b38')
INSERT [dbo].[BlogOfCategory] ([Id], [BlogId], [BlogCategoryId]) VALUES (N'a432882f-65c6-4804-9544-a3ce84ff2485', N'a92fae90-6f9b-4aaf-9c4b-f30077ebdb4a', N'741d1a0d-5951-44b4-8433-c35e8e0c6b38')
INSERT [dbo].[BlogOfCategory] ([Id], [BlogId], [BlogCategoryId]) VALUES (N'110e62c1-d767-4d23-9453-c9839c709387', N'3049eee0-0e6f-4afc-80d4-464673f74a29', N'3bb1280b-5a1b-4e15-9fbf-3b8d9175594c')
INSERT [dbo].[BlogOfCategory] ([Id], [BlogId], [BlogCategoryId]) VALUES (N'b094f85c-8ac7-4bf6-b97f-ebe68131ddea', N'6b75c1fc-e78c-4a96-a1b3-2ab4ac375b77', N'14210e1e-009e-40ed-af29-c004050b7a58')
INSERT [dbo].[BlogOfCategory] ([Id], [BlogId], [BlogCategoryId]) VALUES (N'c111c651-e60a-4ecc-9a97-f76e564d6cd8', N'b5425965-2cc3-4b3a-ae4f-b3f310de4f11', N'14210e1e-009e-40ed-af29-c004050b7a58')
GO
INSERT [dbo].[BlogTag] ([Id], [BlogId], [TagId]) VALUES (N'e97ba5b4-5030-462c-b98c-0f602ff413dd', N'7ea6206e-2dfd-44d8-922d-71cd9185c794', N'a69a52ab-2a25-4e0a-94bb-ba757a46e9dd')
INSERT [dbo].[BlogTag] ([Id], [BlogId], [TagId]) VALUES (N'790dacec-fe1d-4a65-8df2-1515299347a4', N'3049eee0-0e6f-4afc-80d4-464673f74a29', N'e76ebd89-d2af-48d7-81e2-6ded0e607e2f')
INSERT [dbo].[BlogTag] ([Id], [BlogId], [TagId]) VALUES (N'e9122e76-e0bc-40e0-a512-5055130d1750', N'cdf2b6ee-ea2a-4fde-9e35-b9a04a598fbb', N'a69a52ab-2a25-4e0a-94bb-ba757a46e9dd')
INSERT [dbo].[BlogTag] ([Id], [BlogId], [TagId]) VALUES (N'e901d35c-0f62-41d3-a79b-8a95a9008557', N'6b75c1fc-e78c-4a96-a1b3-2ab4ac375b77', N'e4e22aea-3714-45bc-98cd-c103912fe675')
INSERT [dbo].[BlogTag] ([Id], [BlogId], [TagId]) VALUES (N'aaf64f3f-3dab-4607-8b52-8d493a99f7a3', N'b5425965-2cc3-4b3a-ae4f-b3f310de4f11', N'e76ebd89-d2af-48d7-81e2-6ded0e607e2f')
INSERT [dbo].[BlogTag] ([Id], [BlogId], [TagId]) VALUES (N'57986abc-8a30-4ae7-baa2-c5967d29a2e6', N'a92fae90-6f9b-4aaf-9c4b-f30077ebdb4a', N'f897d23c-b998-433a-a4eb-de5d9b0f291a')
INSERT [dbo].[BlogTag] ([Id], [BlogId], [TagId]) VALUES (N'b84fbe41-f08c-482e-9eba-e6895a58ff02', N'3049eee0-0e6f-4afc-80d4-464673f74a29', N'e4e22aea-3714-45bc-98cd-c103912fe675')
INSERT [dbo].[BlogTag] ([Id], [BlogId], [TagId]) VALUES (N'746748f9-262b-4ad2-a4b9-f23addf80798', N'b5425965-2cc3-4b3a-ae4f-b3f310de4f11', N'a69a52ab-2a25-4e0a-94bb-ba757a46e9dd')
GO
INSERT [dbo].[Brand] ([Id], [Name], [Description]) VALUES (N'4240d1c5-6e83-47be-ba40-3a29c62f00ec', N'Versace', N'Ổn')
INSERT [dbo].[Brand] ([Id], [Name], [Description]) VALUES (N'acefe519-2dc8-473d-a88f-d72293335524', N'Chanel', N'ok')
INSERT [dbo].[Brand] ([Id], [Name], [Description]) VALUES (N'd0350d99-7d56-443e-b268-ebaca82d3e3e', N'Dior', N':((')
INSERT [dbo].[Brand] ([Id], [Name], [Description]) VALUES (N'8945fc06-95c0-44a4-81bd-f72925f9b8f5', N'Prada', N':))')
INSERT [dbo].[Brand] ([Id], [Name], [Description]) VALUES (N'45eff8f8-b5f2-4259-89fa-fa69eff9b069', N'Gucci', N'đẹp')
GO
INSERT [dbo].[Category] ([Id], [Name], [Description]) VALUES (N'8b79a6bb-a88b-45c6-8ce4-1f1ddcf96165', N'Gps', N'sa')
INSERT [dbo].[Category] ([Id], [Name], [Description]) VALUES (N'267b8be4-d6d1-42c7-adbc-37867d01cbc4', N'Quần', N'a')
INSERT [dbo].[Category] ([Id], [Name], [Description]) VALUES (N'3253e789-7aab-44bf-a635-8e5d0d4bf413', N'Dép', N'a')
INSERT [dbo].[Category] ([Id], [Name], [Description]) VALUES (N'08aa9eb9-9d09-4100-bb1a-f191f4f7cf1c', N'Áo', N'a')
INSERT [dbo].[Category] ([Id], [Name], [Description]) VALUES (N'2b0ec076-89e5-427b-8ff9-f3a99a0bbb9b', N'Giày', N'a')
GO
INSERT [dbo].[Order] ([Id], [CustomerId], [OrderDate], [TotalAmount], [FinalAmount], [OrderStatus], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Notes], [PaymentStatus], [Address], [Receiver], [Email], [Phone]) VALUES (N'd48e4ae5-86f9-43c9-8bb1-2ca369b2e277', N'9564e849-8f29-474f-8285-eb06134a985a', CAST(N'2025-01-21T23:18:23.510' AS DateTime), CAST(98888.00 AS Decimal(18, 2)), NULL, 0, CAST(N'2025-01-21T23:18:23.510' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL, NULL, 0, N'', N'', N'', N'')
INSERT [dbo].[Order] ([Id], [CustomerId], [OrderDate], [TotalAmount], [FinalAmount], [OrderStatus], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Notes], [PaymentStatus], [Address], [Receiver], [Email], [Phone]) VALUES (N'fac8a49c-14a7-4fb8-a1d9-498a211c891b', N'9564e849-8f29-474f-8285-eb06134a985a', CAST(N'2025-01-21T23:27:04.627' AS DateTime), CAST(800000.00 AS Decimal(18, 2)), NULL, 0, CAST(N'2025-01-21T23:27:04.627' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL, NULL, 0, N'', N'', N'', N'')
INSERT [dbo].[Order] ([Id], [CustomerId], [OrderDate], [TotalAmount], [FinalAmount], [OrderStatus], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Notes], [PaymentStatus], [Address], [Receiver], [Email], [Phone]) VALUES (N'8bc9dfb4-6d79-4a13-8995-71fbfe6d62e5', N'2f3d077c-e3e7-4b61-843b-9090478a7490', CAST(N'2025-01-23T16:44:43.893' AS DateTime), CAST(104888.00 AS Decimal(18, 2)), NULL, 0, CAST(N'2025-01-23T16:44:43.893' AS DateTime), N'2f3d077c-e3e7-4b61-843b-9090478a7490', NULL, NULL, NULL, 0, N'nhà cung cấp 3', N'Trịnh Ngọc Trường', N'2002ngoctruong@gmail.com', N'0353129941')
INSERT [dbo].[Order] ([Id], [CustomerId], [OrderDate], [TotalAmount], [FinalAmount], [OrderStatus], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Notes], [PaymentStatus], [Address], [Receiver], [Email], [Phone]) VALUES (N'e002dc7b-c743-460b-895c-8122a2778d64', N'9564e849-8f29-474f-8285-eb06134a985a', CAST(N'2025-01-21T23:25:41.960' AS DateTime), CAST(98888.00 AS Decimal(18, 2)), NULL, 0, CAST(N'2025-01-21T23:25:41.960' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL, NULL, 0, N'', N'', N'', N'')
INSERT [dbo].[Order] ([Id], [CustomerId], [OrderDate], [TotalAmount], [FinalAmount], [OrderStatus], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Notes], [PaymentStatus], [Address], [Receiver], [Email], [Phone]) VALUES (N'6048ab6f-8617-422b-8482-9d52864b535b', NULL, CAST(N'2025-01-21T21:45:59.927' AS DateTime), CAST(800000.00 AS Decimal(18, 2)), NULL, 1, CAST(N'2025-01-21T21:45:59.930' AS DateTime), NULL, NULL, NULL, NULL, 0, N'Thanh Hóa', N'Trịnh Ngọc Trường', N'2002ngoctruong@gmail.com', N'0353129941')
INSERT [dbo].[Order] ([Id], [CustomerId], [OrderDate], [TotalAmount], [FinalAmount], [OrderStatus], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Notes], [PaymentStatus], [Address], [Receiver], [Email], [Phone]) VALUES (N'3cab6b51-dc85-40b1-a0cd-a46f5bc7a1c9', NULL, CAST(N'2025-01-21T22:45:58.393' AS DateTime), CAST(98888.00 AS Decimal(18, 2)), NULL, 0, CAST(N'2025-01-21T22:45:58.393' AS DateTime), NULL, NULL, NULL, NULL, 0, N'', N'', N'', N'')
INSERT [dbo].[Order] ([Id], [CustomerId], [OrderDate], [TotalAmount], [FinalAmount], [OrderStatus], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Notes], [PaymentStatus], [Address], [Receiver], [Email], [Phone]) VALUES (N'b6f99a89-92ba-4ec9-aa0d-b5ec7da13bc4', N'2f3d077c-e3e7-4b61-843b-9090478a7490', CAST(N'2025-01-23T14:18:00.113' AS DateTime), CAST(98888.00 AS Decimal(18, 2)), NULL, 0, CAST(N'2025-01-23T14:18:00.113' AS DateTime), N'2f3d077c-e3e7-4b61-843b-9090478a7490', NULL, NULL, NULL, 0, N'Thành Công - Hà Nội1', N'Trịnh Ngọc Trường', N'2002ngoctruong@gmail.com', N'0353129941')
INSERT [dbo].[Order] ([Id], [CustomerId], [OrderDate], [TotalAmount], [FinalAmount], [OrderStatus], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Notes], [PaymentStatus], [Address], [Receiver], [Email], [Phone]) VALUES (N'fbff6651-3612-48de-b62d-db4934156889', N'9564e849-8f29-474f-8285-eb06134a985a', CAST(N'2025-01-21T23:21:25.770' AS DateTime), CAST(0.00 AS Decimal(18, 2)), NULL, 0, CAST(N'2025-01-21T23:21:25.770' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL, NULL, 0, N'', N'', N'', N'')
GO
INSERT [dbo].[OrderPayment] ([Id], [OrderId], [Amount], [PaymentDate], [PaymentMethod], [Notes], [PayerName]) VALUES (N'62c7d273-5bcc-411c-8fce-f0ba182cc904', N'c42543e5-55e2-4c4a-a322-21eeab1ed368', CAST(12000.00 AS Decimal(18, 2)), CAST(N'2024-12-23T17:28:41.350' AS DateTime), 0, N'abc', N'nam')
GO
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'00000000-0000-0000-0000-000000000000', N'c42543e5-55e2-4c4a-a322-21eeab1ed368', N'4d9e7243-fdfe-4d18-9807-203463a97581', 2, CAST(98888.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'737290f7-f820-4bb3-b102-066219f57986', N'fbae8b8f-3141-49ef-a92d-891df3afeaef', N'032020b8-3316-4d5e-801a-0cac752a8cbc', 1, CAST(6000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'6e7120c5-3522-4f98-86ab-0b69c56abba9', N'575e36b5-eb0e-42c9-bfc0-28272458175d', N'4d9e7243-fdfe-4d18-9807-203463a97581', 1, CAST(98888.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'483004b9-9d05-44e9-ad4c-0bef9004e3d1', N'ef7e99a0-b3f0-47be-9b0a-529a3361453f', N'fe43bedb-9b56-48ea-bf59-96b7ae3e4db7', 1, CAST(800000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'9929bf1f-9fd5-4074-aad8-0c221c3e42c3', N'3cab6b51-dc85-40b1-a0cd-a46f5bc7a1c9', N'4d9e7243-fdfe-4d18-9807-203463a97581', 1, CAST(98888.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'92eccd03-c1c4-4586-9d15-2a377ef4299c', N'8bc9dfb4-6d79-4a13-8995-71fbfe6d62e5', N'032020b8-3316-4d5e-801a-0cac752a8cbc', 1, CAST(6000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'8574840b-2a6e-487c-80ad-3a52bf5d539c', N'd48e4ae5-86f9-43c9-8bb1-2ca369b2e277', N'4d9e7243-fdfe-4d18-9807-203463a97581', 1, CAST(98888.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'c84c7dba-ea12-4b31-a6ab-3da203b31def', N'b52899cb-f049-42c5-be24-5ad43331f2ea', N'4d9e7243-fdfe-4d18-9807-203463a97581', 1, CAST(98888.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'c7ef557a-c816-49bc-9b5a-424efb33c40d', N'8bc9dfb4-6d79-4a13-8995-71fbfe6d62e5', N'4d9e7243-fdfe-4d18-9807-203463a97581', 1, CAST(98888.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'fbec25bc-9882-4f40-aae1-53f93566d8d8', N'daeb1b52-4ef6-4680-8a01-80d04ea5be6b', N'032020b8-3316-4d5e-801a-0cac752a8cbc', 2, CAST(6000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'0c901d7d-9d74-4cae-b8a5-6323aadef7f4', N'b6f99a89-92ba-4ec9-aa0d-b5ec7da13bc4', N'4d9e7243-fdfe-4d18-9807-203463a97581', 1, CAST(98888.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'6315cbf7-7340-4c3c-96e0-65cfe9a99eed', N'daeb1b52-4ef6-4680-8a01-80d04ea5be6b', N'4d9e7243-fdfe-4d18-9807-203463a97581', 1, CAST(98888.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'8670ead8-8dca-442e-aa93-75029b6d694e', N'3fcad9b5-ef78-424d-b6d0-23e0d1fcafa1', N'b758e03f-89a0-4bbc-8ea5-3a83664c519b', 3, CAST(80000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'd7ff86bf-b5e1-4a89-99e5-7543af4d3d4c', N'6048ab6f-8617-422b-8482-9d52864b535b', N'fe43bedb-9b56-48ea-bf59-96b7ae3e4db7', 1, CAST(800000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'd3eb7f4a-1950-412b-8e32-7a654cda3731', N'f190c549-cf15-4ba4-b329-5d9047360b4b', N'b758e03f-89a0-4bbc-8ea5-3a83664c519b', 1, CAST(80000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'662cd5c3-1386-4995-b06a-9083f63b6de8', N'3fcad9b5-ef78-424d-b6d0-23e0d1fcafa1', N'032020b8-3316-4d5e-801a-0cac752a8cbc', 2, CAST(6000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'a009d306-a8a7-47a4-b64d-98d2f2c8c560', N'ef7e99a0-b3f0-47be-9b0a-529a3361453f', N'4d9e7243-fdfe-4d18-9807-203463a97581', 1, CAST(98888.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'1378eabc-3d99-49e5-8ca0-99de87b27024', N'a7e25cb2-b601-4e00-82e8-2424bce684a7', N'4d9e7243-fdfe-4d18-9807-203463a97581', 1, CAST(98888.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'18a51b7a-813e-4273-9eb0-a670a35bde69', N'fac8a49c-14a7-4fb8-a1d9-498a211c891b', N'fe43bedb-9b56-48ea-bf59-96b7ae3e4db7', 1, CAST(800000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'f84c0154-fa71-4800-b862-b802384a42a5', N'e002dc7b-c743-460b-895c-8122a2778d64', N'4d9e7243-fdfe-4d18-9807-203463a97581', 1, CAST(98888.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'9d498029-3a2a-4d2d-998e-bdce1cd6476a', N'c42543e5-55e2-4c4a-a322-21eeab1ed368', N'b758e03f-89a0-4bbc-8ea5-3a83664c519b', 1, CAST(80000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'5cc8342f-b4de-49bb-94d0-d584e6df51e4', N'575e36b5-eb0e-42c9-bfc0-28272458175d', N'032020b8-3316-4d5e-801a-0cac752a8cbc', 1, CAST(6000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'c753a06a-b8c8-49bc-87fb-d8dfc8cfed9b', N'aa24ee59-6531-4ae1-b6d7-3fb7d72d1efd', N'032020b8-3316-4d5e-801a-0cac752a8cbc', 4, CAST(6000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'02f43ca0-0e48-401c-8244-da7cd5d6a40a', N'a7e25cb2-b601-4e00-82e8-2424bce684a7', N'032020b8-3316-4d5e-801a-0cac752a8cbc', 4, CAST(6000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'064ecfec-6020-440b-a098-f2e4f5d8a410', N'e75ebc87-c79a-4f81-b746-8875d52534ec', N'e33d8748-b6f4-4012-b1f3-8c8d522cbd4e', 2, CAST(12000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'677e7154-6e2e-4d56-a7f4-fba10cd4cbb2', N'e75ebc87-c79a-4f81-b746-8875d52534ec', N'cae5fda3-e4e9-4fb2-9b2c-84b9db214d6e', 1, CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'b2cf5ee8-80fa-4ff3-b922-fd3493cb3b5e', N'c42543e5-55e2-4c4a-a322-21eeab1ed368', N'032020b8-3316-4d5e-801a-0cac752a8cbc', 2, CAST(6000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderProduct] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (N'6c8ccc9d-e6c0-4997-b6eb-fdc57ef1756c', N'b500e7b8-3b79-4714-a322-f813c47b9793', N'fe43bedb-9b56-48ea-bf59-96b7ae3e4db7', 3, CAST(800000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Partner] ([Id], [Name], [NumberPhone], [Address], [ImageId], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Note]) VALUES (N'983a1508-e4d6-476a-a29f-1835ac87b0d4', N'1', NULL, NULL, N'6b522667-9e33-4f38-b103-ae40a0a88ebd', CAST(N'2024-12-18T12:40:32.357' AS DateTime), NULL, NULL, NULL, NULL)
INSERT [dbo].[Partner] ([Id], [Name], [NumberPhone], [Address], [ImageId], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Note]) VALUES (N'd5266ea8-b57c-48a4-8237-1a6a24a8eda5', N'Đối tác 4', N'0353129941', NULL, N'4225da6f-dd95-4102-9ab9-a2b86c42941d', CAST(N'2024-12-11T11:43:31.740' AS DateTime), NULL, CAST(N'2024-12-12T09:38:44.517' AS DateTime), NULL, NULL)
INSERT [dbo].[Partner] ([Id], [Name], [NumberPhone], [Address], [ImageId], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Note]) VALUES (N'820bd1f1-c8ed-49cc-9777-3bd7e4ea0c86', N'Đối tác 7', NULL, NULL, N'6c2c637e-3075-45a6-9edd-f631dd0a3612', CAST(N'2024-12-11T11:43:54.997' AS DateTime), NULL, CAST(N'2024-12-12T09:38:23.933' AS DateTime), NULL, NULL)
INSERT [dbo].[Partner] ([Id], [Name], [NumberPhone], [Address], [ImageId], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Note]) VALUES (N'ea36b67e-bca1-419f-b92f-72c9d537bec8', N'Đối tác 2', N'0353129941', NULL, N'e1f92414-b029-4ffa-b960-f86f68327aa3', CAST(N'2024-12-11T11:42:26.047' AS DateTime), NULL, CAST(N'2024-12-12T09:39:12.683' AS DateTime), NULL, NULL)
INSERT [dbo].[Partner] ([Id], [Name], [NumberPhone], [Address], [ImageId], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Note]) VALUES (N'aea393a7-155a-4601-8fcc-8637beb64c6f', N'Cty TNHH PNP_SOLUTION', N'0353129941', N'Thành Công - Hà Nội1', N'2050262d-634b-498b-88df-de2b6531e628', CAST(N'2024-12-11T10:39:59.180' AS DateTime), NULL, CAST(N'2025-01-23T11:55:25.900' AS DateTime), NULL, N'OK8888')
INSERT [dbo].[Partner] ([Id], [Name], [NumberPhone], [Address], [ImageId], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Note]) VALUES (N'3c5cc0da-3ef1-4561-a272-8e083d0cb679', N'Đối tác 3', NULL, NULL, N'b0bc423c-2322-4210-82f6-a08f2a9b7416', CAST(N'2024-12-11T11:42:38.020' AS DateTime), NULL, CAST(N'2024-12-12T09:38:55.023' AS DateTime), NULL, NULL)
INSERT [dbo].[Partner] ([Id], [Name], [NumberPhone], [Address], [ImageId], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Note]) VALUES (N'370d150b-9511-4cc9-ad58-d5517692378b', N'Đối tác 5', N'0353129941', N'Thanh Hóa', N'24a7c9b1-1042-4626-b81a-15d2815d11c7', CAST(N'2024-12-11T11:43:17.380' AS DateTime), NULL, CAST(N'2024-12-17T09:49:28.887' AS DateTime), NULL, NULL)
INSERT [dbo].[Partner] ([Id], [Name], [NumberPhone], [Address], [ImageId], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Note]) VALUES (N'b63352f2-eb30-4040-ab6f-edaea1cb6c30', N'Đối tác 1', N'0353129941', N'Thanh Hóa', N'5535a0f6-788e-4b72-8f16-57acca1f1ba3', CAST(N'2024-12-11T11:42:04.127' AS DateTime), NULL, CAST(N'2024-12-12T09:39:20.347' AS DateTime), NULL, N'1')
INSERT [dbo].[Partner] ([Id], [Name], [NumberPhone], [Address], [ImageId], [CreatedAt], [CreatedBy], [UpdatedAt], [UpdatedBy], [Note]) VALUES (N'1a93150a-b514-4fed-ac46-fa4b7b1dd390', N'Đối tác 6', NULL, NULL, N'bae5b58d-2803-43d8-b639-37c4d08216b4', CAST(N'2024-12-11T11:43:42.633' AS DateTime), NULL, CAST(N'2024-12-12T09:38:33.907' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[Product] ([Id], [Code], [Name], [Description], [CategoryId], [BrandId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [Title], [IsHot], [PrimaryImageId]) VALUES (N'032020b8-3316-4d5e-801a-0cac752a8cbc', N'Spewre', N'Sản phẩm 5', N'<p>⚡️ Giá Sốc ⚡️Thắt lưng nam da cao cấp khóa kim loại tự động không gỉ - Cam kết 1 đổi 1 bảo hành 12 tháng</p><p><br></p><p>THÔNG TIN SẢN PHẨM</p><p>- Thiết kế : Khóa kim loại tự động</p><p>- Loại sản phẩm: Thắt lưng nam</p><p>- Chất liệu thắt lưng: Da 3 lớp</p><p>- Style: Hàn Quốc</p><p>- Kích thước: 3.5cm x 120cm( có thể điều chỉnh theo kích cỡ bụng từng người)</p><p>- Khóa vật liệu: hợp kim Nano chống xước, chống hoen rỉ</p><p>- Kiểu khóa: Khóa tự động</p><p>- Với vật liệu da cao cấp lên dây rất mềm, độ bền cao.</p><p>- Thiết kê vô cùng tinh tế, Kiểu dáng hiện đại, sang trọng đầy nam tính thời thượng</p><p>----------------------------------------------------------------------------------</p><p>HƯỚNG DẪN SỬ DỤNG</p><p>- Dây lưng dài hơn vòng bụng, bạn tháo dây lưng chỗ đầu khóa &gt; ướm với bụng &gt; cắt bớt dây sao cho vừa bùng &gt; lắp lại là được.</p><p>- Không kỳ cọ vậy sắt vào dây lưng.</p><p><br></p><p>MỤC ĐÍCH SỬ DỤNG</p><p>- Đeo Công sở, đi chơi, dạo phố, dự tiệc đều tạo một phong cách đầy cá tính lịch lãm, sang trọng. Hoặc bạn có thể dùng làm món quà tặng anh, em, bạn bè đồng nghiệp trong các dịp sự kiện, sinh nhật đều rất đẹp và ý nghĩa.</p><p>- Không chỉ là một trong những vật dụng thiết yếu, mà kiểu dáng, màu sắc của chiếc Thắt Lưng Nam Cao Cấp da thật phong cách thời thượng được lựa chọn cũng góp phần giúp phái mạnh khẳng định đẳng cấp và sự sành điệu của mình. Sự tinh tế, vẻ đẹp sang trọng và cá tính của các sản phẩm sẽ khiến bạn hài lòng. Hãy lựa chọn cho mình một kiểu thật ưng ý và diện cùng với bộ trang phục “tông xuyệt tông”, chắc chắn sản phẩm đeo trên người sẽ là điểm nhấn tạo phong cách của bạn với người đối diện.</p><p>Đơn giản, ít cầu kì, nhưng vẫn trẻ trung, lịch sự và sang trọng là những ưu điểm nổi bật của những mẫu Thắt Lưng Nam Cao Cấp.</p><p><br></p><p>SHOP CAM KẾT</p><p>- Sản phẩm 100% giống hình ảnh và mô tả</p><p>- Chất liệu da thật siêu bền</p><p>- Được kiểm tra kỹ càng, đóng gói cẩn thận trước khi gửi đến tay khách hàng</p><p>- Hàng có sẵn, giao ngay khi nhận được đơn</p><p>- Giao hàng toàn quốc, nhận hàng trả tiền</p><p>- Hỗ trợ đổi trả theo quy định của Shopee</p>', N'267b8be4-d6d1-42c7-adbc-37867d01cbc4', N'acefe519-2dc8-473d-a88f-d72293335524', NULL, CAST(N'2024-12-13T16:46:56.033' AS DateTime), NULL, CAST(N'2024-12-18T10:09:40.973' AS DateTime), NULL, 1, N'5ffb7a36-8a99-40cb-beae-572e1f3ba1e5')
INSERT [dbo].[Product] ([Id], [Code], [Name], [Description], [CategoryId], [BrandId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [Title], [IsHot], [PrimaryImageId]) VALUES (N'4d9e7243-fdfe-4d18-9807-203463a97581', N'sp03934', N'Sản  phẩm 4', N'<p>Danh mục sản phẩm: Giày thể thao thông thường</p><p>Nhóm tuổi áp dụng: Thanh niên (18-40 tuổi)</p><p>Giới tính áp dụng: nam</p><p>Mô hình: kết hợp màu sắc</p><p>Chất liệu duy nhất: Cao su</p><p>Cách mặc: Cà vạt phía trước</p><p>Hình dạng gót chân: gót bằng</p><p>Vật liệu bên trong: lưới</p><p>Độ sâu mở: miệng nông (dưới 7cm)</p><p>Chiều cao trên: Đỉnh thấp</p><p>Hình dạng ngón chân: Ngón chân tròn</p><p>Chiều cao gót: Gót thấp (1 - 3CM)</p><p>Quy trình duy nhất: Giày đúc phun</p><p>Chất liệu đế: EVA</p><p>Tổng trọng lượng: 0,75</p><p>Khối lượng đóng gói: 15 * 18 * 14</p><p>Kích thước: 39</p><p>Kích thước: 40</p><p>Kích thước: 41</p><p>Kích thước: 42</p><p>Kích thước: 43</p><p>Kích thước: 44</p><p>Đóng cửa: Ren Up</p><p><br></p><p><img src="http://localhost:5258/api/Resource/get-link-image/7b6d7fe1-75cf-4bc0-bac3-361db343024c"></p>', N'08aa9eb9-9d09-4100-bb1a-f191f4f7cf1c', N'd0350d99-7d56-443e-b268-ebaca82d3e3e', NULL, CAST(N'2024-12-13T16:46:27.673' AS DateTime), NULL, CAST(N'2024-12-18T10:09:50.567' AS DateTime), NULL, 0, N'2d452ecc-1120-402b-8afb-3f6b572c56bf')
INSERT [dbo].[Product] ([Id], [Code], [Name], [Description], [CategoryId], [BrandId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [Title], [IsHot], [PrimaryImageId]) VALUES (N'b758e03f-89a0-4bbc-8ea5-3a83664c519b', N'Spewre', N'Sản phẩm 6', NULL, N'3253e789-7aab-44bf-a635-8e5d0d4bf413', N'd0350d99-7d56-443e-b268-ebaca82d3e3e', NULL, CAST(N'2024-12-13T16:47:21.043' AS DateTime), NULL, CAST(N'2024-12-18T10:09:57.770' AS DateTime), NULL, NULL, N'758b8ebe-433b-43d8-b7c1-acf483c19428')
INSERT [dbo].[Product] ([Id], [Code], [Name], [Description], [CategoryId], [BrandId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [Title], [IsHot], [PrimaryImageId]) VALUES (N'cae5fda3-e4e9-4fb2-9b2c-84b9db214d6e', N'PNP5', N'Sản phẩm 2', NULL, N'267b8be4-d6d1-42c7-adbc-37867d01cbc4', N'4240d1c5-6e83-47be-ba40-3a29c62f00ec', NULL, CAST(N'2024-12-09T15:54:03.150' AS DateTime), NULL, CAST(N'2024-12-18T10:10:05.227' AS DateTime), N'Sản phẩm bán chạy', 1, N'1488fdd9-e271-4af2-810b-08061884d503')
INSERT [dbo].[Product] ([Id], [Code], [Name], [Description], [CategoryId], [BrandId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [Title], [IsHot], [PrimaryImageId]) VALUES (N'e33d8748-b6f4-4012-b1f3-8c8d522cbd4e', N'PNP5', N'Sản phẩm 1', N'<p>Sản phẩm 1 ok .......</p>', N'8b79a6bb-a88b-45c6-8ce4-1f1ddcf96165', N'4240d1c5-6e83-47be-ba40-3a29c62f00ec', NULL, CAST(N'2024-12-09T15:53:44.097' AS DateTime), NULL, CAST(N'2024-12-18T10:10:09.377' AS DateTime), N'Sản phẩm ng trong quá trình sell', 1, N'40b95c78-3613-40f5-b257-9d511cdc90a3')
INSERT [dbo].[Product] ([Id], [Code], [Name], [Description], [CategoryId], [BrandId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [Title], [IsHot], [PrimaryImageId]) VALUES (N'09eb3f9a-95b5-4299-aaf2-8dd1a16b8516', N'9845395', N'Sản phẩm 7', NULL, N'08aa9eb9-9d09-4100-bb1a-f191f4f7cf1c', N'd0350d99-7d56-443e-b268-ebaca82d3e3e', NULL, CAST(N'2024-12-09T15:58:13.217' AS DateTime), NULL, CAST(N'2024-12-18T10:22:09.427' AS DateTime), N'Sản phẩm này đã qua keieemr định chất lượng và .....', 1, N'ee466296-fc7d-4c36-8c00-24119d2e6adf')
INSERT [dbo].[Product] ([Id], [Code], [Name], [Description], [CategoryId], [BrandId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [Title], [IsHot], [PrimaryImageId]) VALUES (N'fe43bedb-9b56-48ea-bf59-96b7ae3e4db7', N'Spewre', N'Sản phẩm 8', NULL, N'3253e789-7aab-44bf-a635-8e5d0d4bf413', N'acefe519-2dc8-473d-a88f-d72293335524', NULL, CAST(N'2024-12-13T16:48:30.277' AS DateTime), NULL, CAST(N'2024-12-18T10:10:18.207' AS DateTime), NULL, NULL, N'c494d8e6-a0a0-4f0a-9cf5-0e72dce0ced6')
INSERT [dbo].[Product] ([Id], [Code], [Name], [Description], [CategoryId], [BrandId], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [Title], [IsHot], [PrimaryImageId]) VALUES (N'759ad149-a544-49be-a56f-b25b2bd86543', N'00123', N'áo 1', N'<p>okok</p>', N'267b8be4-d6d1-42c7-adbc-37867d01cbc4', N'4240d1c5-6e83-47be-ba40-3a29c62f00ec', NULL, CAST(N'2025-01-23T14:56:27.243' AS DateTime), NULL, NULL, NULL, 0, NULL)
GO
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'ac201ae5-9459-425b-8eee-05c30806db8b', N'759ad149-a544-49be-a56f-b25b2bd86543', N'7f39d840-0f44-4ffc-a433-b24724a1e26b')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'61ea4f2b-a351-4e8f-b5d4-05dbe9b0fc14', N'd3cc5cca-c5c7-42e5-b7e8-77e94f903bf2', N'b876dbf7-5a52-4859-9ea1-06e2f3e141a3')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'2a14cbc3-0a75-45fc-b22d-21b5f94ee8b6', N'4d9e7243-fdfe-4d18-9807-203463a97581', N'afe459f5-afeb-4190-b102-c7fc4c4db260')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'a969c7d8-4b9b-4afb-ac5e-21d6f2998071', N'636b0bdb-c97a-4814-a2dd-46fea2e24a70', N'b3652c3d-4b91-4fbc-a26d-504b9901db17')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'35ebd46b-c334-49d0-b45f-5124d3cc22aa', N'759ad149-a544-49be-a56f-b25b2bd86543', N'303214c7-0d74-49ac-8bca-d19b969b1ded')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'4d6730e9-3e53-4ac8-942f-6539b905e756', NULL, N'0509e0b6-d8b8-4356-9c85-62ca970e2b9e')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'2ea7dba5-8aa0-4cb2-b4d7-65956f0c460c', N'd3cc5cca-c5c7-42e5-b7e8-77e94f903bf2', N'093e5d82-5272-4d1e-845c-08ab81475146')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'20bfe6bf-bcfc-4837-9361-6b7f2c08cb00', N'4d9e7243-fdfe-4d18-9807-203463a97581', N'd10927fb-c453-4498-ace1-a4b6017b1ac6')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'6e42d4d9-c9fe-45bf-bee2-8bdbbf5210a2', N'fe43bedb-9b56-48ea-bf59-96b7ae3e4db7', N'c494d8e6-a0a0-4f0a-9cf5-0e72dce0ced6')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'68a79d0c-c09b-489e-b3db-8d234675e24f', N'b758e03f-89a0-4bbc-8ea5-3a83664c519b', N'758b8ebe-433b-43d8-b7c1-acf483c19428')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'2f45d6f5-3b47-4fe2-8a57-8ec20271330c', N'4d9e7243-fdfe-4d18-9807-203463a97581', N'1d25d4ff-706b-4ba1-9086-fb7b46b02c86')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'a1037350-5454-468f-b69f-902be2a6f45c', N'4d9e7243-fdfe-4d18-9807-203463a97581', N'2d452ecc-1120-402b-8afb-3f6b572c56bf')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'fce87fc5-4c37-4a26-b457-97629604778e', N'759ad149-a544-49be-a56f-b25b2bd86543', N'8a2b9f33-2644-46b6-b32f-aae49167f160')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'28db25e7-1f40-4de7-9f0d-97994e28fae3', N'cae5fda3-e4e9-4fb2-9b2c-84b9db214d6e', N'1488fdd9-e271-4af2-810b-08061884d503')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'2fb9e91b-c65f-4d28-8841-9cebe741b4cd', N'e33d8748-b6f4-4012-b1f3-8c8d522cbd4e', N'40b95c78-3613-40f5-b257-9d511cdc90a3')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'7642166b-4da6-48b0-b3fc-9ef808c35b76', NULL, N'd7e20130-4100-4e16-8d57-c9cf38d7fe6c')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'54ca2d7d-8013-4c60-9a6f-9fcb15a342b5', N'4d9e7243-fdfe-4d18-9807-203463a97581', N'b868279b-d83a-4364-89fa-15bf622681b3')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'7209c8b1-999a-4a07-82f3-a87e23981c30', N'09eb3f9a-95b5-4299-aaf2-8dd1a16b8516', N'ee466296-fc7d-4c36-8c00-24119d2e6adf')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'61fd11fb-4901-4dc4-8f2f-adae1793d46d', NULL, N'909e38d8-ad2b-4e73-b506-f218e3194332')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'af5ba905-69aa-435e-b5d5-b1e0c759766f', N'4d9e7243-fdfe-4d18-9807-203463a97581', N'f5a1d8bf-39a6-496b-9f6f-af9be9d7466f')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'4e535c53-05ff-4b90-bde1-b3f21706db06', N'5eb75a85-daf5-4390-bf94-5e518e1847d9', N'1617d801-cad8-405d-a084-ac6fb83af589')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'883b2854-7670-4f78-b90a-c0bdef6576a8', N'bfff18bd-e98a-42a8-ac2e-b7ceec0338c9', N'31b71eb9-08d4-4301-b3cb-a3baad3b50b1')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'54946e38-415c-469b-88b5-e51aa71aeaab', N'032020b8-3316-4d5e-801a-0cac752a8cbc', N'5ffb7a36-8a99-40cb-beae-572e1f3ba1e5')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'6baceb1e-979f-474e-8e6b-e9d4e7eeb2f8', N'92873d58-0b2a-48cb-97ab-e0c029517aaf', N'f0a47aab-7c91-4c49-990b-451f686bef01')
INSERT [dbo].[ProductImage] ([Id], [ProductId], [ResourceId]) VALUES (N'f4a0022c-0948-4a2f-b90d-eea7db2c27a1', N'032020b8-3316-4d5e-801a-0cac752a8cbc', N'37228069-b73e-4ae2-840b-16adc70f9719')
GO
INSERT [dbo].[ProductPrice] ([Id], [ProductId], [Price], [StartDate], [EndDate]) VALUES (N'22bfbe11-a8c6-4796-aa8f-0f1e782c92b8', N'cae5fda3-e4e9-4fb2-9b2c-84b9db214d6e', CAST(50000.00 AS Decimal(10, 2)), CAST(N'2024-12-09T00:00:00.000' AS DateTime), CAST(N'2025-12-19T00:00:00.000' AS DateTime))
INSERT [dbo].[ProductPrice] ([Id], [ProductId], [Price], [StartDate], [EndDate]) VALUES (N'ad8dbb52-0382-4019-8f44-8a434c243bda', N'e33d8748-b6f4-4012-b1f3-8c8d522cbd4e', CAST(12000.00 AS Decimal(10, 2)), CAST(N'2023-12-10T00:00:00.000' AS DateTime), CAST(N'2026-01-08T00:00:00.000' AS DateTime))
INSERT [dbo].[ProductPrice] ([Id], [ProductId], [Price], [StartDate], [EndDate]) VALUES (N'71ec5870-edcc-43ea-9fe5-8bb0bfc8575b', N'032020b8-3316-4d5e-801a-0cac752a8cbc', CAST(6000.00 AS Decimal(10, 2)), CAST(N'2024-12-01T00:00:00.000' AS DateTime), CAST(N'2025-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[ProductPrice] ([Id], [ProductId], [Price], [StartDate], [EndDate]) VALUES (N'24ead8dc-62e8-4cd8-9bf3-c1c53761d1ae', N'fe43bedb-9b56-48ea-bf59-96b7ae3e4db7', CAST(800000.00 AS Decimal(10, 2)), CAST(N'2024-11-30T17:00:00.000' AS DateTime), CAST(N'2025-12-23T17:00:00.000' AS DateTime))
INSERT [dbo].[ProductPrice] ([Id], [ProductId], [Price], [StartDate], [EndDate]) VALUES (N'71ed4d4c-8169-4c57-83bc-ec17df28c6c2', N'b758e03f-89a0-4bbc-8ea5-3a83664c519b', CAST(80000.00 AS Decimal(10, 2)), CAST(N'2024-12-15T17:00:00.000' AS DateTime), CAST(N'2025-01-02T17:00:00.000' AS DateTime))
INSERT [dbo].[ProductPrice] ([Id], [ProductId], [Price], [StartDate], [EndDate]) VALUES (N'8041785e-1c84-4d28-b17a-ec76eb2442de', N'4d9e7243-fdfe-4d18-9807-203463a97581', CAST(98888.00 AS Decimal(10, 2)), CAST(N'2024-12-09T17:00:00.000' AS DateTime), CAST(N'2025-12-17T17:00:00.000' AS DateTime))
INSERT [dbo].[ProductPrice] ([Id], [ProductId], [Price], [StartDate], [EndDate]) VALUES (N'883e09d2-edbb-4f00-bb89-f94e47141f21', N'09eb3f9a-95b5-4299-aaf2-8dd1a16b8516', CAST(123000.00 AS Decimal(10, 2)), CAST(N'2024-12-04T00:00:00.000' AS DateTime), CAST(N'2026-01-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Promotion] ([Id], [PromotionName], [StartDate], [EndDate], [BuyQuantity], [GetQuantity], [DiscountAmount], [DiscountPercentage], [CreatedBy], [CreatedAt], [UpdatedBy], [UpdatedAt], [PromotionType], [IsApplyAll]) VALUES (N'9d8101c3-775e-4115-9b61-0b95648768b2', N'8386', CAST(N'2024-10-31T00:00:00.000' AS DateTime), CAST(N'2024-12-17T00:00:00.000' AS DateTime), 2, 1, NULL, NULL, NULL, CAST(N'2024-11-29T10:41:05.350' AS DateTime), NULL, CAST(N'2024-12-16T09:55:45.317' AS DateTime), 1, 0)
GO
INSERT [dbo].[PromotionImage] ([Id], [PromotionId], [ResourceId]) VALUES (N'143f7ca6-4516-4e0f-9f36-6d1c33915a1d', N'9d8101c3-775e-4115-9b61-0b95648768b2', NULL)
INSERT [dbo].[PromotionImage] ([Id], [PromotionId], [ResourceId]) VALUES (N'c5b92b6a-14fa-42d1-bcb9-a1a3e3e3fd20', N'9d8101c3-775e-4115-9b61-0b95648768b2', NULL)
GO
INSERT [dbo].[PromotionProduct] ([Id], [PromotionId], [ProductId]) VALUES (N'9f928efb-426e-45e4-996c-51b91c9d5105', N'9d8101c3-775e-4115-9b61-0b95648768b2', N'cae5fda3-e4e9-4fb2-9b2c-84b9db214d6e')
GO
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'9df536a0-1df3-4c7e-a6f5-0079c4a4c879', N'akb6nQalV6Tg9zaS1IVTr9lP15bRebDgMqZEZbJfMWa223wn0XrBRRm9X7y1aug6TjLJREK8HlCr3HXk1Erb6A==', CAST(N'2024-12-05T15:16:47.857' AS DateTime), CAST(N'2024-11-28T15:16:47.857' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImI0MTBiMWRiLTJiNTMtNDY1YS04NTg5LWIyMGFlOWYyMzBmMyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzI3ODM2MDcsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.iAIHDMsU8ecmpM_catjs8w8vma1cc4EYof14oHWeroU', CAST(N'2024-11-28T15:16:47.880' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'353c7380-cbf3-4402-ad6b-00acfd239c90', N'a9JhnyJYVPnidZkfXv6OZOqf8jRuuYtb0JzbprtQdAKfzCitAz9Wyv+vOqCGRnKtWCJKrUyJlAr77hhO1xEh+w==', CAST(N'2025-01-30T16:44:42.117' AS DateTime), CAST(N'2025-01-23T16:44:42.117' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbjQiLCJqdGkiOiJiMDgwMTI2Ny03ZjNiLTQyMzgtYTQ3Zi05ZTgyZGVkYjgwMWQiLCJVc2VySWQiOiIyZjNkMDc3Yy1lM2U3LTRiNjEtODQzYi05MDkwNDc4YTc0OTAiLCJVc2VybmFtZSI6ImFkbWluNCIsImV4cCI6MTczNzYyNzI4MiwiaXNzIjoicG5wIiwiYXVkIjoicG5wIn0.0cOER31h2YQbEiE944khNRESeisjOHTrGfTBd_uRGRo', CAST(N'2025-01-23T16:44:42.117' AS DateTime), N'2f3d077c-e3e7-4b61-843b-9090478a7490', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'3bb13e22-41bd-4320-b5fc-01c35db6d83c', N'M6R55yD3p9dnC1Fa7kMj/06XVT3Y+vBQHeG6vGtTvyWItOqsJgSd/T8wIZtelb6EKCdNp6+VlUlqeRl9Lu2UAA==', CAST(N'2025-01-28T23:17:38.717' AS DateTime), CAST(N'2025-01-21T23:17:38.717' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjhmYTliYzM4LWQxOGItNDQwZS1iNjE4LTUxMWFjMTVhMDhmMSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc0NzgwNTgsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.8aRCoZC6O4ZhIChdq1Qja89SXVUiL98KRlufl3GojTo', CAST(N'2025-01-21T23:17:38.733' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'e8a78225-3de7-4f94-a00b-05e2598f7b59', N'h5JaE77B9IPsha+usiOHz4UbUXvnWNXsVfPacI3jDgtVDAFE0D78GUriprBldMqJZWWwqcksRcp8uZh+AOXyxg==', CAST(N'2024-12-10T11:14:57.867' AS DateTime), CAST(N'2024-12-03T11:14:57.867' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImE0MGNmYTVhLTNlZDAtNDU2Ny04YzAyLWY2NzBiMGM4NDQ3NCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMyMDEwOTcsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.4nU0uAjKSKt6SUtTjc5MwtTaZE6lpBnkVDzVgrkwa_E', CAST(N'2024-12-03T11:14:57.870' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'45dce9e6-aac7-4a42-bacd-0f5a6efeefd5', N'NkcDzw2NI/I7ioUWuNgdHkFLjb3dv0mCeCE2i/3I6lw1B4ngKCAaTM6vVLFxWm2/xtCyVRYHCfDuoEqJN0SG9g==', CAST(N'2024-12-05T11:52:51.880' AS DateTime), CAST(N'2024-11-28T11:52:51.880' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjQ4MjExZWM0LTQ0YWItNDgxYS1iZTY1LTNhMTFkNDMwOWIxYiIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzI3NzEzNzEsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.NnVsKcyyq2yez5USM1C60D_mClpSPXrLYRxjKrva2N8', CAST(N'2024-11-28T11:52:51.900' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'65c98cf5-a7db-449b-a0df-1064526af283', N'HNnB4XyQkqwb6wIOmVNBT9cuda2q6VEQSbBo4MvqULONjEh8EPLnk0T4ra5PYB/DuEphJB+ZNMNsecpI65gnWA==', CAST(N'2024-12-09T08:50:33.453' AS DateTime), CAST(N'2024-12-02T08:50:33.453' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjZlNjQxNTJhLWVmYTItNDcwYi04YzczLTI5MTJkOTU0ZTI2ZSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMDYwMzMsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.v1q8KShN7PAs7uPlV4lLAr6aU7qzJbv5sFirvS3kVdo', CAST(N'2024-12-02T08:50:33.457' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'50db0c01-8463-463d-8b63-109b000246f2', N'EsYO3+66n8o4Xy4qM4RYkNC1AgcdN4leqIODDrbvNH0t2Pyyx/nJGDJLlmgpP+cSZ8sGnwed3VaYQW2/ieG8Kg==', CAST(N'2024-12-09T10:22:59.550' AS DateTime), CAST(N'2024-12-02T10:22:59.633' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImUzYTRmMGJkLTE5YTItNGJlNC05YmJiLWUzZjdhZjU5MDdlYiIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMTE1NjksImlzcyI6InBucCIsImF1ZCI6InBucCJ9.nBxLR6OvolkuvAIXlob1Gm1xDHGs_lxPGrJtEf_mrtA', CAST(N'2024-12-02T10:22:59.700' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'8da7589a-0d6d-4310-bed9-15da107bc4fa', N'lLrQ/adEhWCh0l4DwsOJnGXi1B6E3/TXMDdNLTxmliW2wzqmdKiNFD+icbI3TrUTTMtX59+1JsvqjqKXWwKjAA==', CAST(N'2024-12-10T10:08:41.067' AS DateTime), CAST(N'2024-12-03T10:08:41.067' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjZlMzFlNmQ1LTE3MzYtNDczNC05NmVmLTE0Y2Q1MzRjYTBjNyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxOTcxMjEsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.WHYlEx789HkGJuHLtv4CCLXNP3RrzpbvBUteuzwzo5o', CAST(N'2024-12-03T10:08:41.073' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'1c0c45ef-a087-4623-aae4-16af78fd122a', N'7d8iAkPlL8H4bfJdBto0T8Nr7Rr+kXAdpR1GWlWXviKpxxCBcII02Wf1jH/fqDsyfbrsgMOvEcRLx6/IKvRIjA==', CAST(N'2025-01-28T14:17:37.053' AS DateTime), CAST(N'2025-01-21T14:17:37.053' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjRiZjU2YjZhLTJhYjAtNDQ0MS1iMzUxLWVhNDU5ZGFhZDc1OSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc0NDU2NTcsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.Aswowruvpq9YsuOKro9bMNd7irrmE73jUPLwosKnIhI', CAST(N'2025-01-21T14:17:37.057' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'00edea16-680f-4d9e-8f96-16cafae9d2e9', N'gcNS4YN5wRD7FcnyzLyVIrBmcdlij9kfDzL2+XpQWvAfvcmDO3ZqM6e7sRPe16B+sH11vKoK6P3Hwm/FRq1mHg==', CAST(N'2024-12-09T08:50:33.453' AS DateTime), CAST(N'2024-12-02T08:50:33.453' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjdkNThhNDQ2LTQ2NmMtNGE5NS04M2IyLTVjZmY4MWZhZTczNCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMDYwMzMsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.7niX7VEmIePnIGxbvXEBVos1gLjST7HQuHyJb2TrDSM', CAST(N'2024-12-02T08:50:33.457' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'a99c83fb-754a-44bb-9894-19df6ed666c9', N'pCoUCblcXlf4dvmukH6rE/U64fH5yOjX3D18JAm1GF+aIjzq2UICW3gZAVk10cXhkOFmYMxTBsHsZhIpNsOPhg==', CAST(N'2024-12-09T10:22:59.550' AS DateTime), CAST(N'2024-12-02T10:22:59.603' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImQ0NjRlZTg4LWFjNWEtNDc4Yy05YzZjLTAxZmVmYTJiNTRmYSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMTE1NjksImlzcyI6InBucCIsImF1ZCI6InBucCJ9.DShy0sSEXivdcWZ07iCxd83Ssza57rYexaWadUxZvdo', CAST(N'2024-12-02T10:22:59.697' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'f4a2b287-3631-4375-80a9-32ece8c61d81', N'xU3T3eG5C2qWGUvHa1XWlJhXYPSzVbTSjYiEQF898Fu0KXcKHAk0rD9tkZiOvbTCHKHv3LEfAcRi0+GdJZfHHw==', CAST(N'2025-01-30T16:42:44.350' AS DateTime), CAST(N'2025-01-23T16:42:44.350' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjJhMjdjMTAxLWNmNDgtNDRlMS05NDg2LTA0NGFhNTYwNTg0ZSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc2MjcxNjQsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.4wdOBspfFU7LeszyMCJM7FMnk6geReCM0ybu9ZOMezo', CAST(N'2025-01-23T16:42:44.353' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'42d2a598-9a01-44de-b457-361493cbf002', N'XndIoZvIQgxa3EDkid/UyCQkaSvio4Zd+UNde4O1MNkDMxX8K4U25wk4qMm/5eCAIjAv87eRW2RVoGxxzZuymA==', CAST(N'2025-01-28T14:17:30.707' AS DateTime), CAST(N'2025-01-21T14:17:30.707' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6Ijg1NzU1ZTMzLTY3MjktNGFkNC1iNmRmLTEyOWUyNzlmMTE0ZiIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc0NDU2NTAsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.pSiDXuvAA3BK5hg3fkTA5jNE4pP-e5q3lmZrQ2luvVs', CAST(N'2025-01-21T14:17:30.720' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'0464bdef-b262-4af9-acd2-3685f83b5045', N'l0Ap7uwj3vbPo+4BXU6uSkmQ/vMEdBO3VGQaJ2F90sX9TeSmUgzoYW9WNtMFIK2mWO9K08HNgYYeqJynZECWlg==', CAST(N'2025-01-28T22:45:33.287' AS DateTime), CAST(N'2025-01-21T22:45:33.287' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjI2NzQ4YmMxLWFhNjQtNDI0NC1hMjJmLWE0ZDhlNzIxOTYyZCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc0NzYxMzMsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.o0CvbRSXAm39NAYDzJGV_IaycDu5cWP4q0wNuthbYQM', CAST(N'2025-01-21T22:45:33.337' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'45d94a0f-8d1e-411d-ab0f-37e80913bc32', N'zMjfI9k61iV9tWYRm45sP33KlSCT42/dugDCoB9rOrWeN+NeL3YTL7gkaoBywf7qIbOrYrl/gQtRXAN9nK0JzQ==', CAST(N'2025-01-27T23:49:05.453' AS DateTime), CAST(N'2025-01-20T23:49:05.453' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjRhZGFmYjlmLWFkYjYtNGY5Ni1iNTQzLWViODFmMmVmYjFjYiIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzczOTM1NDUsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.8LR5i7ezgKdA-w8oNpucvX7GCeh1i7Ubi_r1Dgibvkc', CAST(N'2025-01-20T23:49:05.500' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'eacf4e73-20d9-4341-9fc9-40b79d8e52a8', N'wAlzey148nS9oZN+Z+C8c8proKleqTieZNuCqO1iRyz+qd6Uaqonwqy1n1Wp0l2puqaNzp9yiuQB87p+6f1d4A==', CAST(N'2024-12-09T09:31:27.050' AS DateTime), CAST(N'2024-12-02T09:31:27.053' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjU3MTVlMjk0LWU2MGQtNDllZS1hODI3LWVmNGNiNzhhZDQxOCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMDg0ODcsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.bKgeQPaIureJIIYMIyCwmnA_sk2NzrLlRqHsxDGLeFM', CAST(N'2024-12-02T09:31:27.063' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'd69141fc-0c81-47ea-9fe2-414a0a0004bf', N'YR8U0Npt3q5AhwXeFsjHe1SiI6dkDqH8EttBDdnEoRi0cgw+kaX57f88pmyHX1XQyjNGqoeFLlUK+vq1W394qg==', CAST(N'2025-01-28T14:08:28.770' AS DateTime), CAST(N'2025-01-21T14:08:28.770' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjMyZGZmNzViLTYzMTQtNDA3NC05YThhLTdlMzNmY2VmNTE1NSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc0NDUxMDgsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.VMYEHB_7tK0pT0q_-YLt2ushJM5BaXgsPPi6UbzZ9J4', CAST(N'2025-01-21T14:08:28.787' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'c29cf192-10f1-4aa8-84ee-4576c9b94f95', N'EFTwKUdPKeatW40S7g0nPeCg7meCHcCaNnmOT1qWI1/bvxqlMx7CWAuCmjvYQiqPQbYB+2pbdz7Kit0I64/Pbg==', CAST(N'2024-12-10T09:38:13.417' AS DateTime), CAST(N'2024-12-03T09:38:13.417' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjRhZGU2YzdjLTBjYTMtNGM2Yy04NTI0LWZlYmY2ZmMxYmZkMSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxOTUyOTMsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.bjEQVF-zqtrM2FWjGTYIT2K3LXh1rXgoe6twY6BWwfw', CAST(N'2024-12-03T09:38:13.417' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'71fe4beb-08ac-45aa-8e07-45cdf76f7252', N'a2YszYeJ7/bdGrOXKLUVZ528BHBzwGC62GtYi1ZKdH9XKJIdkgJ4wPsoVLbqBfkM5nVZwX//IPE+jGnTM6J9vQ==', CAST(N'2024-12-10T13:45:51.883' AS DateTime), CAST(N'2024-12-03T13:45:51.883' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjZlMzQ0NTRiLWVkNDQtNDI1My04NzhhLTgzM2FjZjY1Y2Y3NyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMyMTAxNTEsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.3cWlVe4JUbNebolGEVOgv_2daHVJxtJzrnwifRqcbmM', CAST(N'2024-12-03T13:45:51.890' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'3b2f27b5-d4d2-440f-874e-47d011148656', N'jBGAw/aiakFBjULRN5OHkvHGuoNmraOB4QVLLWGhtBbjbhFGRgug0o/VauVW71Y9WOJeWFnp8MWVp6oOdJvg/g==', CAST(N'2025-01-28T14:08:37.987' AS DateTime), CAST(N'2025-01-21T14:08:37.987' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImQwN2I5NDAwLTRkZjMtNDBjMy1iZDdmLWU3NWI2YjI0OGM3YSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc0NDUxMTcsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.ZwD1YDCp4IIkHxTuahjJ1Vb_F72E2DLGDfJZks4i-lg', CAST(N'2025-01-21T14:08:37.990' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'4e828955-dd1d-47bd-999c-4b27a94f2ca0', N'wYWicCk/3JqvntBq6yf0n1eMr4amDdDObT8E7AUQool1OgR+n/eGYq9GuomxvCYWqHoJivHva04YuWEizLzkdQ==', CAST(N'2024-12-09T09:16:28.793' AS DateTime), CAST(N'2024-12-02T09:16:28.793' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6Ijk2ODNhNWNmLTg4M2MtNGNlZi1iOTUwLThlMzE4M2EzNjE5NSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMDc1ODgsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.B_nAwwRtrD5ByRbr3IDHpYcm2uzxa-Z0OJTYe2y2lJc', CAST(N'2024-12-02T09:16:28.817' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'27c8ccf3-acda-4186-8068-4fef8948a65f', N'mFPWCBK2SFPzep+A7jCQ+YAiiqZyzihZf0wEsi+edCa6ya27adtRO0FhvUK5f/1l7Iol2Vn4HB5vMMEws3K5Rw==', CAST(N'2024-12-10T12:30:59.187' AS DateTime), CAST(N'2024-12-03T12:30:59.187' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImU1NDQxYTM2LTY1NTktNDBmZC1iNzAwLWI1MzFmNjNmOWExZSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMyMDU2NTksImlzcyI6InBucCIsImF1ZCI6InBucCJ9.vu1fbfqF4t0oxbey38bXPD0oDz80d8VUuosfHwTJLP4', CAST(N'2024-12-03T12:30:59.190' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'2c2fea59-6be1-4965-8e9f-51083bf6df6b', N'AwUNTmRD0FtT4aqV1dSKn05O2ALdjAg0sxbPvGMwc7o79teRj2rniCdi65Di8s2KRSvKuUXx/faDddes2CQ8hw==', CAST(N'2024-12-09T15:43:12.933' AS DateTime), CAST(N'2024-12-02T15:43:12.933' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImFhMGZjMmQ1LTgzNDYtNGYwOS05MjhhLWQ4ZTc0YTA1NTE5ZSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMzA3OTIsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.MIaTG6hLjqFZITZxE4udpQPi4qtgS_2H4EFNQ0Uv9IY', CAST(N'2024-12-02T15:43:12.963' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'ce56a1d4-7967-4a36-98d1-5360bfe185b2', N'bvYiw8ceEg+OBLcZzGIj1NWRnBGHFHcSwNTjFxrS37N/kAFfE8lYs0NPdWYa3Knef3gED5T6ixdhOdueIVMH1A==', CAST(N'2025-01-30T16:44:08.193' AS DateTime), CAST(N'2025-01-23T16:44:08.193' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjA5YTQ5MWI2LTA0OTgtNDA0My05YzlhLTA3NTZlN2Y4ODYwMyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc2MjcyNDgsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.iCt9f1UUaYfZ_R-RV_e_5AjgHVCcaaXHElwoLxtGI_c', CAST(N'2025-01-23T16:44:08.200' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'5348c532-e854-4379-872d-5496b3aba1bc', N'8nsH+XU1DFnxb3dLfCinZ7xGpxoMRg2bymKoKC6tgKjzAFSaDefaG++z8ME878wAyZr1KKnT0ENkxuH1zA9nCQ==', CAST(N'2024-12-09T13:42:39.840' AS DateTime), CAST(N'2024-12-02T13:42:39.840' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjhhY2FkNDZmLTk4ZjAtNDZkNy1iZmZiLWM0YzAyM2QxOTAzYSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMjM1NTksImlzcyI6InBucCIsImF1ZCI6InBucCJ9.XvWcrIs-FWT-JK1CSGQTTcpXWv_yCvoPmcsteKyJ7CI', CAST(N'2024-12-02T13:42:39.857' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'57a6bf65-88f6-427b-b092-5c3daca37874', N'yic+cHiH+xTzJUuoCy0GMyafpLvm+cpEYp7BqwPMN4jFKkqZgVaLvRNEV7Rw6xiki2RZqXM9L9bPmpEFZfwMBg==', CAST(N'2025-01-28T14:21:11.797' AS DateTime), CAST(N'2025-01-21T14:21:11.797' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjIzODNhNGNlLTZmNzUtNDNlNS05ODQ0LTM4ZWU4N2YzMjlkMCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc0NDU4NzEsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.HHAlMPByGaOz4ixK5QEJtsl2usEFcKCr0bYxcHHNFn4', CAST(N'2025-01-21T14:21:11.820' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'eb98f975-6ac1-4380-a92a-5f59746bb3ba', N'/AN2pBv9y56ha/NwvM24PuFN+FrXYeJn5FoPNpGwXiAVJOQZh/Nbug44m5sGBXIxgXb3zl3oniYdTw1rrPjfFg==', CAST(N'2024-12-09T10:28:16.323' AS DateTime), CAST(N'2024-12-02T10:28:16.323' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImRlYTNjYzBkLTYxYjctNDJmZS1hMzIxLTM5NWVjODcyMzhiMCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMTE4OTYsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.vtE7I9R01aQJZQcUTeuDp0VHMfg0W8HKuf3R7a8c8wk', CAST(N'2024-12-02T10:28:16.353' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'afe1aa2a-1e3c-480c-b43e-60f73767042c', N'+cDruUArqI4mvvTbjU7p9cvZPIrO732ln+wTGdk3+GP/dg8WAu8aLJFQER1ZwfHBu9RFgbWVjSRoZApA11YX9g==', CAST(N'2024-12-05T15:27:54.033' AS DateTime), CAST(N'2024-11-28T15:27:54.033' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjgyOWExMWIxLTcwZWYtNDI2MS1iMjZjLWM5MTUzYzVhMDk2MyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzI3ODQyNzQsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.rFgG3vUHXMPWy9GqC8G8voZROdGIuir0RCH6ufCGD8A', CAST(N'2024-11-28T15:27:54.047' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'6b0eb133-98c5-4842-96f9-61a8bf09fc26', N'Lx8LJGmPemCHsYq+EgvIwdPcb5DXKScgJO9aAJCvb8cGRXx5njWJpySxtWoLGvIc0tw+0Cq+soVADngRl5Ed3g==', CAST(N'2025-01-28T14:17:08.943' AS DateTime), CAST(N'2025-01-21T14:17:08.943' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjA4NTE4MDFhLWZjYzYtNGU4OS04OWIyLTA1MGQ4OWYwOGRhMyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc0NDU2MjgsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.9Fgmv4YLYBgX0mvsKUccQaMf5dbcPgX-bd1FYn9uEtk', CAST(N'2025-01-21T14:17:08.970' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'93115125-4290-48a9-ba5b-691a1933d808', N'ZcaBbhhUoCZDBcmDe6SHFI0+KMM2LSV5EDGbYkbwK8Xt3SSPLpSrQUmYP71/2TeNvrb8YZqPFJN4zu/+HzLrHA==', CAST(N'2024-12-09T11:30:40.540' AS DateTime), CAST(N'2024-12-02T11:30:40.540' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImE3ODk5MDFiLTU3ZjMtNGU5Mi1hY2QyLTdlZTU0NDA4MDhiZCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMTU2NDAsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.NtoZVbM2XUl2VvfxqFmNJ2jep7T-SWVy6N28ZanIhY0', CAST(N'2024-12-02T11:30:40.583' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'52ce29fd-292f-44a4-a72b-6eee39ab83ed', N'HaWygNeVLoS45pbDLtI/40ZZSYSVKwtpRIS13cr40tc9XUnzmflzV+nPSmpleCCq/tTjQZRv90LAsHrjONWRnw==', CAST(N'2025-01-30T11:46:53.627' AS DateTime), CAST(N'2025-01-23T11:46:53.627' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImIyNGU5YTRjLWVlMGUtNDQ1NC1hNWQ5LWMwNjk5NTllOTFmYyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc2MDk0MTMsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.MlZWI7kYFbUgov7weqxa3Zj7I8nDnwppu7X8xWHMmA8', CAST(N'2025-01-23T11:46:53.650' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'0a922550-e6a4-4ce9-9461-7aa6dc873d23', N'ELxwBmlxaWKwTI9tVhqRDhFOGjvc+HpP42qA1cleH4oA8qEV2tYV2rvQnIi+12fNqOdvlp0X9DWsFxUqN9S9Hg==', CAST(N'2024-12-09T15:43:12.933' AS DateTime), CAST(N'2024-12-02T15:43:12.933' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjdhZWJkODZiLTVmMDItNDBlYi04ODBmLTMyNjA3MDhjMzQyMSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMzA3OTIsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.BWXuxCZQvtro_VitH4NY1msBdd2bDVC1a27NvH5Jsys', CAST(N'2024-12-02T15:43:12.963' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'99504ad6-d78f-4b9c-8047-81de92ea8aae', N'N+UqWSzyhUIwB92LoyHTNe84dHZh0jqh39FEeHi4Az/+M5PSahDoDZaVRCsTF6v346MSP/uCViWAkkw0SMMaxA==', CAST(N'2025-01-30T14:17:47.300' AS DateTime), CAST(N'2025-01-23T14:17:47.300' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbjQiLCJqdGkiOiJmNTAyZGVlZS00MzI1LTRmN2ItODAxNC04OWRiOWRkYjg5ZTgiLCJVc2VySWQiOiIyZjNkMDc3Yy1lM2U3LTRiNjEtODQzYi05MDkwNDc4YTc0OTAiLCJVc2VybmFtZSI6ImFkbWluNCIsImV4cCI6MTczNzYxODQ2NywiaXNzIjoicG5wIiwiYXVkIjoicG5wIn0.gLggYmTM2idU_NeSSwhCMsM1qTjggD4scWmj_xMuM5Y', CAST(N'2025-01-23T14:17:47.357' AS DateTime), N'2f3d077c-e3e7-4b61-843b-9090478a7490', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'77156bd6-9c6c-4dd8-9b73-866d68e47fb2', N'TR3g03lnWhsgiOQYrceNfvySmM1cokgDaHO457gCAvs8hnnGGq0k97kw/C/jCfssGAMI/ztUl4tR3AVXwLatIA==', CAST(N'2024-12-10T09:07:50.727' AS DateTime), CAST(N'2024-12-03T09:07:50.727' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjYyMWY3MTg3LWM1M2QtNGY3My05ZjhkLTZhNTE3NTY1MzkxNSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxOTM0NzAsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.jvEMvL6pT8tJaHh5LCzA-wyMxuW0jIvIZESPiLsEx1Q', CAST(N'2024-12-03T09:07:50.743' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'55440f5b-c877-4b65-8683-8d2f1fd75bac', N'dkNNfVwb0r1O32rayMWK59dJ0rdt0nKjdZ4S3cFyD57QuEh+lyqGaLIowC6RR1XPCVeEdXRm6v+e+doFoQI6xw==', CAST(N'2024-12-09T16:34:00.197' AS DateTime), CAST(N'2024-12-02T16:34:00.197' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImY5ODU3ZWY5LTA4MWMtNDc0Mi1hOGIzLTRhMTUxOTdkMzI5MyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMzM4NDAsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.3A0FotNFD02dEnTL_BNDi-H8El0zhbl8GeL6Omr766k', CAST(N'2024-12-02T16:34:00.230' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'c9287514-3081-4155-b925-90078802a4a3', N'Wz2j48VPGL+1rdwS5HvN9AZUbBTbFgBNDuV1DSJz9dIeR3+xoCF42xwajt6UIjQ09OtX+dbpK4OKKoPF/kOMDw==', CAST(N'2025-01-30T11:44:21.150' AS DateTime), CAST(N'2025-01-23T11:44:21.150' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImNkNGJlY2NiLWJmOGItNDgxMS1hNWVjLWFmOGExMjQ5OWM0OCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc2MDkyNjEsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.5FwrlgMXd2oGppoAwJdT9oTKHe9CPK8PP7n9kW0WKoY', CAST(N'2025-01-23T11:44:21.170' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'3b231390-c26a-4bcd-b58e-90ee3a48f471', N'ofZ/rAGWLl4J+KCiWa1/g4KEfjZ+U9KkMum8gftRLYPeoJ3h99ytwUw4hv6LpwqiiR4oqwhI3zKa3F/3WKbB7A==', CAST(N'2024-12-09T15:43:13.467' AS DateTime), CAST(N'2024-12-02T15:43:13.467' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImM0YjUxNjgxLWI2ODctNDVmNi1iMWZmLTdjZjVjYmIyZWY4YiIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMzA3OTMsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.WnNiFVXYFgIrPgTL93ZbqUSmMsMC2wadcdRWTgo__SQ', CAST(N'2024-12-02T15:43:13.467' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'59a3b69f-4f1c-44fe-94c5-91050936429f', N'ZCrV72tn7UUhI7mY9IcPqNFOmN+R+LaLsGe17QRrFuWKjW75sVAiVNneLKzxAg4tOM+a9xbJI0YOzXlKzOugYg==', CAST(N'2024-12-09T08:51:59.480' AS DateTime), CAST(N'2024-12-02T08:51:59.480' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImVhYjEyZTUzLTU2ODktNGVkYS1hMTUzLTE2NmQ2NDczMmY3NCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMDYxMTksImlzcyI6InBucCIsImF1ZCI6InBucCJ9.wJ1zmuVmt4l506GSashy6YZCwe6tr5SZqJj32Mcx3Z4', CAST(N'2024-12-02T08:51:59.480' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'8bf68a7e-97fe-462d-bbab-955d43bb9244', N'va3UK/bMdOJxZpU/pOFNgglodSevWf7bQWVOfQeSINox7qo4lNpvcu5eSwTCoZFN92Doa8uc9ExkEVxaVTYIGQ==', CAST(N'2024-12-10T11:55:29.073' AS DateTime), CAST(N'2024-12-03T11:55:29.073' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImE0M2RkMGY4LTJkN2QtNDZlYi1iZmUzLTljODRhNTIyYmViYSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMyMDM1MjksImlzcyI6InBucCIsImF1ZCI6InBucCJ9.XyaFe_Bry2ZbakebvzoYbJkwG7YNwzScqGExaOTeOso', CAST(N'2024-12-03T11:55:29.073' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'8721344e-02e4-4d5c-8f8f-9c79f4a65966', N'qAuYZIZSt9nrp4GUhy3ULYHjR00QOotQeavPuKmdwHLmM2MFIeFcFZw1wX1LWbu6HGdQy0c8JRG7EpzXc83geQ==', CAST(N'2024-12-05T15:06:26.560' AS DateTime), CAST(N'2024-11-28T15:06:26.560' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImVlOWE3MDQ2LTNlOTMtNDBlNS1iNDFjLWNlNjgxNGY3MWFmZiIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzI3ODI5ODYsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.6gM8ezsOuWsaSXQNfrhudvRmjOypCowS_siisvH_fe4', CAST(N'2024-11-28T15:06:26.593' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'5ceae577-68fd-49f7-b2a0-a2737745b9c6', N'kxozsZcAfeCbevWChhyWOComup4cU9ad6grBScbOuUbD6UDWKT/mCOdgnL5gjK3eWAgxiLK/NxnNGvORerdsBw==', CAST(N'2025-01-27T23:50:13.647' AS DateTime), CAST(N'2025-01-20T23:50:13.647' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbjIiLCJqdGkiOiI2NTZhNTAzNS1iNmNjLTQwMzEtYTNkZi1hZWNlMTk0NWI2ODgiLCJVc2VySWQiOiJjNzBhNjdhNy00MTQ5LTRhMWYtYWVhYi1lNWY5M2M0NzE3NmQiLCJVc2VybmFtZSI6ImFkbWluMiIsImV4cCI6MTczNzM5MzYxMywiaXNzIjoicG5wIiwiYXVkIjoicG5wIn0.oNBPIgmaVdYBWqLLi8l6rHwonx2u8HUyGdKqMBgdAoo', CAST(N'2025-01-20T23:50:13.650' AS DateTime), N'c70a67a7-4149-4a1f-aeab-e5f93c47176d', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'3aaa045f-ae1d-4345-a45f-a6e19e63df00', N'SIRp/bxSZVAetP4HcyZwE9CMWwg/qAyXUa2bBM/SGs5S4rqVbHGpMwc53wxXg+kbpQ+MPhR1IT5n3Ghr1aF+xg==', CAST(N'2024-12-09T10:18:15.920' AS DateTime), CAST(N'2024-12-02T10:18:15.920' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImMzMWNhMTA1LTMzZDctNDJjYS1iNjAzLTUxZTlkYmFmM2I3MyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMTEyOTUsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.lMyLKRQ-BB87QEUscyqrU4gRJZDEkOfs3TMYEQ-RkO8', CAST(N'2024-12-02T10:18:15.933' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'1debcb82-450a-429b-b4a6-b37bc7c54917', N'8TX/uJOA+GtIfzCovSufFerkQJB5VMV/Na69QySHfEAI1m0Y/b42IpZNrIcucxzl2wPU4iLXNcIlqkvJAmIM2w==', CAST(N'2025-01-28T14:43:43.573' AS DateTime), CAST(N'2025-01-21T14:43:43.577' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImNiYzRjNzVhLTYzZjItNDg1YS04NjRhLTFlZDc3N2I1N2IzYiIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc0NDcyMjMsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.dCkZ1bviTHey6Ei86lYHHWzleFN8Hz-sDwXrctEW9kY', CAST(N'2025-01-21T14:43:43.640' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'fcc07feb-0ef0-41f4-a494-bd313185b92b', N'oz7yswn2p0vsNGtMedcoiNoPkvMmPTXJ3OC5JZAd83r8FkPPBkHVMycyL3FCP0LvdIIuWqOZl1YCErgHFsbDBA==', CAST(N'2024-12-09T00:01:35.413' AS DateTime), CAST(N'2024-12-02T00:01:35.413' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImI3MjgwZTI3LTUyNDctNDY2NC1iMTg2LTgwMzJiYmMxOGFjMyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMwNzQyOTUsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.Q1HZsJPfyNq_GQevtEWS83ds5U7BgO358gkrn0MO32Y', CAST(N'2024-12-02T00:01:35.443' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'ac7f667e-53f5-46e7-940d-c76e8eb025ae', N'zRVtVqZAHNhhjRMG9HgcKJOvt7nIkq3T5KazOECSs2PyopfDpNb3brjeVyQARg6SDsrOavYxkF+whzZnQtJB+g==', CAST(N'2024-12-11T14:21:28.223' AS DateTime), CAST(N'2024-12-04T14:21:28.223' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImIzODgxMDNlLWQ0MWEtNGY0Zi1hMzY4LWYzZTJlOWExOGNlMCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMyOTg2ODgsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.E-QD61JHooz7Ne4tXfkQ0haHW2E9flXq8x7-Rs24GEE', CAST(N'2024-12-04T14:21:28.230' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'171eb633-761b-455c-bad6-c89dd0723dd9', N'6oEqC5paSDjO6kZqUtoKghc9Y7PA4wyu3uNobpgp2kwyf2Eg0s7X/aupUmXZqQP6wlPGcj5za31hi8Mj5MX6nA==', CAST(N'2024-12-18T16:46:17.780' AS DateTime), CAST(N'2024-12-11T16:46:17.780' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjNlNDVhMGY1LWY4MmMtNDNmYS04OWIwLWUyNjBmYzJjOTVhMCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzM5MTIxNzcsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.eCgkCqpacL205YD2-H1tOsgbMe1BbywjnQHeXfM81wQ', CAST(N'2024-12-11T16:46:17.797' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'9ae468ab-985c-4d73-8599-cf65a323db52', N'b/V1qltxGYUvpeMfuUNTH26e1D3f8c9KdRXPHlcUMXsS9743oN+x3YIzplQg/0MtwbCvlHLRqtHtMOsEORWt3A==', CAST(N'2024-12-09T10:26:08.290' AS DateTime), CAST(N'2024-12-02T10:26:08.290' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjcwMzYzNzAyLTBlMGYtNGFhZi05NzBhLWM1MzJhNTg1NDdjYyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMTE3NjgsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.Ek5X2A2qt76XZ9u74nLBlmsBhFwCqAioSRqzb0dKTHM', CAST(N'2024-12-02T10:26:08.317' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'5a1859fc-fef9-4a70-9d27-cfac88fcd34b', N'uAsyM351GmjZL2BGtqfY96ejegq6cRCQl7zr/pTXJWfin62z7YGrLZyhNt2APBGBYa7fQrqOmjGaQaN1JYH9KA==', CAST(N'2024-12-10T15:58:50.330' AS DateTime), CAST(N'2024-12-03T15:58:50.330' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImY0OTEwYTQ1LTRlMDEtNDc2My1iMTkzLWRiNzAxNDZkNzM4NyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMyMTgxMzAsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.ccrzwMyb_3SSvp1yzPABdimA3TaC7pstMcpqKUqUKwM', CAST(N'2024-12-03T15:58:50.337' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'e5905b51-25dc-4f16-bed3-d84aae3cfea2', N'NCFtI9bs3PVeH6ZH5VT7utkvik54Qux3te9OzBKugLGm9hgHuEA+e1XcPv2SKWjGFnOr0XqF+e19nDjngkWq5g==', CAST(N'2024-12-09T10:29:48.513' AS DateTime), CAST(N'2024-12-02T10:29:48.513' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjFiMWIzZmQ5LTQ3ZjAtNDNkNC1iNzliLTg5NmE4M2JjMDg0NiIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMTE5ODgsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.HSFVIxIURND7Nev_z4eXd2ePyPhnWjyO-jjbpUfmldA', CAST(N'2024-12-02T10:29:48.517' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'e5b7f876-f7e4-463f-a70a-dabef0b40f8a', N'D1YGXmdVg06crLPcoHffOatLuSVSq/z2UrjIPgqKRbMpxZnMxOlD6c0uQHvRyG3gLicmzsTZIHp/BJ0SaEuhDA==', CAST(N'2024-12-10T10:44:04.740' AS DateTime), CAST(N'2024-12-03T10:44:04.740' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjY3MzhhNmIwLTYwODEtNDQwOS04NDJhLTM5MzA3OGY2ZmVhNyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxOTkyNDQsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.eXcNUF_AkQwc11Jr7-Eil2H-dYBBdAph6nqiHOGpVTs', CAST(N'2024-12-03T10:44:04.753' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'fbb3072a-499a-4fe5-b413-dd3c6c78ba1a', N'46W/jOcVC7ISlE1xHSTbeGwSd5YXPQnvELpqC9WybuSc4H5qJOU3zXxMHALwSY7HuhbqpBz7y0CmozrCrc//bQ==', CAST(N'2025-01-22T22:33:30.073' AS DateTime), CAST(N'2025-01-15T22:33:30.073' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjFjMzIyZGY5LWQ2MTgtNDg5Yi1hZTU4LWJmYTlhNmU4ZDEyMCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzY5NTcwMTAsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.uzqnAkVeCPbL4Z59vRaMBW_PlgCr4Xkg2tpgZHvuqCQ', CAST(N'2025-01-15T22:33:30.107' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'39e2ea2e-c29d-4406-977d-de582aa54123', N'mtAjDcsNIU2AAKNIRYDb+Xk40t9fduuiFAE2mtn3XnIARI098vDND+CUs1YnZL18qyEMPzFf1Ep8s8q7QF6/Qw==', CAST(N'2024-12-11T15:36:37.540' AS DateTime), CAST(N'2024-12-04T15:36:37.540' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjQ4YzE1MDk3LTMwMjUtNGJiMC04NTVlLWUyNWQ3MzlmMmIzMiIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMzMDMxOTcsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.ZppVXDtHbP4E29lou9SEE-c0NXko-H2v5fT9k3gRDv0', CAST(N'2024-12-04T15:36:37.550' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'9b325d83-6b7e-4a18-8880-e0cf3288db7f', N'vgKLia612KZtJtAqM5W8YDDy2IMPNwJSCSjAaiMSiLfJzTv+TFLpIX1xv0x2nH6Q8xUoGBf1Io7hTgIm6CDvXA==', CAST(N'2024-12-06T17:17:56.233' AS DateTime), CAST(N'2024-11-29T17:17:56.233' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjU0OGQ5ZWFkLWJkM2ItNDBmMy1iOWQ0LTE3NzE2MjZiNWUwOCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzI4NzcyNzYsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.PY2HFF7dRpBhpca1XbEUvl3SA-qsDIURiLOC8jK4QZ8', CAST(N'2024-11-29T17:17:56.317' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'80a238d0-a9ff-43cb-a537-e15dea4cd42f', N'zI7VyVcy1pK+vS9k/BmtMiNa4/6A7CzQCVCKeG71rBjDd7MTJfV6ElyLFKaslIuSW/yyeqXWATotsN0odsI9WA==', CAST(N'2024-12-09T08:44:57.537' AS DateTime), CAST(N'2024-12-02T08:44:57.537' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjE2NGYwMDUyLTNmMjItNDkzNi1hYjFhLThiZjU5NmExMmE0YyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMDU2OTcsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.ScYYPm-cEncnEpNdyRs0kTP9XsiWMpjbN3YCWElc6yI', CAST(N'2024-12-02T08:44:57.560' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'b121e611-d386-40e4-bf3e-e2c6e8299aef', N'3cdTrF6YI/wtrqZ4dcD3Q+XDn0ReAMGae0NWLbE1uw4IqRuCIVRhayhBglVVtKDZllc/zE8siPigyGN8OSBY7g==', CAST(N'2025-01-28T14:26:05.337' AS DateTime), CAST(N'2025-01-21T14:26:05.337' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjkzMmY2NTdjLWUyODgtNDIxOS1hYTljLTUxZTE5ZWM0MTBkMCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc0NDYxNjUsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.DbPmnir0wQmLblNztKKaHu98ISl6w-87cj9q17hs5wI', CAST(N'2025-01-21T14:26:05.353' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'87fc6b09-8a3c-4a21-847d-e93367cf8f3f', N'mklVNHzMs0MaReCZSHZBSv6dtlTeN/bGgZzlDL+uj1lW/YCpT8x8ZSnT5xRLt7+2UZHD0bIO1/0rwGU/IOQnog==', CAST(N'2025-01-30T16:42:20.850' AS DateTime), CAST(N'2025-01-23T16:42:20.850' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjczYzgzZTc3LWRmYWItNDkwYy05MmI5LTA5ZDM2OWE4NTJjNiIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc2MjcxNDAsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.pl5unVvT2bdE404w6oodRnQ4nIjSJAlsRaCMws_TLyk', CAST(N'2025-01-23T16:42:20.860' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'd333728a-6658-4aaa-8feb-ed5efbca4a72', N'wQNNyAgps5nW3GjOp3PJYuPDYKXMs4ta//PZyAA/Jpsd5TTGjT+g8pjl5CScOZzUiIJW+spw6jG0NtH8o7IOxA==', CAST(N'2024-12-10T15:21:27.153' AS DateTime), CAST(N'2024-12-03T15:21:27.153' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImM1ZjY3MmNlLTIyZWQtNGI0NC1hM2E0LTFhYjQ3ODAxOGFjMiIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMyMTU4ODcsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.UV6EMaUwWzbqoBKQfiGcsINxGdXQ8g6JT_hj15nswzA', CAST(N'2024-12-03T15:21:27.160' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'bd3834f1-c858-4e75-ab1b-f403a79306a7', N'NVY9sO3Nv1GKmS3NJSJwTHJUArjTxzJ8XecBatfzVGXQ3wGezrpojVFBY8voEdHKU+j+2C2aJ4LMEyMlwgYPDw==', CAST(N'2025-01-30T14:00:10.907' AS DateTime), CAST(N'2025-01-23T14:00:10.907' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjgxM2I3NWVkLTc0YmItNDQ0ZS05NGE2LTU3YmQ5NDU0MGVjNiIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc2MTc0MTAsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.WeG9dm2PzpUTEuh5hcqgWhhfHGzcRgOfdE-75rUbWo4', CAST(N'2025-01-23T14:00:10.990' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'f9030dd2-2c6d-4497-ab93-f65c664de885', N'W/RR0PEqYnHgOdtzPiZxmXSmF/VYHvRLmSBSs298pFkk9XU7sR1IOsQbUbLZGVChmUdC1OSIo/fhnY1pNUSMSw==', CAST(N'2025-01-28T14:34:52.393' AS DateTime), CAST(N'2025-01-21T14:34:52.397' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjFiNTIwZGYwLTllYTItNDQ4My1iNmZjLTQ0NzQ5Zjc2NWYwNyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc0NDY2OTIsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.DjbQDtTq0qbVz4v6KFtA55YRPJ5FoInLr3o81NtywZU', CAST(N'2025-01-21T14:34:52.413' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'44bd7fb5-1f31-4b12-854a-f6d41b59aa02', N'y7yGphnMLRsh7jbampnz2JXD6DFHrQDotXSS33uWDawvpf3PJqiTkninJvNhSdGymqESo0jDaGsgBrWQ1MJ27w==', CAST(N'2025-01-28T14:07:35.237' AS DateTime), CAST(N'2025-01-21T14:07:35.237' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjM3MjU1Zjc3LWQ4MDctNGY1Mi04M2Y3LTcyMjUwMzllZTU3ZCIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3Mzc0NDUwNTUsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.4KrN8Md7UrnNipPpH2QXyBiT5izSI8v_4sDV5ZTfxjU', CAST(N'2025-01-21T14:07:35.320' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'dd30f014-a8ca-4fe1-8663-f88c9937222d', N'ZjA+QtCY9Iusv8oh+mql3XGp/B/1n/9J914dkhWqUlpr9HE7gpSTlUyB7z2X/4mgR3TQLE8+pkBDvN83Fsd+AQ==', CAST(N'2024-12-09T12:02:55.963' AS DateTime), CAST(N'2024-12-02T12:02:55.963' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjBiNDU3NDcyLWVjNmEtNDNmNS1iMjczLTM4NDZhY2Y1NGE0MyIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMTc1NzUsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.nhuRlxCDTpNSlAbxl8PrgOXYo00dUIn70yqb_e4obaE', CAST(N'2024-12-02T12:02:55.993' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'3e712940-31d6-4baa-b00a-fa2f14ee2f64', N'Y208Yq1Kd2Oih21B8ifZWkuYQpdkDHXGy0Xmx+F6WcIQZ7TD2qfo1XHnk1r9ZMglUorRICNOY9zIrlMIfJlhLg==', CAST(N'2024-12-09T17:05:12.220' AS DateTime), CAST(N'2024-12-02T17:05:12.220' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6IjZlZTJhMDQ2LTBiNDUtNDQxOS1iNzRjLWMzOTMzMjY0ZDc0OSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMxMzU3MTIsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.GcrZMY5pzf2cOfy2uI8uk5ztC7AugCq0om4DGb6Vl_0', CAST(N'2024-12-02T17:05:12.247' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
INSERT [dbo].[RefreshToken] ([Id], [RefreshCode], [RefreshCodeExpire], [RefreshCodeCreated], [Token], [TokenCreated], [UserId], [UpdatePassword], [IsBlock]) VALUES (N'871332d1-b322-47fe-9ead-fd7e76ba78e5', N'svE5gCg8/5cwiI0/XIHc2W9mfGRA2VwjcmyjVUylFezEsfGknsVQ83H7eC1FkkPXYEBLxzA8MmIs4MPYJ5B4ew==', CAST(N'2024-12-10T14:49:57.843' AS DateTime), CAST(N'2024-12-03T14:49:57.843' AS DateTime), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6ImRjMWZmMGZhLWM5MDgtNGJkZC04OWRmLTZiMmQ2YTIwYTk2OSIsIlVzZXJJZCI6Ijk1NjRlODQ5LThmMjktNDc0Zi04Mjg1LWViMDYxMzRhOTg1YSIsIlVzZXJuYW1lIjoiYWRtaW4iLCJleHAiOjE3MzMyMTM5OTcsImlzcyI6InBucCIsImF1ZCI6InBucCJ9.8-kMCdHMb8s3i5S5lez9xQ3zoDBJxaFXvJ_c7T5Xh3E', CAST(N'2024-12-03T14:49:57.847' AS DateTime), N'9564e849-8f29-474f-8285-eb06134a985a', NULL, NULL)
GO
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'a97a2289-7655-42b3-b025-02b8feb96cd6', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Trackinh\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-03T15:43:16.710' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'9287f321-2ad2-4bf4-8b4a-050ae89b1999', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T16:49:11.907' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'2ca1e0fc-61b0-4ef3-af30-06cff3cb641d', N'baner.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\baner.jpg.jpg', CAST(N'2024-12-03T11:56:58.790' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'b876dbf7-5a52-4859-9ea1-06e2f3e141a3', N'product2.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product2.jpg', CAST(N'2024-12-05T10:44:42.633' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'1488fdd9-e271-4af2-810b-08061884d503', N'ảnh 3.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\ảnh 3.jpg', CAST(N'2024-12-09T15:56:07.847' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'093e5d82-5272-4d1e-845c-08ab81475146', N'product4.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product4.jpg', CAST(N'2024-12-05T10:44:42.633' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'5a82d24b-87d8-4377-af66-0afecbd627e7', N'767fa130-01f0-4675-ab88-f80a23440fd6.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\767fa130-01f0-4675-ab88-f80a23440fd6.jpg.jpg', CAST(N'2024-12-03T11:36:22.727' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'36ea05ab-b0b8-470f-8f2b-0b5e5e06ca6f', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Trackinh\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-18T10:20:34.470' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'031d8171-9bd5-4000-855f-0c7f24e2fb34', N'767fa130-01f0-4675-ab88-f80a23440fd6.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\767fa130-01f0-4675-ab88-f80a23440fd6.jpg.jpg', CAST(N'2024-12-02T13:37:20.277' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'c494d8e6-a0a0-4f0a-9cf5-0e72dce0ced6', N'ảnh 1.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\ảnh 1.jpg', CAST(N'2024-12-13T16:48:30.407' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'582f6d8e-d72e-4831-8c28-11d7553571ea', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-03T10:00:47.950' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'67e026c0-81f8-4a28-8f00-12c686378174', N'pexels-marina-endzhirgli-725723515-28978113.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\pexels-marina-endzhirgli-725723515-28978113.jpg.jpg', CAST(N'2024-12-17T09:57:41.613' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'b868279b-d83a-4364-89fa-15bf622681b3', N'product4.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product4.jpg', CAST(N'2024-12-16T11:01:47.140' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'24a7c9b1-1042-4626-b81a-15d2815d11c7', N'logo.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\logo.jpg.jpg', CAST(N'2024-12-17T09:49:28.660' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'37228069-b73e-4ae2-840b-16adc70f9719', N'ảnh 2.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\ảnh 2.jpg', CAST(N'2024-12-13T16:46:56.163' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'2fccb3d5-2a98-4713-b0bd-1bbf797af8d6', N'baner.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\baner.jpg.jpg', CAST(N'2024-12-03T11:42:04.630' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'b4e0167c-14d7-4737-8957-1e76a18bda55', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T17:20:52.273' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'fac781f4-c2b6-4259-97e5-22d7f6e3f737', N'767fa130-01f0-4675-ab88-f80a23440fd6.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\767fa130-01f0-4675-ab88-f80a23440fd6.jpg.jpg', CAST(N'2024-12-03T11:56:58.920' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'06a07135-c99e-49b8-9d76-23826c7d486b', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T17:10:24.177' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'ee466296-fc7d-4c36-8c00-24119d2e6adf', N'ảnh 1.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\ảnh 1.jpg', CAST(N'2024-12-09T15:58:13.490' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'd2c70a71-8423-4cba-b54b-24a098a6a92a', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-02T12:07:17.313' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'6f749b4b-b419-4f65-a000-2c5e82081fe1', N'product5.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product5.jpg.jpg', CAST(N'2024-12-16T17:20:07.910' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'86e416e9-31a3-49ee-8a4b-2fac89c5ea51', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T16:57:47.290' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'0c1ec804-9c13-4003-a1d8-2fbd322d184c', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-12-02T09:23:16.647' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'28cc532b-4aec-4bba-a722-3028739fba3c', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-12-02T09:45:39.757' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'0522c3a5-fef6-4bff-8ee5-34acd8d9e34d', N'pexels-cup-of-couple-7657338.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\pexels-cup-of-couple-7657338.jpg.jpg', CAST(N'2024-12-03T15:43:17.123' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'eb0110c1-22ec-4ed7-bad8-35b6616077c1', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Trackinh\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-18T10:14:42.077' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'7b6d7fe1-75cf-4bc0-bac3-361db343024c', N'contactUs.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\contactUs.jpg.jpg', CAST(N'2024-12-16T10:00:21.177' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'bae5b58d-2803-43d8-b639-37c4d08216b4', N'ảnh 2.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\ảnh 2.jpg.jpg', CAST(N'2024-12-12T09:38:33.713' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'3389ce5a-8abd-4ce2-8cf3-3badf2f28a31', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-12-02T09:26:34.843' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'63fd238d-76c9-41e8-b756-3d29ca38e4ec', N'birdbody.png', N'.png', NULL, N'D:\Trackinh\uploadFile\birdbody.png.png', CAST(N'2024-12-02T09:30:29.267' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'ee95c349-ac14-4dc0-a1b0-3f24b1aa1a99', N'product5.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product5.jpg.jpg', CAST(N'2024-12-16T17:05:12.140' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'69414584-c89c-48a8-8136-3f2b4ab052e7', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Trackinh\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-18T10:22:04.997' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'2d452ecc-1120-402b-8afb-3f6b572c56bf', N'product1.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product1.jpg', CAST(N'2024-12-16T11:03:06.127' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'5d94e17a-1fa4-4e8c-bfa0-40d16a05b86b', N'baner.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\baner.jpg.jpg', CAST(N'2024-12-03T11:36:22.447' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'718d605f-c12a-4020-ba1d-42eec952b1e0', N'ảnh 1.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\ảnh 1.jpg.jpg', CAST(N'2024-12-18T09:09:26.757' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'ac81764b-2045-4cf1-a719-4431cec1530d', N'767fa130-01f0-4675-ab88-f80a23440fd6.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\767fa130-01f0-4675-ab88-f80a23440fd6.jpg.jpg', CAST(N'2024-12-03T11:42:04.363' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'3b0934be-aab6-4f25-b319-44df1bfdc821', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T17:19:03.577' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'c8fa6d7b-9ffe-4d91-92fa-451be43143d4', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T16:57:02.707' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'f0a47aab-7c91-4c49-990b-451f686bef01', N'product6.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product6.jpg', CAST(N'2024-12-05T10:44:58.873' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'6820ae88-2e61-41ed-b6b7-45be59eeed7d', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-02T13:49:30.293' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'17eabf99-82c4-4f52-b977-4a8844cfb761', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-02T11:32:07.223' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'0981cd2c-7db0-41a0-a011-4d3aedd7af9c', N'767fa130-01f0-4675-ab88-f80a23440fd6.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\767fa130-01f0-4675-ab88-f80a23440fd6.jpg.jpg', CAST(N'2024-12-06T16:30:39.377' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'5c9846a3-3ad2-4a33-8d48-4e243f333a68', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-12-02T09:57:36.763' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'b3652c3d-4b91-4fbc-a26d-504b9901db17', N'product.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product.jpg', CAST(N'2024-12-05T10:44:16.007' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'b615232e-b80e-480e-8d3f-513c7f59d059', N'ảnh 3.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\ảnh 3.jpg.jpg', CAST(N'2024-12-18T09:57:43.460' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'c4cbcb2b-8539-451e-a227-53b7b7c9987a', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Trackinh\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-18T10:15:10.537' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'0148b707-34fd-4c3b-9299-53f3cc6da388', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-02T12:05:56.410' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'6e1feefb-5062-471e-84aa-54c41773c622', N'pexels-marina-endzhirgli-725723515-28978113.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\pexels-marina-endzhirgli-725723515-28978113.jpg.jpg', CAST(N'2024-12-17T09:57:54.523' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'5ffb7a36-8a99-40cb-beae-572e1f3ba1e5', N'product6.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product6.jpg', CAST(N'2024-12-17T10:25:29.680' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'5535a0f6-788e-4b72-8f16-57acca1f1ba3', N'ảnh 2.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\ảnh 2.jpg.jpg', CAST(N'2024-12-12T09:39:20.160' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'7625432f-b997-4e8b-8b54-5b08a277116a', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T17:08:05.140' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'9c0e92b8-63e4-45d7-8afc-5bbaa1d0b3ad', N'ảnh 3.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\ảnh 3.jpg.jpg', CAST(N'2024-12-18T09:44:13.253' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'7b3eef9c-686c-44c2-b340-5bd7d8242e46', N'baner4.png', N'.png', NULL, N'D:\Trackinh\uploadFile\baner4.png', CAST(N'2025-01-15T22:22:53.633' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'692f08d3-baf6-4d9f-94c2-5d3031f3363c', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-02T12:03:31.663' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'50ec61cc-e557-48a2-8f6e-610911967461', N'bài 1.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\bài 1.jpg.jpg', CAST(N'2024-12-04T11:56:45.630' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'0509e0b6-d8b8-4356-9c85-62ca970e2b9e', N'ảnh 3.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\ảnh 3.jpg', CAST(N'2024-12-11T11:28:18.750' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'47155224-d4ed-4de2-ad38-634166b2878c', N'ảnh 3.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\ảnh 3.jpg.jpg', CAST(N'2024-12-09T16:19:14.590' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'4c379033-057f-4ad3-8253-636670bc89ae', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T16:55:16.340' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'f0bb3bd9-7f88-434b-8f23-66a675c15a27', N'767fa130-01f0-4675-ab88-f80a23440fd6.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\767fa130-01f0-4675-ab88-f80a23440fd6.jpg.jpg', CAST(N'2024-12-03T11:41:41.260' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'fbfe1513-3a78-4bce-8e7b-6bad19b85c1b', N'birdbody.png', N'.png', NULL, N'D:\Trackinh\uploadFile\birdbody.png.png', CAST(N'2024-11-29T16:50:57.010' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'1c299829-a17d-4b4d-b132-7775a724929e', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-12-02T09:36:38.423' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'4c04ee5c-dfc6-42e5-a8ed-7b1c24997cc5', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-12-02T09:18:47.307' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'83821cb7-85a8-4895-b8fd-7c64da638f72', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-02T12:02:10.970' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'97aa46ff-ad5f-4f5f-a93e-846390ad469b', N'ảnh 1.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\ảnh 1.jpg.jpg', CAST(N'2024-12-18T09:09:38.287' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'29dfba50-4503-4b66-b3c8-8cefcfeac3a4', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T16:59:37.320' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'651ba45a-c949-4dcb-b1ea-927db88e3775', N'pexels-antonius-ferret-6223043.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\pexels-antonius-ferret-6223043.jpg.jpg', CAST(N'2024-12-03T15:43:17.360' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'8005d949-fce7-41d2-8aa1-94201f51f35d', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-12-02T09:17:19.630' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'cf42528b-3845-4043-b746-95dc9eec7561', N'birdbody.png', N'.png', NULL, N'D:\Trackinh\uploadFile\birdbody.png.png', CAST(N'2024-12-02T09:57:13.553' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'84145b8f-b536-4f45-99c1-9bab5722225a', N'birdbody.png', N'.png', NULL, N'D:\Trackinh\uploadFile\birdbody.png.png', CAST(N'2024-11-29T16:49:29.483' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'cad4fb25-f214-4e7d-97ac-9baf22aabb1e', N'bài 1.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\bài 1.jpg.jpg', CAST(N'2024-12-05T08:59:33.740' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'70963514-3c5a-4a80-b0c4-9c6e26b7c580', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T16:45:41.517' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'899ccd16-df5b-47fa-b4f6-9ce5b0880ede', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Trackinh\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-18T10:26:29.037' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'7143a552-a8d7-420e-821c-9d3188273a18', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T17:01:29.223' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'40b95c78-3613-40f5-b257-9d511cdc90a3', N'ảnh 2.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\ảnh 2.jpg', CAST(N'2024-12-09T15:56:16.197' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'b0bc423c-2322-4210-82f6-a08f2a9b7416', N'bài 1.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\bài 1.jpg.jpg', CAST(N'2024-12-12T09:38:54.830' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'4225da6f-dd95-4102-9ab9-a2b86c42941d', N'ảnh 1.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\ảnh 1.jpg.jpg', CAST(N'2024-12-12T09:38:44.327' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'31b71eb9-08d4-4301-b3cb-a3baad3b50b1', N'ảnh 1.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\ảnh 1.jpg', CAST(N'2024-12-09T15:56:36.927' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'd10927fb-c453-4498-ace1-a4b6017b1ac6', N'ảnh 3.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\ảnh 3.jpg', CAST(N'2024-12-13T16:46:27.943' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'2c1cf068-d8a0-4e41-85f9-aa5cdecd6717', N'767fa130-01f0-4675-ab88-f80a23440fd6.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\767fa130-01f0-4675-ab88-f80a23440fd6.jpg.jpg', CAST(N'2024-12-02T11:29:41.507' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'8a2b9f33-2644-46b6-b32f-aae49167f160', N'ao-thun-icondenim-ft-marvel-deapbool-wolverine-creative_80dcf043ba4a4330b1a264d10b47eb04_compact.webp', N'.webp', NULL, N'D:\Trackinh\uploadFile\ao-thun-icondenim-ft-marvel-deapbool-wolverine-creative_80dcf043ba4a4330b1a264d10b47eb04_compact.webp', CAST(N'2025-01-23T14:56:28.167' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'06586b15-154e-4517-b7c4-ac61a9649019', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-02T12:01:26.270' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'1617d801-cad8-405d-a084-ac6fb83af589', N'product1.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product1.jpg', CAST(N'2024-12-05T10:44:28.950' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'758b8ebe-433b-43d8-b7c1-acf483c19428', N'ảnh 3.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\ảnh 3.jpg', CAST(N'2024-12-13T16:47:21.167' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'6b522667-9e33-4f38-b103-ae40a0a88ebd', N'1.png', N'.png', NULL, N'D:\Trackinh\uploadFile\1.png.png', CAST(N'2024-12-18T12:40:32.047' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'f6a3f452-f863-4689-a45d-af7cf9ba157f', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-03T10:26:38.380' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'f5a1d8bf-39a6-496b-9f6f-af9be9d7466f', N'product6.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product6.jpg', CAST(N'2024-12-16T11:03:53.697' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'ef563ddc-80bf-4c60-8f3a-b125b25dc189', N'42663ezc.png', N'.png', NULL, N'D:\Trackinh\uploadFile\42663ezc.png.png', CAST(N'2024-12-02T09:47:15.150' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'7f39d840-0f44-4ffc-a433-b24724a1e26b', N'R.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\R.jpg', CAST(N'2025-01-23T14:56:28.170' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'409591fd-b8a0-4735-9a9e-b30ffcc0dcdf', N'ảnh 3.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\ảnh 3.jpg.jpg', CAST(N'2024-12-18T09:45:16.493' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'109e0be2-782a-424b-95ff-b7e378f29b53', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-03T10:33:56.160' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'd2b469cf-4cff-45dd-8310-b9cc3f6a138e', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T17:00:01.880' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'523380ed-a438-449d-b40e-be3a47be05d2', N'banner_kv__pc_88db980b203a4385a39f05b3a3b7a8d2.png', N'.png', NULL, N'D:\Trackinh\uploadFile\banner_kv__pc_88db980b203a4385a39f05b3a3b7a8d2.png', CAST(N'2025-01-16T15:53:28.140' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'26f1a10e-d733-4dc4-a05c-c05eca46e465', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-07T23:41:34.930' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'afe459f5-afeb-4190-b102-c7fc4c4db260', N'product2.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product2.jpg', CAST(N'2024-12-16T11:03:06.123' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'3025e2d5-6f51-48a2-aa83-c80af71dc354', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-03T11:56:58.037' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'1797fc4b-55dc-4b26-8b3d-c8478a3f0882', N'767fa130-01f0-4675-ab88-f80a23440fd6.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\767fa130-01f0-4675-ab88-f80a23440fd6.jpg.jpg', CAST(N'2024-12-02T13:42:57.620' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'991129bb-ddb6-4063-8d0a-c94749ae8ac6', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T17:01:05.013' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'd7e20130-4100-4e16-8d57-c9cf38d7fe6c', N'ảnh 3.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\ảnh 3.jpg', CAST(N'2024-12-11T11:29:15.037' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'b6a6866f-4a14-4477-97e0-cad79b352892', N'birdbody.png', N'.png', NULL, N'D:\Trackinh\uploadFile\birdbody.png.png', CAST(N'2024-11-29T16:52:44.960' AS DateTime), NULL)
GO
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'0bf217c6-e719-44aa-a41e-ccad5b21ae68', N'pexels-polina-kovaleva-7511848.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\pexels-polina-kovaleva-7511848.jpg.jpg', CAST(N'2024-12-03T15:43:17.580' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'325d5fd9-8bcd-43df-9053-ceb8b921ff65', N'ảnh 3.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\ảnh 3.jpg.jpg', CAST(N'2024-12-18T10:26:39.553' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'd513e4f8-84c3-4a35-9213-cf84dc5fefb1', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-03T15:46:52.610' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'efb433ad-4fee-4e08-a0ad-cfad78d3e7f4', N'product5.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product5.jpg.jpg', CAST(N'2024-12-16T17:23:24.640' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'c9cf89da-ce7d-48fe-96fa-d0aab3ecfb4b', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-03T10:32:32.317' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'968397ca-7a00-4b41-848e-d113a66cd230', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T17:09:06.087' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'303214c7-0d74-49ac-8bca-d19b969b1ded', N'z5682878376957_baecfc34bc07252d24e5556969056843_a34e0259c86c4fd98437ec13137ae24c_1024x1024.webp', N'.webp', NULL, N'D:\Trackinh\uploadFile\z5682878376957_baecfc34bc07252d24e5556969056843_a34e0259c86c4fd98437ec13137ae24c_1024x1024.webp', CAST(N'2025-01-23T14:56:28.243' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'8f461886-54d5-433a-9b90-d325b5486756', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-02T11:26:58.760' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'ffe43a2d-2d09-48b9-9558-d7536118c2aa', N'baner.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\baner.jpg.jpg', CAST(N'2024-12-03T11:41:41.447' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'9870c6e0-3a55-4198-8176-d7ca4280d8c0', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-02T13:43:06.123' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'f2a049c5-51c1-4ae3-a69c-d9bf31c854e7', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-06T16:34:20.640' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'cd193eba-ac32-40bb-8b8e-dd464358a8b1', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-02T10:48:39.793' AS DateTime), N'3fa85f64-5717-4562-b3fc-2c963f66afa6')
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'2050262d-634b-498b-88df-de2b6531e628', N'policies_icon_4.webp', N'.webp', NULL, N'D:\Trackinh\uploadFile\policies_icon_4.webp', CAST(N'2025-01-23T11:55:25.553' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'aabd6644-3573-43e5-a571-e05752b96753', N'bài 1.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\bài 1.jpg.jpg', CAST(N'2024-12-07T23:41:09.077' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'5f7aaa9d-b4d6-4967-9560-e08ccbf54935', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-02T13:45:48.027' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'a9ba7582-2165-4251-be6f-e491c5ec7669', N'banner1.png', N'.png', NULL, N'D:\Trackinh\uploadFile\banner1.png', CAST(N'2025-01-15T22:22:22.703' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'45ed6d2d-264d-4190-a389-eb7936c27ab4', N'26f1a10e-d733-4dc4-a05c-c05eca46e465.webp', N'.webp', NULL, N'D:\Tracking\uploadFile\26f1a10e-d733-4dc4-a05c-c05eca46e465.webp.webp', CAST(N'2024-12-11T09:38:27.323' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'7a03c8b3-6e15-41c0-a78d-ec230c1339a6', N'bài 1.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\bài 1.jpg.jpg', CAST(N'2024-12-04T11:56:31.013' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'2230373b-ca66-480e-8b3f-ecab8f649931', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-03T10:24:49.583' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'ddd419cb-1329-4e1c-8551-ee15fece81ec', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T16:48:28.157' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'909e38d8-ad2b-4e73-b506-f218e3194332', N'ảnh 3.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\ảnh 3.jpg', CAST(N'2024-12-11T11:28:32.737' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'eb26354e-66c0-46c2-a097-f5830762c597', N'42663ezc.png', N'.png', NULL, N'D:\Trackinh\uploadFile\42663ezc.png.png', CAST(N'2024-12-02T09:50:37.300' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'07ebce0f-32b3-45e5-8e86-f60567af55cf', N'contactUs1.jpeg', N'.jpeg', NULL, N'D:\Tracking\uploadFile\contactUs1.jpeg.jpeg', CAST(N'2024-12-03T10:26:27.660' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'6c2c637e-3075-45a6-9edd-f631dd0a3612', N'ảnh 3.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\ảnh 3.jpg.jpg', CAST(N'2024-12-12T09:38:23.573' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'7129f762-9926-4e39-9445-f67e9fd6a9ca', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T17:12:50.700' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'e1f92414-b029-4ffa-b960-f86f68327aa3', N'ảnh 3.jpg', N'.jpg', NULL, N'D:\Tracking\uploadFile\ảnh 3.jpg.jpg', CAST(N'2024-12-12T09:39:12.493' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'ef817181-c9a0-4b94-b092-f88cbd7b870c', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-12-02T09:18:11.837' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'4f85c5b4-94a5-440f-8d8a-fb7476dd0b23', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T17:20:08.917' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'1d25d4ff-706b-4ba1-9086-fb7b46b02c86', N'product5.jpg', N'.jpg', NULL, N'D:\Trackinh\uploadFile\product5.jpg', CAST(N'2024-12-16T11:03:06.120' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'9e591fa8-9757-4912-a2bc-fbafcbc49ab6', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-11-29T17:11:48.110' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'a42fae49-e4ff-4b8b-98a7-fd0182359543', N'banner3.png', N'.png', NULL, N'D:\Trackinh\uploadFile\banner3.png', CAST(N'2025-01-15T22:22:41.200' AS DateTime), NULL)
INSERT [dbo].[Resource] ([Id], [FileName], [Extension], [FileType], [FilePath], [CreatedDate], [CreatedBy]) VALUES (N'98b496da-8662-442b-8676-fd5a0ff8dfa8', N'AWS region.png', N'.png', NULL, N'D:\Trackinh\uploadFile\AWS region.png.png', CAST(N'2024-12-02T09:42:18.857' AS DateTime), NULL)
GO
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (N'ace04c98-735e-413e-ba21-05b057596d64', N'thẻ 6')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (N'e76ebd89-d2af-48d7-81e2-6ded0e607e2f', N'thẻ 1')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (N'a69a52ab-2a25-4e0a-94bb-ba757a46e9dd', N'thẻ 4')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (N'e4e22aea-3714-45bc-98cd-c103912fe675', N'thẻ 3')
INSERT [dbo].[Tag] ([Id], [Name]) VALUES (N'f897d23c-b998-433a-a4eb-de5d9b0f291a', N'thẻ 9')
GO
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [IsStaff], [FullName], [Phone], [Address], [Email], [Actived], [Note]) VALUES (N'2f3d077c-e3e7-4b61-843b-9090478a7490', N'admin4', N'ABUlt9iNSB74l/uzKYd6TsoDhCd87AuOWIU5OoECj7OiGo2rHHZmCvGD7iRWpE/htA==', NULL, NULL, NULL, NULL, NULL, N'admin', NULL, NULL)
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [IsStaff], [FullName], [Phone], [Address], [Email], [Actived], [Note]) VALUES (N'c70a67a7-4149-4a1f-aeab-e5f93c47176d', N'admin2', N'ABm5BEqUCPJXJ3K1unKoWt+PyL5F8/LecjFJhXx2cPAjKJFGPbwLcmBzPGOAzoIoYw==', NULL, 0, N'', NULL, NULL, NULL, 1, NULL)
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [IsStaff], [FullName], [Phone], [Address], [Email], [Actived], [Note]) VALUES (N'9564e849-8f29-474f-8285-eb06134a985a', N'admin', N'ALwhKgGQAi59RX0KsSLnl3d/ZTg4ybh0N3CXb+4keH3A/3NWLT7bTK2D9plh6jn0sQ==', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[User] ([Id], [Username], [Password], [RoleId], [IsStaff], [FullName], [Phone], [Address], [Email], [Actived], [Note]) VALUES (N'26410e85-b587-46ce-b0b8-fbe61bd7db4d', N'admin1', N'AF8KMNDUwuqmWt/IbW2CqqpOuwXkYyNlBYXitRVkefnnCjXSlkVpQ58/gIIz9xK72w==', NULL, 0, N'Trịnh Ngọc Trường', N'0353129941', N'Thanh Hóa', N'2002ngoctruong@gmail.com', 1, NULL)
GO
ALTER TABLE [dbo].[Brand] ADD  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[Category] ADD  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[ProductPrice] ADD  DEFAULT (newid()) FOR [Id]
GO
USE [master]
GO
ALTER DATABASE [PnpWeb] SET  READ_WRITE 
GO
