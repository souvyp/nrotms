USE OTMS
 /** ɾ������,������Ϣ **/
 -- ɾ��������Ϣ
 DELETE FROM Balance_BillDetails WHERE 1=1;
 DELETE FROM Balance_BillIndex WHERE 1=1;
 -- ɾ���Ǻ�Լ������
 DELETE FROM Price_DocDetails FROM Price_DocDetails AS DD INNER JOIN Price_DocIndex AS D  ON D.Index_ID = DD.Detail_DocID WHERE D.Index_Type <> 2; 
 -- ɾ���Ǻ�Լ��������
 DELETE FROM Price_DocFlow FROM Price_DocFlow AS DD INNER JOIN Price_DocIndex AS D  ON D.Index_ID = DD.Flow_DocID WHERE D.Index_Type <> 2; 
 -- ɾ���Ǻ�Լ����
 DELETE FROM Price_DocIndex WHERE Index_Type <> 2;
 -- ɾ�����мƷ�
 DELETE FROM Price_OrderCache WHERE 1=1;
 -- ɾ���¼�
 DELETE FROM TMS_Events WHERE 1=1; 
 -- ɾ��������Ʒ
 DELETE FROM TMS_OrderGoods WHERE 1=1; 
 -- ɾ����������
 DELETE FROM TMS_OrderFlow WHERE 1=1;
 -- ɾ���ϵ�������Ʒͳ�� 
 DELETE FROM TMS_OrderContains WHERE 1=1;
 -- ɾ������
 DELETE FROM TMS_OrderIndex WHERE 1=1;
