SELECT TABLE_SCHEMA, TABLE_NAME, CASE WHEN fdb.TableName IS NOT NULL THEN 'Y' ELSE 'N' END AS IsInScope
    FROM INFORMATION_SCHEMA.TABLES it
    LEFT OUTER JOIN [FrameworkDb].[dbo].[TableMetadata] AS fdb
        ON it.TABLE_NAME = fdb.TableName
           AND it.TABLE_SCHEMA = fdb.TableSchema
           AND  fdb.SourceSystem = 'Database' AND fdb.SourceType IN ('OnPremSQL')
    WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA <> 'dbo'; 