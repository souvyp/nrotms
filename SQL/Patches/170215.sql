-- �������� 
CREATE INDEX IX_TMS_TMS_Position_DEVID ON TMS_Position(DEV_ID);

-- �ջ����޸�
UPDATE	TMS_MEndUser SET EndUser_Name= '�Ĵ�Ұ��' WHERE EndUser_Name = '�Ĵ�Ұ������';
UPDATE	TMS_MEndUser SET EndUser_Name= '������' WHERE EndUser_Name ='��(����)';
-- �鿴��Ҫ�޸Ķ���(SELECT * FROM TMS_OrderIndex WHERE Index_EndUserName in ('�Ĵ�Ұ������','��(����)')AND Index_CustomerCompanyID = 534;) 
-- ��ʷ�����ջ����޸�
UPDATE TMS_OrderIndex SET Index_EndUserName =	'�Ĵ�Ұ��'	WHERE Index_EndUserName =	'�Ĵ�Ұ������' AND Index_CustomerCompanyID = 534; 
UPDATE TMS_OrderIndex SET Index_EndUserName =	'������'	WHERE Index_EndUserName =	'��(����)' AND Index_CustomerCompanyID = 534 ;



