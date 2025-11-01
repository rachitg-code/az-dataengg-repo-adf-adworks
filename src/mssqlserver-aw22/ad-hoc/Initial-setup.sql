ALTER ROLE db_datawriter ADD MEMBER sqluser1; -- Replace with the username
ALTER ROLE db_datareader ADD MEMBER sqluser1; -- Replace with the username

GRANT CREATE PROCEDURE TO sqluser1;

GRANT ALTER ON SCHEMA::dbo TO sqluser1;

GRANT EXECUTE TO sqluser1;

SELECT
   name AS username,
   create_date,
   modify_date,
   type_desc AS type,
   authentication_type_desc AS authentication_type
FROM
   sys.database_principals
WHERE
   type NOT IN ('A', 'G', 'R', 'X')
   AND sid IS NOT NULL
   AND name != 'guest'
ORDER BY
   username;


 SELECT *  FROM
   sys.database_principals

 SELECT * FROM sys.database_principals WHERE type_desc = 'SQL_USER';


WITH t1 AS (
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA <> 'dbo'
),
t2 AS (
SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ModifiedDate'
)
SELECT t1.* FROM t1 LEFT OUTER JOIN t2 ON t1.TABLE_NAME=t2.TABLE_NAME
WHERE t2.TABLE_NAME IS NULL;

begin
declare @v1 nvarchar(100)
declare @v2 int

set @v1='mydata'

SELECT concat('SELECT * FROM [dbo].[TableMetadata] WHERE SourceSchema = ''',@v1,''' AND SourceTable = ''',@v1,'')

end


IF OBJECT_ID('dbo.prc_all_t_cnts', 'P') IS NOT NULL
    DROP PROCEDURE dbo.prc_all_t_cnts;
GO

CREATE PROCEDURE dbo.sp_all_t_cnts 
AS
BEGIN
    DECLARE @Column1 INT, @Column2 NVARCHAR(50);


exec sp_all_t_cnts


SELECT * FROM Production.ProductListPriceHistory

SELECT count(1), ModifiedDate FROM Production.ProductListPriceHistory 
GROUP BY ModifiedDate

SELECT * FROM Production.TransactionHistory

SELECT count(1), ModifiedDate FROM Production.TransactionHistory 
GROUP BY ModifiedDate ORDER BY ModifiedDate DESC

SELECT * FROM Production.TransactionHistory WHERE ModifiedDate > '2014-08-01 00:00:00.000'

SELECT * FROM Sales.ShoppingCartItem

SELECT * FROM Sales.ShoppingCartItem WHERE ModifiedDate > '2013-10-11T00:00:00'

EXEC sp_rename '[dbo].[job_audit_detail]', '[job_audit_detail_v2]';

