CREATE PROCEDURE [dbo].[sp_DeletePwdRequestByEmail]
	@email varchar(256)
AS
begin
	declare @count int
	SELECT @count = COUNT(*) FROM tblResetPwdRequests WHERE email = @email

	IF(@count=0)
	BEGIN
		SELECT -1 AS ReturnCode
	END
	ELSE
	BEGIN
		delete  FROM tblResetPwdRequests WHERE email = @email
		SELECT 1 AS ReturnCode
	END

end