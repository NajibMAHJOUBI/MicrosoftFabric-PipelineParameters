CREATE PROCEDURE [dbo].[InsertCountry]
@name NVARCHAR(64)
AS
BEGIN

DECLARE @filePath   NVARCHAR(250);
SET @filePath = CONCAT('abfss://0af60808-26b6-4548-9eff-6643a332132c@onelake.dfs.fabric.microsoft.com/dd43f299-de32-4121-a390-17c2424c67c0/Files/CSV/', @name, '.csv');

DECLARE @sqlCommand NVARCHAR(MAX);

SET @sqlCommand = 'INSERT INTO [dbo].[Countries]
SELECT  
   [Pays] ,
   [Capital] ,
   [Region] ,
   [Subregion] ,
   [Flags] 
FROM OPENROWSET(
   BULK ''' + @filePath + ''', 
   FORMAT = ''CSV'' , 
   FIRSTROW = 2,     
   FIELDTERMINATOR = '',''
) WITH ([Pays] NVARCHAR(16), [Capital] NVARCHAR(16), [Region] NVARCHAR(16), [Subregion] NVARCHAR(16), [Flags] NVARCHAR(32)) AS tt ;
'

EXECUTE sp_executesql @sqlCommand;

END