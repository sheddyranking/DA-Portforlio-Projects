/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [location]
      ,[population]
      ,[HighestInfectionCount]
      ,[CountriesPercentInfected]
  FROM [DAPortfolioProject].[dbo].[CountriesPercentInfected]