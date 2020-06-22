CREATE PROCEDURE [dbo].[sp_GetUserByUsername]
	@username varchar(50)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblUsers WHERE username = @username

	IF(@count=0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		SELECT 1 AS ReturnCode
		select * from tblUsers where username = @username
	END
END
