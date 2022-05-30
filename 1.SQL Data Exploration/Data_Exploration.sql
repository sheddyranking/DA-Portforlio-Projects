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
--WHERE location LIKE '%States%
WHERE continent IS NOT NULL 
GROUP BY location 
order by TotalDeathsCount DESC


--- BREAKING IT DOWN TO CONTINENT 

---- Showing the Continent with the Highest DeathCount per Population

SELECT continent, MAX(cast(total_deaths as int))  AS TotalDeathsCount
FROM DAPortfolioProject..CovidDeaths

WHERE continent IS NOT NULL
GROUP BY continent 
order by TotalDeathsCount DESC


--- GLOBAL NUMBERING 

SELECT  date, SUM(new_cases) AS Total_cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS DeathPercentage

FROM DAPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2


--- GLOBAL TOTAL NUMBER

SELECT SUM(new_cases) AS Total_cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS DeathPercentage

FROM DAPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2



-- PERFORMING JOIN WITH VACCINATION TABLE ON THE BASE OF (location and date)

SELECT * 
FROM DAPortfolioProject..CovidDeaths dea
JOIN DAPortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date


-- LOOKING AT TOTAL POPULATIONS VS VACCINATIONS

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations

FROM DAPortfolioProject..CovidDeaths dea
JOIN DAPortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3


---CREATING NEW_VACCINATION COUNT COLUMNS(RollingPeopleVaccinated)

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated --CREATING NEW_VACCINATION COUNT COLUMN

FROM DAPortfolioProject..CovidDeaths dea
JOIN DAPortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

-- CREATING A CTE(Common Table Expression), So we can use created RollingPeopleVaccinated Column do other Calculations.

WITH PopvsVac (continent, location, date, population, new_vaccination, RollingPeopleVaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated --CREATING NEW_VACCINATION COUNT COLUMN

FROM DAPortfolioProject..CovidDeaths dea
JOIN DAPortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *,  (RollingPeopleVaccinated/population)*100  --- NOW MAKING CALCULATOINS WITH RollingPeopleVaccinated Column to Know Per% Polulation Vaccinated by Country.
FROM PopvsVac  --Highlight the Whole Query and Execute



 

