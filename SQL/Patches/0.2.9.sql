-- 长途与市内
UPDATE TMS_OrderIndex SET Index_ShipMode = (CASE WHEN Index_FromProvince = Index_ToProvince AND Index_FromCity = Index_ToCity THEN 1 ELSE 2 END);

-- TMS_MCar
ALTER TABLE TMS_MCar ALTER COLUMN Car_Length DECIMAL(18,2) NULL;
ALTER TABLE TMS_MCar ADD  CONSTRAINT DF_TMS_MCar_Car_Length DEFAULT 0 FOR Car_Length;

-- TMS_OrderIndex
ALTER TABLE TMS_OrderIndex DROP CONSTRAINT DF_TMS_OrderIndex_Index_CarLength;
ALTER TABLE TMS_OrderIndex ALTER COLUMN Index_CarLength DECIMAL(18,2) NOT NULL;
ALTER TABLE TMS_OrderIndex ADD CONSTRAINT DF_TMS_OrderIndex_Index_CarLength DEFAULT 0 FOR Index_CarLength;

ALTER TABLE TMS_OrderIndex ADD Index_OnLoad BIGINT NULL DEFAULT 0;
ALTER TABLE TMS_OrderIndex ADD Index_OffLoad BIGINT NULL DEFAULT 0;

-- Price_DocDetails
ALTER TABLE Price_DocDetails DROP CONSTRAINT DF__Price_Doc__Detai__07EC11B9;
ALTER TABLE Price_DocDetails ALTER COLUMN Detail_CarLength DECIMAL(18,2) NOT NULL;
ALTER TABLE Price_DocDetails ADD CONSTRAINT DF__Price_Doc__Detai__07EC11B9 DEFAULT 0 FOR Detail_CarLength;

-- 车长的默认值
UPDATE TMS_MCar SET Car_Length = (CASE 
WHEN Car_Length = 9.00 THEN 20.00 
WHEN Car_Length = 8.00 THEN 17.00 
WHEN Car_Length = 7.00 THEN 13.00 
WHEN Car_Length = 6.00 THEN 9.60
WHEN Car_Length = 5.00 THEN 8.60 
WHEN Car_Length = 4.00 THEN 6.80 
WHEN Car_Length = 3.00 THEN 6.20 
WHEN Car_Length = 2.00 THEN 5.20 
WHEN Car_Length = 1.00 THEN 4.20 
ELSE 0 END);

UPDATE TMS_OrderIndex SET Index_CarLength = (CASE 
WHEN Index_CarLength = 9.00 THEN 20.00 
WHEN Index_CarLength = 8.00 THEN 17.00 
WHEN Index_CarLength = 7.00 THEN 13.00 
WHEN Index_CarLength = 6.00 THEN 9.60
WHEN Index_CarLength = 5.00 THEN 8.60 
WHEN Index_CarLength = 4.00 THEN 6.80 
WHEN Index_CarLength = 3.00 THEN 6.20 
WHEN Index_CarLength = 2.00 THEN 5.20 
WHEN Index_CarLength = 1.00 THEN 4.20 
ELSE 0 END);

UPDATE Price_DocDetails SET Detail_CarLength = (CASE 
WHEN Detail_CarLength = 9.00 THEN 20.00 
WHEN Detail_CarLength = 8.00 THEN 17.00 
WHEN Detail_CarLength = 7.00 THEN 13.00 
WHEN Detail_CarLength = 6.00 THEN 9.60
WHEN Detail_CarLength = 5.00 THEN 8.60 
WHEN Detail_CarLength = 4.00 THEN 6.80 
WHEN Detail_CarLength = 3.00 THEN 6.20 
WHEN Detail_CarLength = 2.00 THEN 5.20 
WHEN Detail_CarLength = 1.00 THEN 4.20 
ELSE 0 END);

-- CREATE TABLE Price_OrderCache

-- CREATE TABLE Balance_BillIndex
-- CREATE TABLE Balance_BillDetails