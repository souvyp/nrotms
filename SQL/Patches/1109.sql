-- ���������Ӱ��豸��
ALTER TABLE TMS_OrderIndex ADD Index_DeviceCode NVARCHAR(50);

-- ���ñ����Ӷ�Ӧ���۵�

ALTER TABLE dbo.Price_OrderCache ADD Cache_DocID BIGINT;
