/* Write your T-SQL query statement below */
with greater_100 as 
(
    select * from Stadium 
    where people >= 100 
),
rank_greater_100 as 
(
    select *, row_number() over (order by id) as rn from greater_100 
),
group_greater_100 as 
(
    select id-rn as diff, count(id-rn) as consec_count from rank_greater_100 
    group by id-rn 
    having count(id-rn) >= 3 
)
select s.id, s.visit_date, s.people from group_greater_100 g 
join rank_greater_100 s on g.diff = s.id - s.rn 
order by visit_date 