CREATE PROCEDURE [sp_InsertRequisicoes]
	@data_requisicao date,
	@estado char(1),
	@id_user int,
	@id_equip int
AS
BEGIN
		insert into tblRequisicoes(data_requisicao,estado,id_user,id_equip) values (@data_requisicao,@estado,@id_user,@id_equip)
		SELECT 1 AS ReturnCode
END