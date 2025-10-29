-- https://www.hackerrank.com/challenges/draw-the-triangle-2/problem?isFullScreen=true

with nums as
    (
        select 1 as n
        union all
        select n+1
        from nums
        where n < 20
    )
select replicate('* ', n)
from nums
order by n
