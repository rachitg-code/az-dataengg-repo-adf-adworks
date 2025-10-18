IF OBJECT_ID('dbo.UpdateWatermark', 'P') IS NOT NULL
    DROP PROCEDURE dbo.UpdateWatermark;
GO


CREATE PROCEDURE dbo.UpdateWatermark
(
    @pMetaId INT = NULL
    , @pLastRunTime DATETIME = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.TableMetadata
    SET LastRunTimestamp = @pLastRunTime
    WHERE Id = @pMetaId;

    RETURN 0;

END;
