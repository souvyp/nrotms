-- Print_Type
INSERT INTO Price_Type(Type_Name, Type_Creator, Type_CreateTime, Type_Invalid) VALUES(N'零担', 1, GETDATE(), 0);
INSERT INTO Price_Type(Type_Name, Type_Creator, Type_CreateTime, Type_Invalid) VALUES(N'整车', 1, GETDATE(), 0);
INSERT INTO Price_Type(Type_Name, Type_Creator, Type_CreateTime, Type_Invalid) VALUES(N'提货费', 1, GETDATE(), 0);
INSERT INTO Price_Type(Type_Name, Type_Creator, Type_CreateTime, Type_Invalid) VALUES(N'送货费', 1, GETDATE(), 0);
INSERT INTO Price_Type(Type_Name, Type_Creator, Type_CreateTime, Type_Invalid) VALUES(N'装货费', 1, GETDATE(), 0);
INSERT INTO Price_Type(Type_Name, Type_Creator, Type_CreateTime, Type_Invalid) VALUES(N'卸货费', 1, GETDATE(), 0);
INSERT INTO Price_Type(Type_Name, Type_Creator, Type_CreateTime, Type_Invalid) VALUES(N'最低收费', 1, GETDATE(), 0);
INSERT INTO Price_Type(Type_Name, Type_Creator, Type_CreateTime, Type_Invalid) VALUES(N'保险费', 1, GETDATE(), 0);
INSERT INTO Price_Type(Type_Name, Type_Creator, Type_CreateTime, Type_Invalid) VALUES(N'附加费', 1, GETDATE(), 0);

-- 删除了TMS_OrderCost, TMS_OrderCostType等表
-- 添加了两个运输系统中配套的函数