use store;
select * from customers
order by first_name;

select last_name, first_name, points, (points * 10) + 100 AS 'discount_factor'
from customers;

select last_name, first_name, points, (points + 10) * 100 AS 'discount_factor'
from customers;

select name, unit_price, (unit_price *1.1) AS new_price
from products;

select * from customers
where birth_date > '1990-01-01';

select DISTINCT * from customers, order_statuses, order_items
where  name = 'delivered' OR name = 'shipped'
order by unit_price DESC
limit 25;