CREATE TABLE [dbo].[tblRequisicoes]
(
	[id_requisicao] INT NOT NULL PRIMARY KEY identity,
	[data_requisicao] DATE not null,
	[estado] CHAR(1) not null ,
	[id_user] int not null,
	[id_equip] int not null,
	constraint [FK_tblReservas_tblEquip] foreign key ([id_equip]) references [tblEquip]([id_equip]),
	constraint [FK_tblReservas_tblUsers] foreign key ([id_user]) references [tblUsers]([id_user])
)
