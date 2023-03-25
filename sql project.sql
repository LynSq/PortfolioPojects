---Datasets I will be using
SELECT * 
FROM project..countries

SELECT * 
FROM project..economies

--Showing how many distinct rows there are
SELECT DISTINCT COUNT(*)
FROM project..countries

--Showing African and Asian countries government forms
SELECT country_name, gov_form
FROM project..countries
WHERE (continent = 'Africa') OR (continent = 'Asia')
ORDER BY country_name

--Showing data only for countries that have c in there name
SELECT *
FROM project..countries
WHERE country_name LIKE '%C%'
--No c's 
SELECT *
FROM project..countries
WHERE country_name NOT LIKE '%C%'

--Showing which country had independence for the longest time
SELECT country_name, indep_year 
FROM project..countries
WHERE indep_year IS NOT NULL
ORDER BY indep_year

-- Showing which country has the highest and lowest surface area
SELECT country_name, surface_area
FROM project..countries
ORDER BY surface_area desc
--- lowest
SELECT country_name, surface_area
FROM project..countries
ORDER BY surface_area

--AVG surface area for a country
SELECT round(avg(surface_area), 1) as avg_surf
FROM project..countries

-- Categorizing countries based on their surface area
SELECT country_name, gov_form, e.imports, e.exports, e.inflation_rate, surface_area,
CASE WHEN surface_area > 1000000 THEN  'Huge surface'
WHEN surface_area < 100000 THEN  'Small surface'
ELSE 'Average surface'
END AS surface_area_categories
FROM project..countries c 
LEFT JOIN project..economies e
ON c.code = e.code
ORDER BY e.imports DESC

--Showing the total of imports per continent
SELECT DISTINCT continent, SUM(e.imports) as 'total imports per con'
FROM project..countries c 
LEFT JOIN project..economies e
ON c.code = e.code
GROUP BY continent
ORDER BY 'total imports per con' DESC


--Creating a cte 
WITH variable (country_name, gov_form, imports, exports, inflation_rate, surface_area, inflation_rank, year)
AS
(
SELECT country_name, gov_form, e.imports, e.exports, e.inflation_rate, surface_area,
CASE WHEN inflation_rate < 15.0 THEN  'Avg inflation'
WHEN inflation_rate > 30.0 THEN  'High inflation'
ELSE 'Kind of high inflation'
END AS inflation_rank,
e.year
FROM project..countries c 
LEFT JOIN project..economies e
ON c.code = e.code
WHERE inflation_rate IS NOT NULL
)
SELECT *
FROM variable
ORDER BY inflation_rate DESC

-- Creating a table
DROP TABLE IF EXISTS #HighestInflatedCountry
CREATE TABLE #HighestInflatedCountry
( 
country_name VARCHAR(255),
gov_form VARCHAR(255),
imports FLOAT,
exports FLOAT,
inflation_rate FLOAT,
surface_area numeric,
inflation_rank VARCHAR(255),
year numeric
)
INSERT INTO #HighestInflatedCountry
SELECT country_name, gov_form, e.imports, e.exports, e.inflation_rate, surface_area,
CASE WHEN inflation_rate < 15.0 THEN  'Avg inflation'
WHEN inflation_rate > 30.0 THEN  'High inflation'
ELSE 'Kind of high inflation'
END AS inflation_rank,
e.year
FROM project..countries c 
LEFT JOIN project..economies e
ON c.code = e.code
WHERE inflation_rate IS NOT NULL
ORDER BY inflation_rank DESC

SELECT *
FROM #HighestInflatedCountry

--Making a view
Create View HighestInflatedCountry as 
SELECT country_name, gov_form, e.imports, e.exports, e.inflation_rate, surface_area,
CASE WHEN inflation_rate < 15.0 THEN  'Avg inflation'
WHEN inflation_rate > 30.0 THEN  'High inflation'
ELSE 'Kind of high inflation'
END AS inflation_rank,
e.year
FROM project..countries c 
LEFT JOIN project..economies e
ON c.code = e.code
WHERE e.inflation_rate IS NOT NULL
--ORDER BY inflation_rank DESC

