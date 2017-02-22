-- 价格类型列表[由南软填写]
CREATE TABLE Price_Type
(
	[Type_ID] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,	-- 类型编号
	[Type_Name] NVARCHAR(100) NOT NULL,						-- 类型名
	[Type_Creator] BIGINT NOT NULL DEFAULT 0,				-- 创建者
	[Type_CreateTime] DATETIME NOT NULL DEFAULT GETDATE(),	-- 创建时间
	[Type_Updater] BIGINT NULL DEFAULT 0,					-- 修改者
	[Type_UpdateTime] DATETIME NULL,						-- 修改者时间
	[Type_Invalid] TINYINT NOT NULL DEFAULT 0,				-- 是否失效
	[Type_Comments] VARCHAR(256) NULL,						-- 备注
	[opt_status] BIGINT NULL DEFAULT 0						-- 保留字段
);

--  计量单位[由南软填写]
CREATE TABLE Price_Unit
(
	[Unit_ID] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,	-- 计量单位编号
	[Unit_Name] NVARCHAR(100) NOT NULL,						-- 计量单位名称
	[Unit_Creator] BIGINT NOT NULL DEFAULT 0,				-- 创建者
	[Unit_CreateTime] DATETIME NOT NULL DEFAULT GETDATE(),	-- 创建时间
	[Unit_Updater] BIGINT NULL DEFAULT 0,					-- 更新者
	[Unit_UpdateTime] DATETIME NULL,						-- 更新时间
	[Unit_Invalid] TINYINT NOT NULL DEFAULT 0,				-- 是否失效
	[Unit_Comments] VARCHAR(256) NULL,						-- 备注
	[opt_status] BIGINT NULL DEFAULT 0						-- 保留字段
);

-- 报价主表
CREATE TABLE Price_DocIndex
(
	[Index_ID] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,	-- 报价单编号
	[opt_status] BIGINT NULL DEFAULT 0,						-- 保留字段
	[Index_Code] NVARCHAR(50) NOT NULL,						-- 报价单编码
	[Index_PactCode] NVARCHAR(50) NOT NULL,					-- 合同编码
	[Index_Name] NVARCHAR(300) NULL,						-- 报价单名
	[Index_StartTime] DATETIME NOT NULL,					-- 合约起始时间(>=)
	[Index_EndTime] DATETIME NOT NUll,						-- 合约结束时间(<=)
	[Index_Description] NVARCHAR(1024) NULL,				-- 说明
	[Index_OrderID] BIGINT NULL DEFAULT 0,					-- 订单编号
	[Index_SrcDocID] BIGINT NULL DEFAULT 0,					-- 原报价单号[废弃，所有补充报价都是针对订单的]
	[Index_Type] BIGINT NOT NULL DEFAULT 0,					-- 报价方式 1 按单报价 2 合约 3 补充报价 4 合单报价
															-- 保留该字段, 可以知道订单编号什么时候使用
	[Index_Status] BIGINT NOT NULL DEFAULT 0,				-- 报价单状态(0 草稿 1 已发布 2 已同意 4 已关闭)
	[Index_StatusTime] DATETIME NOT NULL DEFAULT GETDATE(),	-- 状态更新时间
	[Index_CustomerID] BIGINT NOT NULL DEFAULT 0,			-- 客户编号
	[Index_CustomerCompanyID] BIGINT NOT NULL DEFAULT 0,	-- 客户公司编号(没有则填0)
	[Index_CreatorID] BIGINT NOT NULL DEFAULT 0,			-- 创建者账户编号
	[Index_CreatorCompanyID] BIGINT NOT NULL DEFAULT 0,		-- 创建者公司编号
	[Index_CreateTime] DATETIME NOT NULL DEFAULT GETDATE(),	-- 创建时间
	[Index_Confirmer] BIGINT NOT NULL DEFAULT 0,			-- 修改者编号
	[Index_ConfirmTime] DATETIME NULL,						-- 修改时间
	[Index_Invalid] TINYINT NOT NULL DEFAULT 0,				-- 是否失效
	[Index_Comments] VARCHAR(256) NULL						-- 备注
);

