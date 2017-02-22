-- TMS_OrderIndex.Index_SrcClass默认值修改为1

ALTER TABLE TMS_OrderIndex ADD Index_ShipMode BIGINT NULL DEFAULT 0;
ALTER TABLE TMS_OrderIndex ADD Index_Pick BIGINT NULL DEFAULT 0;
ALTER TABLE TMS_OrderIndex ADD Index_Delivery BIGINT NULL DEFAULT 0;

DROP PROCEDURE sp_pub_order_SeparateOrder;
DROP PROCEDURE sp_pub_order_AllocateOrder;
DROP PROCEDURE sp_pub_order_SendOrder;
DROP PROCEDURE sp_prv_order_EditOrderCost;
DROP PROCEDURE sp_pub_order_EditOrderCost;
DROP PROCEDURE fn_pub_order_CostDescription;
DROP PROCEDURE fn_pub_order_ExcepDescription;
DROP PROCEDURE sp_pub_event_TaskList;

DROP FUNCTION fn_pub_user_IsOfflineSupplier;
DROP PROCEDURE sp_pub_my_EditOfflineSupplier;

DELETE TMS_MSupplier WHERE Supplier_CompanyID = 0;

-- TMS_MCar中删除Car_SupplierID字段
-- TMS_MDriver中删除Driver_SupplierID字段
-- TMS_MSupplier中删除线下承运商的相关字段

-- 各角色分权限登录
UPDATE TMS_User SET User_RoleID = User_RoleID ^ 8 WHERE (User_RoleID & 8) = 8;
UPDATE TMS_User SET User_RoleID = 119 WHERE User_RoleID = 0;

-- TMS_MGoods
ALTER TABLE TMS_MGoods ADD Goods_CreatorCompanyID BIGINT NOT NULL DEFAULT 0;