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
���ӷ�
<Add>
	<Pr>
		<DetailID>3333</DetailID>
		<AdditionType>1</AdditionType>
		<Amount>4</Amount>
		<Description>�ֽ�</Description>
	</Pr>
	<Pr>
		<DetailID>0</DetailID>
		<AdditionType>2</AdditionType>
		<Amount>5</Amount>
		<Description>��2��</Description>
	</Pr>
</Add>
*/
CREATE PROCEDURE [dbo].[sp_prv_price_AdditionPrice]
(
	@Operator BIGINT,							
	--@DetailID BIGINT = 0,					-- �۸���
	@DocType BIGINT,						-- �������ͣ��̶�Ϊ9
	-- @Price DECIMAL(18,2),					-- �۸�
	-- @Description NVARCHAR(1024) = N'',		-- ����˵�� 
	@TxnRequired TINYINT = 0,
	-- @AdditionType BIGINT = 0,				-- ���ӷѵ���Ŀ���
	@DocID BIGINT ,				-- ���۵���
	@AddpriceLst NVARCHAR(MAX) = N'',
	@Result BIGINT OUTPUT
)
AS
BEGIN
	
	DECLARE @CompanyID BIGINT;
	SET @Result= 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -5200101001;
	END
	
	-- ��ǰ�û�û����ӿͻ���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -520010002;
	END
	
	-- �۸������Ƿ�ƥ��(���ӷ�)
	IF @Result = 0 AND @DocType <> 9
	BEGIN
		SET @Result = -520010003;
	END
	
	
	-- ���۵��Ƿ����
	IF @Result = 0 AND @DocID > 0  AND NOT EXISTS(SELECT Index_ID FROM Price_DocIndex WHERE Index_ID = @DocID AND Index_Invalid = 0)
	BEGIN
		SET @Result = -520010004;
	END
	
	DECLARE @XmlDocId INT;
	SET @XmlDocId = 0;
	
	IF @Result = 0
	BEGIN
		
		
			EXEC SP_XML_PREPAREDOCUMENT @XmlDocId OUTPUT, @AddpriceLst;
			-- ���� 
			INSERT INTO Price_DocDetails(Detail_DocID, Detail_Type, Detail_Amount, Detail_Description, Detail_Creator, Detail_CreatorCompanyID, Detail_CreateTime, Detail_Invalid, Detail_AdditionType) SELECT @DocID, 9, Amount, [Description], @Operator, @CompanyID, GETDATE(), 0, AdditionType FROM 
OPENXML(@XmlDocId, '/Add/Pr', 2) WITH (
	DetailID NVARCHAR(200),
	AdditionType NVARCHAR(200),
	Amount NVARCHAR(200),
	[Description] NVARCHAR(200)
	) WHERE DetailID = 0 ;
			-- �޸�
			UPDATE Price_DocDetails SET Detail_AdditionType =  AdditionType, Detail_Amount = Amount, Detail_Description = [Description] FROM
OPENXML(@XmlDocId, '/Add/Pr', 2) WITH (
	DetailID NVARCHAR(200),
	AdditionType NVARCHAR(200),
	Amount NVARCHAR(200),
	[Description] NVARCHAR(200)
	) WHERE DetailID > 0 AND Detail_ID = DetailID;
			
			/** �����޸� ,���ԭ������ �޷��ж� ����ע��
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -520010005;
			END
			**/
		
		
	END
	


END
GO


