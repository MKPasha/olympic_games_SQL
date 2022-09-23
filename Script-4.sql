/*SELECT * FROM athletes LIMIT 30;
SELECT * FROM winter_games wg  
LIMIT 30;

--- union summer and winter games
SELECT athlete_id, gold
FROM summer_games sg 
UNION ALL
SELECT athlete_id, gold
FROM winter_games wg 
LIMIT 55;

--- to reach our solution, we did an UNION operation first and now we are going to JOIN the tables
--- UNION in subquery
SELECT athlete_id, gender, age, gold
FROM(
     SELECT athlete_id, gold
     FROM summer_games sg
     UNION ALL
     SELECT athlete_id, gold
     FROM winter_games wg ) AS c
INNER JOIN athletes AS a
ON c.athlete_id = a.id 
LIMIT 20; */

/*JOIN first, UNION second
SELECT athlete_id, gender, age, gold
FROM summer_games sg 
INNER JOIN athletes a 
ON a.id = sg.athlete_id
UNION ALL 
SELECT athlete_id, gender, age, gold 
FROM winter_games wg 
INNER JOIN athletes AS a 
ON a.id = wg.athlete_id
LIMIT 20;*/
----Gold Medals by Demographic Group (Western Europen Regions only)
SELECT 'Summer' AS SESSION , CASE WHEN a.age >= 13
AND a.age <= 25
AND a.gender = 'M' THEN 'Male Age 13-25'
WHEN a.age > 25
AND a.gender = 'M' THEN 'Male Age 25+'
WHEN a.age >= 13
AND a.age <= 25
AND a.gender = 'F' THEN 'Female Age 13-25'
WHEN a.age > 25
AND a.gender = 'F' THEN 'Female Age 25+'
 END AS demographic_group, SUM(sg.gold)AS golds
FROM summer_games sg
INNER JOIN athletes a 
ON
a.id = sg.athlete_id
----- where clause 
INNER JOIN countries AS c 
ON
sg.country_id = c.id
WHERE region = 'WESTERN EUROPE'
GROUP BY demographic_group
UNION ALL

--- now add for winter games
SELECT 'Winter' AS SESSION , CASE WHEN a.age >= 13
AND a.age <= 25
AND a.gender = 'M' THEN 'Male Age 13-25'
WHEN a.age > 25
AND a.gender = 'M' THEN 'Male Age 25+'
WHEN a.age >= 13
AND a.age <= 25
AND a.gender = 'F' THEN 'Female Age 13-25'
WHEN a.age > 25
AND a.gender = 'F' THEN 'Female Age 25+'
 END AS demographic_group, SUM(wg.gold)AS golds
FROM winter_games wg
INNER JOIN athletes a 
ON
a.id = wg.athlete_id
----- where clause 
WHERE country_id IN(
       SELECT id
       FROM countries
       WHERE region = 'WESTERN EUROPE')
GROUP BY demographic_group
ORDER BY golds DESC;

--- Top Athletes in Nobel Prized Countries By Gender
SELECT EVENT AS EVENT, CASE WHEN EVENT LIKE '%Women%' THEN 'Female'
ELSE 'Male' END AS Gender, count (DISTINCT athlete_id) AS Athletes
FROM summer_games sg
WHERE country_id IN
     (SELECT country_id
FROM country_stats cs
WHERE nobel_prize_winners >0 )
GROUP BY EVENT
UNION ALL
SELECT EVENT AS EVENT, CASE WHEN EVENT LIKE '%Women%' THEN 'Female'
ELSE 'Male' END AS Gender, count (DISTINCT athlete_id) AS Athletes
FROM winter_games wg
WHERE country_id IN
     (SELECT country_id
FROM country_stats cs
WHERE nobel_prize_winners >0 )
GROUP BY EVENT
ORDER BY athletes DESC
LIMIT 10;

---chapter three
/*
SELECT column_name, data_type
FROM information_schema.COLUMNS 
WHERE table_name = 'country_stats';

SELECT YEAR,date_part('decade', CAST(YEAR AS DATE)) AS decade,date_trunc('decade', CAST(YEAR AS DATE)) AS decade_truncated, SUM(gdp) AS world_gdp
FROM country_stats
GROUP BY YEAR
ORDER BY YEAR DESC; */

SELECT country, substring(country FROM 7) AS country_altered
FROM countries
GROUP BY country;





