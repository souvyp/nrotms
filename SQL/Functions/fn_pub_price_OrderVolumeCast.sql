USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_price_OrderVolumeCast]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_price_OrderVolumeCast]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_price_OrderVolumeCast]
(
	@Volume DECIMAL(18,6),
	@PriceUnit BIGINT			-- 1 �� 2 ���� 3 ���� 4 ��
)
RETURNS DECIMAL(18, 6)
AS
BEGIN
	DECLARE @Result DECIMAL(18,6);
	SET @Result = 0;
	
	IF @PriceUnit = 3
	BEGIN
		-- ��������Ʒ������λΪ�����ף��Ƽ۵�λΪ������ʱ����ת��
		SET @Result = @Volume;
	END
	ELSE IF @PriceUnit = 4
	BEGIN
		-- �Ƽ۵�λΪ��
		SET @Result = @Volume * 1000;
	END
	ELSE
	BEGIN
		-- ������֧�ֵĵ�λ
		SET @Result = @Volume;
	END
	
	RETURN @Result;
END
GO


