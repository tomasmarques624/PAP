CREATE PROCEDURE [dbo].[sp_GetCatByID]
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
		SELECT 1 AS ReturnCode
		select * from tblCat where id_cat = @id_cat
	END
END
