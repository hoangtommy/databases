# SELCT Section 0
# 1. Grab Germany's population
SELECT population FROM world  WHERE name = 'Germany';

# 2. The keyword IN
SELECT name, population FROM world WHERE name IN ('Sweden', 'Norway');

# 3. Between things
SELECT name, area FROM world WHERE area BETWEEN 200000 AND 250000;

# SELECT Section 3
# 3. Per capita
SELECT name, gdp/population FROM world WHERE population > 200000000;

# 5. IN keyword
SELECT name, population FROM world WHERE name IN ('France', 'Germany', 'Italy');

# 7. OR
SELECT name, population, area
FROM world
WHERE population > 250000000 OR area > 3000000;

# 8. Either or not not both aka XOR
SELECT name, population, area
FROM world
WHERE population > 250000000 XOR area > 3000000;

# 9. Round to two decimal places using ROUND
SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2)
FROM world
WHERE continent = 'South America';

# 10. Round to closest 1000 whole number
SELECT name, ROUND((gdp/population), -3) AS per_capita
FROM world
WHERE gdp > 1000000000000;

# 11. Length of a text
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);

# 12. Matching one letter using LEFT
SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1) AND name <> capital;

# 13. Selecting name with all the vowels but no space
SELECT name
FROM world
WHERE name LIKE '%a%'
  AND name LIKE '%e%'
  AND name LIKE '%i%'
  AND name LIKE '%o%'
  AND name LIKE '%u%'
  AND name NOT LIKE '% %';



