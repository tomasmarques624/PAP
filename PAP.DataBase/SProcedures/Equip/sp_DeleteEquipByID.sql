CREATE PROCEDURE [dbo].[sp_DeleteEquipByID]
	@id_equip int
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
	declare @count1 int
	select @count1 = COUNT(*) from tblEquip where id_equip = @id_equip
	if(@count1=0)
	begin
		delete from tblEquip where id_equip = @id_equip
		SELECT 1 AS ReturnCode
	end
	else
	begin
		select 2 as ReturnCode
	end
	END
END

