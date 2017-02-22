
-- DATA PATCH
update TMS_OrderIndex SET Index_ToProvince = 110000,Index_ToCity = 110100,Index_ToDistrict = 110106 WHERE index_id = 1080727

update[TMS_BasicArea]  SET [Area_Invalid] = 1  WHERE [Area_ID] = 1;

update[TMS_BasicArea]  SET [Area_Invalid] = 1  WHERE [Area_ID] = 429000;

update[TMS_BasicArea]  SET [Area_Invalid] = 1  WHERE [Area_ID] = 500300;

update[TMS_BasicArea]  SET [Area_Invalid] = 1  WHERE [Area_ID] = 659000;