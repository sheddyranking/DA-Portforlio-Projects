SELECT * 
FROM DAPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
order by 3,4

--SELECT * 
--FROM DAPortfolioProject..CovidVaccinations
--order by 3,4

-- SELECTING  THE DATA THA WE ARE GOING TO BE USING 

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM DAPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
order by 1,2


--- LOOKING AT TOTAL DEATHS VS TOTAL CASES (PERCENTAGE OF DYING IF YOU GET INFECTED)

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM DAPortfolioProject..CovidDeaths
WHERE location LIKE '%States%' and  continent IS NOT NULL
order by 1,2

--- LOOKING AT TOTAL CASES VS POPULATIONS 
--- Shows the Percentage of those who got Covid

SELECT location, date, population, total_cases, (total_cases/population)*100 AS   PercentagePopulationInfected
FROM DAPortfolioProject..CovidDeaths
-- WHERE location LIKE '%States%'
WHERE continent IS NOT NULL
order by 1,2


--- LOOKING AT COUNTRIES WITH THE HIGHEST INFECTION RATE COMPARE TO POPULATION

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentagePopulationInfected
FROM DAPortfolioProject..CovidDeaths
-- WHERE location LIKE '%States%'
WHERE continent IS NOT NULL
GROUP BY location, population
order by PercentagePopulationInfected DESC


--LOOKING AT COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION

SELECT location, MAX(cast(total_deaths as int))  AS TotalDeathsCount
FROM DAPortfolioProject..CovidDeaths
-- WHERE location LIKE '%States%
WHERE continent IS NOT NULL
GROUP BY location 
order by TotalDeathsCount DESC


--- BREAKING IT DOWN TO CONTINENT 

SELECT continent, MAX(cast(total_deaths as int))  AS TotalDeathsCount
FROM DAPortfolioProject..CovidDeaths

WHERE continent IS NOT NULL
GROUP BY continent 
order by TotalDeathsCount DESC
