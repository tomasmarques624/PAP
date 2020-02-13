CREATE PROCEDURE [dbo].[sp_DeleteRequisicaoByID]
	@id_requisicao int
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
		delete from tblRequisicoes where id_requisicao = @id_requisicao
		SELECT 1 AS ReturnCode
	END
END