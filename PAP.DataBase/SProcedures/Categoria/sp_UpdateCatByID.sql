CREATE PROCEDURE [dbo].[sp_UpdateCatByID]
	@id_cat int,
	@nome varchar(50)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblCat WHERE id_cat = @id_cat

	IF(@count=0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		update tblCat set Nome = @nome where id_cat = @id_cat
		SELECT 1 AS ReturnCode
	END
END