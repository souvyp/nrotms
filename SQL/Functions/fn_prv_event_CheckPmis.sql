USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_prv_event_CheckPmis]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_prv_event_CheckPmis]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
/**
1 被邀请成为供应商             1 承运商
  2 供应商邀请被拒               1 承运商
  3 待接收订单                   2 订单
  4 订单被拒                     2 订单
  5 异常提醒                     3 异常与附加费
  6 附加费提醒                   3 异常与附加费
  7 待审核报价单                 4 报价单
  8 报价单被拒绝                 4 报价单
  9 同意成为承运商               1 承运商
 10 接受订单                     2 订单
 11 客户接受报价单               4 报价单
 12 待审核拼车单                 5 拼车单
 13 拼车单被拒绝                 5 拼车单
 14 接受拼车单                   5 拼车单
 15 报价单被强制过期             4 报价单

 16 承运商签收订单			     2 订单
 17 客户撤销委托订单             2 订单
 18 客户关闭委托订单             2 订单
 19 承运商上传回单照片           2 订单
 20 承运商已回单                 2 订单
 21 承运商关闭订单               2 订单
 
 22 新的加入集团申请             6 集团
 23 成功加入集团                 6 集团
 24 集团申请被拒绝               6 集团

25 基础价格预警（整车，零担）
 26 提货费预警
 27 送货费预警
 28 装货费预警
 29 卸货费预警
 30 保价费预警
 	
 31 被退出集团			6 集团
 32 退出园区			6 集团
 
 33 新的加入园区申请             6 集团
 34 成功加入园区                 6 集团
 35 园区申请被拒绝               6 集团	
**/
-- 检查用户是否有获取当前事件的权限
CREATE FUNCTION [dbo].[fn_prv_event_CheckPmis]
(
	@Operator BIGINT,
	@EventType BIGINT
)
RETURNS TINYINT
AS
BEGIN
	DECLARE @Result TINYINT;
	DECLARE @Role BIGINT;
	SET @Result=0;
	SET @Role=dbo.fn_pub_user_User2RoleID(@Operator)
	
	-- 运营
	IF @Role & 1 = 1 AND @EventType IN (1,2,4,5,6,9,10,13,14,16,19,20,21,25,26,27,28,29,30)
	BEGIN
		SET @Result = 1;
	END

	-- 客服 
	IF @Role & 2 = 2 AND @EventType IN (3,12,17,18)
	BEGIN
		SET @Result = 1;
	END
	
	-- 采购 
	IF  @Role & 32 = 32 AND @EventType IN (1,2,7,9,15)
	BEGIN
		SET @Result = 1;
	END

	-- 管理员
	IF @Role & 256 = 256 AND @EventType IN (22,23,24,31,32)
	BEGIN
		SET @Result = 1;
	END

	-- 业务员
	IF  @Role & 512 = 512 AND @EventType IN (8,11,25,26,27,28,29,30)
	BEGIN 
		SET @Result = 1;
	END

	RETURN @Result;
END
GO


