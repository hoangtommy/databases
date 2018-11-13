# 1. How many stops are in the database
SELECT COUNT(name)
  FROM stops;

# 2.Find the id value for the stop 'Craiglockhart'
SELECT id
FROM stops
WHERE name = 'Craiglockhart';

# 3. Give the id and the name for the stops on the '4' 'LRT' service.
SELECT id, name
  FROM stops
  INNER JOIN route
  ON stops.id = route.stop
WHERE route.num = '4';

# 4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). 
	# Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING num = 4 OR num = 45;

# 5. Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. 
	#Change the query so that it shows the services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = 149;

# 6. Stops by name using double self joins
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road';

# 7. Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT a.company, a.num
  FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
  WHERE (a.stop = 115 AND b.stop = 137)
    OR (a.stop = 137 AND b.stop = 115);

# 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT DISTINCT a.company, a.num
  FROM route a JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopA ON (a.stop = stopA.id)
  JOIN stops stopB ON (b.stop = stopB.id)
WHERE (stopA.name = 'Craiglockhart' AND stopB.name = 'Tollcross')
  OR (stopA.name = 'Tollcross' AND stopB.name = 'Craiglockhart');

# 9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, 
     #including 'Craiglockhart' itself, offered by the LRT company. 
     # Include the company and bus no. of the relevant services.
SELECT DISTINCT stopB.name, a.company, a.num
FROM route a JOIN route b ON 
  (a.company = b.company AND a.num = b.num)
  JOIN stops stopA ON (a.stop = stopA.id)
  JOIN stops stopB ON (b.stop = stopB.id)
WHERE (stopA.name = 'Craiglockhart');

# 10. Find the routes involving two buses that can go from Craiglockhart to Sighthill. 
-- Show the bus no. and company for the first bus, the name of the stop for the transfer,
-- and the bus no. and company for the second bus.
# TIP: find all buses that go to/fr Craiglockhart. Then all the buses that go to/fr Sightill

# buses that go to and from Craiglockhart
SELECT DISTINCT a.num, stopa.name
FROM route a JOIN route b ON (a.num = b.num AND a.company = b.company)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE (stopb.name = 'Craiglockhart');

#buses that go to Sighthill
SELECT DISTINCT a.num, stopa.name
FROM route a JOIN route b ON (a.num = b.num AND a.company = b.company)
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE (stopb.name = 'Sighthill');

# My solution (not correct)
SELECT DISTINCT craig.num, craig.company, craig.name, sight.num, sight.company
FROM (SELECT DISTINCT stopa.name, a.company, a.num
              FROM route a JOIN route b ON (a.num = b.num AND a.company = b.company)
             JOIN stops stopa ON (a.stop = stopa.id)
             JOIN stops stopb ON (b.stop = stopb.id)
             WHERE (stopb.name = 'Craiglockhart')
           ) AS craig
JOIN (SELECT DISTINCT stopa.name, a.company, a.num
             FROM route a JOIN route b ON (a.num = b.num AND a.company = b.company)
            JOIN stops stopa ON (a.stop = stopa.id)
            JOIN stops stopb ON (b.stop = stopb.id)
            WHERE (stopb.name = 'Sighthill')
            ORDER BY num DESC
          ) AS sight
ON sight.name = craig.name;

