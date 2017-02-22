USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_price_CacheCombineOrderPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_price_CacheCombineOrderPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/*����ϵ������ļ۸�*/
CREATE PROCEDURE [dbo].[sp_prv_price_CacheCombineOrderPrice]
(
	@Operator BIGINT,
	@OrderID BIGINT,
	@LessLoadPrice DECIMAL(18,2),
	@FullLoadPrice DECIMAL(18,2),
	@PickPrice DECIMAL(18,2),
	@DeliveryPrice DECIMAL(18,2),
	@OnLoadPrice DECIMAL(18,2),
	@OffLoadPrice DECIMAL(18,2),
	@AdditionPrice DECIMAL(18,2),
	@InsuranceCost DECIMAL(18, 2), 
	@TaxPrice DECIMAL(18,2),
	@IsDebugMode TINYINT = 0, 
	@DocID BIGINT,
	@Result BIGINT OUTPUT
)
AS
BEGIN
	SET @Result = 0;

	DECLARE @PriceFound BIGINT;
	DECLARE @PriceType BIGINT;
	DECLARE @TotalWeight DECIMAL(18,4);
	DECLARE @TotalVolume DECIMAL(18,6);
	DECLARE @DocType BIGINT;
	SET @TotalWeight = 0;
	SET @PriceFound = 0;
	SET @PriceType = 0;
	SET @TotalVolume = 0;
	SET @DocType = 0;
	
	
	SELECT @DocType = Index_Type FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Invalid = 0;
	

	-- ������
	SELECT @TotalWeight = SUM(CASE WHEN Contains_Weight = 0 THEN Contains_Volume * 250 ELSE Contains_Weight END) FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0;

	-- �����	
	-- SELECT @TotalVolume = SUM(Contains_Volume) FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0;
	

	-- ���������Ƿ��Ѿ�����(�Ѵ�������Ϊ��Ч,����������)
	IF @DocType = 4 AND EXISTS(SELECT A.Cache_ID FROM Price_OrderCache AS A INNER JOIN TMS_OrderContains AS B ON A.Cache_OrderID = B.Contains_OrderID WHERE B.Contains_OwnerOrderID = @OrderID AND B.Contains_Invalid = 0 AND A.Cache_Invalid = 0)
	BEGIN
		UPDATE Price_OrderCache SET Cache_Invalid = 1 WHERE Cache_OrderID IN (SELECT Contains_OrderID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0);
	END

	-- �㵣
	IF @LessLoadPrice > 0
	BEGIN
		SET @PriceType = 1;
  
		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, Cache_Invalid,Cache_DocID) SELECT Contains_OrderID, 
@PriceType, 0, ROUND((CASE WHEN Contains_Weight = 0 THEN ( Contains_Volume * 250 / @TotalWeight ) ELSE ( Contains_Weight / @TotalWeight ) END) * @LessLoadPrice, 2), @Operator, GETDATE(),0, @DocID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0;
		IF @@ROWCOUNT > 0
		BEGIN
			SET @PriceFound = 1;

			-- �˴��������÷��۹�����������5�뵼�µ���ֵ���¸���
			WITH cr AS
			(
				SELECT MAX(a.Cache_OrderID) AS [OrderID], SUM(Cache_Amount) AS [Current], @LessLoadPrice AS [Actual] FROM Price_OrderCache AS a INNER JOIN TMS_OrderContains AS b ON a.Cache_OrderID = b.Contains_OrderID WHERE 
b.Contains_OwnerOrderID = @OrderID AND b.Contains_Invalid = 0 AND a.Cache_Invalid = 0 AND a.Cache_Type = @PriceType
			)
			UPDATE A SET A.Cache_Amount = ROUND(A.Cache_Amount + B.[Actual] - B.[Current], 2), A.Cache_Comments = CAST(B.Actual AS VARCHAR) FROM Price_OrderCache A INNER JOIN cr B ON A.Cache_OrderID = B.OrderID WHERE 
