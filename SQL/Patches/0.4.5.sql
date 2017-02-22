-- 外网已经执行
-- DROP TABLE TMS_MPrice;

ALTER TABLE Balance_BillDetails ADD Detail_Tax DECIMAL(18,2) NOT NULL DEFAULT 0;
ALTER TABLE Balance_BillDetails ADD Detail_ReceiptQty DECIMAL(18,2) NOT NULL DEFAULT 0;
ALTER TABLE Balance_BillDetails ADD Detail_Code NVARCHAR(50) NULL DEFAULT '';
-- 下面这段已经手工执行了
-- ALTER TABLE Balance_BillDetails ALTER COLUMN Detail_Volume DECIMAL(18,6) NOT NULL DEFAULT 0;

-- 下面这行需要单独执行
UPDATE Balance_BillDetails SET Detail_Code = (SELECT TOP 1 Index_Code FROM TMS_OrderIndex WHERE Index_ID = Detail_OrderID);

ALTER TABLE Price_DocDetails ADD Detail_CarVolume DECIMAL(18,6) NULL DEFAULT 0;
ALTER TABLE Price_DocDetails ADD Detail_CarWeight DECIMAL(18,4) NULL DEFAULT 0;
-- 下面这段已经手工执行了
-- ALTER TABLE Price_DocDetails ALTER COLUMN Detail_MinVolume DECIMAL(18,6) NULL DEFAULT 0;
-- ALTER TABLE Price_DocDetails ALTER COLUMN Detail_MaxVolume DECIMAL(18,6) NULL DEFAULT 0;

ALTER TABLE TMS_MCar ADD Car_Volume DECIMAL(18,6) NULL DEFAULT 0;
-- 下面这行已经手工执行
-- ALTER TABLE TMS_MCar ALTER COLUMN Car_Weight DECIMAL(18,4) NULL DEFAULT 0;

ALTER TABLE TMS_MGoods ALTER COLUMN Goods_Volume DECIMAL(18,6) NULL DEFAULT 0;

ALTER TABLE TMS_OrderGoods ADD GoodsLst_BatchNo NVARCHAR(50) NULL DEFAULT '';

--下面这段已经手工执行了
--ALTER TABLE TMS_OrderGoods ALTER COLUMN GoodsLst_Qty DECIMAL(18,2) NOT NULL DEFAULT 0;
--ALTER TABLE TMS_OrderGoods ALTER COLUMN GoodsLst_Weight DECIMAL(18,4) NOT NULL DEFAULT 0;
--ALTER TABLE TMS_OrderGoods ALTER COLUMN GoodsLst_Volume DECIMAL(18,6) NOT NULL DEFAULT 0;
--ALTER TABLE TMS_OrderGoods ALTER COLUMN GoodsLst_ReceiptQty DECIMAL(18,2) NOT NULL DEFAULT 0;
--ALTER TABLE TMS_OrderGoods ALTER COLUMN GoodsLst_ExceptionQty DECIMAL(18,2) NOT NULL DEFAULT 0;

ALTER TABLE TMS_OrderIndex ADD Index_Description NVARCHAR(MAX) NULL DEFAULT '';
ALTER TABLE TMS_OrderIndex ADD Index_CarVolume DECIMAL(18,6) NULL DEFAULT 0;
ALTER TABLE TMS_OrderIndex ADD Index_CarWeight DECIMAL(18,4) NULL DEFAULT 0;
ALTER TABLE TMS_OrderIndex ALTER COLUMN Index_VolumeAddition DECIMAL(18,6) NULL DEFAULT 0;
ALTER TABLE TMS_OrderIndex ALTER COLUMN Index_WeightAddition DECIMAL(18,4) NULL DEFAULT 0;

-- 拼车订单
ALTER TABLE TMS_OrderIndex ADD Index_Combined BIGINT NULL DEFAULT 0;

-- Index_SrcClass新增定义3
-- TMS_OrderIndex表中的绝大部分字段都修改为了非必填

-- CREATE TABLE TMS_OrderContains

INSERT INTO TMS_SN(SN_Number, SN_Type, SN_Prefix) VALUES(0, 4, 'DOC');
INSERT INTO TMS_SN(SN_Number, SN_Type, SN_Prefix) VALUES(0, 5, 'OFS');

UPDATE TMS_OrderIndex SET 
Index_Insurance = ISNULL(Index_Insurance, 0), 
Index_VolumeAddition = ISNULL(Index_VolumeAddition, 0),
Index_WeightAddition = ISNULL(Index_WeightAddition, 0),
Index_Combined = ISNULL(Index_Combined, 0);

-- TMS_User
-- 已经手工执行
-- ALTER TABLE TMS_User ADD User_SignInTime DATETIME NULL;