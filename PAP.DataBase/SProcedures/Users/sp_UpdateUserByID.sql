CREATE PROCEDURE [dbo].[sp_UpdateUserByID]
	@id_user int,
	@username varchar(50),
	@password char(64),
	@email varchar(64),
	@role char(1)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblUsers WHERE @id_user=id_user

	IF(@count=0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		update tblUsers set username=@username,password=@password,role=@role,email=@email where id_user=@id_user
		SELECT 1 AS ReturnCode
	END
END