CREATE PROCEDURE [dbo].[sp_InsertDenuncia]
	@problema varchar(255),
	@data_denuncia date,
	@qrcode varchar(255),
	@estado char(1),
	@prioridade char(1),
	@id_user int,
	@id_equip int
AS
BEGIN
		insert into tblDenuncias(problema,data_denuncia,qrcode,estado,prioridade,id_user,id_equip) values (@problema,@data_denuncia,@qrcode,@estado,@prioridade,@id_user,@id_equip)
		SELECT 1 AS ReturnCode
END