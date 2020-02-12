CREATE PROCEDURE [dbo].[sp_ResetPassword]
	@id_user int,
	@new_password char(64)
AS
begin
	declare @count int
	SELECT @count = COUNT(*) FROM tblUsers WHERE id_user = @id_user
	if(@count<>0)
	begin
		update tblUsers set password=@new_password where id_user = @id_user
		select 1 as returncode
	end
	else
	begin
		select -1 as returncode
	end
end