CREATE PROCEDURE [dbo].[sp_InsertUser]
	@username varchar(50),
	@nome varchar(20),
	@password char(64),
	@email varchar(256),
	@role char(1)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblUsers WHERE username = @username or email = @email
	IF(@count<>0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		insert into tblUsers (username,password,email,role) values (@username,@password,@email,@role)
		SELECT 1 AS ReturnCode
	END
END