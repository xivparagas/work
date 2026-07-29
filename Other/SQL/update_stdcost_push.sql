USE [DATA]
GO

UPDATE [dbo].[iminvloc_sql]
SET [std_cost] = (CASE WHEN [avg_cost] >= [last_cost] THEN [avg_cost] ELSE [last_cost] END) * 1.25
WHERE [item_no] LIKE '301%'
GO