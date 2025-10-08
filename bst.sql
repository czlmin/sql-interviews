-- https://www.hackerrank.com/challenges/binary-search-tree-1/problem?isFullScreen=true

SET NOCOUNT ON;

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/

select distinct a.N, case when b.P is null then 'Leaf' when a.P is null then 'Root' 
else 'Inner' end from BST a left join BST b on a.N = b.P 

go
