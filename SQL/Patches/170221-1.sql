-- the patch has been done!

ALTER TABLE TMS_Devices ADD Device_Battery nvarchar(300) NULL;
ALTER TABLE TMS_Devices ADD Device_GPRS nvarchar(300) NULL;
ALTER TABLE TMS_Devices ADD Device_GPS_Signal nvarchar(300) NULL;
ALTER TABLE TMS_Devices ADD Device_HBT_TIME datetime NULL;
ALTER TABLE TMS_Devices ADD Device_LOGIN_TIME datetime NULL;