USE [master]
GO
/****** Object:  Database [SmashedCloudTollManagment]    Script Date: 1/1/2023 6:20:57 PM ******/
CREATE DATABASE [SmashedCloudTollManagment]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SmashedCloudTollManagment', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.YAWAR\MSSQL\DATA\SmashedCloudTollManagment.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SmashedCloudTollManagment_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.YAWAR\MSSQL\DATA\SmashedCloudTollManagment_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SmashedCloudTollManagment] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SmashedCloudTollManagment].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SmashedCloudTollManagment] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET ARITHABORT OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET RECOVERY FULL 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET  MULTI_USER 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SmashedCloudTollManagment] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SmashedCloudTollManagment] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SmashedCloudTollManagment', N'ON'
GO
ALTER DATABASE [SmashedCloudTollManagment] SET QUERY_STORE = OFF
GO
USE [SmashedCloudTollManagment]
GO
/****** Object:  User [yaw]    Script Date: 1/1/2023 6:20:57 PM ******/
CREATE USER [yaw] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[TollEntryAndExit]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TollEntryAndExit](
	[TollEntryAndExitId] [int] IDENTITY(1,1) NOT NULL,
	[EnteringTollInterChangeId] [int] NOT NULL,
	[EnteringDateTime] [datetime] NOT NULL,
	[ExitingTollInterChangeId] [int] NULL,
	[ExitingDateTime] [datetime] NULL,
	[VehicleNumberPlate] [varchar](10) NOT NULL,
	[UpdatedBy] [nvarchar](128) NULL,
	[UpdatedDateTime] [datetime] NULL,
	[AddedBy] [nvarchar](128) NOT NULL,
	[AddedDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_TollEntryAndExit] PRIMARY KEY CLUSTERED 
(
	[TollEntryAndExitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TollInterchange]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TollInterchange](
	[TollInterChangeId] [int] NOT NULL,
	[TollInterchangeTitle] [varchar](200) NOT NULL,
	[DistanceInKm] [float] NOT NULL,
	[AddedBy] [nvarchar](128) NOT NULL,
	[AddedDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetTollEntryAndExitInfo]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[GetTollEntryAndExitInfo](
@VehicleNumberPlate varchar(10),
@ExitingTollInterChangeId int ,
@ExitingDateTime datetime
)     
returns table       
as      
return(
Select 
	TollEntryAndExitId,
	EnteringTollInterChangeId,
	EnteringDateTime,
	ExitingTollInterChangeId,
	ExitingDateTime,
	VehicleNumberPlate,
	EnteringTollInterchange.DistanceInKm as EnteringDistanceInKm,
	EnteringTollInterchange.TollInterchangeTitle as EnteringTollInterchangeTitle,
	ExitingTollInterchange.DistanceInKm as ExitingDistanceInKm,
	ExitingTollInterchange.TollInterchangeTitle as ExitingTollInterchangeTitle
	

from TollEntryAndExit

inner join TollInterchange EnteringTollInterchange
on EnteringTollInterchange.TollInterChangeId = TollEntryAndExit.EnteringTollInterChangeId

inner join TollInterchange ExitingTollInterchange
on ExitingTollInterchange.TollInterChangeId = TollEntryAndExit.ExitingTollInterChangeId

where TollEntryAndExit.IsDeleted = 'false' 
	and VehicleNumberPlate = @VehicleNumberPlate
	and ExitingDateTime  = @ExitingDateTime 
) 
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpecialDay]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpecialDay](
	[SpecialDayId] [int] IDENTITY(1,1) NOT NULL,
	[DayTile] [varchar](20) NOT NULL,
	[DayNumber] [int] NULL,
	[DayDate] [date] NULL,
	[ExtraChargeAmountPercentage] [float] NULL,
	[DiscountPercentage] [float] NULL,
	[SpecialDiscountTypeId] [int] NULL,
	[AddedBy] [nvarchar](128) NOT NULL,
	[AddedDateTime] [datetime] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_SpecialDay] PRIMARY KEY CLUSTERED 
