USE [DATA]
GO

UPDATE [dbo].[iminvloc_sql]
SET [std_cost] = GREATEST([avg_cost], [last_cost]) * 1.25
WHERE [item_no] LIKE '301%'
GO