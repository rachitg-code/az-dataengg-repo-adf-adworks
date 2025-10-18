CREATE TABLE dbo.job_audit_detail (
    AuditId INT IDENTITY(1,1) PRIMARY KEY,

    -- Reference info (but no FK constraint)
    MetadataId INT NULL,                    
    SourceSystem NVARCHAR(100),
    SourceTable NVARCHAR(200),
    SourceFilePath NVARCHAR(500),

    TargetSystem NVARCHAR(100),
    TargetTable NVARCHAR(200),
    TargetFilePath NVARCHAR(500),

    -- Job & pipeline info
    PipelineName NVARCHAR(200) NOT NULL,
    ActivityName NVARCHAR(200),
    RunId NVARCHAR(100) NOT NULL,           -- ADF pipeline run ID

    -- Audit measures
    RowsCopied BIGINT NULL,
    CopyDurationSeconds INT NULL,
    Status NVARCHAR(50) NOT NULL,           -- e.g., 'Success' / 'Failed'
    WaterMarkPrevious DATETIME NULL,
    WaterMarkCurrent DATETIME NULL,
    ParentAuditId INT NULL,               -- for hierarchical jobs if needed

    ErrorMessage NVARCHAR(MAX) NULL,

    -- Timestamps
    StartTime DATETIME NOT NULL,
    EndTime DATETIME,
    CreatedOn DATETIME NOT NULL DEFAULT GETDATE()
);

