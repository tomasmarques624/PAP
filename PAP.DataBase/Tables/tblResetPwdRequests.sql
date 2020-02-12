CREATE TABLE [dbo].[tblResetPwdRequests]
(
	[id_resetPwdRequest] INT NOT NULL PRIMARY KEY identity,
	[guid] UNIQUEIDENTIFIER not null,
	[email] varchar(256) not null,
	[date_recovery_request] datetime not null, 
    CONSTRAINT [UK_tblResetPwdRequests_guid] UNIQUE ([guid]), 
    CONSTRAINT [UK_tblResetPwdRequests_email] UNIQUE ([email]),
	
)
