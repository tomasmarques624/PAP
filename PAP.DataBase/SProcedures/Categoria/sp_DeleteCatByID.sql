CREATE PROCEDURE [dbo].[sp_DeleteCatByID]
	@id_cat int
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
		delete from tblCat where id_cat = @id_cat
		SELECT 1 AS ReturnCode
	END
END
