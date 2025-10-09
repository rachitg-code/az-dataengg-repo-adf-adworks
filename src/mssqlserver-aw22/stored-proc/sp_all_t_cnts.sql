IF OBJECT_ID('dbo.prc_all_t_cnts', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_all_t_cnts;
GO

CREATE PROCEDURE dbo.sp_all_t_cnts 
AS
BEGIN
    DECLARE @Column1 INT, @Column2 NVARCHAR(50);

    DECLARE @DynamicSQL NVARCHAR(MAX);
    DECLARE @table_schema NVARCHAR(150);
    DECLARE @table_name NVARCHAR(150);
    DECLARE @full_table_name NVARCHAR(150);

    -- Declare a cursor
    DECLARE myCursor CURSOR FOR
    SELECT TABLE_SCHEMA, TABLE_NAME
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA <> 'dbo';

    -- Declare a table variable to store results
    DECLARE @Results TABLE (
        name NVARCHAR(150),
        cnt int
    );

    -- Insert data into the table variable
    
    /*VALUES (1, 'Item A', 100.50),
           (2, 'Item B', 200.75),
           (3, 'Item C', 300.00);
           */

    -- Open the cursor
    OPEN myCursor;

    -- Fetch the first row
    FETCH NEXT FROM myCursor INTO @table_schema, @table_name;

    -- Loop through the rows
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Build the dynamic SQL query
        SET @DynamicSQL = N'SELECT ''' + @full_table_name + ''' AS TableName, COUNT(1) AS Cnt FROM ' + @full_table_name;

        SET @full_table_name = QUOTENAME(@table_schema) + '.' + QUOTENAME(@table_name);

        print(@DynamicSQL)
        print(@full_table_name)
        -- Execute the query with parameters
        
        INSERT INTO @Results (name, cnt)
        EXEC sp_executesql @DynamicSQL, 
                           N'@f_tname NVARCHAR(100)', 
                           @f_tname = @full_table_name;

        -- Fetch the next row
        FETCH NEXT FROM myCursor INTO @table_schema, @table_name;
    END;

     -- Close and deallocate the cursor
     CLOSE myCursor;
     DEALLOCATE myCursor;

     SELECT REPLACE(REPLACE(name, '[',''),']','') AS name, cnt FROM @Results ORDER BY cnt DESC,name;

END
