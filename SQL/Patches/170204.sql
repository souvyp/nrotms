-- ÐÂÔöË÷Òý 
CREATE INDEX IX_TMS_OrderIndex_Srclass ON TMS_OrderIndex(Index_SrcClass);

CREATE INDEX IX_Price_DocIndex_OrderBePrice ON dbo.Price_DocIndex(Index_OrderID,Index_Type,Index_Status,Index_Invalid);


