CREATE PROCEDURE [dbo].[sp_UpdatePass]
	@username varchar(50),
	@password char(64)
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
			update tblUsers set password = @password where username = @username
			SELECT 1 AS ReturnCode
	END
END