CREATE PROCEDURE [dbo].[sp_DeleteGenreByID]
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
	declare @count1 int
	select @count1 = COUNT(*) from tblCat where id_cat = @id_cat
	if(@count1=0)
	begin
		delete from tblCat where id_cat = @id_cat
		SELECT 1 AS ReturnCode
	end
	else
	begin
		select 2 as ReturnCode
	end
	END
END
