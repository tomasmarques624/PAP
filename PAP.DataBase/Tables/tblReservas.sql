CREATE TABLE [dbo].[tblReservas]
(
	[id_reserva] INT NOT NULL PRIMARY KEY identity,
	[data_reserva] datetime not null,
	[estado_reserva] bit not null default 0,
	[id_user] int not null,
	[id_equip] int not null,
	constraint [FK_tblReservas_tblEquip] foreign key ([id_equip]) references [tblEquip]([id_equip]),
	constraint [FK_tblReservas_tblUsers] foreign key ([id_user]) references [tblUsers]([id_user])
)
