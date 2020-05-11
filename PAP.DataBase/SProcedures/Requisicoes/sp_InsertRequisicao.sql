CREATE PROCEDURE [sp_InsertRequisicao]
	@data_requisicao date,
	@data_requisicao_final date,
	@estado bit,
	@id_user int,
	@id_equip int
AS
BEGIN
		insert into tblRequisicoes(data_requisicao,data_requisicao_final,estado,id_user,id_equip) values (@data_requisicao,@data_requisicao_final,@estado,@id_user,@id_equip)
		SELECT 1 AS ReturnCode
END