A.Cache_Invalid = 0 AND A.Cache_Type = @PriceType;
		END
	END
	
	-- ����
	IF @FullLoadPrice > 0
	BEGIN
		SET @PriceType = 2;

		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, Cache_Invalid, Cache_DocID) SELECT Contains_OrderID, 
@PriceType, 0, ROUND((CASE WHEN Contains_Weight = 0 THEN ( Contains_Volume * 250 / @TotalWeight ) ELSE ( Contains_Weight / @TotalWeight ) END) * @FullLoadPrice, 2), @Operator, GETDATE(),0, @DocID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0;
		IF @@ROWCOUNT > 0
		BEGIN
			SET @PriceFound = 1;
			
			-- �˴��������÷��۹�����������5�뵼�µ���ֵ���¸���
			WITH cr AS
			(
				SELECT MAX(a.Cache_OrderID) AS [OrderID], SUM(Cache_Amount) AS [Current], @FullLoadPrice AS [Actual] FROM Price_OrderCache AS a INNER JOIN TMS_OrderContains AS b ON a.Cache_OrderID = b.Contains_OrderID WHERE 
b.Contains_OwnerOrderID = @OrderID AND b.Contains_Invalid = 0 AND a.Cache_Invalid = 0 AND a.Cache_Type = @PriceType
			)
			UPDATE A SET A.Cache_Amount = ROUND(A.Cache_Amount + B.[Actual] - B.[Current], 2), A.Cache_Comments = CAST(B.Actual AS VARCHAR) FROM Price_OrderCache A INNER JOIN cr B ON A.Cache_OrderID = B.OrderID WHERE 
A.Cache_Invalid = 0 AND A.Cache_Type = @PriceType;
		END
	END
	
	-- ���
	IF @PickPrice > 0
	BEGIN
		SET @PriceType = 3;

		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, Cache_Invalid, Cache_DocID) SELECT Contains_OrderID, 
@PriceType, 0, ROUND((CASE WHEN Contains_Weight = 0 THEN (Contains_Volume * 200 / @TotalWeight ) ELSE ( Contains_Weight / @TotalWeight ) END) * @PickPrice, 2), @Operator, GETDATE(),0, @DocID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0;
		IF @@ROWCOUNT > 0
		BEGIN
			SET @PriceFound = 1;

			-- �˴��������÷��۹�����������5�뵼�µ���ֵ���¸���
			WITH cr AS
			(
				SELECT MAX(a.Cache_OrderID) AS [OrderID], SUM(Cache_Amount) AS [Current], @PickPrice AS [Actual] FROM Price_OrderCache AS a INNER JOIN TMS_OrderContains AS b ON a.Cache_OrderID = b.Contains_OrderID WHERE 
b.Contains_OwnerOrderID = @OrderID AND b.Contains_Invalid = 0 AND a.Cache_Invalid = 0 AND a.Cache_Type = @PriceType
			)
			UPDATE A SET A.Cache_Amount = ROUND(A.Cache_Amount + B.[Actual] - B.[Current], 2), A.Cache_Comments = CAST(B.Actual AS VARCHAR) FROM Price_OrderCache A INNER JOIN cr B ON A.Cache_OrderID = B.OrderID WHERE 
A.Cache_Invalid = 0 AND A.Cache_Type = @PriceType;
		END
	END
	
	-- �ͻ�
	IF @DeliveryPrice > 0
	BEGIN
		SET @PriceType = 4;

		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, Cache_Invalid ,Cache_DocID) SELECT Contains_OrderID, 
@PriceType, 0, ROUND((CASE WHEN Contains_Weight = 0 THEN ( Contains_Volume * 250 / @TotalWeight ) ELSE ( Contains_Weight / @TotalWeight ) END) * @DeliveryPrice, 2), @Operator, GETDATE(),0 ,@DocID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0;
		IF @@ROWCOUNT > 0
		BEGIN
			SET @PriceFound = 1;
			
			-- �˴��������÷��۹�����������5�뵼�µ���ֵ���¸���
			WITH cr AS
			(
				SELECT MAX(a.Cache_OrderID) AS [OrderID], SUM(Cache_Amount) AS [Current], @DeliveryPrice AS [Actual] FROM Price_OrderCache AS a INNER JOIN TMS_OrderContains AS b ON a.Cache_OrderID = b.Contains_OrderID WHERE 
b.Contains_OwnerOrderID = @OrderID AND b.Contains_Invalid = 0 AND a.Cache_Invalid = 0 AND a.Cache_Type = @PriceType
			)
			UPDATE A SET A.Cache_Amount = ROUND(A.Cache_Amount + B.[Actual] - B.[Current], 2), A.Cache_Comments = CAST(B.Actual AS VARCHAR) FROM Price_OrderCache A INNER JOIN cr B ON A.Cache_OrderID = B.OrderID WHERE 
