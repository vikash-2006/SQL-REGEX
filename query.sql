-- use world;
-- show tables; 
-- select * from country;
-- select name, continent from country where region != 'South Europe';
-- select name, continent, population, population+(population*0.1) from country;
-- select * from country where lifeExpectancy in (75.1,74.4)
-- use world;
-- SELECT name, population, region
-- FROM country
-- WHERE population NOT BETWEEN 5000 AND 300000;

-- ****************************************************************************************-- 
-- like operator
-- match a pattern

-- name -> letter start ,letter include, letter end
-- % : special character
-- 'A'
-- % : zero or more character

-- _ (underscore) : only 1 character

-- select * from country where name not like '%r%';

-- select * from country where name like '____';
-- select * from country where name like '_u%a%';


-- select * from country;
-- select name, continent from country where continent like 'n%';
-- select name, continent from country where continet like '%p_';
-- select name from country where name like '____%';
-- select name, continent from country where region like '_a%a_';
-- select name, continent from country where egion like '___c%sia';
-- select name, region, continent from country where continent in ('north america', 'south america');


show databases;
use world;
-- show tables; 
-- select * from country;

-- select name, continent, population from country;
-- select * from country;
-- select name, continent from country where continent = 'Asia';

-- select name, population from country where population > 5000000;

-- select name, LifeExpectancy from country where LifeExpectancy > 75;

-- select name, SurfaceArea from country where SurfaceArea < 10000;

-- select * from country;

-- select * from country where GovernmentForm = 'Republic';

-- select * from country where HeadOfState = 'NULL';

-- SELECT COUNT(*) AS TotalCountries FROM Country;

-- basic functions
-- string related function

-- case conversion
-- upper()
-- lower()
-- concat()
-- concat_ws() -> it give us seprator
-- substr()
-- instr()
-- char_length() -> it is use to get the character length
-- lpad and rpad -> when we want to define a columnn  with fixed size

select name , upper(name), lower(name) from country;
select name, code, concat(name,' ',code,' ','Vikash') from country;
select name, code, concat(name,' ',code,' ','Vikash'),
concat_ws('$',name,code,'kumawat') from country;

select name, code,concat(name,' ',code) from country where concat(name,' ',code) = 'Afghanistan AFG';

select name, continent, region from country 
where region like concat('%', continent); 

select name from country 
where name = region;

select name, population where Continent like 'A%' = name; 
select name,continent , left(name,1) from country
where left(continent,1) = left(name,1); 

select * from country;
use world;
select name, substr(name,-3) from country;
select name, substr(name,2,4) from country;

select name, substr(name,-4,2) from country;

select name,continent,substr(continent,1,1),substr(name,1,1) from country where substr(continent,1,1) = substr(name,1,1);

select name, population from country where substr(name,1,3) = 'alg'; 

select name, instr(name,'e') from country;
select name, char_length(name) from country;



select '        vikash    ';
select char_length('        vikash    ');
select rtrim('        vikash    ');
select char_length(ltrim('        vikash    '));

select name, trim( both 'a' from trim(both 'A' from name)) from country;
use world; 
select name, population, lpad(population,9,0) from country;

-- NUMERIC FUNCTION -- 
-- round()
-- truncate() --> extract valuue
-- mod() --> remainder
-- ceil --> just upper values
-- floor() --> same value return
-- pow(value,power) --> calculte power
 
use world;
select lifeexpectancy, round(lifeexpectancy) from country;

select 30.68, round(30.641,2); 
select 30.68, round(30.641,-3); 

select 456.68, round(456.68,-2), truncate(456.68,1); 


-- DATE FUNCTION
-- now()
-- current_timestamp()
-- current_date()
-- current_time()
-- add date functionn -> by default date add, (month, year, time )
-- subdate() -> subract the date
-- extract() -> extract anything from date and time 
-- date_formate --> extract but with a string (message)

select now(), adddate(now(), 2),adddate( now(), interval 2 month); 
select now(), current_timestamp(),current_date(), current_time();

select now(), extract(year from now());

select now(), extract(year from now()), date_format(now(), 'Year is %Y');
select now(), extract(year from now()), date_format(now(), 'Year is %y');
select now(), extract(year from now()), date_format(now(), 'Month is %M');
select now(), extract(year from now()), date_format(now(), 'Month is %m');

-- what are aggrate functions 
-- what are in relationships 
-- revise all the assinment



-- ****************************************************************************************
-- 1. distint -> keyword -> give unique data from table

select distinct continent from country;
select distinct continent, region  from country;

-- 2. Group by. statement (similar values ko collect krna in a group)

select  count(name), continent from country group by continent;



-- AGREGATE FUNCTION (Multiple line function) => will give you some result
--  To apply some calculation over set of rows

-- 1. count(*) = count the rows 
-- 2. sum() = give the sum 
-- 3. avg = give the avrage


use world;


select count(indepyear) from country;
select count(population), sum(population), avg(population), max(population), min(population) from country;

select count(continent), count(distinct continent) from country;

select count(name), count(region), avg(LifeExpectancy), sum(population) from country where indepyear > 1947 and indepyear < 1998;

select * from country;

select count(name), count(distinct region), sum(population), max(LifeExpectancy), sum(capital) 
from country where name like 'A%' or name like 'D%';

select count(name), sum(population) from country group by indepyear; 

select continent ,count(name) from country group by continent;

select continent ,count(name) from country where continent = 'Asia' group by continent;


use world;
select sum(population) from country;
select continent, count(name) from country group by continent;

select continent ,count(name) from country where continent = 'Asia' and indepyear > 1950;

select continent ,count(name) from country where indepyear > 1950 group by continent;

select continent ,count(name) from country group by continent;

select continent, count(name) from country 
group by continent having count(name) > 30;
 
select * from country;
select continent, sum(population) from country group by continent having sum(population) > 30401150;

select indepyear, count(name) from country where indepyear> 1930 group by indepyear having count(name)>2;

select * from country;

select governmentform, count(name) from country group by governmentform having count(name)>20;


select governmentform, count(name) from country where capital > 20 group by governmentform;

select continent, count(name), count(region), sum(population) from country 
where lifeexpectancy > 38 group by continent having sum(population)>3000000;