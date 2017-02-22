USE OTMS
 /** 删除订单,报价信息 **/
 -- 删除对账信息
 DELETE FROM Balance_BillDetails WHERE 1=1;
 DELETE FROM Balance_BillIndex WHERE 1=1;
 -- 删除非合约报价详
 DELETE FROM Price_DocDetails FROM Price_DocDetails AS DD INNER JOIN Price_DocIndex AS D  ON D.Index_ID = DD.Detail_DocID WHERE D.Index_Type <> 2; 
 -- 删除非合约报价流程
 DELETE FROM Price_DocFlow FROM Price_DocFlow AS DD INNER JOIN Price_DocIndex AS D  ON D.Index_ID = DD.Flow_DocID WHERE D.Index_Type <> 2; 
 -- 删除非合约报价
 DELETE FROM Price_DocIndex WHERE Index_Type <> 2;
 -- 删除所有计费
 DELETE FROM Price_OrderCache WHERE 1=1;
 -- 删除事件
 DELETE FROM TMS_Events WHERE 1=1; 
 -- 删除订单物品
 DELETE FROM TMS_OrderGoods WHERE 1=1; 
 -- 删除订单流程
 DELETE FROM TMS_OrderFlow WHERE 1=1;
 -- 删除合单订单物品统计 
 DELETE FROM TMS_OrderContains WHERE 1=1;
 -- 删除订单
 DELETE FROM TMS_OrderIndex WHERE 1=1;
