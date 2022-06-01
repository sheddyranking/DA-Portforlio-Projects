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
 
CREATE VIEW DeathPercentage as --Create View to store query in table 
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM DAPortfolioProject..CovidDeaths
WHERE location LIKE '%States%' and  continent IS NOT NULL
--order by 1,2
 



--- LOOKING AT TOTAL CASES VS POPULATIONS 
--- Shows the Percentage of those who got Covid

SELECT location, date, population, total_cases, (total_cases/population)*100 AS   PercentagePopulationInfected
FROM DAPortfolioProject..CovidDeaths
-- WHERE location LIKE '%States%'
WHERE continent IS NOT NULL
order by 1,2

CREATE VIEW PercentagePopulationInfected as --Creating view
SELECT location, date, population, total_cases, (total_cases/population)*100 AS   PercentagePopulationInfected
FROM DAPortfolioProject..CovidDeaths
-- WHERE location LIKE '%States%'
WHERE continent IS NOT NULL
--order by 1,2





--- LOOKING AT COUNTRIES WITH THE HIGHEST INFECTION RATE COMPARE TO POPULATION

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS CountriesPercentInfected
FROM DAPortfolioProject..CovidDeaths
-- WHERE location LIKE '%States%'
WHERE continent IS NOT NULL
GROUP BY location, population
order by CountriesPercentInfected DESC

CREATE VIEW CountriesPercentInfected  as --Creating View
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS CountriesPercentInfected
FROM DAPortfolioProject..CovidDeaths
-- WHERE location LIKE '%States%'
WHERE continent IS NOT NULL
GROUP BY location, population
--order by CountriesPercentInfected DESC

 


--LOOKING AT COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION

SELECT location, MAX(cast(total_deaths as int))  AS TotalDeathsCount
FROM DAPortfolioProject..CovidDeaths
--WHERE location LIKE '%States%
WHERE continent IS NOT NULL 
GROUP BY location 
order by TotalDeathsCount DESC

CREATE VIEW TotalDeathsCount as --Creating view 
SELECT location, MAX(cast(total_deaths as int))  AS TotalDeathsCount
FROM DAPortfolioProject..CovidDeaths
--WHERE location LIKE '%States%
WHERE continent IS NOT NULL 
GROUP BY location 
--order by TotalDeathsCount DESC




--- BREAKING IT DOWN TO CONTINENT 

---- Showing the Continent with the Highest DeathCount per Population

SELECT continent, MAX(cast(total_deaths as int))  AS TotalDeathsCountPerContinent
FROM DAPortfolioProject..CovidDeaths

WHERE continent IS NOT NULL
GROUP BY continent 
order by TotalDeathsCountPerContinent DESC

CREATE VIEW TotalDeathsCountPerContinent as -- Creating view
SELECT continent, MAX(cast(total_deaths as int))  AS TotalDeathsCountPerContinent
FROM DAPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent 
--order by TotalDeathsCountPerContinent DESC

 


--- GLOBAL NUMBERING 

SELECT  date, SUM(new_cases) AS Total_cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS GlobalNumbering

FROM DAPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2

CREATE VIEW  GlobalNumbering as 
SELECT  date, SUM(new_cases) AS Total_cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS GlobalNumbering

FROM DAPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
--ORDER BY 1,2



--- GLOBAL TOTAL NUMBER

SELECT SUM(new_cases) AS Total_cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS TotalGlobalNumbering

FROM DAPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
--GROUP BY date
--ORDER BY 1,2

CREATE VIEW TotalGlobalNumbering as 
SELECT SUM(new_cases) AS Total_cases, SUM(cast(new_deaths as int)) as Total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS TotalGlobalNumbering
FROM DAPortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
--GROUP BY date
--ORDER BY 1,2



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

CREATE VIEW TotalPopulationVsVaccinated as  --Creating View
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations

FROM DAPortfolioProject..CovidDeaths dea
JOIN DAPortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

 


---CREATING NEW_VACCINATION COUNT COLUMNS(RollingPeopleVaccinated)

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated --CREATING NEW_VACCINATION COUNT COLUMN

FROM DAPortfolioProject..CovidDeaths dea
JOIN DAPortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

CREATE VIEW RollingPeopleVaccinated as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated --CREATING NEW_VACCINATION COUNT COLUMN

FROM DAPortfolioProject..CovidDeaths dea
JOIN DAPortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3



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
SELECT *,  (RollingPeopleVaccinated/population)*100 AS RPVcalculate  --- NOW MAKING CALCULATOINS WITH RollingPeopleVaccinated Column to Know Per% Polulation Vaccinated by Country.
FROM PopvsVac  --Highlight the Whole Query and Execute


-- TEMP TABLE
DROP TABLE if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated --CREATING NEW_VACCINATION COUNT COLUMN

FROM DAPortfolioProject..CovidDeaths dea
JOIN DAPortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
--WHERE dea.continent IS NOT NULL

SELECT *,  (RollingPeopleVaccinated/population)*100 AS  RVPTempTableCalculate
FROM #PercentPopulationVaccinated



-- CREATING VIEWS  FOR DATA VISUALIZATIONS 

CREATE VIEW PercentPopulationVaccinated as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(cast(vac.new_vaccinations as int)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated 

FROM DAPortfolioProject..CovidDeaths dea
JOIN DAPortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

--- YOU CAN SELECT THE VIEWS BECAUSE IT IS NOW A TABLE THAT HAS BEEN CREATED 

SELECT *
FROM PercentPopulationVaccinated
