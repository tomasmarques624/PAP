CREATE PROCEDURE [dbo].[sp_UpdateEquipByID]
	@id_equip int,
	@descri varchar(50),
	@disp char(1),
	@id_cat int,
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
		update tblEquip set descri = @descri, disp = @disp, id_cat = @id_cat, id_sala = @id_sala where id_equip = @id_equip
		SELECT 1 AS ReturnCode
	END
END