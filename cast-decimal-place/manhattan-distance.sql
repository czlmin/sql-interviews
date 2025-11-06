-- https://www.hackerrank.com/challenges/weather-observation-station-18/problem?isFullScreen=true

SET NOCOUNT ON;

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

select cast(abs(max(lat_n) - min(lat_n)) + abs(max(long_w) - min(long_w)) as numeric(19, 4)) as distance from Station
-- result is 259.6859

-- below is not right
select round(abs(max(lat_n) - min(lat_n)) + abs(max(long_w) - min(long_w)) 4) as distance from Station
-- result is 259.68590000
go
