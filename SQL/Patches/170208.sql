-- 对账单表加对账类型 1 应收 2 应付
ALTER TABLE Balance_BillIndex ADD Index_BillType BIGINT DEFAULT 0;