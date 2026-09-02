USE [DATA]
GO

UPDATE [dbo].[iminvloc_sql]
SET [std_cost] = (CASE WHEN [avg_cost] >= [last_cost] THEN [avg_cost] ELSE [last_cost] END) * 1.25
WHERE ([item_no] LIKE '301%'
    OR [item_no] LIKE '302%'
    OR [item_no] LIKE '261%'
    OR [item_no] LIKE '262%'
    OR [item_no] LIKE '401%'
    OR [item_no] LIKE '402%'
    OR [item_no] LIKE '421%'
    OR [item_no] LIKE '422%')
GO