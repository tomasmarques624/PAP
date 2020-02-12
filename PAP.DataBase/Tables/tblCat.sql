CREATE TABLE [dbo].[tblCat]
(
	[id_cat] INT NOT NULL PRIMARY KEY identity,
	[Nome] varchar(50) unique not null
    CONSTRAINT [UK_tblCat_Nome] UNIQUE ([Nome])
)
