--����Ƿ�԰����־ �Ƿ�԰������λ
ALTER TABLE TMS_Company ADD Company_IsZones BIGINT NULL DEFAULT 0;
--��ӷֹ�˾���� 1 ���ŷֹ�˾ 2 ԰����ҵ
ALTER TABLE TMS_CompanyBranches ADD Branch_Category BIGINT NULL DEFAULT 1;
--���м��ŷֹ�˾����޸�
UPDATE TMS_CompanyBranches SET Branch_Category=1;