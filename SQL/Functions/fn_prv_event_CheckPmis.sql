USE [OTMS]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_prv_event_CheckPmis]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_prv_event_CheckPmis]
GO

USE [OTMS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
/**
1 �������Ϊ��Ӧ��             1 ������
  2 ��Ӧ�����뱻��               1 ������
  3 �����ն���                   2 ����
  4 ��������                     2 ����
  5 �쳣����                     3 �쳣�븽�ӷ�
  6 ���ӷ�����                   3 �쳣�븽�ӷ�
  7 ����˱��۵�                 4 ���۵�
  8 ���۵����ܾ�                 4 ���۵�
  9 ͬ���Ϊ������               1 ������
 10 ���ܶ���                     2 ����
 11 �ͻ����ܱ��۵�               4 ���۵�
 12 �����ƴ����                 5 ƴ����
 13 ƴ�������ܾ�                 5 ƴ����
 14 ����ƴ����                   5 ƴ����
 15 ���۵���ǿ�ƹ���             4 ���۵�

 16 ������ǩ�ն���			     2 ����
 17 �ͻ�����ί�ж���             2 ����
 18 �ͻ��ر�ί�ж���             2 ����
 19 �������ϴ��ص���Ƭ           2 ����
 20 �������ѻص�                 2 ����
 21 �����̹رն���               2 ����
 
 22 �µļ��뼯������             6 ����
 23 �ɹ����뼯��                 6 ����
 24 �������뱻�ܾ�               6 ����

25 �����۸�Ԥ�����������㵣��
 26 �����Ԥ��
 27 �ͻ���Ԥ��
 28 װ����Ԥ��
 29 ж����Ԥ��
 30 ���۷�Ԥ��
 	
 31 ���˳�����			6 ����
 32 �˳�԰��			6 ����
 
 33 �µļ���԰������             6 ����
 34 �ɹ�����԰��                 6 ����
 35 ԰�����뱻�ܾ�               6 ����	
**/
-- ����û��Ƿ��л�ȡ��ǰ�¼���Ȩ��
CREATE FUNCTION [dbo].[fn_prv_event_CheckPmis]
(
	@Operator BIGINT,
	@EventType BIGINT
)
RETURNS TINYINT
AS
BEGIN
	DECLARE @Result TINYINT;
	DECLARE @Role BIGINT;
	SET @Result=0;
	SET @Role=dbo.fn_pub_user_User2RoleID(@Operator)
	
	-- ��Ӫ
	IF @Role & 1 = 1 AND @EventType IN (1,2,4,5,6,9,10,13,14,16,19,20,21,25,26,27,28,29,30)
	BEGIN
		SET @Result = 1;
	END

	-- �ͷ� 
	IF @Role & 2 = 2 AND @EventType IN (3,12,17,18)
	BEGIN
		SET @Result = 1;
	END
	
	-- �ɹ� 
	IF  @Role & 32 = 32 AND @EventType IN (1,2,7,9,15)
	BEGIN
		SET @Result = 1;
	END

	-- ����Ա
	IF @Role & 256 = 256 AND @EventType IN (22,23,24,31,32)
	BEGIN
		SET @Result = 1;
	END

	-- ҵ��Ա
	IF  @Role & 512 = 512 AND @EventType IN (8,11,25,26,27,28,29,30)
	BEGIN 
		SET @Result = 1;
	END

	RETURN @Result;
END
GO


