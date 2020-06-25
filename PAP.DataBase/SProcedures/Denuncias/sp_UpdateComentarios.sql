CREATE PROCEDURE [dbo].[sp_UpdateComentarios]
	@id_denu int,
	@comentarios nchar(255)
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
		update tblDenuncias set comentarios = @comentarios where id_denuncia = @id_denu
		SELECT 1 AS ReturnCode
	END
END