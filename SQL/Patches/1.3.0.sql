--添加是否园区标志 是否园区管理单位
ALTER TABLE TMS_Company ADD Company_IsZones BIGINT NULL DEFAULT 0;
--添加分公司类型 1 集团分公司 2 园区企业
ALTER TABLE TMS_CompanyBranches ADD Branch_Category BIGINT NULL DEFAULT 1;
--已有集团分公司标记修复
UPDATE TMS_CompanyBranches SET Branch_Category=1;