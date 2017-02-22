-- Balance_BillDetails
ALTER TABLE Balance_BillDetails ADD Detail_Amount DECIMAL(18,2) NOT NULL DEFAULT 0;

-- 删除承运商常用地址文件
-- TMS/SupplierAddr.aspx
-- TMS/SupplierAddr_Edit.aspx

-- 删除承运商常用地址
DELETE FROM TMS_MAddr WHERE Addr_Type = 3;

-- Price_Unit
DELETE FROM Price_Unit;

INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'公斤', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'吨', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'立方米', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'升', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'个', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'托', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'台', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'箱', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'包', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'捆', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'辆', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'票', 1, GETDATE(), 0);

-- TMS_MGoods
ALTER TABLE TMS_MGoods ADD Goods_Unit BIGINT NOT NULL DEFAULT 0;
ALTER TABLE TMS_MGoods ALTER COLUMN Goods_Volume DECIMAL(18,4) NULL;
ALTER TABLE TMS_MGoods ALTER COLUMN Goods_Weight DECIMAL(18,4) NULL;
ALTER TABLE TMS_MGoods ALTER COLUMN Goods_MWeight DECIMAL(18,4) NULL;

-- **设置默认单位为个
UPDATE TMS_MGoods SET Goods_Unit = 5;

-- TMS_OrderGoods
ALTER TABLE TMS_OrderGoods ADD GoodsLst_Unit BIGINT NOT NULL DEFAULT 0;

-- **设置默认单位为托
UPDATE TMS_OrderGoods SET GoodsLst_Unit = 6;

-- 删除现有字段(已手工执行)
-- ALTER TABLE Price_DocDetails DROP COLUMN Detail_Count;
-- ALTER TABLE Price_DocDetails DROP COLUMN Detail_Unit;

-- 添加按数量报价的字段
ALTER TABLE Price_DocDetails ADD Detail_MinCount DECIMAL(18,2) NULL DEFAULT 0;
ALTER TABLE Price_DocDetails ADD Detail_MaxCount DECIMAL(18,2) NULL DEFAULT 0;
ALTER TABLE Price_DocDetails ADD Detail_CountUnit BIGINT NULL DEFAULT 0;

-- TMS_Company
ALTER TABLE TMS_Company ADD Company_GoodsCategory BIGINT NULL DEFAULT 0;
ALTER TABLE TMS_Company ADD Company_PackageMode BIGINT NULL DEFAULT 0;
ALTER TABLE TMS_Company ADD Company_ChargeMode BIGINT NULL DEFAULT 0;
ALTER TABLE TMS_Company ADD Company_PriceUnit BIGINT NULL DEFAULT 0;
ALTER TABLE TMS_Company ADD Company_Insurance BIGINT NULL DEFAULT 0;

-- TMS_OrderIndex
ALTER TABLE TMS_OrderIndex ADD Index_Insurance BIGINT NULL DEFAULT 0;
ALTER TABLE TMS_OrderIndex ADD Index_VolumeAddition DECIMAL(18,4) NULL DEFAULT 0;
ALTER TABLE TMS_OrderIndex ADD Index_WeightAddition DECIMAL(18,4) NULL DEFAULT 0;