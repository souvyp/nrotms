-- �۸������б�[��������д]
CREATE TABLE Price_Type
(
	[Type_ID] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,	-- ���ͱ��
	[Type_Name] NVARCHAR(100) NOT NULL,						-- ������
	[Type_Creator] BIGINT NOT NULL DEFAULT 0,				-- ������
	[Type_CreateTime] DATETIME NOT NULL DEFAULT GETDATE(),	-- ����ʱ��
	[Type_Updater] BIGINT NULL DEFAULT 0,					-- �޸���
	[Type_UpdateTime] DATETIME NULL,						-- �޸���ʱ��
	[Type_Invalid] TINYINT NOT NULL DEFAULT 0,				-- �Ƿ�ʧЧ
	[Type_Comments] VARCHAR(256) NULL,						-- ��ע
	[opt_status] BIGINT NULL DEFAULT 0						-- �����ֶ�
);

--  ������λ[��������д]
CREATE TABLE Price_Unit
(
	[Unit_ID] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,	-- ������λ���
	[Unit_Name] NVARCHAR(100) NOT NULL,						-- ������λ����
	[Unit_Creator] BIGINT NOT NULL DEFAULT 0,				-- ������
	[Unit_CreateTime] DATETIME NOT NULL DEFAULT GETDATE(),	-- ����ʱ��
	[Unit_Updater] BIGINT NULL DEFAULT 0,					-- ������
	[Unit_UpdateTime] DATETIME NULL,						-- ����ʱ��
	[Unit_Invalid] TINYINT NOT NULL DEFAULT 0,				-- �Ƿ�ʧЧ
	[Unit_Comments] VARCHAR(256) NULL,						-- ��ע
	[opt_status] BIGINT NULL DEFAULT 0						-- �����ֶ�
);

-- ��������
CREATE TABLE Price_DocIndex
(
	[Index_ID] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,	-- ���۵����
	[opt_status] BIGINT NULL DEFAULT 0,						-- �����ֶ�
	[Index_Code] NVARCHAR(50) NOT NULL,						-- ���۵�����
	[Index_PactCode] NVARCHAR(50) NOT NULL,					-- ��ͬ����
	[Index_Name] NVARCHAR(300) NULL,						-- ���۵���
	[Index_StartTime] DATETIME NOT NULL,					-- ��Լ��ʼʱ��(>=)
	[Index_EndTime] DATETIME NOT NUll,						-- ��Լ����ʱ��(<=)
	[Index_Description] NVARCHAR(1024) NULL,				-- ˵��
	[Index_OrderID] BIGINT NULL DEFAULT 0,					-- �������
	[Index_SrcDocID] BIGINT NULL DEFAULT 0,					-- ԭ���۵���[���������в��䱨�۶�����Զ�����]
	[Index_Type] BIGINT NOT NULL DEFAULT 0,					-- ���۷�ʽ 1 �������� 2 ��Լ 3 ���䱨�� 4 �ϵ�����
															-- �������ֶ�, ����֪���������ʲôʱ��ʹ��
	[Index_Status] BIGINT NOT NULL DEFAULT 0,				-- ���۵�״̬(0 �ݸ� 1 �ѷ��� 2 ��ͬ�� 4 �ѹر�)
	[Index_StatusTime] DATETIME NOT NULL DEFAULT GETDATE(),	-- ״̬����ʱ��
	[Index_CustomerID] BIGINT NOT NULL DEFAULT 0,			-- �ͻ����
	[Index_CustomerCompanyID] BIGINT NOT NULL DEFAULT 0,	-- �ͻ���˾���(û������0)
	[Index_CreatorID] BIGINT NOT NULL DEFAULT 0,			-- �������˻����
	[Index_CreatorCompanyID] BIGINT NOT NULL DEFAULT 0,		-- �����߹�˾���
	[Index_CreateTime] DATETIME NOT NULL DEFAULT GETDATE(),	-- ����ʱ��
	[Index_Confirmer] BIGINT NOT NULL DEFAULT 0,			-- �޸��߱��
	[Index_ConfirmTime] DATETIME NULL,						-- �޸�ʱ��
	[Index_Invalid] TINYINT NOT NULL DEFAULT 0,				-- �Ƿ�ʧЧ
	[Index_Comments] VARCHAR(256) NULL						-- ��ע
);

