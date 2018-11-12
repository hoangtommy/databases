#SECTION 4, Nested SELECT
# 1. Bigger than Russia
SELECT name FROM world
  WHERE population > 
     (SELECT population FROM world
      WHERE name='Russia');

# 2. Richer than UK
SELECT name FROM world WHERE continent = 'Europe' AND gdp/population > 
(SELECT gdp/population FROM world WHERE name = 'United Kingdom');

# 3. Neighbors of Argentina and Australia
SELECT name, continent
FROM world
WHERE continent IN (
  SELECT continent
  FROM world
  WHERE name IN ('Argentina', 'Australia')
)
ORDER BY name;

# 4. Between Canada & Poland
SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland');;

# 5. Percentages of Germany
SELECT name, CONCAT(ROUND(population / (SELECT population FROM world WHERE name = 'Germany') * 100), '%')
FROM world
WHERE continent = 'Europe';