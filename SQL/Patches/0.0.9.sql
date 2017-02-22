-- V0.0.9

-- TMS_OrderFlow
EXEC sp_rename 'TMS_OrderFlow.Flow_Accept', 'Flow_Operation';
ALTER TABLE TMS_OrderFlow ADD Flow_Description NVARCHAR(512) NULL;