﻿CREATE PROCEDURE [dbo].[sp_UpdateDenuPrio]
	@id_denu int,
	@prio char(1)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblDenuncias WHERE id_denuncia = @id_denu

	IF(@count=0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		update tblDenuncias set prioridade = @prio where id_denuncia = @id_denu
		SELECT 1 AS ReturnCode
	END
END