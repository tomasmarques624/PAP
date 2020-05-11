CREATE PROCEDURE [dbo].[sp_UpdateDenunciasByID]
	@id_denuncia int,
	@problema varchar(255),
	@data_denuncia date,
	@estado char(1),
	@prioridade char(1),
	@id_user int,
	@id_equip int
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
		update tblDenuncias set problema = @problema, data_denuncia = @data_denuncia, estado = @estado, prioridade = @prioridade , id_user=@id_user, id_equip=@id_equip where id_denuncia = @id_denuncia
		SELECT 1 AS ReturnCode
	END
END