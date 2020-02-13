CREATE PROCEDURE [dbo].[sp_DeleteDenunciaByID]
	@id_denuncia int
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblDenuncias WHERE id_denuncia = @id_denuncia

	IF(@count=0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
	declare @count1 int
	select @count1 = COUNT(*) from tblDenuncias where id_denuncia = @id_denuncia
	if(@count1=0)
	begin
		delete from tblDenuncias where id_denuncia = @id_denuncia
		SELECT 1 AS ReturnCode
	end
	else
	begin
		select 2 as ReturnCode
	end
	END
END
