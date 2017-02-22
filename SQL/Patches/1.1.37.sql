ALTER TABLE TMS_Company ADD Company_IsGroup BIGINT NULL DEFAULT 0;

-- 添加表TMS_CompanyBranches

-- 添加表TMS_MConfig

-- 删除TMS_Company表中的如下字段：
-- Company_GoodsCategory, Company_PackageMode, Company_ChargeMode, Company_PriceUnit, Company_Insurance

-- 来源运输订单编号，用于多次拆单
ALTER TABLE TMS_OrderIndex ADD Index_PrevOrderID BIGINT NULL DEFAULT 0;

-- 自营按单报价记录线下承运商标记
ALTER TABLE Price_DocIndex ADD Index_SupplierSymbolID BIGINT NULL DEFAULT 0;

-- 自营按单报价线下承运商标记数据修复
UPDATE Price_DocIndex SET Index_SupplierSymbolID = 0 WHERE Index_SupplierSymbolID IS NULL;
UPDATE Price_DocIndex SET Index_SupplierSymbolID = (SELECT c.Index_SupplierSymbolID FROM TMS_OrderIndex AS c WHERE c.Index_ID = Index_OrderID) WHERE Index_OrderID IN (SELECT Index_ID FROM TMS_OrderIndex WHERE Index_SrcClass = 2 AND Index_SupplierSymbolID > 0 AND Index_Invalid = 0);