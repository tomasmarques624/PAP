CREATE TABLE [dbo].[tblUsers] (
    [id_user]          INT           IDENTITY (1, 1) NOT NULL,
    [username]         VARCHAR (50)  NOT NULL,
    [nome]             VARCHAR (20)  NOT NULL,
    [password]         CHAR (64)     NOT NULL,
    [email]            VARCHAR (256) NOT NULL,
    [role]             CHAR (1)      NOT NULL,
    [is_looked]        BIT           DEFAULT ((0)) NULL,
    [nr_attempts]      INT           DEFAULT ((0)) NULL,
    [locked_date_time] DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([id_user] ASC),
    CONSTRAINT [AK_tblUsers_email] UNIQUE NONCLUSTERED ([email] ASC),
    CONSTRAINT [UK_tblUsers_username] UNIQUE NONCLUSTERED ([username] ASC)
);


