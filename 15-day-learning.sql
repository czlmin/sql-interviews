-- https://www.hackerrank.com/challenges/15-days-of-learning-sql/problem?isFullScreen=true

SET NOCOUNT ON;

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

-- Calendar: 2016-03-01 .. 2016-03-15


with everyday_submission as 
(
    select hacker_id, submission_date, count(*) as submission_count
    from Submissions 
    where submission_date between '2016-03-01' and '2016-03-15'
    group by hacker_id, submission_date 
),
everyday_max_submission as 
(
    select hacker_id, submission_date, 
    row_number() over (partition by submission_date order by submission_count desc, hacker_id) as rn from everyday_submission 
),
dates as 
(
    select cast('2016-03-01' as date) as dt 
    union all 
    select dateadd(day, 1, dt)  
    from dates 
    where dt < cast('2016-03-15' as date)
),
active_submission as 
(
    select dt, count(*) as total_active from dates as d
    cross apply (
        select hacker_id from Submissions 
        where submission_date between '2016-03-01' and d.dt
        group by hacker_id 
        having count(distinct submission_date) = datediff(day, '2016-03-01', d.dt) + 1
    ) as count_submission 
    group by d.dt 
)
select ems.submission_date, isnull(ac.total_active, 0) as total_active, ems.hacker_id, h.name from 
dates d left join 
active_submission ac on d.dt = ac.dt left join 
everyday_max_submission ems 
on ems.submission_date = ac.dt and ems.rn = 1
left join hackers h 
on ems.hacker_id = h.hacker_id
order by ems.submission_date



go