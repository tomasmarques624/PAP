CREATE PROCEDURE [dbo].[sp_GetRequisicaoByID]
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
		SELECT 1 AS ReturnCode
		select * from tblRequisicoes where id_requisicao = @id_requisicao
	END
END