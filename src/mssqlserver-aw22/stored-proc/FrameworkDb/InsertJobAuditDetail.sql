IF OBJECT_ID('dbo.InsertJobAuditDetail', 'P') IS NOT NULL
    DROP PROCEDURE dbo.InsertJobAuditDetail;
GO


CREATE PROCEDURE dbo.InsertJobAuditDetail
(
    @ParentAuditId INT = NULL,
    -- Reference info
    @MetadataId INT = NULL,
    @SourceSystem NVARCHAR(100) = NULL,
    @SourceContainer NVARCHAR(200) = NULL,
    @SourceSchema NVARCHAR(100) = NULL,
    @SourceTable NVARCHAR(200) = NULL,
    @SourceFilePath NVARCHAR(500) = NULL,
    
    @TargetSystem NVARCHAR(100) = NULL,
    @TargetTable NVARCHAR(200) = NULL,
    @TargetFilePath NVARCHAR(500) = NULL,

    -- Job & pipeline info
    @PipelineName NVARCHAR(200),
    @ActivityName NVARCHAR(200),
    @RunId NVARCHAR(100),

    -- Audit measures
    @RowsCopied BIGINT = NULL,
    @CopyDurationSeconds INT = NULL,
    @Status NVARCHAR(50),
    @WaterMarkPrevious DATETIME = NULL,
    @WaterMarkCurrent DATETIME = NULL,
    
    @ErrorMessage NVARCHAR(MAX) = NULL,

    -- Timestamps
    @StartTime DATETIME,
    @EndTime DATETIME
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.job_audit_detail
    (
        -- Reference info
        MetadataId, SourceSystem, SourceContainer, SourceSchema, SourceTable, SourceFilePath,
        TargetSystem, TargetTable, TargetFilePath,
        
        -- Job & pipeline info
        PipelineName, ActivityName, RunId,
        
        -- Audit measures
        RowsCopied, CopyDurationSeconds, Status,
        WaterMarkPrevious, WaterMarkCurrent, ParentAuditId,
        ErrorMessage,
        
        -- Timestamps
        StartTime, EndTime
    )
    VALUES
    (
        -- Reference info
        @MetadataId, @SourceSystem, @SourceContainer, @SourceSchema, @SourceTable, @SourceFilePath,
        @TargetSystem, @TargetTable, @TargetFilePath,
        
        -- Job & pipeline info
        @PipelineName, @ActivityName, @RunId,
        
        -- Audit measures
        @RowsCopied, @CopyDurationSeconds, @Status,
        @WaterMarkPrevious, @WaterMarkCurrent, @ParentAuditId,
        @ErrorMessage,
        
        -- Timestamps
        @StartTime, @EndTime
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS oAuditId;

END;
