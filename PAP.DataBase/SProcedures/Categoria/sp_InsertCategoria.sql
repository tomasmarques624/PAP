CREATE PROCEDURE [sp_InsertCategoria]
	@Nome varchar(50)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblCat WHERE Nome = @Nome 
	IF(@count<>0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		insert into tblCat(Nome) values (@Nome)
		SELECT 1 AS ReturnCode
	END
END