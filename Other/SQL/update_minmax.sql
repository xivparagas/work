USE [DATA]
GO

UPDATE [dbo].[iminvloc_sql]
    SET [ord_up_to_lvl] = FLOOR(prior_year_usage / 4), [reorder_lvl] = FLOOR(ord_up_to_lvl / 4)
      
GO


