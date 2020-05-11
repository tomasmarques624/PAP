CREATE PROCEDURE [dbo].[sp_UpdateEquipByID]
	@id_equip int,
	@descri varchar(50)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblEquip WHERE id_equip = @id_equip

	IF(@count=0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		update tblEquip set descri = @descri where id_equip = @id_equip
		SELECT 1 AS ReturnCode
	END
END