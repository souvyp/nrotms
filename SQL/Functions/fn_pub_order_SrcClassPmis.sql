USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_pub_order_SrcClassPmis]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_pub_order_SrcClassPmis]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_pub_order_SrcClassPmis]
(
	@Operator BIGINT,
	@SrcClass BIGINT
)
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT;
	DECLARE @RoleID BIGINT;
	SET @Result = 0;
	SET @RoleID = dbo.fn_pub_user_User2RoleID( @Operator );
	
	IF @RoleID > 0
	BEGIN
		-- 运营
		IF @RoleID & 1 = 1 AND ( @SrcClass = 2 OR @SrcClass = 3 )
		BEGIN
			SET @Result = 1;
		END
		
		-- 客服
		IF @RoleID & 2 = 2 AND @SrcClass = 1
		BEGIN
			SET @Result = 1;
		END
	END
	
	RETURN @Result;
END

GO


