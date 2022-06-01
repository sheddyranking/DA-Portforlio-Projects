/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [location]
      ,[date]
      ,[population]
      ,[total_cases]
      ,[PercentagePopulationInfected]
  FROM [DAPortfolioProject].[dbo].[PercentagePopulationInfected]