USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_pub_Order_CountOrder]
(
	@Companyid BIGINT,
	@Status INT,
	@SrcClass INT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT;
	
	SELECT @Result = COUNT(1) FROM TMS_OrderIndex WHERE Index_CreatorCompanyID = @Companyid AND Index_SrcClass = @SrcClass AND Index_Invalid = 0 AND Index_Status = @Status

	

	
	RETURN @Result;

END
GO

