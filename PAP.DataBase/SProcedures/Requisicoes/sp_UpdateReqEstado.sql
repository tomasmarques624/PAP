CREATE PROCEDURE [dbo].[sp_UpdateReqEstado]
	@id_req int,
	@estado bit
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblRequisicoes WHERE id_requisicao = @id_req

	IF(@count=0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		update tblRequisicoes set estado = @estado where id_requisicao = @id_req
		SELECT 1 AS ReturnCode
	END
END