A.Cache_Invalid = 0 AND A.Cache_Type = @PriceType;
		END
	END
	
	-- װ��
	IF @OnLoadPrice > 0
	BEGIN
		SET @PriceType = 5;

		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, Cache_Invalid, Cache_DocID) SELECT Contains_OrderID, 
@PriceType, 0, ROUND((CASE WHEN Contains_Weight = 0 THEN ( Contains_Volume * 250 / @TotalWeight ) ELSE ( Contains_Weight / @TotalWeight ) END) * @OnLoadPrice, 2), @Operator, GETDATE(),0 ,@DocID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0;
		IF @@ROWCOUNT > 0
		BEGIN
			SET @PriceFound = 1;
			
			-- �˴��������÷��۹�����������5�뵼�µ���ֵ���¸���
			WITH cr AS
			(
				SELECT MAX(a.Cache_OrderID) AS [OrderID], SUM(Cache_Amount) AS [Current], @OnLoadPrice AS [Actual] FROM Price_OrderCache AS a INNER JOIN TMS_OrderContains AS b ON a.Cache_OrderID = b.Contains_OrderID WHERE 
b.Contains_OwnerOrderID = @OrderID AND b.Contains_Invalid = 0 AND a.Cache_Invalid = 0 AND a.Cache_Type = @PriceType
			)
			UPDATE A SET A.Cache_Amount = ROUND(A.Cache_Amount + B.[Actual] - B.[Current], 2), A.Cache_Comments = CAST(B.Actual AS VARCHAR) FROM Price_OrderCache A INNER JOIN cr B ON A.Cache_OrderID = B.OrderID WHERE 
A.Cache_Invalid = 0 AND A.Cache_Type = @PriceType;
		END
	END
	
	-- ж��
	IF @OffLoadPrice > 0
	BEGIN
		SET @PriceType = 6;

		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, Cache_Invalid, Cache_DocID) SELECT Contains_OrderID, 
@PriceType, 0, ROUND((CASE WHEN Contains_Weight = 0 THEN ( Contains_Volume * 250 / @TotalWeight ) ELSE ( Contains_Weight / @TotalWeight ) END) * @OffLoadPrice, 2), @Operator, GETDATE(),0, @DocID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0;
		IF @@ROWCOUNT > 0
		BEGIN
			SET @PriceFound = 1;
			
			-- �˴��������÷��۹�����������5�뵼�µ���ֵ���¸���
			WITH cr AS
			(
				SELECT MAX(a.Cache_OrderID) AS [OrderID], SUM(Cache_Amount) AS [Current], @OffLoadPrice AS [Actual] FROM Price_OrderCache AS a INNER JOIN TMS_OrderContains AS b ON a.Cache_OrderID = b.Contains_OrderID WHERE 
b.Contains_OwnerOrderID = @OrderID AND b.Contains_Invalid = 0 AND a.Cache_Invalid = 0 AND a.Cache_Type = @PriceType
			)
			UPDATE A SET A.Cache_Amount = ROUND(A.Cache_Amount + B.[Actual] - B.[Current], 2), A.Cache_Comments = CAST(B.Actual AS VARCHAR) FROM Price_OrderCache A INNER JOIN cr B ON A.Cache_OrderID = B.OrderID WHERE 
A.Cache_Invalid = 0 AND A.Cache_Type = @PriceType;
		END
	END
	
	-- ��С���[ͳһΪ0]
	
	-- ����
	IF @InsuranceCost > 0
	BEGIN
		SET @PriceType = 8;

		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, Cache_Invalid, Cache_DocID) SELECT Contains_OrderID, 
