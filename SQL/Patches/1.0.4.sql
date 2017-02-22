ALTER TABLE TMS_MAddr ADD Addr_Phone NVARCHAR(300) NULL DEFAULT N'';
UPDATE TMS_MAddr SET Addr_Phone = N'';

-- **********************************************************************************************
-- 首先，执行第1步
-- 然后，执行第2步查询所有待修复订单数量
-- 最后，执行第3步修复部分订单
-- 重复执行2和3两个步骤，直接执行步骤2时记录集为空为止

-- 1 修复Index_RootOrderID数据不准确的问题
UPDATE TMS_OrderIndex SET Index_RootOrderID = Index_ID WHERE Index_RootOrderID = 0;

-- 当前所有订单的Index_RootOrderID情况
SELECT Index_ID, Index_SrcOrderID, Index_RootOrderID, dbo.fn_pub_order_SrcOrderID2RootOrderID(Index_ID, Index_SrcOrderID) AS Index_TrueRootOrderID FROM TMS_OrderIndex WHERE 
Index_ID >= 1041949
 AND Index_ID <= 1043262 ORDER BY Index_ID ASC

-- 2 当前待修复数据的订单
SELECT * FROM (SELECT Index_ID, Index_SrcOrderID, Index_RootOrderID, dbo.fn_pub_order_SrcOrderID2RootOrderID(Index_ID, Index_SrcOrderID) AS Index_TrueRootOrderID FROM TMS_OrderIndex WHERE 
Index_ID >= 1041949
 AND Index_ID <= 1043262) AS a 
WHERE Index_RootOrderID <> Index_TrueRootOrderID ORDER BY Index_ID ASC

-- 3 重复执行
UPDATE TMS_OrderIndex SET Index_RootOrderID = dbo.fn_pub_order_SrcOrderID2RootOrderID(Index_ID, Index_SrcOrderID)

-- **********************************************************************************************