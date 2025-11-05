-- https://www.hackerrank.com/challenges/the-company/problem?isFullScreen=true

SET NOCOUNT ON;
/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
select distinct c.company_code, c.founder, count(distinct lm.lead_manager_code),
count(distinct sm.senior_manager_code), count(distinct m.manager_code),
count(distinct e.employee_code)
from Company c left join
Lead_Manager lm on c.company_code = lm.company_code left join
Senior_Manager sm on lm.lead_manager_code = sm.lead_manager_code left join
Manager m on sm.senior_manager_code = m.senior_manager_code left join
Employee e on m.manager_code = e.manager_code
group by c.company_code, c.founder
order by c.company_code



go