ALTER TABLE TMS_BasicArea ALTER COLUMN Area_Code NVARCHAR(100) NULL;

UPDATE TMS_BasicArea SET Area_Code = SUBSTRING(dbo.fn_pub_basic_GetPinYin(Area_Name, 1, 1), 1, 100);
UPDATE TMS_BasicArea SET Area_Code = 'Shi Qu /SQ' WHERE Area_ID = 4;

ALTER TABLE TMS_OrderIndex ADD Index_ReceiptDoc1 NVARCHAR(512) NULL;
ALTER TABLE TMS_OrderIndex ADD Index_ReceiptDoc2 NVARCHAR(512) NULL;
ALTER TABLE TMS_OrderIndex ADD Index_ReceiptDoc3 NVARCHAR(512) NULL;