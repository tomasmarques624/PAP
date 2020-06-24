CREATE PROCEDURE [dbo].[sp_InsertDenuncia]
	@problema varchar(255),
	@estado char(1),
	@prioridade char(1),
	@id_user int,
	@id_equip int
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblDenuncias WHERE problema = @problema and id_equip = @id_equip and prioridade <> 'R'

	IF(@count<>0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		insert into tblDenuncias(problema,data_denuncia,estado,prioridade,id_user,id_equip) values (@problema,GETDATE(),@estado,@prioridade,@id_user,@id_equip)
		SELECT 1 AS ReturnCode
	END
END