-- CREATE TABLE TMS_MSymbol

ALTER TABLE TMS_OrderIndex ADD Index_CustomerSymbolID BIGINT NULL DEFAULT 0;
ALTER TABLE TMS_OrderIndex ADD Index_SupplierSymbolID BIGINT NULL DEFAULT 0;

UPDATE Price_Unit SET Unit_Name = N'件', Unit_Updater = 1, Unit_UpdateTime = GETDATE() WHERE Unit_Name = N'票';
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'袋', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'架', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'盒', 1, GETDATE(), 0);
INSERT INTO Price_Unit(Unit_Name, Unit_Creator, Unit_CreateTime, Unit_Invalid) VALUES(N'其他', 1, GETDATE(), 0);