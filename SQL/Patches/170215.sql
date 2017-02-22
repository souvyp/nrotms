-- 新增索引 
CREATE INDEX IX_TMS_TMS_Position_DEVID ON TMS_Position(DEV_ID);

-- 收货方修改
UPDATE	TMS_MEndUser SET EndUser_Name= '四川野马' WHERE EndUser_Name = '四川野马汽车';
UPDATE	TMS_MEndUser SET EndUser_Name= '万都宁波' WHERE EndUser_Name ='万都(宁波)';
-- 查看需要修改订单(SELECT * FROM TMS_OrderIndex WHERE Index_EndUserName in ('四川野马汽车','万都(宁波)')AND Index_CustomerCompanyID = 534;) 
-- 历史订单收货人修改
UPDATE TMS_OrderIndex SET Index_EndUserName =	'四川野马'	WHERE Index_EndUserName =	'四川野马汽车' AND Index_CustomerCompanyID = 534; 
UPDATE TMS_OrderIndex SET Index_EndUserName =	'万都宁波'	WHERE Index_EndUserName =	'万都(宁波)' AND Index_CustomerCompanyID = 534 ;



