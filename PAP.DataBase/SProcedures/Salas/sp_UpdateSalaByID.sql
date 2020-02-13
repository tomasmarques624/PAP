CREATE PROCEDURE [dbo].[sp_UpdateSalaByID]
	@id_sala int,
	@nome_sala varchar(10)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblSalas WHERE id_sala = @id_sala

	IF(@count=0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		update tblSalas set nome_sala = @nome_sala where id_sala = @id_sala
		SELECT 1 AS ReturnCode
	END
END