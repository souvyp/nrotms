--创建索引 已执行
CREATE INDEX IX_TMS_OrderIndex_ByCreatorCompanyID ON TMS_OrderIndex(Index_CreatorCompanyID)include(Index_SupplierSymbolID,Index_SrcClass,Index_CustomerCompanyID,Index_Invalid,Index_Status);

CREATE INDEX  IX_TMS_OrderIndex_BySrcOrderID ON TMS_OrderIndex(Index_SrcOrderID);

CREATE INDEX IX_Price_OrderCache_ByDoc ON Price_OrderCache(Cache_DocID);

CREATE INDEX IX_Price_OrderCache_ByOrder ON Price_OrderCache(Cache_OrderID);

CREATE INDEX IX_TMS_OrderIndex_BySupplier ON TMS_OrderIndex(Index_SupplierID);

CREATE INDEX IX_TMS_OrderGoods_ByOrder ON TMS_OrderGoods(GoodsLst_OrderID);

