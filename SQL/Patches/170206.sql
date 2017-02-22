-- 加入物品摘要列
ALTER TABLE TMS_OrderIndex ADD Index_GoodsLst NVARCHAR(MAX);

UPDATE TMS_OrderIndex SET  Index_GoodsLst = STUFF((select ';'+A.GOODSLST from (SELECT GoodsLst_Name+', 数量：'+CAST (LTRIM(CAST(GoodsLst_Qty as float))  AS NVARCHAR ) AS GOODSLST FROM TMS_OrderGoods WHERE  GoodsLst_OrderID = Index_ID) A FOR xml PATH('')), 1, 1, '');

