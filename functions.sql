create type body account_t as map member function getAge
return integer
is
begin
return extract(year from sysdate) - extract(year from self.d_of_b);
end;
member function getFullName
return varchar
is
begin
return self.fname||' '||self.lname;
end;
end;
/

create type body employee_t as member function getSalary
return number
is
begin
return self.salary;
end;
end;
/

create type body salesperson_t as overriding member function getSalary 
return number
is
begin
return (self.rate * self.hours) + self.commission;
end;
end;
/

create type body address_t as member function getFullAddress
return varchar
is
begin
return self.street||', '||self.city||', '||self.province||' '||self.postalcode;
end;
end;
/

create type body product_t as order member function compareProfit(p product_t)
return integer
is 
begin
if (self.price - self.cost < p.price - p.cost) then
return -1;
elsif (self.price - self.cost > p.price - p.cost) then
return 1;
else
return 0;
end if;
end;
end;
/