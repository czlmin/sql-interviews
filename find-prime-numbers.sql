declare @n as int = 100;
declare @i as int
declare @is_prime = 1
declare @j as int

create table primes(prime_number int)
while @i <= @n
begin
    @is_prime = 1
    while @j < @i
    begin
        if @i % @j = 0
        begin
            @is_prime = 0
            break
        end
    end
    if @is_prime
    begin
        insert into primes(prime_number)
        values(@i)
    end
end

