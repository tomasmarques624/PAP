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
		delete from tblDenuncias where id_denuncia = @id_denuncia
		SELECT 1 AS ReturnCode
	END
END
