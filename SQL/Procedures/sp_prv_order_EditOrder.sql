USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prv_order_EditOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_prv_order_EditOrder]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
��ӻ�༭����

Status�Ŀ���ֵ��
 0 �µ���
 1 �Ѽƻ�
 2 �ѵ���
 4 ��ǩ��
 8 �ѻص�
16 �ѽ���

@_Version = 1��ع�����sp_prv_order_TransportPlan_V1����, �ʺ�����ƻ��ֶ�ִ�е����

@_Version = 2��ع�����sp_prv_order_TransportPlan_V2����, �ʺ�����ƻ��Զ�ִ���������β𵥵����
��ǰģʽΪ��ʱ��@GoodsLst�ĸ�ʽ��
goodid1=goodamount1,goodid2=goodamount2

@_Version >= 3ʱ�µ����ʱ(�����޸Ķ���)��@GoodsLst�ĸ�ʽ��
<Lst>
	<Goods>
		<ID>88</ID>
		<Code>2016042200226</Code>
		<Name>�ֽ�</Name>
		<Qty>1</Qty>
		<Weight>1.2000</Weight>
		<Volume>2.000000</Volume>
		<Unit>2</Unit>
		<BatchNo>w</BatchNo>
		<Price>14</Price>
	</Goods>
</Lst>
*/
CREATE PROCEDURE [dbo].[sp_prv_order_EditOrder]
(
	@Operator BIGINT,
	@PactCode NVARCHAR(100),
	@EndUserID BIGINT,
	@From NVARCHAR(600),
	@To NVARCHAR(600),
	@SrcOrderID BIGINT,
	@CustomerID BIGINT = 0,			-- �ͻ���Ų���(Ĭ��Ϊ�Լ���˾)
	@SupplierID BIGINT,
	@GoodsLst NVARCHAR(MAX) = N'',
	@TxnRequired TINYINT = 1,
	@FromProvince BIGINT = 0,		-- ����ʡ
	@FromCity BIGINT = 0,			-- ������
	@FromDistrict BIGINT = 0,		-- ������
	@FromTime DATETIME = NULL,		-- ����ʱ��
	@ToProvince BIGINT = 0,			-- ����ʡ
	@ToCity BIGINT = 0,				-- ������
	@ToDistrict BIGINT = 0,			-- ������
	@ToTime DATETIME = NULL,		-- ����ʱ��
	@TransportMode BIGINT = 0,		-- ����ģʽ��1 �㵣 2 ���� 3 ���� 4 ��� 5 ��· 6 ����
	@GoodsCategory BIGINT = 0,		-- ������࣬1 ��ͨ���� 2 Σ��Ʒ 4 �¿ػ�ȡ������ʹ��or
	@PackageMode BIGINT = 0,		-- ��װ��ʽ��1 ɢ��(�ɶѵ����˹�װж) 2 ���̻�ľ��(�ɶѵ����泵װж) 3 ���̡�ľ��򲻹�����״�����ɶѵ����泵װж
	@ChargeMode BIGINT = 0,			-- �Ʒ�ģʽ��1 ��� 2 ����
	@PriceUnit BIGINT = 0,			-- �۸�λ��1 ���� 2 �� 3 ���� 4 ��
	@SrcClass BIGINT = 1,			-- ��Դ���ͣ�1 �ͻ����� 2 ���䶩��
	@Kms BIGINT = 0,				-- �ܹ�����
	@CarType BIGINT = 0,            -- ����(ö��ֵ)
	@CarLength DECIMAL(18,2) = 0,	-- ����/���(ö��ֵ)
	@ShipMode BIGINT = 0,			-- ����ģʽ��1 ���� 2 ��;
	@IsPick BIGINT = 0,				-- �Ƿ����
	@IsDelivery BIGINT = 0,			-- �Ƿ��ͻ�
	@DstStatus BIGINT = 0,			-- Ŀ�궩��״̬
	@IsOnLoad BIGINT = 0,			-- �Ƿ�װ��
	@IsOffLoad BIGINT = 0,			-- �Ƿ�ж��
	@IsInsurance BIGINT = 0,		-- �Ƿ񱣼�
	@VolumeAddition DECIMAL(18,6) = 0,			-- �������
	@WeightAddition DECIMAL(18,4) = 0,			-- ��������
	@Descriptions NVARCHAR(MAX) = N'',
	@CarVolume DECIMAL(18,6) = 0,	-- �����ݻ�
	@CarWeight DECIMAL(18,4) = 0,	-- ��������
	@CustomerSymbolID BIGINT = 0,	-- �ͻ���ʶ(�����¿ͻ�ʹ��)
	@FromContact NVARCHAR(300) = N'',			-- ������ϵ��Ϣ
	@ToContact NVARCHAR(300) = N'',				-- �ջ���ϵ��Ϣ
	@GoodsValue DECIMAL(18,2) = 0,	-- �����ܼ�ֵ
	@PrevOrderID BIGINT = 0,		-- ����۵�ʱ��ǰ�ö�����
	@_Version BIGINT = 1 ,			-- ���ô洢���̵��ĸ��汾��
	@DeviceCode NVARCHAR(50) = N'',  -- ���豸���
	@Payment DECIMAL(18,2) = 0,		-- Ԥ������
	@Payable DECIMAL(18,2) = 0,		-- ��������
	@OrderID BIGINT OUTPUT,
	@Result BIGINT OUTPUT
)
AS
BEGIN
	
	DECLARE @CompanyID BIGINT;
	DECLARE @RootOrderID BIGINT;
	DECLARE @CustomerCompanyID BIGINT;
	DECLARE @SupplierCompanyID BIGINT;
	DECLARE @Code NVARCHAR(100);
	DECLARE @InsertMode TINYINT;
	DECLARE @AddrID BIGINT;
	DECLARE @SetProvince BIGINT;
	DECLARE @SetCity BIGINT;
	DECLARE @Mode BIGINT;
	DECLARE @DstOrderID BIGINT;
	SET @AddrID = 0;
	
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	IF @OrderID IS NULL OR @OrderID = 0
	BEGIN
		IF @SrcOrderID IS NULL OR @SrcOrderID = 0
		BEGIN
			-- �ǲ�ģʽֱ�����ɱ��
			EXEC sp_pub_basic_GetSN 2, @SN = @Code OUTPUT;
		END
		ELSE
		BEGIN
			-- ��ģʽ��ԭ�������ɱ��
			SELECT @Code = Index_Code FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014013;
			END
			ELSE
			BEGIN
				DECLARE @__Amount BIGINT;
				SET @__Amount = 0;
				
				SELECT @__Amount = COUNT(*) FROM TMS_OrderIndex WHERE Index_SrcOrderID = @SrcOrderID;
				IF @@ROWCOUNT = 0
				BEGIN
					SET @__Amount = 0;
				END
				
				SET @__Amount = @__Amount + 1;
				SET @Code = @Code + '-' + CAST(@__Amount AS VARCHAR);
			END
		END
	END
	SET @RootOrderID = 0;
	SET @CustomerCompanyID = 0;
	SET @SupplierCompanyID = 0;
	SET @InsertMode = 0;
	IF @CarLength IS NULL
	BEGIN
		SET @CarLength = 0;
	END
	IF @SrcOrderID IS NULL
	BEGIN
		SET @SrcOrderID = 0;
	END
	IF @CustomerID IS NULL
	BEGIN
		SET @CustomerID = 0;
	END
	IF @SupplierID IS NULL
	BEGIN
		SET @SupplierID = 0;
	END
	IF @EndUserID IS NULL
	BEGIN
		SET @EndUserID = 0;
	END
	IF @DstStatus <> 1 AND @DstStatus <> 0
	BEGIN
		SET @DstStatus = 0;
	END
	IF @FromContact IS NULL
	BEGIN
		SET @FromContact = N'';
	END
	IF @ToContact IS NULL
	BEGIN
		SET @ToContact = N'';
	END
	SET @SetProvince = 0;
	SET @SetCity = 0;
	-- ��ǰ�洢���̹���ģʽ
	/*
	1 ��
	2 �µ�
	3 �޸�
	*/
	SET @Mode = 2;
	IF @SrcOrderID IS NOT NULL AND @SrcOrderID > 0
	BEGIN
		SET @Mode = 1;
	END
	IF @OrderID IS NOT NULL AND @OrderID > 0
	BEGIN
		SET @Mode = 3;
		SELECT @WeightAddition = Index_WeightAddition+@WeightAddition,@VolumeAddition=Index_VolumeAddition+@VolumeAddition FROM TMS_OrderIndex WHERE Index_ID = @OrderID;
	END
	SET @DstOrderID = 0;
	
	-- ��ʱ��;������Ӧ����ʼ����ֹ�����¼���
	SET @ShipMode = dbo.fn_pub_order_CalcShipMode( @Operator, @CompanyID, @FromProvince, @FromCity, @ToProvince, @ToCity);
	
	-- ��ǰ�û�û�й�����˾
	IF @CompanyID <= 0
	BEGIN
		SET @Result = -510014001;
	END
	
	-- ��ǰ�û�û����ӿͻ���Ȩ��
	IF @Result = 0 AND NOT EXISTS(SELECT [User_ID] FROM TMS_User WHERE [User_ID] = @Operator AND User_CompanyID = @CompanyID AND User_Invalid = 0)
	BEGIN
		SET @Result = -510014002;
	END

	-- ��ҪͶ��ʱ�����ܼ�ֵ������д
	-- ��ʱ��У������ܼ�ֵ
	IF @Result = 0 AND @Mode <> 1 AND @IsInsurance = 1 AND @GoodsValue = 0
	BEGIN
		SET @Result = -510014015;
	END

	-- �ͻ�û����(Ϊ0��Ϊ��,Ĭ��Ϊ�Լ���˾)
	IF @Result = 0 AND (@CustomerID = 0 OR @CustomerID IS NULL)
	BEGIN
		SELECT @CustomerID = Customer_ID FROM TMS_MCustomer WHERE Customer_OwnerCompany = @CompanyID AND Customer_CompanyID = @CompanyID AND Customer_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014012;
		END
	END
	
	-- �ͻ���ʶ�Ƿ����
	IF @Result = 0 AND @CustomerSymbolID > 0
	BEGIN
		IF NOT EXISTS(SELECT Symbol_ID FROM TMS_MSymbol WHERE Symbol_ID = @CustomerSymbolID AND Symbol_Type = 1 AND Symbol_Invalid = 0)
		BEGIN
			SET @CustomerSymbolID = 0;
		END
	END
	
	-- EndUser�Ƿ����[�ջ��˱���]
	IF @Result = 0 AND NOT EXISTS(SELECT EndUser_ID FROM TMS_MEndUser WHERE EndUser_ID = @EndUserID AND EndUser_OwnerCompany = @CompanyID AND EndUser_Invalid = 0)
	BEGIN
		SET @Result = -510014003;
	END

	-- Customer�Ƿ����
	IF @Result = 0
	BEGIN
		SELECT @CustomerCompanyID = Customer_CompanyID FROM TMS_MCustomer WHERE Customer_ID = @CustomerID AND Customer_OwnerCompany = @CompanyID AND Customer_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014004;
		END
	END

	-- ������ַ�ڿͻ����õ�ַ���Ƿ���ڣ����������Զ�׷�ӣ��������޸���ϵ�绰��
	IF @Result = 0 AND @SrcOrderID = 0
	BEGIN
		SELECT @AddrID = Addr_ID FROM TMS_MAddr WHERE Addr_CustomerID = @CustomerID AND Addr_Type = 2 AND Addr_ProvinceID = @FromProvince AND Addr_CityID = @FromCity AND Addr_DistrictID = @FromDistrict AND Addr_Desc = @From;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @AddrID = 0;
		END

		EXEC sp_prv_my_EditAddr @Operator, @AddrID, @CustomerID, @From, 2, @FromProvince, @FromCity, @FromDistrict, 0, 1, @FromContact, @Result = @Result OUTPUT, @AddrID = @AddrID OUTPUT;
	END

	-- �ջ���ַ���ջ��˳��õ�ַ���Ƿ���ڣ����������Զ�׷�ӣ��������޸���ϵ�绰��
	IF @Result = 0 
	BEGIN
		SELECT @AddrID = Addr_ID FROM TMS_MAddr WHERE Addr_CustomerID = @EndUserID AND Addr_Type = 1 AND Addr_ProvinceID = @ToProvince AND Addr_CityID = @ToCity AND Addr_DistrictID = @ToDistrict AND Addr_Desc = @To;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @AddrID = 0;
		END

		EXEC sp_prv_my_EditAddr @Operator, @AddrID, @EndUserID, @To, 1, @ToProvince, @ToCity, @ToDistrict, 0, 1, @ToContact, @Result = @Result OUTPUT, @AddrID = @AddrID OUTPUT;
	END
	
	-- ��Դ�����Ƿ����
	IF @Result = 0 AND @SrcOrderID > 0
	BEGIN
		SELECT @RootOrderID = Index_RootOrderID FROM TMS_OrderIndex WHERE Index_ID = @SrcOrderID AND Index_Invalid = 0;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014005;
		END
		ELSE
		BEGIN
			IF @RootOrderID = 0
			BEGIN
				SET @RootOrderID = @SrcOrderID;
			END
		END
	END
	
	-- �༭ģʽ�����Ƿ����[ֻ�ܱ༭�Լ���˾�Ķ���]
	IF @Result = 0 AND @OrderID > 0 AND NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0 ANd Index_CreatorCompanyID = @CompanyID)
	BEGIN
		SET @Result = -510014006;
	END
	
	-- ֻ�ܱ༭״̬Ϊ�µ���\�Ѽƻ��Ķ���
	IF @Result = 0 AND @OrderID > 0 AND NOT EXISTS(SELECT Index_ID FROM TMS_OrderIndex WHERE Index_ID = @OrderID AND Index_Invalid = 0 AND Index_Status <= 1)
	BEGIN
		SET @Result = -510014007;
	END

	-- ��Ӧ���Ƿ����
	IF @Result = 0 AND @SupplierID > 0
	BEGIN
		SELECT @SupplierCompanyID = Supplier_CompanyID FROM TMS_MSupplier WHERE Supplier_ID = @SupplierID AND Supplier_OwnerCompanyID = @CompanyID AND Supplier_Invalid = 0 AND Supplier_Status = 1;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014010;
		END
	END

	-- ���������Ϣ
	IF @Result = 0
	BEGIN
		IF @OrderID = 0 OR @OrderID IS NULL
		BEGIN
			INSERT INTO TMS_OrderIndex(Index_Code, Index_PactCode, Index_EndUserID, Index_EndUserName, 
Index_From, Index_FromProvince, Index_FromCity, Index_FromDistrict, Index_FromTime, 
Index_To, Index_ToProvince, Index_ToCity, Index_ToDistrict, Index_ToTime, 
Index_TransportMode, Index_GoodsCategory, Index_PackageMode, Index_ChargeMode, Index_PriceUnit, 
Index_Status, Index_StatusTime, Index_SrcOrderID, Index_RootOrderID, Index_SrcClass, Index_Kms, Index_CarType, Index_CarLength, 
Index_SupplierID, Index_SupplierCompanyID, Index_CustomerID, Index_CustomerCompanyID, Index_ShipMode, Index_Pick, Index_Delivery, 
Index_Creator, Index_CreatorCompanyID, Index_CreateTime, Index_Invalid, Index_OnLoad, Index_OffLoad, 
Index_Insurance, Index_VolumeAddition, Index_WeightAddition, Index_Description, Index_CarVolume, Index_CarWeight, Index_CustomerSymbolID,
Index_FromContact, Index_ToContact,Index_DeviceCode,Index_Payment, Index_Payable) VALUES(@Code, @PactCode, @EndUserID, dbo.fn_pub_user_EndUser2Name(@EndUserID), @From, @FromProvince, @FromCity, @FromDistrict, 
(CASE WHEN @FromTime IS NULL THEN '' ELSE @FromTime END), @To, @ToProvince, @ToCity, @ToDistrict, 
(CASE WHEN @ToTime IS NULL THEN '' ELSE @ToTime END),@TransportMode, @GoodsCategory, @PackageMode, @ChargeMode, @PriceUnit, @DstStatus, 
GETDATE(), @SrcOrderID, @RootOrderID, @SrcClass, @Kms, @CarType, @CarLength, 0, 0, @CustomerID, 
@CustomerCompanyID, @ShipMode, @IsPick, @IsDelivery, @Operator, @CompanyID, GETDATE(), 0, @IsOnLoad, @IsOffLoad, @IsInsurance, @VolumeAddition, 
@WeightAddition, @Descriptions, @CarVolume, @CarWeight, @CustomerSymbolID, @FromContact, @ToContact, @DeviceCode, @Payment, @Payable);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014008;
			END
			ELSE
			BEGIN
				SET @OrderID = IDENT_CURRENT('TMS_OrderIndex');
				
				-- �½������ĸ�����������Լ�
				UPDATE TMS_OrderIndex SET Index_RootOrderID = (CASE WHEN Index_RootOrderID IS NULL OR Index_RootOrderID = 0 THEN @OrderID ELSE Index_RootOrderID END) WHERE Index_ID = @OrderID AND Index_SrcOrderID = 0;
				
				SET @InsertMode = 1;
			END
		END
		ELSE
		BEGIN
			UPDATE TMS_OrderIndex SET Index_PactCode = @PactCode, Index_EndUserID = @EndUserID, Index_EndUserName = dbo.fn_pub_user_EndUser2Name(@EndUserID),
