IF OBJECT_ID('dbo.UpdateJobAuditDetail', 'P') IS NOT NULL
    DROP PROCEDURE dbo.UpdateJobAuditDetail;
GO


CREATE PROCEDURE dbo.UpdateJobAuditDetail
(
    @pAuditId INT = NULL
    , @pActivityName NVARCHAR(200) = NULL
    , @pRowsCopied BIGINT = NULL
    , @pCopyDurationSeconds INT = NULL
    , @pEndTime DATETIME = NULL
    , @pStatus NVARCHAR(50) = NULL
    , @pErrorMessage NVARCHAR(MAX) = NULL
    , @pMetadataId INT
    , @pSourceFilePath NVARCHAR(500) = NULL
    , @pSourceSystem NVARCHAR(200) = NULL
    , @pTargetFilePath NVARCHAR(500) = NULL
    , @pTargetSystem NVARCHAR(200) = NULL
    , @pTargetTable NVARCHAR(200) = NULL
    , @pWaterMarkPrevious DATETIME = NULL
    , @pWaterMarkCurrent DATETIME = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.job_audit_detail
    SET ActivityName = @pActivityName
    , RowsCopied = @pRowsCopied
    , CopyDurationSeconds = @pCopyDurationSeconds
    , Status = @pStatus
    , EndTime = @pEndTime
    , ErrorMessage = @pErrorMessage
    , MetadataId = @pMetadataId
    , SourceFilePath = @pSourceFilePath
    , SourceSystem = @pSourceSystem
    , TargetFilePath = @pTargetFilePath
    , TargetSystem = @pTargetSystem
    , TargetTable = @pTargetTable
    , WaterMarkPrevious = @pWaterMarkPrevious
    , WaterMarkCurrent = @pWaterMarkCurrent
    WHERE AuditId = @pAuditId;

    RETURN 0;

END;
