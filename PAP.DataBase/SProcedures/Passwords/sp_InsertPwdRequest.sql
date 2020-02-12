CREATE PROCEDURE [dbo].[sp_InsertPwdRequest]
	@email varchar(256)
AS
begin
	declare @guid uniqueidentifier
	
	set @guid = newid()
		declare @count int
		SELECT @count = COUNT(*) FROM tblResetPwdRequests WHERE email = @email
		if(@count<>0)
		begin
			update tblResetPwdRequests set guid=@guid,date_recovery_request=GETDATE() where email = @email
		end
		else
		begin
			insert into tblResetPwdRequests values (@guid,@email,GETDATE())
		end

		select @guid as guid
end