USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_user_EODCustomerInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_user_EODCustomerInfo]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*���û���ÿͻ�*/
CREATE PROCEDURE [dbo].[sp_pub_user_EODCustomerInfo]
(
	@Operator BIGINT,
	@InfoID BIGINT,
	@Type TINYINT, -- 1,��Ʒ���� 2 ,�ͻ���Ʒ 3,���õ�ַ 4,�ջ�����Ϣ 5,�ջ������õ�ַ
	@EOD TINYINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
	DECLARE @CompanyID BIGINT;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator,0);
	SET @Result = 0;
	
	BEGIN TRANSACTION;
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510028001;
	END
	
	-- ��ǰ�û�û�����û���ÿͻ���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510028002;
	END
	-- ������Ʒ����
	IF @Result = 0 AND @Type = 1 
		BEGIN

			-- �ͻ���Ʒ���ͱ���Ƿ���Ч
			IF @Result = 0 AND NOT EXISTS(SELECT GoodsType_ID FROM TMS_MGoodsType WHERE GoodsType_ID = @InfoID AND GoodsType_CompanyID = @CompanyID)
			BEGIN
				SET @Result = -510028005;
			END
			-- �������ͻ���δ������Ʒ
			IF @Result = 0 AND  EXISTS (SELECT Goods_TypeID FROM dbo.TMS_MGoods WHERE Goods_TypeID = @InfoID AND Goods_Invalid = 0)
			BEGIN
				SET @Result = -510028006;
			END
				
			-- ���û������Ʒ����
			IF @Result = 0
			BEGIN
				UPDATE TMS_MGoodsType SET GoodsType_Invalid = (CASE WHEN @EOD = 1 THEN 0 ELSE 1 END) WHERE GoodsType_ID = @InfoID;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510028007;
				END
			END
		END
	-- ������Ʒ
	IF @Result = 0 AND @Type = 2 
		BEGIN

			-- �ͻ���Ʒ�Ƿ���Ч
			IF @Result = 0 AND NOT EXISTS(SELECT Goods_ID FROM TMS_MGoods WHERE Goods_ID = @InfoID AND Goods_CreatorCompanyID = @CompanyID)
			BEGIN
				SET @Result = -510028008;
			END
				
			-- ��Ʒ���ͱ�����
			IF @Result = 0 AND @EOD = 1 AND NOT EXISTS (SELECT Goods_TypeID FROM dbo.TMS_MGoods AS A INNER JOIN TMS_MGoodsType AS B ON A.Goods_TypeID = B.GoodsType_ID  WHERE A.Goods_ID = @InfoID AND B.GoodsType_Invalid = 0)
			BEGIN
				SET @Result = -510028017;
			END
				
			-- ���û������Ʒ����
			IF @Result = 0
			BEGIN
				UPDATE TMS_MGoods SET Goods_Invalid = (CASE WHEN @EOD = 1 THEN 0 ELSE 1 END) WHERE Goods_ID = @InfoID;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510028009;
				END
			END
		END
	
	IF @Result = 0 AND @Type = 3
		BEGIN

			-- �ͻ���ַ�Ƿ���Ч
			IF @Result = 0 AND NOT EXISTS(SELECT Addr_ID FROM TMS_MAddr WHERE Addr_ID = @InfoID AND Addr_CompanyID = @CompanyID)
			BEGIN
				SET @Result = -510028010;
			END
				
			-- ���û���õ�ַ
			IF @Result = 0
			BEGIN
				UPDATE TMS_MAddr SET Addr_Invalid = (CASE WHEN @EOD = 1 THEN 0 ELSE 1 END) WHERE Addr_ID = @InfoID;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510028011;
				END
			END
		END	
	
	IF @Result = 0 AND @Type = 4
		BEGIN

			-- �ջ����Ƿ���Ч
			IF @Result = 0 AND NOT EXISTS(SELECT EndUser_ID FROM TMS_MEndUser WHERE EndUser_ID = @InfoID AND EndUser_OwnerCompany = @CompanyID)
			BEGIN
				SET @Result = -510028012;
			END
			
			-- �����ջ��˻��е�ַδ����
			IF @Result = 0 AND  EXISTS (SELECT Addr_ID FROM dbo.TMS_MAddr WHERE Addr_CustomerID = @InfoID AND Addr_Invalid = 0)
			BEGIN
				SET @Result = -510028013;
			END
				
			-- ���û������Ʒ����
			IF @Result = 0
			BEGIN
				UPDATE TMS_MEndUser SET EndUser_Invalid = (CASE WHEN @EOD = 1 THEN 0 ELSE 1 END) WHERE EndUser_ID = @InfoID;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510028014;
				END
			END
		END	
			
	IF @Result = 0 AND @Type = 5
		BEGIN

			-- �ͻ���ַ�Ƿ���Ч
			IF @Result = 0 AND NOT EXISTS(SELECT Addr_ID FROM TMS_MAddr WHERE Addr_ID = @InfoID AND Addr_CompanyID = @CompanyID)
			BEGIN
				SET @Result = -510028015;
			END
			
			-- ���ͱ�����
			IF @Result = 0 AND @EOD = 1 AND NOT EXISTS (SELECT Addr_ID FROM TMS_MAddr AS A INNER JOIN TMS_MEndUser AS B ON A.Addr_CustomerID = B.EndUser_ID WHERE Addr_ID = @InfoID AND B.EndUser_Invalid = 0 )
			BEGIN
				SET @Result = -510028018;
			END
				
			-- ���û���õ�ַ
			IF @Result = 0
			BEGIN
				UPDATE TMS_MAddr SET Addr_Invalid = (CASE WHEN @EOD = 1 THEN 0 ELSE 1 END) WHERE Addr_ID = @InfoID;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @Result = -510028016;
				END
			END
		END	
		
	IF @Result = 0
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		ROLLBACK TRANSACTION;
	END

	SELECT @Result AS Customer_Result;

	SET NOCOUNT OFF;
END
GO


