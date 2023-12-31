USE [master]
GO
/****** Object:  Database [jxsk]    Script Date: 2021/12/3 12:28:16 ******/
CREATE DATABASE [jxsk]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'jxsk', FILENAME = N'C:\Users\Administrator\Desktop\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\jxsk.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'jxsk_log', FILENAME = N'C:\Users\Administrator\Desktop\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\jxsk_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [jxsk] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [jxsk].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [jxsk] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [jxsk] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [jxsk] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [jxsk] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [jxsk] SET ARITHABORT OFF 
GO
ALTER DATABASE [jxsk] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [jxsk] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [jxsk] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [jxsk] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [jxsk] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [jxsk] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [jxsk] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [jxsk] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [jxsk] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [jxsk] SET  DISABLE_BROKER 
GO
ALTER DATABASE [jxsk] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [jxsk] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [jxsk] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [jxsk] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [jxsk] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [jxsk] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [jxsk] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [jxsk] SET RECOVERY FULL 
GO
ALTER DATABASE [jxsk] SET  MULTI_USER 
GO
ALTER DATABASE [jxsk] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [jxsk] SET DB_CHAINING OFF 
GO
ALTER DATABASE [jxsk] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [jxsk] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [jxsk] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [jxsk] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'jxsk', N'ON'
GO
ALTER DATABASE [jxsk] SET QUERY_STORE = OFF
GO
USE [jxsk]
GO
/****** Object:  ApplicationRole [Teacher1]    Script Date: 2021/12/3 12:28:16 ******/
/* To avoid disclosure of passwords, the password is generated in script. */
declare @idx as int
declare @randomPwd as nvarchar(64)
declare @rnd as float
select @idx = 0
select @randomPwd = N''
select @rnd = rand((@@CPU_BUSY % 100) + ((@@IDLE % 100) * 100) + 
       (DATEPART(ss, GETDATE()) * 10000) + ((cast(DATEPART(ms, GETDATE()) as int) % 100) * 1000000))
while @idx < 64
begin
   select @randomPwd = @randomPwd + char((cast((@rnd * 83) as int) + 43))
   select @idx = @idx + 1
