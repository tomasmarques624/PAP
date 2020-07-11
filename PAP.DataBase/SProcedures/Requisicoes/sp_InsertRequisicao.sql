CREATE PROCEDURE [sp_InsertRequisicao]
	@data_requisicao date,
	@data_requisicao_final date,
	@estado bit,
	@id_user int,
	@id_equip int
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblRequisicoes WHERE id_equip=@id_equip and data_requisicao BETWEEN @data_requisicao and @data_requisicao_final

	IF(@count<>0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		DECLARE @count1 int
		SELECT @count1 = COUNT(*) FROM tblRequisicoes WHERE id_equip=@id_equip and data_requisicao_final BETWEEN @data_requisicao and @data_requisicao_final
		IF(@count1<>0)
		BEGIN
			SELECT -1 AS ReturnCode
		END
		ELSE
		BEGIN
			SELECT 1 AS ReturnCode
			insert into tblRequisicoes(data_requisicao,data_requisicao_final,estado,id_user,id_equip) values (@data_requisicao,@data_requisicao_final,@estado,@id_user,@id_equip)
		end
	END
end