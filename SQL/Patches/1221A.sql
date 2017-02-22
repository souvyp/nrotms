-- 测试绑定指定设备
update TMS_OrderIndex SET Index_DeviceCode =	110333	 WHERE Index_ID =	1086472	;
update TMS_OrderIndex SET Index_DeviceCode =	110334	 WHERE Index_ID =	1087068	;
update TMS_OrderIndex SET Index_DeviceCode =	110335	 WHERE Index_ID =	1086536	;
update TMS_OrderIndex SET Index_DeviceCode =	110336	 WHERE Index_ID =	1087158	;
update TMS_OrderIndex SET Index_DeviceCode =	110337	 WHERE Index_ID =	1085048	;
update TMS_OrderIndex SET Index_DeviceCode =	110338	 WHERE Index_ID =	1087080	;
update TMS_OrderIndex SET Index_DeviceCode =	110339	 WHERE Index_ID =	1086652	;
update TMS_OrderIndex SET Index_DeviceCode =	110340	 WHERE Index_ID =	1086690	;
-- 增加模拟测试位置
update TMS_OrderIndex SET Index_DeviceCode =	110341	 WHERE Index_ID =	1087006	;
update TMS_OrderIndex SET Index_DeviceCode =	110342	 WHERE Index_ID =	1087140	;
update TMS_OrderIndex SET Index_DeviceCode =	110343	 WHERE Index_ID =	1086460	;
update TMS_OrderIndex SET Index_DeviceCode =	110344	 WHERE Index_ID =	1086636	;
update TMS_OrderIndex SET Index_DeviceCode =	110345	 WHERE Index_ID =	1086470	;
update TMS_OrderIndex SET Index_DeviceCode =	110346	 WHERE Index_ID =	1087016	;
update TMS_OrderIndex SET Index_DeviceCode =	110347	 WHERE Index_ID =	1087154	;
update TMS_OrderIndex SET Index_DeviceCode =	110348	 WHERE Index_ID =	1086492	;

update [TMS_Devices] SET [Device_IMEICode] =	'351608080965937'	 WHERE [Device_ID] =	110341	;
update [TMS_Devices] SET [Device_IMEICode] =	'351608080965938'	 WHERE [Device_ID] =	110342	;
update [TMS_Devices] SET [Device_IMEICode] =    '351608080965939'	 WHERE [Device_ID] =	110343	;
update [TMS_Devices] SET [Device_IMEICode] =	'351608080965940'	 WHERE [Device_ID] =	110344	;
update [TMS_Devices] SET [Device_IMEICode] =	'351608080965941'    WHERE [Device_ID] =	110345	;
update [TMS_Devices] SET [Device_IMEICode] =	'351608080965942'	 WHERE [Device_ID] =	110346	;
update [TMS_Devices] SET [Device_IMEICode] =	'351608080965943'	 WHERE [Device_ID] =	110347	;
update [TMS_Devices] SET [Device_IMEICode] =	'351608080965944'    WHERE [Device_ID] =	110348	;


INSERT INTO [TMS_Position] ([DEV_ID],[longitude],[latitude],[b_longitude],[b_latitude],[time]) Values ('351608080965937',116.420000,39.930000,116.420000,39.930000,GETDATE());
  INSERT INTO [TMS_Position] ([DEV_ID],[longitude],[latitude],[b_longitude],[b_latitude],[time]) Values ('351608080965938',117.220000,39.120000,117.220000,39.120000,GETDATE());
  INSERT INTO [TMS_Position] ([DEV_ID],[longitude],[latitude],[b_longitude],[b_latitude],[time]) Values ('351608080965939',114.500000,38.050000,114.500000,38.050000,GETDATE());
  INSERT INTO [TMS_Position] ([DEV_ID],[longitude],[latitude],[b_longitude],[b_latitude],[time]) Values ('351608080965940',118.420000,39.730000,118.420000,39.730000,GETDATE());
  INSERT INTO [TMS_Position] ([DEV_ID],[longitude],[latitude],[b_longitude],[b_latitude],[time]) Values ('351608080965941',115.150000,36.280000,115.150000,36.280000,GETDATE());
  INSERT INTO [TMS_Position] ([DEV_ID],[longitude],[latitude],[b_longitude],[b_latitude],[time]) Values ('351608080965942',114.500000,36.850000,114.500000,36.850000,GETDATE());
  INSERT INTO [TMS_Position] ([DEV_ID],[longitude],[latitude],[b_longitude],[b_latitude],[time]) Values ('351608080965943',115.930000,38.920000,115.930000,38.920000,GETDATE());
  INSERT INTO [TMS_Position] ([DEV_ID],[longitude],[latitude],[b_longitude],[b_latitude],[time]) Values ('351608080965944',111.770000,36.850000,111.770000,36.850000,GETDATE());




