-- https://www.hackerrank.com/challenges/print-prime-numbers/problem?isFullScreen=true

SET NOCOUNT ON;

/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
declare @n as int = 1000;
declare @i as int = 2;
declare @is_prime as int = 1;
declare @j as int;

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[primes]') AND type in (N'U'))
DROP TABLE [dbo].[primes]
create table primes(prime_number int)
while @i <= @n
begin
    set @is_prime = 1
    set @j = 2
    while @j < @i
    begin
        if @i % @j = 0
        begin
            set @is_prime = 0
            break
        end
        set @j = @j + 1
    end
    if @is_prime = 1
    begin
        insert into primes(prime_number)
        values(@i)
    end
    set @i = @i + 1
end

select string_agg(prime_number, '&') as prime_numbers 
from primes

go