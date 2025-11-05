-- https://www.hackerrank.com/challenges/interviews/problem?isFullScreen=true

SET NOCOUNT ON;

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

with vs as (select s.challenge_id, sum(total_views) as total_views, sum(total_unique_views) as total_unique_views from view_stats s 
group by s.challenge_id),
ss as (select s.challenge_id, sum(total_submissions) as total_submissions, sum(total_accepted_submissions) as total_accepted_submissions from submission_stats s
group by s.challenge_id)
select c.contest_id, c.hacker_id, c.name, coalesce(sum(ss.total_submissions), 0) as total_submissions,  coalesce(sum(ss.total_accepted_submissions), 0) as total_accepted_submissions, coalesce(sum(vs.total_views), 0) as total_views, coalesce(sum(total_unique_views), 0) as total_unique_views
from contests c 
left join colleges col on c.contest_id = col.contest_id 
left join challenges cha on col.college_id = cha.college_id 
left join vs on cha.challenge_id = vs.challenge_id 
left join ss on cha.challenge_id = ss.challenge_id 
group by c.contest_id, c.hacker_id, c.name 
having (coalesce(sum(ss.total_submissions), 0) + coalesce(sum(ss.total_accepted_submissions), 0) + 
coalesce(sum(vs.total_views), 0) + coalesce(sum(total_unique_views), 0) )> 0 
order by c.contest_id 




go