Index_From = @From, Index_FromProvince= @FromProvince, Index_FromCity = @FromCity, Index_FromDistrict = @FromDistrict, Index_FromTime = (CASE WHEN @FromTime IS NULL THEN '' ELSE @FromTime END), 
Index_To = @To, Index_ToProvince = @ToProvince, Index_ToCity = @ToCity, Index_ToDistrict = @ToDistrict, Index_ToTime = (CASE WHEN @ToTime IS NULL THEN '' ELSE @ToTime END), 
Index_TransportMode = @TransportMode, Index_GoodsCategory = @GoodsCategory, Index_PackageMode = @PackageMode, Index_ChargeMode = @ChargeMode, Index_PriceUnit = @PriceUnit, 
-- ������ 2016-07-30
-- �༭ʱ�����޸�Դ����\������
-- Index_SrcOrderID = @SrcOrderID, Index_RootOrderID = (CASE WHEN @RootOrderID IS NULL OR @RootOrderID = 0 THEN @OrderID ELSE @RootOrderID END), 
Index_Kms = @Kms, Index_CarType = @CarType, Index_CarLength = @CarLength, 
Index_CustomerID = @CustomerID, Index_CustomerCompanyID = @CustomerCompanyID, Index_ShipMode = @ShipMode, Index_Pick = @IsPick,
Index_OnLoad = @IsOnLoad, Index_OffLoad = @IsOffLoad, Index_Delivery = @IsDelivery, Index_SupplierID = 0, Index_SupplierCompanyID = 0, 
Index_Insurance = @IsInsurance, Index_VolumeAddition = @VolumeAddition, Index_WeightAddition = @WeightAddition, Index_Description = @Descriptions, Index_CarVolume = @CarVolume, 
Index_CarWeight = @CarWeight, Index_CustomerSymbolID = @CustomerSymbolID, Index_FromContact = @FromContact, Index_ToContact = @ToContact , Index_Payment = @Payment, Index_Payable = @Payable WHERE Index_ID = @OrderID;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014009;
			END
		END
	END
	
	-- ���ʱ׷����Ʒ��Ϣ
	IF @Result = 0 AND @InsertMode = 1
	BEGIN
		IF @_Version < 3 AND @SrcOrderID > 0 AND LEN(@GoodsLst) > 0
		BEGIN
			-- ��Ʒ��Ϣ��ʽ
			-- goodid1=goodamount1,goodid2=goodamount2
			INSERT INTO TMS_OrderGoods(GoodsLst_OrderID, GoodsLst_GoodsID, GoodsLst_Code, GoodsLst_Name, GoodsLst_Qty, 
	GoodsLst_Weight, GoodsLst_Volume, GoodsLst_Unit, GoodsLst_BatchNo, GoodsLst_Price, GoodsLst_Creator, GoodsLst_InsertTime, GoodsLst_Invalid) 
	SELECT @OrderID, A.GoodsLst_GoodsID AS Goods_ID, A.GoodsLst_Code, A.GoodsLst_Name, B.Amount AS Goods_Amount, 
	dbo.fn_pub_order_GoodsWeight(A.GoodsLst_GoodsID, B.Amount) AS Goods_Weight, 
	dbo.fn_pub_order_GoodsVolume(A.GoodsLst_GoodsID, B.Amount) AS Goods_Volume, 
	A.GoodsLst_Unit, A.GoodsLst_BatchNo, A.GoodsLst_Price, @Operator, GETDATE(), 0 FROM TMS_OrderGoods AS A 
	INNER JOIN (SELECT  [value] = CONVERT(XML , '<v>' + REPLACE(@GoodsLst , ',' , '</v><v>') + '</v>')) C 
	CROSS APPLY (SELECT ID = SUBSTRING(N.v.value('.' , 'varchar(100)'), 1, charindex( '=', N.v.value('.' , 'varchar(100)')) - 1 ), Amount = SUBSTRING(N.v.value('.' , 'varchar(100)'), charindex( '=', N.v.value('.' , 'varchar(100)')) + 1, LEN(N.v.value('.' , 'varchar(100)'))) FROM C.[value].nodes('/v') N ( v ) ) B 
	ON A.GoodsLst_ID = B.ID WHERE A.GoodsLst_OrderID = (CASE WHEN @PrevOrderID IS NOT NULL AND @PrevOrderID > 0 THEN @PrevOrderID ELSE @SrcOrderID END) AND B.Amount > 0;
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014011;
			END
		END
		IF @_Version >= 3 AND LEN(@GoodsLst) > 0
		BEGIN
			/*
			<Lst>
				<Goods>
					<ID>88</ID>
					<Code>2016042200226</Code>
					<Name>�ֽ�</Name>
					<Qty>1</Qty>
					<Weight>1.2000</Weight>
					<Volume>2.000000</Volume>
					<Unit>2</Unit>
					<BatchNo>w</BatchNo>
					<Price>14</Price>
				</Goods>
			</Lst>
			*/
			DECLARE @XmlDocId INT;
			SET @XmlDocId = 0;
			
			EXEC SP_XML_PREPAREDOCUMENT @XmlDocId OUTPUT, @GoodsLst;
			INSERT TMS_OrderGoods(GoodsLst_OrderID, GoodsLst_GoodsID, GoodsLst_Code, GoodsLst_Name, GoodsLst_Qty, GoodsLst_Weight, GoodsLst_Volume, GoodsLst_Creator, 
GoodsLst_Unit, GoodsLst_BatchNo, GoodsLst_Price) SELECT @OrderID, [ID], Code, Name, Qty, [Weight], Volume, @Operator, Unit, BatchNo, Price FROM 
OPENXML(@XmlDocId, '/Lst/Goods', 2) WITH (
	[ID] BIGINT,
	Code NVARCHAR(100),
	Name NVARCHAR(200),
	Qty DECIMAL(18, 2),
	[Weight] DECIMAL(18,4),
	Volume DECIMAL(18,6),
	Unit BIGINT,
	BatchNo NVARCHAR(100),
	Price DECIMAL(18,2)
);
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014019;
			END

			EXEC SP_XML_REMOVEDOCUMENT @XmlDocId;
		END
	END
	
	-- �����ܼ�ֵ
	IF @Result = 0
	BEGIN
		UPDATE TMS_OrderIndex SET Index_GoodsValue = @GoodsValue, Index_GoodsLst = STUFF((select '; '+A.GOODSLST from (SELECT GoodsLst_Name+'(������'+CAST (LTRIM(CAST(GoodsLst_Qty as float))  AS NVARCHAR )+')' AS GOODSLST FROM TMS_OrderGoods WHERE  GoodsLst_OrderID = @OrderID) A FOR xml PATH('')), 1, 1, '') WHERE Index_ID = @OrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014014;
		END
	END

	-- �汾3����ִ���Զ��ƻ�, ֮ǰ�İ汾ͨ��Э�����
	IF @Result = 0 AND @_Version >= 3 AND LEN(@GoodsLst) > 0
	BEGIN
		EXEC sp_prv_order_AutoPlan @Operator, @OrderID, 0, @Result = @Result OUTPUT, @DstOrderID = @DstOrderID OUTPUT;
	END
	
	-- �汾3�����Զ����ƻ�������䶩��@DstOrderID���ȸ�@SupplierID
	IF @Result = 0 AND @_Version >= 3 AND @DstOrderID > 0 AND @SupplierID > 0
	BEGIN
		EXEC sp_prv_order_SendOrder @Operator, @DstOrderID, @SupplierID, 0, 0, 0, @Result = @Result OUTPUT;
	END
	
	-- ������ 2016-07-27
	-- 2���ϰ汾ʱ���ã���ʱ������Դ���䶩��
	IF @Result = 0 AND @Mode = 1 AND @_Version >= 2
	BEGIN
		UPDATE TMS_OrderIndex SET Index_PrevOrderID = @PrevOrderID WHERE Index_ID = @OrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014016;
		END
	END
	
	-- ������ 2016-07-29
	-- 2���ϰ汾���ã���ʱ��ԭ����Ϊ��Ч
	IF @Result = 0 AND @Mode = 1 AND @PrevOrderID > 0 AND @_Version >= 2
	BEGIN
		UPDATE TMS_OrderIndex SET Index_Status = 32, Index_StatusTime = GETDATE() WHERE Index_ID = @PrevOrderID;
		IF @@ROWCOUNT = 0
		BEGIN
			SET @Result = -510014017;
		END
		
		-- д����״̬�����¼
		IF @Result = 0
		BEGIN
			INSERT INTO TMS_OrderFlow(Flow_OrderID, Flow_SrcStatus, Flow_DstStatus, Flow_Creator, Flow_InsertTime, Flow_CompanyID, Flow_Invalid,Flow_Description) VALUES(@PrevOrderID, 1, 32, @Operator, GETDATE(), @CompanyID, 0,'��');
			IF @@ROWCOUNT = 0
			BEGIN
				SET @Result = -510014018;
			END
		END
	END


	IF @_Version >= 3
	BEGIN
		SELECT @Result AS Order_Result, @OrderID AS Order_ID, @DstOrderID AS Order_DstID;
	END
	ELSE
	IF @_Version < 3 AND @Mode = 1
	BEGIN
		SELECT @Result AS Order_Result, @OrderID AS Order_ID;
	END

	
END





GO


