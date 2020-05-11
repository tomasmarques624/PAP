CREATE PROCEDURE [dbo].[sp_InsertEquip]
	@descri varchar(50),
	@disp bit,
	@id_cat int,
	@id_sala int
AS
BEGIN
	BEGIN
		insert into tblEquip(descri,disp,id_cat,id_sala) values (@descri,@disp,@id_cat,@id_sala)
		SELECT 1 AS ReturnCode
	END
END