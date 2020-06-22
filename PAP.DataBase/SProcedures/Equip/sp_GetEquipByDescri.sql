CREATE PROCEDURE [dbo].[sp_GetEquipByDescri]
	@descri varchar(50)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblEquip WHERE descri = @descri

	IF(@count=0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		SELECT 1 AS ReturnCode
		select * from tblEquip where descri = @descri
	END
END
