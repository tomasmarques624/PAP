CREATE TABLE [dbo].[tblRequisicoes]
(
	[id_requisicao] INT NOT NULL PRIMARY KEY identity,
	[data_requisicao] DATE not null,
	[data_requisicao_final] DATE not null,
	[estado] BIT not null DEFAULT 0 ,
	[id_user] int not null,
	[id_equip] int not null,
	constraint [FK_tblReservas_tblEquip] foreign key ([id_equip]) references [tblEquip]([id_equip]),
	constraint [FK_tblReservas_tblUsers] foreign key ([id_user]) references [tblUsers]([id_user])
)
