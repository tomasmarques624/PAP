CREATE PROCEDURE [dbo].[sp_LockUser]
	@id_user int
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblUsers WHERE id_user = @id_user

	IF(@count=0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		update tblUsers set is_looked = 1, nr_attempts = 0, locked_date_time = GETDATE() where id_user = @id_user
		SELECT 1 AS ReturnCode
	END
END
