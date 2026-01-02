-- case
/* 
case
	when  condition | Expression then output
    when  condition. then output
end
 */
 
 
 
 select continent,
 
 count(case
	when population between 8000 and 70000 then 1 else 0
 end)
  -
 sum(case
	when population between 8000 and 70000 then 1 else 0
 end)
	from world.country
    group by continent;