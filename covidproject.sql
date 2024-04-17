select *
from PortfolioProject.dbo.CovidDeaths
WHERE continent IS NULL


--select data that will be used

SELECT location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject.dbo.CovidDeaths
order by 1,2

--total cases vs total death data filtered by country

SELECT location, date, total_cases, total_deaths, ROUND((total_deaths/total_cases)*100, 2) as DeathPercentage
from PortfolioProject.dbo.CovidDeaths
where location = 'Malaysia'
order by 1,2

-- total cases vs population 

SELECT location, date, total_cases, population, ROUND((total_cases/population)*100, 2) as CasesPercentage
from PortfolioProject.dbo.CovidDeaths
where location = 'Malaysia'
order by 1,2

--Countries with highest covid cases rate compared to population

SELECT LOCATION, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as HighestInfectionPerc
from PortfolioProject.dbo.CovidDeaths
GROUP BY LOCATION, population
ORDER BY HighestInfectionPerc DESC

--Countries with highest death count 

SELECT LOCATION, MAX(cast(total_deaths as INT)) as TotalDeathCount
from PortfolioProject.dbo.CovidDeaths
WHERE continent is NOT NULL
GROUP BY LOCATION
ORDER BY TotalDeathCount DESC

--Continent with highest death count 

SELECT location, MAX(cast(total_deaths as INT)) as TotalDeathCount
from PortfolioProject.dbo.CovidDeaths
WHERE continent is NULL
GROUP BY location
ORDER BY TotalDeathCount DESC


--Global numbers new cases, new deaths

SELECT DATE, sum(new_cases)as DailyCases, sum(cast(new_deaths as INT)) as DailyDeaths
from PortfolioProject.dbo.CovidDeaths
WHERE continent is NULL
GROUP BY DATE
ORDER BY DATE

--Global numbers new cases, new deaths, new death percentage

SELECT DATE, sum(new_cases)as DailyCases, sum(cast(new_deaths as INT)) as DailyDeaths, sum(cast(new_deaths as INT))/NULLIF(sum(new_cases),0)*100 as DeathPercentage
from PortfolioProject.dbo.CovidDeaths
WHERE continent is NULL
GROUP BY DATE
ORDER BY DATE

-- Join CovidDeaths and CovidVaccinations tables

SELECT *
FROM PortfolioProject.dbo.CovidDeaths dea
JOIN PortfolioProject.dbo.CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date

-- Total vaccinations by location

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations as INT)) OVER (PARTITION BY dea.location order by dea.location, dea.date)  as Total_Vacc
FROM PortfolioProject.dbo.CovidDeaths dea
JOIN PortfolioProject.dbo.CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is  NOT NULL
ORDER BY 2,3

	     
-- Total population vs vaccinations using CTE


WITH PopvsVac (Continent, Location, Date,  population, new_vaccinations, Total_Vacc)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations as INT)) OVER (PARTITION BY dea.location order by dea.location, dea.date)  as Total_Vacc
FROM PortfolioProject.dbo.CovidDeaths dea
JOIN PortfolioProject.dbo.CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is  NOT NULL
)

SELECT *, (Total_Vacc/ population)*100
FROM PopvsVac


-- Total population vs vaccinations using Temp tables

drop table if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
population numeric,
new_vaccinations numeric,
Total_Vacc numeric
) 

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations as INT)) OVER (PARTITION BY dea.location order by dea.location, dea.date)  as Total_Vacc
FROM PortfolioProject.dbo.CovidDeaths dea
JOIN PortfolioProject.dbo.CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is  NOT NULL

SELECT *, (Total_Vacc/ population)*100 as TotalVacPerc
FROM #PercentPopulationVaccinated

--Create views for later visualizations

CREATE VIEW PercentPopulationVaccinatedVIEW AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations as INT)) OVER (PARTITION BY dea.location order by dea.location, dea.date)  as Total_Vacc
FROM PortfolioProject.dbo.CovidDeaths dea
JOIN PortfolioProject.dbo.CovidVaccinations vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is  NOT NULL

