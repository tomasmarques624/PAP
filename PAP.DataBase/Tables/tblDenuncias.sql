CREATE TABLE [dbo].[tblDenuncias]
(
	[id_denuncia] INT NOT NULL PRIMARY KEY identity,
	[problema] varchar(255) not null,
	[data_denuncia] DATE not null,
	[estado] char(1) not null,
	[prioridade] char(1) not null,
	[id_user] int not null,
	[id_equip] int not null,
	constraint [FK_tblDenuncias_tblEquip] foreign key ([id_equip]) references [tblEquip]([id_equip]),
	constraint [FK_tblDenuncias_tblUsers] foreign key ([id_user]) references [tblUsers]([id_user])
)
