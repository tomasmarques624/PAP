CREATE TABLE [dbo].[tblUsers]
(
	[id_user] INT NOT NULL PRIMARY KEY identity,
	[username] varchar(50) not null,
	[password] char(64) not null,
	[email] varchar(256) not null,
	[role] char(1) not null,
	[is_looked] BIT DEFAULT 0 , 
    [nr_attempts] INT DEFAULT 0, 
    [locked_date_time] DATETIME ,	
    constraint [UK_tblUsers_username] unique ([username]), 
    CONSTRAINT [AK_tblUsers_email] UNIQUE ([email]),
)
