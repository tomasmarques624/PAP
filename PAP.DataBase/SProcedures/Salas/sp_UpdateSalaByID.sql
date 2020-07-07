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
		DECLARE @count1 int
		SELECT @count1 = COUNT(*) FROM tblSalas WHERE nome_sala = @nome_sala and id_sala <> @id_sala
		IF(@count1=0)
		BEGIN
			update tblSalas set nome_sala = @nome_sala where id_sala = @id_sala
			SELECT 1 AS ReturnCode
		End
		else
		begin
			SELECT 2 AS ReturnCode
		end
	END
END