-- �޸��ջ���ַ����
	DECLARE @Code nvarchar (300);
SET @Code = 'ORD2016101219936%'
select Index_ID,Index_To,* from dbo.TMS_OrderIndex where  Index_Code like @Code;
UPDATE TMS_OrderIndex SET Index_To='�������ຼ����һ��·��߽�·�����' WHERE Index_Code like @Code;