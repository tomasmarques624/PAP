CREATE PROCEDURE [dbo].[sp_GetUserReq]
	@id_user int
AS
begin
		select id_requisicao,data_requisicao,data_requisicao_final,estado,id_equip from tblRequisicoes where id_user = @id_user
end