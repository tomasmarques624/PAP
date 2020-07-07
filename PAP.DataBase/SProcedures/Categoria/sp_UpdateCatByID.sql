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
		DECLARE @count1 int
		SELECT @count1 = COUNT(*) FROM tblCat WHERE Nome = @nome and id_cat <> @id_cat
		IF(@count1=0)
		BEGIN
			update tblCat set Nome = @nome where id_cat = @id_cat
			SELECT 1 AS ReturnCode
		end
		else
		begin
			SELECT 2 AS ReturnCode
		end
	END
END