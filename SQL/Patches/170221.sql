-- Index_GoodsLst����Ʒ��ʾ


UPDATE TMS_OrderIndex SET  Index_GoodsLst = STUFF((select '; '+A.GOODSLST from (SELECT GoodsLst_Name+'(����:'+CAST (LTRIM(CAST(GoodsLst_Qty as float))  AS NVARCHAR )+')' AS GOODSLST FROM TMS_OrderGoods WHERE  GoodsLst_OrderID = Index_ID) A FOR xml PATH('')), 1, 1, '');


