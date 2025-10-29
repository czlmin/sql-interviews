-- https://www.hackerrank.com/challenges/draw-the-triangle-1/problem?isFullScreen=true

with trig as (
    select 20 as n
    union all
    select n - 1
    from trig
    where n > 1
)
select replicate('* ', n)
from trig
order by n DESC