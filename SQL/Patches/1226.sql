 -- �޸����� ���Ⱥ��ڴ�������ʱ��Ĳ���ӱ�,ִ��ֱ����Ӱ��
 
 -- ��������
	SELECT B.Index_WeightAddition,A.Index_WeightAddition FROM TMS_OrderIndex AS B INNER JOIN TMS_OrderIndex AS A ON B.Index_WeightAddition/A.Index_WeightAddition =2 WHERE  A.Index_WeightAddition <>0 AND B.Index_SrcOrderID = A.Index_ID;
 -- �޸������ӱ�
UPDATE B SET Index_WeightAddition = B.Index_WeightAddition/2 FROM TMS_OrderIndex AS B INNER JOIN TMS_OrderIndex AS A ON B.Index_WeightAddition/A.Index_WeightAddition =2 WHERE  A.Index_WeightAddition <>0 AND B.Index_SrcOrderID = A.Index_ID;
 -- ��������
 SELECT B.Index_VolumeAddition,A.Index_VolumeAddition FROM TMS_OrderIndex AS B INNER JOIN TMS_OrderIndex AS A ON B.Index_VolumeAddition/A.Index_VolumeAddition =2 WHERE  A.Index_VolumeAddition <>0 AND B.Index_SrcOrderID = A.Index_ID;
 -- �޸�����ӱ�
UPDATE B SET Index_VolumeAddition = B.Index_VolumeAddition/2 FROM TMS_OrderIndex AS B INNER JOIN TMS_OrderIndex AS A ON B.Index_VolumeAddition/A.Index_VolumeAddition =2 WHERE  A.Index_VolumeAddition <>0 AND B.Index_SrcOrderID = A.Index_ID;