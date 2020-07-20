USE ForumDB
GO

--Get all threads by User
SELECT Title
	,PostDate
	,Username
FROM Thread JOIN Account ON
	CreatorID = AccountID