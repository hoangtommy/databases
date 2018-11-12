# 1. Show all goals from germany
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER';

# 2. Info from a game
SELECT id,stadium,team1,team2
  FROM game
  WHERE id = 1012;

# 3. show the player, teamid, stadium and mdate for every German goal.
SELECT player, teamid, stadium, mdate
  FROM game 
  JOIN goal 
    ON (game.id = goal.matchid)
  WHERE goal.teamid = 'GER';

# 4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
  FROM game
  JOIN goal
SELECT team1, team2, player
    ON (game.id = goal.matchid)
  WHERE goal.player LIKE 'Mario%';

# 5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
  FROM goal
  JOIN eteam
  ON (goal.teamid = eteam.id)
 WHERE goal.gtime <= 10;

# 6. List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname
  FROM game
  JOIN eteam
    ON (game.team1 = eteam.id)
WHERE coach = 'Fernando Santos';

# 7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player
  FROM game
  JOIN goal
    ON (game.id = goal.matchid)
WHERE stadium = 'National Stadium, Warsaw';

# 8. Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT player
  FROM game
  JOIN goal
    ON (game.id = goal.matchid)
  WHERE (team1 = 'GER' OR team2 = 'GER') AND goal.teamid != 'GER';

# 9. Show teamname and the total number of goals scored.
SELECT teamname, COUNT(goal.teamid) AS total_goals
  FROM eteam JOIN goal ON eteam.id = goal.teamid
  GROUP BY teamname;

# 10. Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(stadium) as goals
  FROM game JOIN goal ON (game.id = goal.matchid)
  GROUP BY stadium;

# 11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, COUNT(game.id) AS total_goals
  FROM game 
  JOIN goal 
    ON (game.id = goal.matchid)
  WHERE (game.team1 = 'POL' OR game.team2 = 'POL')
  GROUP BY matchid, mdate;

# 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(goal.teamid) AS goals_by_GER
  FROM game
  JOIN goal
    ON game.id = goal.matchid
WHERE goal.teamid = 'GER'
GROUP BY matchid, mdate;

# 13. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
SELECT mdate, team1, SUM(scoreOne) AS score1, team2, SUM(scoreTwo) AS score2
  FROM (SELECT mdate,team1, matchid, id,
      CASE WHEN teamid=team1 THEN 1 ELSE 0 END scoreOne,
      team2,
      CASE WHEN teamid=team2 THEN 1 ELSE 0 END scoreTwo
      FROM game LEFT JOIN goal ON matchid = id) as temp
  GROUP BY mdate, matchid;