ALTER TABLE TMS_OrderIndex ADD Index_GoodsValue DECIMAL(18,2) NULL DEFAULT 0;

-- 计算货物总价值
UPDATE TMS_OrderIndex SET Index_GoodsValue = dbo.fn_pub_order_TotalGoodsValue(Index_ID);

-- 数据修复：验证是否有物品价格为0
SELECT * FROM TMS_MGoods WHERE Goods_Price = 0 OR Goods_Price IS NULL;

-- 数据修复：验证是否有货物总价值为0的情况，调查原因
SELECT * FROM TMS_OrderIndex WHERE Index_GoodsValue = 0 OR Index_GoodsValue IS NULL;

-- 数据修复：清除自己把自己加为承运商的情况

ALTER TABLE TMS_OrderGoods ADD GoodsLst_Price DECIMAL(18,2) NULL DEFAULT 0;

-- 数据修复：订单物品明细中冗余价格，防止用户中途修改商品价格
UPDATE TMS_OrderGoods SET GoodsLst_Price = ISNULL((SELECT Goods_Price FROM TMS_MGoods WHERE Goods_ID = GoodsLst_GoodsID), 0);