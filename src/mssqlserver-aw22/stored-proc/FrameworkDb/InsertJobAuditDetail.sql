IF OBJECT_ID('dbo.InsertJobAuditDetail', 'P') IS NOT NULL
    DROP PROCEDURE dbo.InsertJobAuditDetail;
GO


CREATE PROCEDURE dbo.InsertJobAuditDetail
(
    @MetadataId INT = NULL,
    @ParentAuditId INT = NULL,
    @PipelineName NVARCHAR(200),
    @ActivityName NVARCHAR(200),
    @RunId NVARCHAR(100),
    
    -- Source details
    @SourceSystem NVARCHAR(100) = NULL,
    @SourceTable NVARCHAR(200) = NULL,
    @SourceFilePath NVARCHAR(500) = NULL,

    -- Target details
    @TargetSystem NVARCHAR(100) = NULL,
    @TargetTable NVARCHAR(200) = NULL,
    @TargetFilePath NVARCHAR(500) = NULL,

    -- Audit measures
    @RowsCopied BIGINT = NULL,
    @CopyDurationSeconds INT = NULL,
    @Status NVARCHAR(50),
    @ErrorMessage NVARCHAR(MAX) = NULL,

    -- Timestamps
    @WaterMarkPrevious DATETIME = NULL,
    @WaterMarkCurrent DATETIME = NULL,
    @StartTime DATETIME,
    @EndTime DATETIME
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.job_audit_detail
    (
        MetadataId, PipelineName, ActivityName, RunId,
        SourceSystem, SourceTable, SourceFilePath,
        TargetSystem, TargetTable, TargetFilePath,
        RowsCopied, CopyDurationSeconds, Status, ErrorMessage,
        StartTime, EndTime, ParentAuditId, WaterMarkPrevious, WaterMarkCurrent
    )
    VALUES
    (
        @MetadataId, @PipelineName, @ActivityName, @RunId,
        @SourceSystem, @SourceTable, @SourceFilePath,
        @TargetSystem, @TargetTable, @TargetFilePath,
        @RowsCopied, @CopyDurationSeconds, @Status, @ErrorMessage,
        @StartTime, @EndTime, @ParentAuditId, @WaterMarkPrevious, @WaterMarkCurrent
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS oAuditId;

END;
