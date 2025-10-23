CREATE TABLE dbo.TableMetadata (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    
    -- Source Info
    SourceSystem NVARCHAR(100) NOT NULL,
    SourceType NVARCHAR(50) NOT NULL,      -- e.g., 'AzureBlob', 'OnPremSQL', 'ADLS', 'S3'
    SourceConnection NVARCHAR(200) NULL, -- linked service name in ADF
    SourceContainer NVARCHAR(200) NULL,     -- e.g., for blob/adls
    SourceSchema NVARCHAR(100) NULL,
    SourceTable NVARCHAR(200) NULL,
    SourceFilePath NVARCHAR(500) NULL,     -- for files

    -- Target Info
    TargetSystem NVARCHAR(100) NOT NULL,  
    TargetType NVARCHAR(50) NOT NULL,      -- e.g., 'AzureSQLDB', 'Synapse', 'DeltaLake'
    TargetConnection NVARCHAR(200) NULL,
    TargetSchema NVARCHAR(100)  NULL,
    TargetTable NVARCHAR(200)  NULL,
    TargetFilePath NVARCHAR(500) NULL,

    -- Control Info
    LoadType NVARCHAR(20) NOT NULL DEFAULT 'FULL', -- FULL / INCREMENTAL
    IsActive BIT NOT NULL DEFAULT 1,               -- Enable/Disable pipeline
    PrimaryKeys NVARCHAR(500) NULL,                -- for merge logic if needed
    LastRunTimestamp DATETIME NULL,                -- for incremental loads
    CreatedOn DATETIME NOT NULL DEFAULT GETDATE(),
    ModifiedOn DATETIME NULL
);


INSERT INTO dbo.TableMetadata
(
    SourceSystem, SourceType, SourceConnection, SourceContainer,
    SourceSchema, SourceTable, SourceFilePath,
    TargetSystem, TargetType, TargetConnection, TargetFilePath,
    IsActive, ModifiedOn
)
VALUES
-- Sales tables
('Database', 'OnPremSQL', 'ln_SqlServer_AW22', 'AdventureWorks2022', 'Sales', 'SalesOrderHeader', NULL, 'ADLS_Gen2', 'Files', 'ln_Adls_AW22', '/landing/Sales/SalesOrderHeader/', 1, GETDATE()),
('Database', 'OnPremSQL', 'ln_SqlServer_AW22', 'AdventureWorks2022', 'Sales', 'SalesOrderDetail', NULL, 'ADLS_Gen2', 'Files', 'ln_Adls_AW22', '/landing/Sales/SalesOrderDetail/', 1, GETDATE()),
('Database', 'OnPremSQL', 'ln_SqlServer_AW22', 'AdventureWorks2022', 'Sales', 'Customer', NULL, 'ADLS_Gen2', 'Files', 'ln_Adls_AW22', '/landing/Sales/Customer/', 1, GETDATE()),
('Database', 'OnPremSQL', 'ln_SqlServer_AW22', 'AdventureWorks2022', 'Sales', 'SalesTerritory', NULL, 'ADLS_Gen2', 'Files', 'ln_Adls_AW22', '/landing/Sales/SalesTerritory/', 1, GETDATE()),
('Database', 'OnPremSQL', 'ln_SqlServer_AW22', 'AdventureWorks2022', 'Sales', 'SalesPerson', NULL, 'ADLS_Gen2', 'Files', 'ln_Adls_AW22', '/landing/Sales/SalesPerson/', 1, GETDATE()),

-- Production tables
('Database', 'OnPremSQL', 'ln_SqlServer_AW22', 'AdventureWorks2022', 'Production', 'Product', NULL, 'ADLS_Gen2', 'Files', 'ln_Adls_AW22', '/landing/Production/Product/', 1, GETDATE()),

-- Person tables
('Database', 'OnPremSQL', 'ln_SqlServer_AW22', 'AdventureWorks2022', 'Person', 'Person', NULL, 'ADLS_Gen2', 'Files', 'ln_Adls_AW22', '/landing/Person/Person/', 1, GETDATE()),

-- HumanResources tables
('Database', 'OnPremSQL', 'ln_SqlServer_AW22', 'AdventureWorks2022', 'HumanResources', 'Employee', NULL, 'ADLS_Gen2', 'Files', 'ln_Adls_AW22', '/landing/HumanResources/Employee/', 1, GETDATE()),

-- rest_api
('RestAPI', 'File', 'ln_Rest_Countries', 'api_restcountries', NULL,'country_parameter', 'https://restcountries.com/v3.1/name', 'ADLS_Gen2', 'Json', 'ln_Adls_AW22', '/landing/restapi', 1, GETDATE()),

--sftp
('Sftp', 'File', 'ln_Sftp_Rebex', 'sftp_testrebex', NULL,  NULL, 'pub/example', 'ADLS_Gen2', 'Binary', 'ln_Adls_AW22', '/landing/sftp_source', 1, GETDATE());
