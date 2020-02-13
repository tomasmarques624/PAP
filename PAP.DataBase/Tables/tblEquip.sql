CREATE TABLE [dbo].[tblEquip]
(
	[id_equip] INT NOT NULL PRIMARY KEY identity,
	[desc] varchar(50) NOT NULL,
	[disp] BIT default 0 not null,
	[id_cat] int not null,
	[id_sala] INT NULL, 
    constraint [FK_tblEquip_tblCat] foreign key ([id_cat]) references [tblCat]([id_cat]),
	constraint [FK_tblEquip_tblSalas] foreign key ([id_sala]) references [tblSalas]([id_sala])
)