select @rnd = rand()
end
declare @statement nvarchar(4000)
select @statement = N'CREATE APPLICATION ROLE [Teacher1] WITH DEFAULT_SCHEMA = [dbo], ' + N'PASSWORD = N' + QUOTENAME(@randomPwd,'''')
EXEC dbo.sp_executesql @statement
GO
/****** Object:  DatabaseRole [Teacher]    Script Date: 2021/12/3 12:28:16 ******/
CREATE ROLE [Teacher]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 2021/12/3 12:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Sno] [nchar](5) NOT NULL,
	[Sname] [nchar](10) NULL,
	[Cno] [nchar](1) NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[Sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Class]    Script Date: 2021/12/3 12:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[Cno] [nchar](1) NOT NULL,
	[Zhuanye] [nchar](10) NULL,
	[Sdept] [nchar](10) NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[Cno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Student_View]    Script Date: 2021/12/3 12:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Student_View]
AS
SELECT  dbo.Class.Cno, dbo.Class.Zhuanye, dbo.Class.Sdept, dbo.Student.Sno, dbo.Student.Sname
FROM      dbo.Class INNER JOIN
                   dbo.Student ON dbo.Class.Cno = dbo.Student.Cno
GO
/****** Object:  Table [dbo].[Course]    Script Date: 2021/12/3 12:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[Kno] [nchar](5) NOT NULL,
	[Kname] [nchar](10) NULL,
	[Term] [nchar](1) NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[Kno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Grade]    Script Date: 2021/12/3 12:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grade](
	[Kno] [nchar](5) NOT NULL,
	[Sno] [nchar](5) NOT NULL,
	[Term] [nchar](1) NOT NULL,
	[Grade] [int] NULL,
 CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED 
(
	[Kno] ASC,
	[Sno] ASC,
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Grade_View]    Script Date: 2021/12/3 12:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Grade_View]
AS
SELECT  TOP (100) PERCENT dbo.Course.Kname, dbo.Grade.Sno, dbo.Grade.Term, dbo.Grade.Grade, dbo.Grade.Kno
FROM      dbo.Grade INNER JOIN
                   dbo.Course ON dbo.Grade.Kno = dbo.Course.Kno
GO
/****** Object:  Table [dbo].[Power]    Script Date: 2021/12/3 12:28:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Power](
	[Num] [nchar](5) NOT NULL,
	[Type] [nchar](2) NULL,
	[Name] [nchar](10) NULL,
	[Password] [nchar](5) NULL,
 CONSTRAINT [PK_Power] PRIMARY KEY CLUSTERED 
(
	[Num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Class] ([Cno], [Zhuanye], [Sdept]) VALUES (N'0', N'1213      ', N'123       ')
INSERT [dbo].[Class] ([Cno], [Zhuanye], [Sdept]) VALUES (N'1', N'软件工程      ', N'计算机       ')
INSERT [dbo].[Class] ([Cno], [Zhuanye], [Sdept]) VALUES (N'2', N'计算机       ', N'计算机       ')
INSERT [dbo].[Class] ([Cno], [Zhuanye], [Sdept]) VALUES (N'3', N'网络工程      ', N'计算机       ')
INSERT [dbo].[Class] ([Cno], [Zhuanye], [Sdept]) VALUES (N'4', N'材料        ', N'材料        ')
INSERT [dbo].[Class] ([Cno], [Zhuanye], [Sdept]) VALUES (N'5', N'环境        ', N'环境        ')
INSERT [dbo].[Class] ([Cno], [Zhuanye], [Sdept]) VALUES (N'6', N'马克思       ', N'马克思       ')
INSERT [dbo].[Class] ([Cno], [Zhuanye], [Sdept]) VALUES (N'7', N'毛概        ', N'马克思       ')
INSERT [dbo].[Class] ([Cno], [Zhuanye], [Sdept]) VALUES (N'8', N'概率论       ', N'数学        ')
INSERT [dbo].[Class] ([Cno], [Zhuanye], [Sdept]) VALUES (N'9', N'线性代数      ', N'数学        ')
GO
INSERT [dbo].[Course] ([Kno], [Kname], [Term]) VALUES (N'11111', N'ccca      ', N'6')
INSERT [dbo].[Course] ([Kno], [Kname], [Term]) VALUES (N'12138', N'bbb       ', N'7')
INSERT [dbo].[Course] ([Kno], [Kname], [Term]) VALUES (N'12222', N'ab        ', N'3')
INSERT [dbo].[Course] ([Kno], [Kname], [Term]) VALUES (N'30001', N'Java      ', N'1')
INSERT [dbo].[Course] ([Kno], [Kname], [Term]) VALUES (N'30002', N'C语言       ', N'2')
INSERT [dbo].[Course] ([Kno], [Kname], [Term]) VALUES (N'30003', N'计算机网络     ', N'1')
INSERT [dbo].[Course] ([Kno], [Kname], [Term]) VALUES (N'30004', N'材料        ', N'2')
INSERT [dbo].[Course] ([Kno], [Kname], [Term]) VALUES (N'30005', N'环境        ', N'1')
INSERT [dbo].[Course] ([Kno], [Kname], [Term]) VALUES (N'30006', N'马克思       ', N'2')
INSERT [dbo].[Course] ([Kno], [Kname], [Term]) VALUES (N'30007', N'毛概        ', N'1')
INSERT [dbo].[Course] ([Kno], [Kname], [Term]) VALUES (N'30008', N'概率论       ', N'2')
INSERT [dbo].[Course] ([Kno], [Kname], [Term]) VALUES (N'30009', N'线性代数      ', N'1')
GO
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'10001', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'10002', N'1', 90)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'10003', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'10004', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'10005', N'1', 50)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'10006', N'1', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'10007', N'1', 50)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'10008', N'1', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'10009', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'10010', N'1', 58)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'10011', N'1', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'20001', N'1', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'20002', N'1', 62)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'20004', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'20005', N'1', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'20006', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'20007', N'1', 65)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'20008', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'20009', N'1', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30001', N'20010', N'1', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'10001', N'2', 90)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'10002', N'2', 59)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'10003', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'10004', N'2', 79)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'10005', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'10006', N'2', 76)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'10007', N'2', 55)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'10008', N'2', 65)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'10009', N'2', 65)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'10010', N'2', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'10011', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'20001', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'20003', N'2', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'20004', N'2', 62)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'20005', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'20006', N'2', 69)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'20007', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'20008', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'20009', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'20010', N'2', 72)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'30001', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'30002', N'2', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'30003', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'30004', N'2', 64)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'30005', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'30006', N'2', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'30007', N'2', 76)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'30008', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'30009', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'30010', N'2', 86)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30002', N'30011', N'2', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'10001', N'1', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'10002', N'1', 88)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'10003', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'10004', N'1', 88)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'10005', N'1', 62)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'10006', N'1', 78)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'10007', N'1', 56)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'10008', N'1', 64)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'10009', N'1', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'10010', N'1', 68)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'10011', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'20001', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'20003', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'20004', N'1', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'20005', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'20006', N'1', 64)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'20007', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'20008', N'1', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'20009', N'1', 72)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'20010', N'1', 90)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'30001', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'30002', N'1', 90)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'30003', N'1', 83)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'30004', N'1', 63)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'30005', N'1', 62)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'30006', N'1', 75)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'30007', N'1', 54)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'30008', N'1', 62)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'30009', N'1', 69)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'30010', N'1', 89)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30003', N'30011', N'1', 75)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30004', N'40004', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30005', N'50005', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'10001', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'10002', N'2', 77)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'10003', N'2', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'10004', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'10005', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'10006', N'2', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'10007', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'10008', N'2', 77)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'10009', N'2', 68)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'10010', N'2', 69)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'10011', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'20001', N'2', 65)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'20002', N'1', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'20002', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'20003', N'2', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'20004', N'2', 69)
GO
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'20005', N'2', 62)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'20006', N'2', 58)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'20007', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'20008', N'2', 75)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'20009', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'20010', N'2', 85)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'30001', N'2', 75)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'30002', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'30003', N'2', 96)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'30004', N'2', 62)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'30005', N'2', 75)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'30006', N'2', 72)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'30007', N'2', 63)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'30008', N'2', 61)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'30009', N'2', 67)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'30010', N'2', 87)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'30011', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'40004', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'50005', N'2', 62)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'60006', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'70007', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'80008', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30006', N'90009', N'2', 75)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'10001', N'1', 89)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'10002', N'1', 99)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'10003', N'1', 76)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'10004', N'1', 75)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'10005', N'1', 76)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'10006', N'1', 69)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'10007', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'10008', N'1', 79)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'10009', N'1', 65)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'10010', N'1', 76)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'10011', N'1', 62)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'20001', N'1', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'20002', N'1', 75)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'20002', N'2', 75)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'20003', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'20004', N'1', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'20005', N'1', 65)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'20006', N'1', 50)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'20007', N'1', 75)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'20008', N'1', 62)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'20009', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'20010', N'1', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'30001', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'30002', N'1', 72)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'30003', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'30004', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'30005', N'1', 67)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'30006', N'1', 63)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'30007', N'1', 68)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'30008', N'1', 63)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'30009', N'1', 86)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'30010', N'1', 90)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'30011', N'1', 72)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'40004', N'1', 72)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'50005', N'1', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'60006', N'1', 69)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'70007', N'1', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'80008', N'1', 92)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30007', N'90009', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'10001', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'10002', N'2', 88)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'10003', N'2', 79)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'10004', N'2', 76)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'10005', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'10006', N'2', 67)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'10007', N'2', 61)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'10008', N'2', 68)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'10009', N'2', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'10010', N'2', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'10011', N'2', 63)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'20001', N'2', 69)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'20003', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'20004', N'2', 72)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'20005', N'2', 68)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'20006', N'2', 69)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'20007', N'2', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'20008', N'2', 72)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'20009', N'2', 88)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'20010', N'2', 86)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'30001', N'2', 85)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'30002', N'2', 71)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'30003', N'2', 70)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'30004', N'2', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'30005', N'2', 62)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'30006', N'2', 68)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'30007', N'2', 72)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'30008', N'2', 85)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'30009', N'2', 78)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'30010', N'2', 92)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'30011', N'2', 75)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'40004', N'2', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'50005', N'2', 69)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'60006', N'2', 64)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'70007', N'2', 69)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'80008', N'2', 76)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30008', N'90009', N'2', 76)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'10001', N'1', 85)
GO
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'10002', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'10003', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'10004', N'1', 92)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'10005', N'1', 64)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'10006', N'1', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'10007', N'1', 62)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'10008', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'10009', N'1', 69)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'10010', N'1', 88)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'10011', N'1', 65)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'20001', N'1', 75)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'20003', N'1', 66)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'20004', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'20005', N'1', 67)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'20006', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'20007', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'20008', N'1', 71)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'20009', N'1', 82)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'20010', N'1', 76)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'30001', N'1', 90)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'30002', N'1', 76)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'30003', N'1', 74)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'30004', N'1', 63)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'30005', N'1', 63)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'30006', N'1', 63)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'30007', N'1', 64)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'30008', N'1', 60)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'30009', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'30010', N'1', 86)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'30011', N'1', 73)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'80008', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'30009', N'90009', N'1', 80)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'40008', N'40008', N'1', 100)
INSERT [dbo].[Grade] ([Kno], [Sno], [Term], [Grade]) VALUES (N'40009', N'40009', N'1', 100)
GO
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'10001', N'教师', N'周一        ', N'20003')
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'10002', N'教师', N'周二        ', N'10002')
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'10003', N'教师', N'周三        ', N'10003')
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'10004', N'教师', N'周四        ', N'10004')
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'10005', N'教师', N'周五        ', N'10005')
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'20001', N'学生', N'王一        ', N'20001')
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'20002', N'学生', N'王二        ', N'20002')
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'20003', N'学生', N'王三        ', N'20003')
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'20004', N'学生', N'王四        ', N'20004')
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'20005', N'学生', N'王五        ', N'20005')
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'20006', N'学生', N'王六        ', N'20006')
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'20007', N'学生', N'王七        ', N'20007')
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'20008', N'学生', N'王八        ', N'20008')
INSERT [dbo].[Power] ([Num], [Type], [Name], [Password]) VALUES (N'20009', N'学生', N'王九        ', N'20009')
GO
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'10002', N'一班2号      ', N'1')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'10003', N'一班3号      ', N'1')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'10004', N'一班4号      ', N'1')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'10005', N'一班5号      ', N'1')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'10006', N'一班6号      ', N'1')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'10007', N'一班7号      ', N'1')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'10008', N'一班8号      ', N'1')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'10009', N'一班9号      ', N'1')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'10010', N'一班10号     ', N'1')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'10011', N'一班11号     ', N'1')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'11123', N'abc       ', N'4')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'20001', N'二班1号      ', N'2')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'20002', N'二班2号      ', N'2')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'20003', N'二班3号      ', N'2')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'20004', N'二班4号      ', N'2')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'20005', N'学生6       ', NULL)
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'20006', N'二班6号      ', N'2')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'20007', N'二班7号      ', N'2')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'20008', N'二班8号      ', N'2')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'20009', N'学生九       ', NULL)
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'20010', N'二班10号     ', N'2')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'30001', N'三班1号      ', N'3')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'30002', N'三班2号      ', N'3')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'30003', N'三班3号      ', N'3')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'30004', N'三班4号      ', N'3')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'30005', N'三班5号      ', N'3')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'30006', N'三班6号      ', N'3')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'30007', N'三班7号      ', N'3')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'30008', N'三班8号      ', N'3')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'30009', N'三班9号      ', N'3')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'30010', N'三班10号     ', N'3')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'30011', N'三班11号     ', N'3')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'40004', N'四班4号      ', N'4')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'50005', N'五班5号      ', N'5')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'60006', N'六班6号      ', N'6')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'70007', N'七班7号      ', N'7')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'80008', N'八班8号      ', N'8')
INSERT [dbo].[Student] ([Sno], [Sname], [Cno]) VALUES (N'90009', N'九班9号      ', N'3')
GO
ALTER TABLE [dbo].[Power]  WITH CHECK ADD  CONSTRAINT [isType] CHECK  (([Type]='学生' OR [Type]='教师'))
GO
ALTER TABLE [dbo].[Power] CHECK CONSTRAINT [isType]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Course"
            Begin Extent = 
               Top = 100
               Left = 334
               Bottom = 241
               Right = 495
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Grade"
            Begin Extent = 
               Top = 57
               Left = 79
               Bottom = 220
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Grade_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Grade_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Class"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 202
               Right = 171
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Student"
            Begin Extent = 
               Top = 10
               Left = 219
               Bottom = 169
               Right = 418
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Student_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Student_View'
GO
USE [master]
GO
ALTER DATABASE [jxsk] SET  READ_WRITE 
GO
