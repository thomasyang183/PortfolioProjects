-- Create Excel tables for tableau public
-- 1. Stats on cases VS. deaths worldwide

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
(CAST(SUM(new_deaths) AS FLOAT) / CAST(SUM(new_cases) AS FLOAT)) * 100 AS death_percentage
FROM CovidDeaths
WHERE continent is NOT NULL

-- 2. Using the drill down approach, we are exploring the total cases VS. deaths by regions

SELECT continent, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
(CAST(SUM(new_deaths) AS FLOAT) / CAST(SUM(new_cases) AS FLOAT)) * 100 AS death_percentage
FROM CovidDeaths
WHERE continent is NOT NULL
GROUP BY continent
ORDER BY death_percentage DESC


-- 3. By location. Make sure to address the NULL values before uploadding to Tableau Public

SELECT location, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
(CAST(SUM(new_deaths) AS FLOAT) / CAST(SUM(new_cases) AS FLOAT)) * 100 AS death_percentage
FROM CovidDeaths
WHERE continent is NOT NULL
GROUP BY location
ORDER BY death_percentage DESC


-- 4. By location, but instead of aggregate values. We will look at each of their daily stats by location

SELECT location, population, date, MAX(new_cases) AS highest_infection, 
MAX(CAST(total_cases AS FLOAT)/CAST(population AS FLOAT)) * 100 AS percentage_population_infected
FROM CovidDeaths
WHERE continent is NOT NULL
GROUP BY location, population, date
ORDER BY location, population, date DESC
