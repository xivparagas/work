USE [DATA]
GO

SELECT [item_no], [avg_cost], [last_cost], [std_cost] AS current_std_cost,
    GREATEST([avg_cost], [last_cost]) * 1.25 AS new_std_cost, (GREATEST([avg_cost], [last_cost]) * 1.25) - [std_cost] AS difference
FROM [dbo].[iminvloc_sql]
WHERE [item_no] LIKE '301%'
ORDER BY [item_no]
GO