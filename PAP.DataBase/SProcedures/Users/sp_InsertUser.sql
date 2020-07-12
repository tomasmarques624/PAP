CREATE PROCEDURE [dbo].[sp_InsertUser]
	@username varchar(50),
	@nome varchar(20),
	@password char(64),
	@email varchar(256),
	@role char(1)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblUsers WHERE username = @username
	IF(@count<>0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
	DECLARE @count1 int
		SELECT @count1 = COUNT(*) FROM tblUsers WHERE email = @email
		IF(@count1<>0)
		BEGIN
			SELECT 2 AS ReturnCode
		END
		ELSE
		BEGIN
			insert into tblUsers (username,password,email,role,nome) values (@username,@password,@email,@role,@nome)
			SELECT 1 AS ReturnCode
		end
		
	END
END