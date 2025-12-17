-- ****************************************************************************************
-- 17 december 2025 wednesday -------------

use sakila;
show tables;
select * from payment;
select amount, count(*) from payment group by amount;

select * from payment;

select customer_id, sum(amount) from payment where amount > 3 group by customer_id;
select customer_id, count(amount) from payment where month(payment_date) = 5 group by customer_id;

select staff_id, max(amount), avg(amount), sum(amount) from payment group by staff_id;

select staff_id, max(amount), avg(amount), sum(amount) from payment where customer_id % 2 = 0 group by staff_id;

select amount, count(amount) from payment where staff_id = 1 group by amount having count(amount) > 30;

select * from payment;       

select month(payment_date), amount, count(customer_id), avg(amount) from payment group by month(payment_date);

select extract(month from payment_date), count(customer_id), avg(amount), sum(amount) from payment
 where staff_id = 1 or staff_id = 2 group by extract(month from payment_date);
 
 select year(payment_date), month(payment_date) , count(customer_id),
 avg(amount), sum(amount) 
 from payment
 where staff_id = 1 or staff_id = 2
 group by year(payment_date), month(payment_date);
 
 select * from payment order by customer_id, amount;