-- �������̱�
CREATE TABLE Price_DocFlow
(
	[Flow_ID] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,	-- ���̱��
	[opt_status] BIGINT NOT NULL DEFAULT 0,					-- �����ֶ�
	[Flow_DocID] BIGINT NOT NULL DEFAULT 0,					-- ���۵���
	[Flow_SrcStatus] BIGINT NOT NULL DEFAULT 0,				-- Դ״̬
	[Flow_DstStatus] BIGINT NOT NULL DEFAULT 0,				-- Ŀ��״̬
	[Flow_Operation] BIGINT NOT NULL DEFAULT 0,				-- 0 ������(ͬ��) 1 ������(�ܾ�) 2 ǿ�ƹر� 3 ���ò����±���
	[Flow_Description] NVARCHAR(512) NULL,					-- ����
	[Flow_Creator] BIGINT NOT NULL DEFAULT 0,				-- ������
	[Flow_CompanyID] BIGINT NOT NULL DEFAULT 0,				-- �����߹�˾���
	[Flow_InsertTime] DATETIME NOT NULL DEFAULT GETDATE(),	-- ���ʱ��
	[Flow_Invalid] BIGINT NOT NULL DEFAULT 0,				-- �Ƿ�ʧЧ
	[Flow_Comments] VARCHAR(256) NULL						-- ��ע
);

-- ������ϸ��
CREATE TABLE Price_DocDetails
(
	[Detail_ID] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,	-- ��ϸ���
	[opt_status] BIGINT NOT NULL DEFAULT 0,					-- �����ֶ�
	[Detail_DocID] BIGINT NOT NULL DEFAULT 0,				-- ���۵���
	[Detail_Type] BIGINT NOT NULL DEFAULT 0,				-- �۸�����
	[Detail_FromProvince] BIGINT NULL DEFAULT 0,			-- ��·���ʡ
	[Detail_FromCity] BIGINT NULL DEFAULT 0,				-- ��·�����
	[Detail_FromDistrict] BIGINT NULL DEFAULT 0,			-- ��·�����
	[Detail_From] NVARCHAR(300) NULL,						-- ��·���
	[Detail_ToProvince] BIGINT NULL DEFAULT 0,				-- ��·�յ�ʡ
	[Detail_ToCity] BIGINT NULL DEFAULT 0,					-- ��·�յ���
	[Detail_ToDistrict] BIGINT NULL DEFAULT 0,				-- ��·�յ���
	[Detail_To] NVARCHAR(300) NULL,							-- ��·�յ�
	[Detail_Kms] BIGINT NULL DEFAULT 0,						-- �ܹ�����
	[Detail_CarType] BIGINT NULL DEFAULT 0,					-- ����
	[Detail_CarLength] BIGINT NULL DEFAULT 0,				-- ����
	[Detail_Description] NVARCHAR(1024) NULL,				-- ˵��
	[Detail_MinVolume] DECIMAL(18,4) NULL DEFAULT 0,		-- �������õ��������
	[Detail_MaxVolume] DECIMAL(18,4) NULL DEFAULT 0,		-- �������õ��������
	[Detail_VolumeUnit] BIGINT NULL DEFAULT 1,				-- �����λ[1 �� 2 ��]
	[Detail_MinWeight] DECIMAL(18,4) NULL DEFAULT 0,		-- �������õ���������
	[Detail_MaxWeight] DECIMAL(18,4) NULL DEFAULT 0,		-- �������õ���������
	[Detail_WeightUnit] BIGINT NULL DEFAULT 1,				-- ������λ[1 �� 2 ����]
	[Detail_MinEqual] TINYINT NULL DEFAULT 1,				-- �Ƿ����Min�߽�
	[Detail_MaxEqual] TINYINT NULL DEFAULT 1,				-- �Ƿ����Max�߽�
	[Detail_Count] DECIMAL(18,2) NULL DEFAULT 0,			-- ����
	[Detail_Unit] BIGINT NULL DEFAULT 0,					-- ������λ
	[Detail_Amount] DECIMAL(18,2) NULL DEFAULT 0,			-- ����
	[Detail_MinPay] DECIMAL(18,2) NULL DEFAULT 0,           -- ��͸���
	[Detail_Creator] BIGINT NOT NULL DEFAULT 0,				-- ������
	[Detail_CreatorCompanyID] BIGINT NOT NULL DEFAULT 0,	-- �����߹�˾���
	[Detail_CreateTime] DATETIME NOT NULL DEFAULT GETDATE(),-- ����ʱ��
	[Detail_Updater] BIGINT NULL DEFAULT 0,					-- ������
	[Detail_UpdateTime] DATETIME NULL,						-- ����ʱ��
	[Detail_Invalid] TINYINT NOT NULL DEFAULT 0,			-- �Ƿ�ʧЧ
	[Detail_Comments] VARCHAR(256) NULL						-- ��ע
);
