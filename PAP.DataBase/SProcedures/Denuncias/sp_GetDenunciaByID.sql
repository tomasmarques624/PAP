CREATE PROCEDURE [dbo].[sp_GetDenunciaByID]
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
		SELECT 1 AS ReturnCode
		select * FROM tblDenuncias WHERE id_denuncia = @id_denuncia
	end
END