@PriceType, 1, ROUND((CASE WHEN Contains_Weight = 0 THEN ( Contains_Volume * 250 / @TotalWeight ) ELSE ( Contains_Weight / @TotalWeight ) END) * @InsuranceCost, 2), @Operator, GETDATE(),0,@DocID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0;
		IF @@ROWCOUNT > 0
		BEGIN
			SET @PriceFound = 1;
			
			-- �˴��������÷��۹�����������5�뵼�µ���ֵ���¸���
			WITH cr AS
			(
				SELECT MAX(a.Cache_OrderID) AS [OrderID], SUM(Cache_Amount) AS [Current], @InsuranceCost AS [Actual] FROM Price_OrderCache AS a INNER JOIN TMS_OrderContains AS b ON a.Cache_OrderID = b.Contains_OrderID WHERE 
b.Contains_OwnerOrderID = @OrderID AND b.Contains_Invalid = 0 AND a.Cache_Invalid = 0 AND a.Cache_Type = @PriceType
			)
			UPDATE A SET A.Cache_Amount = ROUND(A.Cache_Amount + B.[Actual] - B.[Current], 2), A.Cache_Comments = CAST(B.Actual AS VARCHAR) FROM Price_OrderCache A INNER JOIN cr B ON A.Cache_OrderID = B.OrderID WHERE 
A.Cache_Invalid = 0 AND A.Cache_Type = @PriceType;
		END
	END
		
	-- ����
	IF @AdditionPrice <> 0
	BEGIN
		SET @PriceType = 9;

		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, Cache_Invalid,Cache_DocID) SELECT Contains_OrderID, 
@PriceType, (CASE WHEN  @DocType = 4 THEN 0 ELSE 1 END), ROUND((CASE WHEN Contains_Weight = 0 THEN ( Contains_Volume * 250 / @TotalWeight ) ELSE ( Contains_Weight / @TotalWeight ) END) * @AdditionPrice, 2), @Operator, GETDATE(),0,@DocID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0;
		IF @@ROWCOUNT > 0
		BEGIN
			SET @PriceFound = 1;
			
			-- �˴��������÷��۹�����������5�뵼�µ���ֵ���¸���
			WITH cr AS
			(
				SELECT MAX(a.Cache_OrderID) AS [OrderID], SUM(Cache_Amount) AS [Current], @AdditionPrice AS [Actual] FROM Price_OrderCache AS a INNER JOIN TMS_OrderContains AS b ON a.Cache_OrderID = b.Contains_OrderID WHERE 
b.Contains_OwnerOrderID = @OrderID AND b.Contains_Invalid = 0 AND a.Cache_Invalid = 0 AND a.Cache_Type = @PriceType AND Cache_IsAddition = (CASE WHEN  @DocType = 4 THEN 0 ELSE 1 END) AND Cache_DocID = @DocID 
			)
			UPDATE A SET A.Cache_Amount = ROUND(A.Cache_Amount + B.[Actual] - B.[Current], 2), A.Cache_Comments = CAST(B.Actual AS VARCHAR) FROM Price_OrderCache A INNER JOIN cr B ON A.Cache_OrderID = B.OrderID WHERE 
A.Cache_Invalid = 0 AND A.Cache_Type = @PriceType AND Cache_DocID = @DocID;
		END
	END
	
	-- ˰��
	IF @TaxPrice > 0
	BEGIN
		SET @PriceType = 10;

		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, Cache_Invalid,Cache_DocID) SELECT Contains_OrderID, 
