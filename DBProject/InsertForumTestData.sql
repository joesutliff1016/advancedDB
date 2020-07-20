SET IDENTITY_INSERT [dbo].[Account] ON 

GO
INSERT [dbo].[Account] ([AccountID], [Username], [PasswordHash], [PasswordSalt], [ProfilePic], [Email], [IsVerified], [JoinDate], [NumStrikes], [IsDeleted]) 
	VALUES (1000, N'JoeProgrammer', N'abc', N'abc', NULL, N'joe@email.com', 0, CAST(N'2017-07-19 00:00:00.0000000' AS DateTime2), NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[Account] OFF
GO




SET IDENTITY_INSERT [dbo].[Thread] ON 

GO
INSERT [dbo].[Thread] ([ThreadID], [CreatorID], [Title], [PostDate], [IsFlagged], [IsCheckedByMod]) 
	VALUES (1, 1000, N'First Thread!', CAST(N'2017-07-19 00:00:00.0000000' AS DateTime2), NULL, NULL)
			,(2, 1000, N'How to be lazy at SQL', CAST(N'2017-07-19 00:00:00.0000000' AS DateTime2), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Thread] OFF
GO