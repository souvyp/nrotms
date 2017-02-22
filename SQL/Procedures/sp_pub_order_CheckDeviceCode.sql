USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_order_CheckDeviceCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_order_CheckDeviceCode]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_pub_order_CheckDeviceCode]

	@DeviceCode NVARCHAR(100) = N''
	
AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @Result BIGINT;
	SET @Result = 0;
	
	-- 设备是否存在
	IF @DeviceCode <> 0 AND NOT EXISTS (SELECT Device_ID FROM dbo.TMS_Devices WHERE Device_ID = @DeviceCode)
	BEGIN
		SET @Result = -510062001;
	END	
	
	-- 是否绑定了未签收的订单
	IF @Result = 0 AND @DeviceCode <> 0 AND EXISTS (SELECT Index_Code FROM TMS_OrderIndex WHERE Index_DeviceCode = @devicecode AND  Index_Status < 4 AND Index_Invalid = 0 AND Index_SrcOrderID = 0  )
	BEGIN
		SET @Result = -510062002;
	END	
	
	
	SELECT @Result AS Check_Result;
	
	IF @Result  = -510062002 AND @DeviceCode <> 0
	BEGIN
		SELECT Index_Code AS [code],Index_PactCode AS [pactcode] FROM TMS_OrderIndex WHERE Index_DeviceCode = @devicecode  AND Index_Status < 4 AND Index_Invalid = 0 AND Index_ID = Index_RootOrderID;
	END	

END
GO
