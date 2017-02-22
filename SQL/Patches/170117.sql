-- Ô¤¸¶Index_Payment µ½¸¶ Index_Payable
ALTER TABLE TMS_OrderIndex ADD Index_Payment DECIMAL(18,2) DEFAULT 0;

ALTER TABLE TMS_OrderIndex ADD Index_Payable DECIMAL(18,2) DEFAULT 0;

UPDATE TMS_OrderIndex SET Index_Payment = 0 WHERE Index_Payment IS NULL;

UPDATE TMS_OrderIndex SET Index_Payable = 0 WHERE Index_Payable IS NULL;