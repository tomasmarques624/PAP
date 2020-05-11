CREATE PROCEDURE [dbo].[sp_UpdateDenuEstado]
	@id_denu int,
	@estado char(1)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblDenuncias WHERE id_denuncia = @id_denu

	IF(@count=0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		update tblDenuncias set estado = @estado where id_denuncia = @id_denu
		SELECT 1 AS ReturnCode
	END
END