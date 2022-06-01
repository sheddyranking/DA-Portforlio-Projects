/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [date]
      ,[Total_cases]
      ,[Total_deaths]
      ,[GlobalNumbering]
  FROM [DAPortfolioProject].[dbo].[GlobalNumbering]