USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_price_AdditionPrice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_price_AdditionPrice]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
附加费
<Add>
	<Pr>
		<DetailID>3333</DetailID>
		<AdditionType>1</AdditionType>
		<Amount>4</Amount>
		<Description>钢筋</Description>
	</Pr>
	<Pr>
		<DetailID>0</DetailID>
		<AdditionType>2</AdditionType>
		<Amount>5</Amount>
		<Description>钢2筋</Description>
	</Pr>
</Add>
*/
CREATE PROCEDURE [dbo].[sp_prv_price_AdditionPrice]
(
	@Operator BIGINT,							
	--@DetailID BIGINT = 0,					-- 价格编号
	@DocType BIGINT,						-- 报价类型，固定为9
	-- @Price DECIMAL(18,2),					-- 价格
	-- @Description NVARCHAR(1024) = N'',		-- 附加说明 
	@TxnRequired TINYINT = 0,
	-- @AdditionType BIGINT = 0,				-- 附加费的名目编号
	@DocID BIGINT ,				-- 报价单号
	@AddpriceLst NVARCHAR(MAX) = N'',
	@Result BIGINT OUTPUT
)
AS
BEGIN
	
	DECLARE @CompanyID BIGINT;
	SET @Result= 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	-- 当前用户没有关联公司
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -5200101001;
	END
	
	-- 当前用户没有添加客户的权限
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520010002;
	END
	
	-- 价格类型是否匹配(附加费)
	IF @Result = 0 AND @DocType <> 9
	BEGIN
		SET @Result = -520010003;
	END
	
	
	-- 报价单是否存在
	IF @Result = 0 AND @DocID > 0  AND NOT EXISTS(SELECT Index_ID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Invalid = 0)
	BEGIN
		SET @Result = -520010004;
	END
	
	DECLARE @XmlDocId INT;
	SET @XmlDocId = 0;
	
	IF @Result = 0
	BEGIN
		
		
			EXEC SP_XML_PREPAREDOCUMENT @XmlDocId OUTPUT, @AddpriceLst;
			-- 新增 
			INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Amount, Detail_Description, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid, Detail_AdditionType) SELECT @DocID, 9, Amount, [Description], @Operator, @CompanyID, GETDATE(), 0, AdditionType FROM 
OPENXML(@XmlDocId, '/Add/Pr', 2) WITH (
	DetailID NVARCHAR(200),
	AdditionType NVARCHAR(200),
	Amount NVARCHAR(200),
	[Description] NVARCHAR(200)
	) WHERE DetailID = 0 ;
			-- 修改
			UPDATE Price_DocDetails SET Detail_AdditionType =  AdditionType, Detail_Amount = Amount, Detail_Description = [Description] FROM
OPENXML(@XmlDocId, '/Add/Pr', 2) WITH (
	DetailID NVARCHAR(200),
	AdditionType NVARCHAR(200),
	Amount NVARCHAR(200),
	[Description] NVARCHAR(200)
	) WHERE DetailID > 0 AND Detail_ID = DetailID;
			
			/** 新增修改 ,结合原来新增 无法判断 故先注释
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520010005;
			END
			**/
		
		
	END
	


END
GO


