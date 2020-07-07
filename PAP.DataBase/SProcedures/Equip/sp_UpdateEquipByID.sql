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
		DECLARE @count1 int
		SELECT @count1 = COUNT(*) FROM tblEquip WHERE descri = @descri and id_equip <> @id_equip
		IF(@count1=0)
		BEGIN
			update tblEquip set descri = @descri where id_equip = @id_equip
			SELECT 1 AS ReturnCode
		end
		else
		begin
			SELECT 2 AS ReturnCode
		End
	END
END