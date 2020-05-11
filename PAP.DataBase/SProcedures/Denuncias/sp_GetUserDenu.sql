CREATE PROCEDURE [dbo].[sp_GetUserDenu]
	@id_user int
AS
begin
		select problema,estado,id_denuncia,data_denuncia,id_equip from tblDenuncias where id_user = @id_user
end