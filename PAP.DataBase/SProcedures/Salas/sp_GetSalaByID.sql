CREATE PROCEDURE [dbo].[sp_GetSalaByID]
	@id_sala int
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
		SELECT 1 AS ReturnCode
		select * from tblSalas where id_sala = @id_sala
	END
END
