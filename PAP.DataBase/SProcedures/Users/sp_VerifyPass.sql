CREATE PROCEDURE [dbo].[sp_VerifyPass]
@username varchar(50),
	@password char(64)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblUsers WHERE username = @username

	IF(@count<>0)
		BEGIN
			declare @isloocked bit
			DECLARE @count1 int
		
			Select @isloocked = is_looked FROM tblUsers WHERE username = @username

			if(@isloocked = 0)
				begin
					SELECT @count1 = COUNT(*) FROM tblUsers WHERE username = @username and password = @password
					if(@count1 = 0)
						SELECT -1 AS ReturnCode
					else
						begin
							SELECT 1 AS ReturnCode
						end
				end
			END
END