CREATE PROCEDURE [sp_InsertSala]
	@nome_sala varchar(10)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblSalas WHERE nome_sala = @nome_sala 
	IF(@count<>0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		insert into tblSalas(nome_sala) values (@nome_sala)
		SELECT 1 AS ReturnCode
	END
END