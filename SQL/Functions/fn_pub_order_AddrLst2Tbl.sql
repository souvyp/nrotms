USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_AddrLst2Tbl]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_AddrLst2Tbl]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- 拆地址参数格式
-- fp = from province, fc = from city, fd = from district, fcnt = from contact
-- tp = to province, tc = to city, td = to district, tcnt = to contact
-- eu = end user id
-- fp1,fc1,fd1,from1,tp1,tc1,td1,to1,time1,eu1,fcnt1,tcnt1|fp2,fc2,fd2,from2,tp2,tc2,td2,to2,time2,eu2,fcnt2,tcnt2
CREATE FUNCTION [dbo].[fn_pub_order_AddrLst2Tbl]
(
	@AddrLst NVARCHAR(MAX)
)
RETURNS @tblAddr TABLE
(
	Addr_FromProvince BIGINT,
	Addr_FromCity BIGINT,
	Addr_FromDistrict BIGINT,
	Addr_From NVARCHAR(600),
	Addr_ToProvince BIGINT,
	Addr_ToCity BIGINT,
	Addr_ToDistrict BIGINT,
	Addr_To NVARCHAR(600),
	Addr_Time DATETIME,
	Addr_EndUserID BIGINT,
	Addr_FromContact NVARCHAR(300),
	Addr_ToContact NVARCHAR(300),
	Addr_EndUserName NVARCHAR(300)
)
AS
BEGIN
	DECLARE @Start BIGINT;
	DECLARE @End BIGINT;
	DECLARE @Len BIGINT;
	SET @Start = 1;
	SET @End = 1;
	SET @Len = LEN(@AddrLst);

	WHILE (@End < @Len)
	BEGIN
		DECLARE @Breaked TINYINT;
		DECLARE @Item NVARCHAR(MAX);
		SET @Breaked = 0;
		SET @Item = N'';

		SET @End = CHARINDEX('|', @AddrLst, @Start);
		IF @End <> 0 AND @End > @Start
		BEGIN
			SET @Item = SUBSTRING(@AddrLst, @Start, @End - @Start);
		END
		ELSE
		BEGIN
			SET @Item = SUBSTRING(@AddrLst, @Start, @Len);
			
			SET @Breaked = 1;
		END
		
		INSERT INTO @tblAddr SELECT B.[1], B.[2], B.[3], B.[4], B.[5], B.[6], B.[7], B.[8], B.[9], B.[10], B.[11], B.[12],B.[13] FROM (SELECT [value] = CONVERT(XML , '<v>' + REPLACE(@Item , ',' , '</v><v>') + '</v>')) A 
CROSS APPLY (SELECT [1] = A.[value].value('v[1]', 'nvarchar(100)'),
[2] = A.[value].value('v[2]', 'nvarchar(100)'), 
[3] = A.[value].value('v[3]', 'nvarchar(100)'),
[4] = A.[value].value('v[4]', 'nvarchar(100)'),
[5] = A.[value].value('v[5]', 'nvarchar(100)'),
[6] = A.[value].value('v[6]', 'nvarchar(100)'),
[7] = A.[value].value('v[7]', 'nvarchar(100)'),
[8] = A.[value].value('v[8]', 'nvarchar(100)'), 
[9] = A.[value].value('v[9]', 'nvarchar(100)'),
[10] = A.[value].value('v[10]', 'nvarchar(100)'),
[11] = A.[value].value('v[11]', 'nvarchar(100)'),
[12] = A.[value].value('v[12]', 'nvarchar(100)'),
[13] = A.[value].value('v[13]', 'nvarchar(100)')) B;

		IF @Breaked = 1
		BEGIN
			BREAK;
		END
		
		SET @Start = @End + 1;
	END

	RETURN;
END

GO


