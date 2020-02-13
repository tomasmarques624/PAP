CREATE PROCEDURE [dbo].[sp_UpdateRequisicaoByID]
	@id_requisicao int,
	@data_requisicao date,
	@estado char(1),
	@id_user int,
	@id_equip int
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblRequisicoes WHERE id_requisicao = @id_requisicao

	IF(@count=0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		update tblRequisicoes set data_requisicao = @data_requisicao, estado = @estado, id_user = @id_user, id_equip = @id_equip where id_requisicao = @id_requisicao
		SELECT 1 AS ReturnCode
	END
END