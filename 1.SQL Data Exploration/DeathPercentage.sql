/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [location]
      ,[date]
      ,[total_cases]
      ,[total_deaths]
      ,[DeathPercentage]
  FROM [DAPortfolioProject].[dbo].[DeathPercentage]