(
	[SpecialDayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SpecialDiscountType]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SpecialDiscountType](
	[SpecialDiscountTypeId] [int] NOT NULL,
	[SpecialDayTypeTitle] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 1/1/2023 6:20:57 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 1/1/2023 6:20:57 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 1/1/2023 6:20:57 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RoleId]    Script Date: 1/1/2023 6:20:57 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 1/1/2023 6:20:57 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 1/1/2023 6:20:57 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SpecialDay] ADD  CONSTRAINT [DF_SpecialDay_AddedDateTime]  DEFAULT (getdate()) FOR [AddedDateTime]
GO
ALTER TABLE [dbo].[SpecialDay] ADD  CONSTRAINT [DF_SpecialDay_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[TollEntryAndExit] ADD  CONSTRAINT [DF_TollEntryAndExit_AddedDateTime1]  DEFAULT (getdate()) FOR [UpdatedDateTime]
GO
ALTER TABLE [dbo].[TollEntryAndExit] ADD  CONSTRAINT [DF_TollEntryAndExit_AddedDateTime]  DEFAULT (getdate()) FOR [AddedDateTime]
GO
ALTER TABLE [dbo].[TollEntryAndExit] ADD  CONSTRAINT [DF_TollEntryAndExit_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[TollInterchange] ADD  CONSTRAINT [DF_TollInterchange_AddedDateTime]  DEFAULT (getdate()) FOR [AddedDateTime]
GO
ALTER TABLE [dbo].[TollInterchange] ADD  CONSTRAINT [DF_TollInterchange_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
/****** Object:  StoredProcedure [dbo].[EnterVehicle]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[EnterVehicle]
@EnteringTollInterChangeId int,
@EnteringDateTime datetime,
@VehicleNumberPlate varchar(10),
@AddedBy nvarchar(128)
as 
insert into TollEntryAndExit
(
EnteringTollInterChangeId,
EnteringDateTime,
VehicleNumberPlate,
AddedBy

)
values
(
@EnteringTollInterChangeId,
@EnteringDateTime,
@VehicleNumberPlate,
@AddedBy
)

select SCOPE_IDENTITY() as int
GO
/****** Object:  StoredProcedure [dbo].[GetAndUpdateVehicleExit]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[GetAndUpdateVehicleExit]
@VehicleNumberPlate varchar(10),
@ExitingTollInterChangeId int ,
@ExitingDateTime datetime,
@UpdatedBy nvarchar(128) -- loggedin User Id
as 


Update TollEntryAndExit 
set 
ExitingTollInterChangeId = @ExitingTollInterChangeId,
ExitingDateTime = @ExitingDateTime,
UpdatedBy = @UpdatedBy,
UpdatedDateTime = getdate()


where IsDeleted = 'false' 
	and VehicleNumberPlate = @VehicleNumberPlate
	and ExitingDateTime is null


------------------------------------------


select * from dbo.[GetTollEntryAndExitInfo](@VehicleNumberPlate,@ExitingTollInterChangeId,@ExitingDateTime)
GO
/****** Object:  StoredProcedure [dbo].[GetSpecialDays]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetSpecialDays]
@exitDate date
as
select top(1)
SpecialDay.SpecialDayId,
SpecialDay.DayTile,
SpecialDay.DayNumber,
SpecialDay.DayDate,
SpecialDay.ExtraChargeAmountPercentage,
SpecialDay.DiscountPercentage,
SpecialDay.SpecialDiscountTypeId


from SpecialDay 
left join SpecialDiscountType
on SpecialDay.SpecialDiscountTypeId = SpecialDiscountType.SpecialDiscountTypeId

where SpecialDay.DayNumber = DATEPART(WEEKDAY,@exitDate) or 
				( DAY(SpecialDay.DayDate) =  DAY(@exitDate) 
					and  Month(SpecialDay.DayDate) =  Month(@exitDate) )  
order by SpecialDay.DayDate
GO
/****** Object:  StoredProcedure [dbo].[GetTollInterchange]    Script Date: 1/1/2023 6:20:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetTollInterchange]
@TollInterchangeId int
as 
select * from TollInterchange 
where IsDeleted = 'false' 
	and TollInterchangeId = coalesce(@TollInterchangeId,TollInterchangeId)
	-- if @TollInterchangeId is passed get specific(sinlge) TollInterchange else get all TollInterchanges
GO
USE [master]
GO
ALTER DATABASE [SmashedCloudTollManagment] SET  READ_WRITE 
GO
