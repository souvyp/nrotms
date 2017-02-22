USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_basic_GetSN]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_basic_GetSN]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- 生成序号(调用者按需创建事务)
/*
序号格式：
3-6个字符的前缀，4位年份，2位月份，2位日期，5位数字
@Type的可能值：
----------------------------------------
编号 名称         编号        附加编号
----------------------------------------
  1  公司         ORG
  2  订单         ORD
     合单订单     ORD-C       1
  3  物品         GOD
  4  单据         DOC
     按单报价     DOC-P1      2
     补充报价     DOC-P2      3
     合单报价     DOC-P3      4
     合约报价     DOC-P4      5
     补充合单	  DOC-P5      6	
  5  客户         CUS
  6  承运商       SUP
  7  收货人       EDU
----------------------------------------
*/
CREATE PROCEDURE [dbo].[sp_pub_basic_GetSN]
(
	@Type BIGINT,
	@SN NVARCHAR(100) OUTPUT,
	@AdditionType BIGINT = 0
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @Num BIGINT;
	DECLARE @Prefix NVARCHAR(50);
	DECLARE @SN_ID BIGINT;
	DECLARE @Now DATETIME;
	SET @Num = 0;
	SET @Prefix = '';
	SET @SN_ID = 0;
	SET @Now = GETDATE();
	
	SET @SN = '';

	SELECT TOP 1 @Num = SN_Number, @Prefix = SN_Prefix, @SN_ID = SN_ID FROM TMS_SN WHERE SN_Type = @Type ORDER BY SN_ID ASC;
	IF @@ROWCOUNT = 0
	BEGIN
		SET @SN = '';
	END
	ELSE
	BEGIN
		-- 处理附加编号
		IF @Type = 2
		BEGIN
			IF @AdditionType = 1
			BEGIN
				SET @Prefix = @Prefix + '-C'
			END
		END
		ELSE IF @Type = 4
		BEGIN
			IF @AdditionType = 2
			BEGIN
				SET @Prefix = @Prefix + '-P1';
			END
			ELSE IF @AdditionType = 3
			BEGIN
				SET @Prefix = @Prefix + '-P2';
			END
			ELSE IF @AdditionType = 4
			BEGIN
				SET @Prefix = @Prefix + '-P3';
			END
			ELSE IF @AdditionType = 5
			BEGIN
				SET @Prefix = @Prefix + '-P4';
			END
			ELSE IF @AdditionType = 6
			BEGIN
				SET @Prefix = @Prefix + '-P5';
			END
		END

		SET @Num = @Num + 1;
		UPDATE TMS_SN SET SN_Number = SN_Number + 1 WHERE SN_ID = @SN_ID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @SN = '';
		END
		ELSE
		BEGIN
			SET @SN = UPPER(@Prefix) + 
				CAST(YEAR(@NOW) AS VARCHAR) + (CASE WHEN MONTH(@NOW) < 10 THEN '0' + CAST(MONTH(@NOW) AS VARCHAR) ELSE CAST(MONTH(@NOW) AS VARCHAR) END) + (CASE WHEN DAY(@NOW) < 10 THEN '0' + CAST(DAY(@NOW) AS VARCHAR) ELSE CAST(DAY(@NOW) AS VARCHAR) END)	+ 
				(CASE WHEN @Num <= 0 THEN '00000' 
					WHEN @Num < 10 THEN '0000' + CAST(@Num AS VARCHAR) 
					WHEN @Num < 100 THEN '000' + CAST(@Num AS VARCHAR) 
					WHEN @Num < 1000 THEN '00' + CAST(@Num AS VARCHAR) 
					WHEN @Num < 10000 THEN '0' + CAST(@Num AS VARCHAR) 
					WHEN @Num < 99999 THEN CAST(@Num AS VARCHAR) 
				ELSE '00000' END);
		END
	END

	SET NOCOUNT OFF;
END



GO


