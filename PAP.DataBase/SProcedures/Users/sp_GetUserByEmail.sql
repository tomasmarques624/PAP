CREATE PROCEDURE [dbo].[sp_GetUserByEmail]
	@email varchar(256)
AS
BEGIN
	select * from tblUsers where email = @email
END
