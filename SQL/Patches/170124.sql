-- 修复数据将提货费改为零担费 已执行
  UPDATE Price_DocDetails SET Detail_Amount =(SELECT A.Detail_Amount FROM Price_DocDetails AS A  WHERE A.Detail_DOCID = 8372 AND A.Detail_Type = 3) WHERE  Detail_Type = 1 AND  Detail_DOCID = 8372;
  UPDATE Price_DocDetails SET Detail_Amount =(SELECT A.Detail_Amount FROM Price_DocDetails AS A  WHERE A.Detail_DOCID = 9820 AND A.Detail_Type = 3) WHERE  Detail_Type = 1 AND  Detail_DOCID = 9820;
  GO
  
  UPDATE Price_DocDetails SET Detail_Amount = 0 WHERE  Detail_DOCID IN (8372,9820) AND Detail_Type = 3;
  GO