@PriceType, 0, ROUND((CASE WHEN Contains_Weight = 0 THEN ( Contains_Volume * 250 / @TotalWeight ) ELSE ( Contains_Weight / @TotalWeight ) END) * @TaxPrice, 2), @Operator, GETDATE(),0, @DocID FROM TMS_OrderContains WHERE Contains_OwnerOrderID = @OrderID AND Contains_Invalid = 0;
		IF @@ROWCOUNT > 0
		BEGIN
			SET @PriceFound = 1;
			
			-- �˴��������÷��۹�����������5�뵼�µ���ֵ���¸���
			WITH cr AS
			(
				SELECT MAX(a.Cache_OrderID) AS [OrderID], SUM(Cache_Amount) AS [Current], @TaxPrice AS [Actual] FROM Price_OrderCache AS a INNER JOIN TMS_OrderContains AS b ON a.Cache_OrderID = b.Contains_OrderID WHERE 
b.Contains_OwnerOrderID = @OrderID AND b.Contains_Invalid = 0 AND a.Cache_Invalid = 0 AND a.Cache_Type = @PriceType
			)
			UPDATE A SET A.Cache_Amount = ROUND(A.Cache_Amount + B.[Actual] - B.[Current], 2), A.Cache_Comments = CAST(B.Actual AS VARCHAR) FROM Price_OrderCache A INNER JOIN cr B ON A.Cache_OrderID = B.OrderID WHERE 
A.Cache_Invalid = 0 AND A.Cache_Type = @PriceType;
		END
	END
	
	IF @PriceFound = 0
	BEGIN
		SET @Result = -510039101;
	END
	ELSE
	-- ���ɱ��϶����ĳ����̿ͻ������ļ۸�
	BEGIN
		-- �ϵ����ۼ۸��Ƿ����(���������)
		IF @DocType = 4
		BEGIN 
			IF EXISTS(SELECT Cache_ID FROM Price_OrderCache WHERE Cache_OrderID IN (SELECT A.Index_ID FROM TMS_OrderIndex AS A INNER JOIN TMS_OrderContains AS B ON A.Index_SrcOrderID = B.Contains_OrderID WHERE B.Contains_OwnerOrderID = @OrderID AND B.Contains_Invalid = 0 AND A.Index_Invalid = 0))
				BEGIN
					UPDATE Price_OrderCache SET Cache_Invalid = 1 WHERE Cache_OrderID IN (SELECT A.Index_ID FROM TMS_OrderIndex AS A INNER JOIN TMS_OrderContains AS B ON A.Index_SrcOrderID = B.Contains_OrderID WHERE B.Contains_OwnerOrderID = @OrderID AND B.Contains_Invalid = 0 AND A.Index_Invalid = 0);
				END	
		-- ���Ƽ۸�
		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, Cache_Invalid,Cache_DocID) SELECT A.Index_ID, C.Cache_Type, C.Cache_IsAddition, C.Cache_Amount, C.Cache_Author, C.Cache_InsertTime, C.Cache_Invalid,C.Cache_DocID  FROM TMS_OrderIndex AS A 
INNER JOIN TMS_OrderContains AS B ON A.Index_SrcOrderID = B.Contains_OrderID 
INNER JOIN Price_OrderCache AS C ON C.Cache_OrderID = B.Contains_OrderID 
WHERE B.Contains_OwnerOrderID = @OrderID AND B.Contains_Invalid = 0 AND A.Index_Invalid = 0 AND C.Cache_Invalid = 0;
		END
		ELSE 
		BEGIN
		INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, Cache_InsertTime, Cache_Invalid,Cache_DocID) SELECT A.Index_ID, C.Cache_Type, C.Cache_IsAddition, C.Cache_Amount, C.Cache_Author, C.Cache_InsertTime, C.Cache_Invalid,C.Cache_DocID  FROM TMS_OrderIndex AS A 
INNER JOIN TMS_OrderContains AS B ON A.Index_SrcOrderID = B.Contains_OrderID 
INNER JOIN Price_OrderCache AS C ON C.Cache_OrderID = B.Contains_OrderID 
WHERE B.Contains_OwnerOrderID = @OrderID AND B.Contains_Invalid = 0 AND A.Index_Invalid = 0 AND C.Cache_Invalid = 0 AND Cache_Type = 9 AND Cache_IsAddition = 1;
		END
		/*
		-- comments by guohongliang, 20160808
		-- ���ֶ�����û����Դ������
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510039102;
		END
		*/
	END
END



GO


