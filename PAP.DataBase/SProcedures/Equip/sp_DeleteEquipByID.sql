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
	select @count1 = COUNT(*) from tblRequisicoes where id_equip = @id_equip
	if(@count1=0)
	begin
		declare @count2 int
		select @count2 = COUNT(*) from tblDenuncias where id_equip = @id_equip
		if(@count2=0)
		begin
			delete from tblEquip where id_equip = @id_equip
			SELECT 1 AS ReturnCode
		end
		else
		begin
			select 3 as ReturnCode
		end
	end
	else
	begin
		select 2 as ReturnCode
	end
	END
END

