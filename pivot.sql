-- https://www.hackerrank.com/challenges/occupations/problem?isFullScreen=true

WITH numbered AS (
  SELECT Name, Occupation,
         ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn
  FROM OCCUPATIONS
)
SELECT [Doctor],[Professor],[Singer],[Actor]
FROM numbered
PIVOT ( MAX(Name) FOR Occupation IN ([Doctor],[Professor],[Singer],[Actor]) ) p
ORDER BY rn;

WITH numbered AS (
  SELECT Name, Occupation,
         ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn
  FROM OCCUPATIONS
)
SELECT
  MAX(CASE WHEN Occupation='Doctor'    THEN Name END) AS Doctor,
  MAX(CASE WHEN Occupation='Professor' THEN Name END) AS Professor,
  MAX(CASE WHEN Occupation='Singer'    THEN Name END) AS Singer,
  MAX(CASE WHEN Occupation='Actor'     THEN Name END) AS Actor
FROM numbered
GROUP BY rn
ORDER BY rn;
