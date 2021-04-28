-- Setup COMPATIBILITY to SQL 2019
ALTER DATABASE WideWorldImporters
SET COMPATIBILITY_LEVEL = 150;
GO

-- Setup Server Memory 
sp_configure 'show advanced options',1
GO
reconfigure
GO
sp_configure 'max server memory (MB)',4096
GO
reconfigure
GO

-- Enable additional DBCC trace Flag ( after SQL server is UP)
DBCC TRACEON( 6530, 6531, -1 );