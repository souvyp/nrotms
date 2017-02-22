-- 订单表增加绑定设备列
ALTER TABLE TMS_OrderIndex ADD Index_DeviceCode NVARCHAR(50);

-- 费用表增加对应报价单

ALTER TABLE dbo.Price_OrderCache ADD Cache_DocID BIGINT;
