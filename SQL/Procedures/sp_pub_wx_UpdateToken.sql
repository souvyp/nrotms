USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_pub_wx_UpdateToken]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_pub_wx_UpdateToken]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_pub_wx_UpdateToken]
(
	@AppID NVARCHAR(100),
	@Token NVARCHAR(100),
	@Expired BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @WxID BIGINT;
	SET @WxID = 0;

	-- AppID记录不存在则添加，存在则更新
	SELECT TOP 1 @WxID = Wx_ID FROM Wx_Token WHERE Wx_AppID = @AppID;
	IF @@ROWCOUNT = 0
	BEGIN
		INSERT INTO Wx_Token(Wx_AppID, Wx_Token, Wx_ExpiredTime, Wx_InsertTime) VALUES(@AppID, @Token, DATEADD(SECOND, @Expired, GETDATE()), GETDATE());
		IF @@ROWCOUNT > 0
		BEGIN
			SET @WxID = IDENT_CURRENT('Wx_Token');
		END
	END
	ELSE
	BEGIN
		UPDATE Wx_Token SET Wx_Token = @Token, Wx_ExpiredTime = DATEADD(SECOND, @Expired, GETDATE()), Wx_InsertTime = GETDATE() WHERE Wx_ID = @WxID;
	END
	
	SELECT @WxID AS TokenID;
	
	SET NOCOUNT OFF;
END
GO


