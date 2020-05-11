CREATE PROCEDURE [dbo].[sp_GetDispEquips]
AS
begin
		select * from tblEquip where disp = 0
end