USE [DATA]
GO

SELECT [item_no], [avg_cost], [last_cost], [std_cost] AS current_std_cost,
    (CASE WHEN [avg_cost] >= [last_cost] THEN [avg_cost] ELSE [last_cost] END) * 1.25 AS new_std_cost,
    ((CASE WHEN [avg_cost] >= [last_cost] THEN [avg_cost] ELSE [last_cost] END) * 1.25) - [std_cost] AS difference,
    ROUND(
        (((CASE WHEN [avg_cost] >= [last_cost] THEN [avg_cost] ELSE [last_cost] END) * 1.25) - [std_cost])
        / NULLIF([std_cost], 0)
    , 2) AS pct_change,
    (CASE WHEN [avg_cost] >= [last_cost] THEN 'Average Cost' ELSE 'Last Cost' END) AS cost_basis_used
FROM [dbo].[iminvloc_sql]
WHERE ([item_no] LIKE '021%'
    OR [item_no] LIKE '022%')
ORDER BY [item_no]
GO
