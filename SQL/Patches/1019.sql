-- ����û����� 1 ��ͨ�û���Ĭ�ϣ� 2 ΢���û�
ALTER TABLE TMS_User ADD User_Type BIGINT NOT NULL DEFAULT 1;
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 ��ͨ�û� 2 ΢���û�' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_User', @level2type=N'COLUMN',@level2name=N'User_Type'
GO
-- ����û�΢��OpenId
ALTER TABLE TMS_User ADD User_OpenId NVARCHAR(300) NULL DEFAULT NULL;
-- ����û����� �Ƿ���� �ͻ� װ�� ж��
ALTER TABLE TMS_MConfig ADD Cfg_Pick BIGINT NOT NULL DEFAULT 0;
ALTER TABLE TMS_MConfig ADD Cfg_Delivery BIGINT NOT NULL DEFAULT 0;
ALTER TABLE TMS_MConfig ADD Cfg_OnLoad BIGINT NOT NULL DEFAULT 0;
ALTER TABLE TMS_MConfig ADD Cfg_OffLoad BIGINT NOT NULL DEFAULT 0;
