CREATE TABLE [dbo].[tblEquip]
(
	[id_equip] INT NOT NULL PRIMARY KEY identity,
	[desc] varchar(50) NOT NULL,
	[Quant] int not null,
	[disp] BIT default 0 not null,
	[id_cat] int not null,
	constraint [FK_tblEquip_tblCat] foreign key ([id_cat]) references [tblCat]([id_cat])
)
