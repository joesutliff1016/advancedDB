/*
	Author: Joe Programmer
	Description: Creates the forum database
	Date: July 19th, 2017
*/

IF DB_ID('ForumDB') IS NOT NULL
BEGIN
	DROP DATABASE ForumDB
END
GO
CREATE DATABASE ForumDB
GO

USE ForumDB
GO

/********************************************************************
	CREATE TABLES
**********************************************************************/

CREATE TABLE Account
(
	AccountID	int	PRIMARY KEY IDENTITY(1000, 1)
	,Username	varchar(50)	UNIQUE NOT NULL
		CHECK(LEN(Username) >= 5)
	,PasswordHash	varchar(255) NOT NULL
	,PasswordSalt	varchar(100) NOT NULL
	--The URL of the profile picture
	,ProfilePic		varchar(300) NULL
	-- https://en.wikipedia.org/wiki/Email_address
	,Email			varchar(254) NOT NULL UNIQUE
	,IsVerified		bit		NOT NULL DEFAULT 'false'
	,JoinDate		datetime2(2) NOT NULL
	,NumStrikes		tinyint	NULL
	,IsDeleted		bit		NOT NULL DEFAULT 'false'
)
GO


CREATE TABLE Thread
(
	ThreadID	int		PRIMARY KEY IDENTITY
	,CreatorID	int				NOT NULL
		REFERENCES Account (AccountID)
	,Title		varchar(50)		NOT NULL
	--datetime2(0) accurate to the second
	,PostDate	datetime2(0)	NOT NULL
	,IsFlagged		bit			NULL
	,IsCheckedByMod	bit			NULL
)