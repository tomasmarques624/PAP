CREATE PROCEDURE [dbo].[sp_UpdateEquipSala]
	@id_equip int,
	@id_sala int
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
		update tblEquip set id_sala = @id_sala where id_equip = @id_equip
		SELECT 1 AS ReturnCode
	END
END