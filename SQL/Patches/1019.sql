-- 添加用户类型 1 普通用户（默认） 2 微信用户
ALTER TABLE TMS_User ADD User_Type BIGINT NOT NULL DEFAULT 1;
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 普通用户 2 微信用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TMS_User', @level2type=N'COLUMN',@level2name=N'User_Type'
GO
-- 添加用户微信OpenId
ALTER TABLE TMS_User ADD User_OpenId NVARCHAR(300) NULL DEFAULT NULL;
-- 添加用户配置 是否提货 送货 装货 卸货
ALTER TABLE TMS_MConfig ADD Cfg_Pick BIGINT NOT NULL DEFAULT 0;
ALTER TABLE TMS_MConfig ADD Cfg_Delivery BIGINT NOT NULL DEFAULT 0;
ALTER TABLE TMS_MConfig ADD Cfg_OnLoad BIGINT NOT NULL DEFAULT 0;
ALTER TABLE TMS_MConfig ADD Cfg_OffLoad BIGINT NOT NULL DEFAULT 0;
