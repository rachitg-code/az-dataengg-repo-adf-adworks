
IF OBJECT_ID('dbo.test', 'P') IS NOT NULL
    DROP PROCEDURE dbo.test;
GO

CREATE PROCEDURE dbo.test
(
    @MetadataId INT ,
    @oAuditId NVARCHAR(100) OUTPUT
)
AS
begin
declare @v1 nvarchar(100)
declare @v2 int
declare @v3 nvarchar(500)

set @v1='mydata'

SELECT @oAuditId = concat('>>SELECT * FROM [dbo].[TableMetadata] WHERE SourceSchema = ''',@v1,''' AND SourceTable = ''',@v1,'')

print(@oAuditId)

RETURN 1

end


begin

declare @v5 INT
declare @v6 NVARCHAR(100)

EXEC @v5 = dbo.test 
        @MetadataId=5
        ,  @oAuditId=@v6 OUTPUT ;

PRINT(@v5)
PRINT( @v6)
end

---------------