# SECTION 5 - AGGREGATEs
# 5. Baltic states population
SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

# 6. Counting countries of each continent
SELECT continent, COUNT(name) AS total_countries
FROM world
GROUP BY continent;

# 7. Counting big countries in each continent
SELECT continent, COUNT(name)
FROM world
WHERE population >= 10000000
GROUP BY continent;

# 8. counting big continents
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;