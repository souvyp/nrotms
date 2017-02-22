USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_EditOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_EditOrder]
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
CREATE PROCEDURE [dbo].[sp_pub_order_EditOrder]
(
	@Operator BIGINT,
	@OrderID BIGINT,
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
	@Payable DECIMAL(18,2) = 0		-- ��������
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @Result BIGINT;
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
	SET @Result = 0;
	SET @CompanyID = dbo.fn_pub_user_User2CompanyID(@Operator, 0);
	
	BEGIN
		EXEC sp_prv_order_EditOrder @Operator = @Operator,@PactCode = @PactCode,@EndUserID = @EndUserID,@From= @From,@To = @To,@SrcOrderID = @SrcOrderID,@CustomerID = @CustomerID,@SupplierID = @SupplierID,@GoodsLst = @GoodsLst,@TxnRequired = 1,@FromProvince = @FromProvince, @FromCity = @FromCity, @FromDistrict =@FromDistrict, @FromTime =@FromTime,@ToProvince = @ToProvince,@ToCity = @ToCity, @ToDistrict = @ToDistrict,@ToTime = @ToTime,@TransportMode = @TransportMode,@GoodsCategory = @GoodsCategory,@PackageMode = @PackageMode, @ChargeMode = @ChargeMode,@PriceUnit = @PriceUnit,@SrcClass = @SrcClass,@Kms = @Kms,@CarType = @CarType,@CarLength = @CarLength,@ShipMode = @ShipMode,@IsPick = @IsPick,@IsDelivery = @IsDelivery,@DstStatus = @DstStatus,@IsOnLoad = @IsOnLoad ,@IsOffLoad =@IsOffLoad,@IsInsurance = @IsInsurance,@VolumeAddition = @VolumeAddition,@WeightAddition = @WeightAddition,@Descriptions = @Descriptions,@CarVolume = @CarVolume,@CarWeight = @CarWeight,@CustomerSymbolID = @CustomerSymbolID,@FromContact = @FromContact,@ToContact = @ToContact,@GoodsValue = @GoodsValue,@PrevOrderID = @PrevOrderID,@_Version = @_Version,@DeviceCode = @DeviceCode,@Payment = @Payment,@Payable = @Payable,@OrderID = @OrderID OUTPUT,@Result = @Result OUTPUT;
	END

	IF @TxnRequired = 1
	BEGIN
		IF @Result = 0
		BEGIN
			COMMIT TRANSACTION;
		END
		ELSE
		BEGIN
			ROLLBACK TRANSACTION;
		END
	END

	IF @_Version >= 3
	BEGIN
		SELECT @Result AS Order_Result, @OrderID AS Order_ID, @DstOrderID AS Order_DstID;
	END
	ELSE
	BEGIN
		SELECT @Result AS Order_Result, @OrderID AS Order_ID;
	END

	SET NOCOUNT OFF;
END





GO


