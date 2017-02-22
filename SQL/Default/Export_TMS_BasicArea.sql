DECLARE @AreaID BIGINT;
DECLARE @AreaName NVARCHAR(100);
DECLARE @AreaParentID BIGINT;
SET @AreaID = 0;
SET @AreaName = N'';
SET @AreaParentID = 0;

DECLARE paras_cursor CURSOR LOCAL FOR SELECT Area_ID, Area_Name, Area_ParentID FROM TMS_BasicArea WHERE Area_ID >= 110000;
OPEN paras_cursor;
			
FETCH NEXT FROM paras_cursor INTO @AreaID, @AreaName, @AreaParentID;
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT 'INSERT INTO TMS_BasicArea(Area_ID, Area_Name, Area_ParentID, Area_NodeType, Area_CreatorID, Area_InsertTime) VALUES(' + CAST(@AreaID AS VARCHAR) + ', ''' + @AreaName + ''', ' + CAST(@AreaParentID AS VARCHAR) + ', 1, 1, GETDATE() );';

	FETCH NEXT FROM paras_cursor INTO @AreaID, @AreaName, @AreaParentID;
END

CLOSE paras_cursor;
DEALLOCATE paras_cursor;