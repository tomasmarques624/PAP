CREATE PROCEDURE [dbo].[sp_DeleteSalaByID]
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
	declare @count1 int
	select @count1 = COUNT(*) from tblSalas where id_sala = @id_sala
	if(@count1=0)
	begin
		delete from tblSalas where id_sala = @id_sala
		SELECT 1 AS ReturnCode
	end
	else
	begin
		select 2 as ReturnCode
	end
	END
END
