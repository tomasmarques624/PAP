CREATE PROCEDURE [dbo].[sp_AuthenticateUser]
	@username varchar(50),
	@password char(64)
AS
BEGIN
	DECLARE @count int

	SELECT @count = COUNT(*) FROM tblUsers WHERE username = @username

	IF(@count<>0)
		BEGIN
			declare @isloocked bit
			declare @nr_attempts int
			declare @locked_date_time datetime
			DECLARE @count1 int
		
			select @locked_date_time = locked_date_time from tblUsers WHERE username = @username
			Select @isloocked = is_looked FROM tblUsers WHERE username = @username
			select @nr_attempts = nr_attempts from tblUsers WHERE username = @username

			if(@isloocked = 1)
				begin
					declare @a int
					select @a = DATEDIFF(HOUR,@locked_date_time,GETDATE())

					if(@a>24)
					begin
						update tblUsers set is_looked=0, nr_attempts=0, locked_date_time=null where username = @username	
						set @isloocked = 0
					end
				end

			if(@isloocked = 0)
				begin
					SELECT @count1 = COUNT(*) FROM tblUsers WHERE username = @username and password = @password
					if(@count1 = 0)
						begin
							if(@nr_attempts >= 3)
								begin
									update tblUsers set is_looked = 1, nr_attempts = 0, locked_date_time = GETDATE() where username = @username
								end
							else
								begin
									update tblUsers set nr_attempts = nr_attempts + 1 where username = @username
								end	
						end
					else
						begin
							update tblUsers set is_looked = 0,locked_date_time = null, nr_attempts = 0 where username = @username
						end
				end
			END
	SELECT * from tblUsers where username = @username
END