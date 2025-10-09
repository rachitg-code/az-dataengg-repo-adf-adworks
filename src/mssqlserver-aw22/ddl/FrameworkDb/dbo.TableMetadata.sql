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
    SourceSystem, SourceType, SourceConnection,
    SourceSchema, SourceTable,
    TargetSystem, TargetType, TargetConnection, TargetFilePath,
    IsActive
)
VALUES
-- Sales tables
('Database', 'OnPremSQL', 'LS_OnPremSQL', 'Sales', 'SalesOrderHeader', 'ADLS_Gen2', 'Files', 'LS_Gen2', '/Raw/Sales/SalesOrderHeader/', 1),
('Database', 'OnPremSQL', 'LS_OnPremSQL', 'Sales', 'SalesOrderDetail', 'ADLS_Gen2', 'Files', 'LS_Gen2', '/Raw/Sales/SalesOrderDetail/', 1),
('Database', 'OnPremSQL', 'LS_OnPremSQL', 'Sales', 'Customer', 'ADLS_Gen2', 'Files', 'LS_Gen2', '/Raw/Sales/Customer/', 1),
('Database', 'OnPremSQL', 'LS_OnPremSQL', 'Sales', 'SalesTerritory', 'ADLS_Gen2', 'Files', 'LS_Gen2', '/Raw/Sales/SalesTerritory/', 1),
('Database', 'OnPremSQL', 'LS_OnPremSQL', 'Sales', 'SalesPerson', 'ADLS_Gen2', 'Files', 'LS_Gen2', '/Raw/Sales/SalesPerson/', 1),

-- Production tables
('Database', 'OnPremSQL', 'LS_OnPremSQL', 'Production', 'Product', 'ADLS_Gen2', 'Files', 'LS_Gen2', '/Raw/Production/Product/', 1),

-- Person tables
('Database', 'OnPremSQL', 'LS_OnPremSQL', 'Person', 'Person', 'ADLS_Gen2', 'Files', 'LS_Gen2', '/Raw/Person/Person/', 1),

-- HumanResources tables
('Database', 'OnPremSQL', 'LS_OnPremSQL', 'HumanResources', 'Employee', 'ADLS_Gen2', 'Files', 'LS_Gen2', '/Raw/HumanResources/Employee/', 1);