-- 报价流程表
CREATE TABLE Price_DocFlow
(
	[Flow_ID] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,	-- 流程编号
	[opt_status] BIGINT NOT NULL DEFAULT 0,					-- 保留字段
	[Flow_DocID] BIGINT NOT NULL DEFAULT 0,					-- 报价单号
	[Flow_SrcStatus] BIGINT NOT NULL DEFAULT 0,				-- 源状态
	[Flow_DstStatus] BIGINT NOT NULL DEFAULT 0,				-- 目标状态
	[Flow_Operation] BIGINT NOT NULL DEFAULT 0,				-- 0 无异议(同意) 1 有疑问(拒绝) 2 强制关闭 3 禁用并重新报价
	[Flow_Description] NVARCHAR(512) NULL,					-- 描述
	[Flow_Creator] BIGINT NOT NULL DEFAULT 0,				-- 创建人
	[Flow_CompanyID] BIGINT NOT NULL DEFAULT 0,				-- 创建者公司编号
	[Flow_InsertTime] DATETIME NOT NULL DEFAULT GETDATE(),	-- 添加时间
	[Flow_Invalid] BIGINT NOT NULL DEFAULT 0,				-- 是否失效
	[Flow_Comments] VARCHAR(256) NULL						-- 备注
);

-- 报价明细表
CREATE TABLE Price_DocDetails
(
	[Detail_ID] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,	-- 明细编号
	[opt_status] BIGINT NOT NULL DEFAULT 0,					-- 保留字段
	[Detail_DocID] BIGINT NOT NULL DEFAULT 0,				-- 报价单号
	[Detail_Type] BIGINT NOT NULL DEFAULT 0,				-- 价格类型
	[Detail_FromProvince] BIGINT NULL DEFAULT 0,			-- 线路起点省
	[Detail_FromCity] BIGINT NULL DEFAULT 0,				-- 线路起点市
	[Detail_FromDistrict] BIGINT NULL DEFAULT 0,			-- 线路起点区
	[Detail_From] NVARCHAR(300) NULL,						-- 线路起点
	[Detail_ToProvince] BIGINT NULL DEFAULT 0,				-- 线路终点省
	[Detail_ToCity] BIGINT NULL DEFAULT 0,					-- 线路终点市
	[Detail_ToDistrict] BIGINT NULL DEFAULT 0,				-- 线路终点区
	[Detail_To] NVARCHAR(300) NULL,							-- 线路终点
	[Detail_Kms] BIGINT NULL DEFAULT 0,						-- 总公里数
	[Detail_CarType] BIGINT NULL DEFAULT 0,					-- 车型
	[Detail_CarLength] BIGINT NULL DEFAULT 0,				-- 车长
	[Detail_Description] NVARCHAR(1024) NULL,				-- 说明
	[Detail_MinVolume] DECIMAL(18,4) NULL DEFAULT 0,		-- 报价适用的体积下限
	[Detail_MaxVolume] DECIMAL(18,4) NULL DEFAULT 0,		-- 报价适用的体积上限
	[Detail_VolumeUnit] BIGINT NULL DEFAULT 1,				-- 体积单位[1 方 2 升]
	[Detail_MinWeight] DECIMAL(18,4) NULL DEFAULT 0,		-- 报价适用的重量下限
	[Detail_MaxWeight] DECIMAL(18,4) NULL DEFAULT 0,		-- 报价适用的重量上限
	[Detail_WeightUnit] BIGINT NULL DEFAULT 1,				-- 重量单位[1 吨 2 公斤]
	[Detail_MinEqual] TINYINT NULL DEFAULT 1,				-- 是否包含Min边界
	[Detail_MaxEqual] TINYINT NULL DEFAULT 1,				-- 是否包含Max边界
	[Detail_Count] DECIMAL(18,2) NULL DEFAULT 0,			-- 数量
	[Detail_Unit] BIGINT NULL DEFAULT 0,					-- 数量单位
	[Detail_Amount] DECIMAL(18,2) NULL DEFAULT 0,			-- 单价
	[Detail_MinPay] DECIMAL(18,2) NULL DEFAULT 0,           -- 最低付费
	[Detail_Creator] BIGINT NOT NULL DEFAULT 0,				-- 创建者
	[Detail_CreatorCompanyID] BIGINT NOT NULL DEFAULT 0,	-- 创建者公司编号
	[Detail_CreateTime] DATETIME NOT NULL DEFAULT GETDATE(),-- 创建时间
	[Detail_Updater] BIGINT NULL DEFAULT 0,					-- 更新者
	[Detail_UpdateTime] DATETIME NULL,						-- 更新时间
	[Detail_Invalid] TINYINT NOT NULL DEFAULT 0,			-- 是否失效
	[Detail_Comments] VARCHAR(256) NULL						-- 备注
);
