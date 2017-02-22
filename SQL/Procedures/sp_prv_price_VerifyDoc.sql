USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_price_VerifyDoc]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_price_VerifyDoc]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*审核报价单*/
CREATE PROCEDURE [dbo].[sp_prv_price_VerifyDoc]
(
	@Operator BIGINT,
	@DocID BIGINT,
	@Op BIGINT,					-- 0 同意 1 拒绝
	@Description NVARCHAR(512),	-- 描述(拒绝时必填)
	@Result BIGINT OUTPUT
)
AS
BEGIN

	DECLARE @CompanyID BIGINT;
	DECLARE @DstCompanyID BIGINT;
	DECLARE @SrcStatus BIGINT;
	DECLARE @DstStatus BIGINT;
	DECLARE @DocType BIGINT;				-- 报价单类型: 1 按单报价 2 按合约报价 3 补充报价 4 合单报价 5 合单补充报价
	DECLARE @DocOrderID BIGINT;				-- 按单报价 和 补充报价 针对的订单编号
	
	DECLARE @OrderCreator BIGINT;			-- 订单价格计算者
	DECLARE @OrderCreatorCompanyID BIGINT;	-- 订单价格计算公司编号
	DECLARE @SrcOrderID BIGINT;				-- 源订单
	DECLARE @OrderSrcClass BIGINT;			-- 订单类型
	DECLARE @SrcOrderCreator BIGINT;		-- 源订单创建者
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	SET @DstCompanyID = 0;
	SET @SrcStatus = 1;
	IF @Op = 0
	BEGIN
		SET @DstStatus = 2;
	END
	ELSE
	BEGIN
		SET @DstStatus = 0;
	END
	SET @DocType = 0;
	SET @DocOrderID = 0;
	SET @OrderCreator = 0;
	SET @OrderCreatorCompanyID = 0;
	SET @SrcOrderID = 0;
	SET @OrderSrcClass = 0;
	SET @SrcOrderCreator = 0;

	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -520013001;
	END
	

	-- 当前用户没有发布报价单的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520013002;
	END

	-- 报价单是否存在
	IF @Result = 0
	BEGIN
		SELECT @DocType = [Index_Type], @DocOrderID = [Index_OrderID], @SrcStatus = [Index_Status], @DstCompanyID = Index_CreatorCompanyID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Invalid = 0 AND Index_Status = 1;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -520013003;
		END
	END
	
	-- 只有报价单接收者(所在公司)或者自营按单报价可以审核
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM Price_DocIndex WHERE Index_ID = @DocID AND (CASE WHEN  Index_SupplierSymbolID > 0 AND Index_CreatorCompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0) THEN 1 WHEN Index_SupplierSymbolID = 0 AND Index_CustomerCompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0)THEN 1  ELSE 0 END)=1)
	BEGIN
		SET @Result = -520013004;
	END

	-- 只有已发布的报价单可以审核
	IF @Result = 0 AND NOT EXISTS(SELECT [Index_ID] FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Status = 1)
	BEGIN
		SET @Result = -520013005;
	END
	
	-- 拒绝时必须写描述
	IF @Result = 0 AND @Op = 1 AND (@Description IS NULL OR @Description = '')
	BEGIN
		SET @Result = -520013006;
	END

	-- 执行审核操作
	IF @Result = 0
	BEGIN
		UPDATE Price_DocIndex SET Index_Status = @DstStatus, Index_StatusTime = GETDATE(), Index_Confirmer = @Operator, Index_ConfirmTime = GETDATE() WHERE Index_ID = @DocID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -520013007;
		END
		ELSE
		BEGIN
			DECLARE @tmpResult BIGINT;
			DECLARE @EventID BIGINT;
			DECLARE @OccurTime DATETIME;
			SET @tmpResult = 0;
			SET @EventID = 0;
			SET @OccurTime = GETDATE();

			IF @Op = 1
			BEGIN
				-- 添加事件通知(8 报价单被拒绝)
				EXEC sp_prv_event_AddEvent @Operator, 8, @DstCompanyID, 1, @DocID, @OccurTime,@Description, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
				IF @tmpResult <> 0 
				BEGIN
					SET @Result = -520013008;
				END
			END
			-- 生成报价(报价单审核通过,并且报价单类型为按单报价 或 补充报价
			ELSE IF @Op = 0
			BEGIN
				SELECT @OrderCreator = Index_Creator, @OrderCreatorCompanyID = Index_CreatorCompanyID, @SrcOrderID = Index_SrcOrderID, @OrderSrcClass = Index_SrcClass FROM TMS_OrderIndex WHERE Index_ID = @DocOrderID AND Index_Invalid = 0;
				IF @@ROWCOUNT > 0
				BEGIN
					-- 按单报价重算,补充报价追加价格
					IF @DocType IN (1,3,5) AND @DocOrderID > 0
					BEGIN
						-- 按单报价，整单价格重算
						IF @DocType = 1
						BEGIN
							-- 当前订单
							EXEC sp_prv_price_CacheOrderPrice @OrderCreator, @DocOrderID, 0, @Result = @Result OUTPUT;
							
							-- 客户的运输订单
							IF @Result = 0 AND @SrcOrderID > 0 AND @OrderSrcClass = 1
							BEGIN
								SELECT @SrcOrderCreator = Index_Creator FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID AND Index_SupplierCompanyID = @OrderCreatorCompanyID AND Index_SrcClass = 2 AND Index_Invalid = 0;
								IF @@ROWCOUNT > 0
								BEGIN
									EXEC sp_prv_price_CacheOrderPrice @SrcOrderCreator, @SrcOrderID, 0, @Result = @Result OUTPUT;
								END
							END
						END
						-- 补充报价，追加价格
						ELSE IF @DocType IN (3,5)
						BEGIN
							-- 当前订单
							IF @DocType = 3 
							BEGIN
								INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, 
		Cache_InsertTime, Cache_Invalid, Cache_DocID) SELECT @DocOrderID, Detail_Type, 1, Detail_Amount, @OrderCreator, GETDATE(), 0 ,@DocID FROM Price_DocDetails WHERE Detail_DocID = @DocID AND Detail_Invalid = 0;
								IF @@ROWCOUNT = 0
								BEGIN
									SET @Result = -520013009;
								END
							END
							-- 客户运输订单
							IF @Result = 0 AND @SrcOrderID > 0 AND @OrderSrcClass = 1
							BEGIN
								SELECT @SrcOrderCreator = Index_Creator FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID AND Index_SupplierCompanyID = @OrderCreatorCompanyID AND Index_SrcClass = 2 AND Index_Invalid = 0;
								IF @@ROWCOUNT > 0
								BEGIN
									INSERT INTO Price_OrderCache(Cache_OrderID, Cache_Type, Cache_IsAddition, Cache_Amount, Cache_Author, 
	Cache_InsertTime, Cache_Invalid,Cache_DocID) SELECT @SrcOrderID, Detail_Type, 1, Detail_Amount, @SrcOrderCreator, GETDATE(), 0,@DocID FROM Price_DocDetails WHERE Detail_DocID = @DocID AND Detail_Invalid = 0;
									IF @@ROWCOUNT = 0
									BEGIN
										SET @Result = -520013010;
									END
								END
							END
						END
						
						IF @DocType = 5 AND @DocOrderID > 0
						BEGIN
							DECLARE @OrderID BIGINT;
							DECLARE @_AdditionCost BIGINT;
							SET @OrderID = 0;
							SET @_AdditionCost = 0;
							SELECT @OrderID = Index_OrderID FROM Price_DocIndex WHERE Index_ID = @DocID;
							SELECT @_AdditionCost = Detail_Amount FROM Price_DocDetails WHERE Detail_DOCID = @DocID;

							EXEC sp_prv_price_CacheCombineOrderPrice @Operator, @OrderID, 0, 0, 0, 0, 0, 0, @_AdditionCost, 0, 0, 0, @DocID,@Result = @Result OUTPUT;
						END
					END
					-- 合单报价重算
					ELSE IF @DocType = 4 AND @DocOrderID > 0
					BEGIN
						-- 被合单订单将自动计算价格
						EXEC sp_prv_price_CacheOrderPrice @OrderCreator, @DocOrderID, 0, @Result = @Result OUTPUT;
					END
				END
				
				-- 添加事件通知(11 客户接受报价单)
				IF @Result = 0
				BEGIN
					EXEC sp_prv_event_AddEvent @Operator, 11, @DstCompanyID, 0, @DocID, @OccurTime, @Result = @tmpResult OUTPUT, @EventID = @EventID OUTPUT;
					IF @tmpResult <> 0 
					BEGIN
						SET @Result = -520013008;
					END
				END
			END
		END
	END
	
	-- 写报价流程表
	IF @Result = 0
	BEGIN
		INSERT INTO Price_DocFlow(Flow_DocID, Flow_SrcStatus, Flow_DstStatus, Flow_Operation, Flow_Description, Flow_Creator, Flow_CompanyID, 
Flow_InsertTime, Flow_Invalid) VALUES(@DocID, @SrcStatus, @DstStatus, @Op, @Description, @Operator, @CompanyID, GETDATE(), 0);
	END

	
END
GO


