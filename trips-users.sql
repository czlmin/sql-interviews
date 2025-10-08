/* Write your T-SQL query statement below */
with unbanned_requests as 
(
    select t.request_at, count(*) as unbanned_count 
    from Trips t 
    join Users c on t.client_id = c.users_id 
    join Users d on t.driver_id = d.users_id 
    where c.banned = 'No' and d.banned = 'No' 
    group by t.request_at 
),
cancelled_unbanned_requests as 
(
    select t.request_at, count(*) as cancelled_unbanned_count 
    from Trips t 
    join Users c on t.client_id = c.users_id 
    join Users d on t.driver_id = d.users_id 
    where c.banned = 'No' and d.banned = 'No' and t.status like '%cancelled%'
    group by t.request_at 
)
select tr.request_at as Day, round(cast(isnull(cancelled_unbanned_count, 0) as decimal(10,0))/unbanned_count, 2) as [Cancellation Rate] 
from unbanned_requests tr 
left join cancelled_unbanned_requests ur 
on tr.request_at = ur.request_at
where tr.request_at between '2013-10-01' and '2013-10-03'