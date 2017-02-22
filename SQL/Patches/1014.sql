-- 修复收货地址错误
	DECLARE @Code nvarchar (300);
SET @Code = 'ORD2016101219936%'
select Index_ID,Index_To,* from dbo.TMS_OrderIndex where  Index_Code like @Code;
UPDATE TMS_OrderIndex SET Index_To='杭州市余杭区文一西路与高教路交叉口' WHERE Index_Code like @Code;