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
		DECLARE @count1 int
		SELECT @count1 = COUNT(*) FROM tblUsers WHERE username = @username and id_user <> @id_user
		IF(@count1=0)
		BEGIN
			DECLARE @count2 int
			SELECT @count2 = COUNT(*) FROM tblUsers WHERE email = @email and id_user <> @id_user
			IF(@count2=0)
			begin
				update tblUsers set username=@username,password=@password,role=@role,email=@email where id_user=@id_user
				SELECT 1 AS ReturnCode
			end
			else
			begin
				SELECT 3 AS ReturnCode
			end
		end
		else
		begin
			SELECT 2 AS ReturnCode
		end
	END
END