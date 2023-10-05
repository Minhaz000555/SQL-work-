USE store;
select state
from customers;

SELECT name,
		unit_price,
		(unit_price * 1.1) AS 'new price'
FROM products
WHERE unit_price > 2.5
ORDER BY unit_price
LIMIT 3;

select * 
from orders
where order_date >= '2018-01-01'
order by customer_id ;

select * from customers 
where NOT birth_date >'1990-01-01' OR 
(points >2000 AND state= 'FL');

SELECT *
FROM order_items
WHERE order_id = 6 AND unit_price * quantity > 30;
select * 
from customers
where state not in ('FL', 'CA', 'TX');

SELECT * 
FROM products
#WHERE quantity_in_stock IN (49, 38, 72);
WHERE quantity_in_stock BETWEEN 40 AND 70;

SELECT * 
FROM customers 
#WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';
WHERE first_name LIKE 'a%____';

SELECT *
FROM customers 
#where address LIKE '%TRAIL%' 
 #  OR address LIKE '%AVENUE%'
WHERE phone LIKE '%9';

select * 
from customers 
#where last_name LIKE '%field%'
#where last_name REGEXP 'field$'
#where last_name REGEXP '^field$'
#where last_name REGEXP 'field$|mac|rose'
#where last_name REGEXP '[gim]e'
where last_name REGEXP '[g-m]e';

SELECT *
FROM customers; 
#WHERE first_name REGEXP 'ELKA|ambur';
#where last_name REGEXP 'ey$|on$'
#WHERE last_name REGEXP '^my|se'
#where last_name REGEXP 'b[ru]'

select *
from customers
where phone is not null;

SELECT *
FROM orders
where shipped_date is null;

SELECT *
FROM customers
ORDER BY state DESC, first_name DESC;

SELECT * #quantity * unit_price AS total_price
FROM order_items 
where order_id = 2 
order by quantity * unit_price DESC;

SELECT *
FROM customers 
LIMIT 7,3;

SELECT * 
FROM customers 
ORDER BY points DESC
LIMIT 3;

SELECT order_id, o.customer_id, first_name, last_name
FROM orders o
#from orders
JOIN customers c
ON o.customer_id = c.customer_id;

SELECT order_id, o.product_id, quantity, o.unit_price
FROM order_items o
JOIN products p
ON o.product_id = p.product_id;

#SELECT * to join different databases 
#FROM order_items o
#JOIN sql_inventory.p 
#ON o.product_id = p.product_id 

#joining a table with itself if there's a null value/ repeated data in a column
#select *
# OR select e.employee_id, e.first_name, m.first_name AS manager
#from employees e
#join empolyees m
#e.report.to = m.employee.id 

SELECT o.order_id, o.order_date, c.first_name, c.last_name, os.name AS status 
FROM orders o
JOIN customers c
ON o.customer_id =c.customer_id
JOIN order_statuses os
ON o.status = os.order_status_id;

#compound joining
#SELECT * 
#FROM order_items oi
#JOIN order_item_notes oin
#ON oi.order_id = oin.order_id
#AND oi.product_id = oin.product_id

#implicit join syntax, not preferable 
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id; 

#outer join
SELECT c.customer_id, c.first_name, o.order_id, sh.name AS shipper, os.name AS status
FROM customers c
LEFT JOIN orders o
ON o.customer_id = c.customer_id
#joining multiple tables
LEFT JOIN shippers sh
#include this 
ON o.shipper_id = sh.shipper_id
LEFT JOIN order_statuses os;


SELECT o.order_id, o.order_date, c.first_name AS customer, os.name AS status
FROM orders o 
JOIN customers c
ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
ON o.status = os.order_status_id;

#using, alternate for ON, use ON if there are different table names
SELECT o.order_id, c.first_name, sh.name AS shipper
FROM orders o
JOIN customers c 
USING (customer_id)
#can us (,) for multiple conditions
LEFT JOIN shippers sh
USING (shipper_id);

#across join
SELECT  c.first_name AS customer, p.name AS product
FROM customers c
CROSS JOIN products p
#no cross join because of this
ORDER BY c.first_name;

SELECT sh.name AS shippers, p.name AS products 
FROM shippers sh, products p
ORDER BY sh.name;

#unions, joins rows from tables, rows should be equal via no. of columns
#1st
SELECT order_id, order_date, 'Active' AS status
FROM orders
WHERE order_date >='2019-01-01'
#3rd
UNION
#2nd
SELECT order_id, order_date, 'Archived' AS status
FROM orders
WHERE order_date <'2019-01-01';

SELECT customer_id, first_name, points, 'bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT customer_id, first_name, points, 'silver' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT customer_id, first_name, points, 'gold' AS type
FROM customers
WHERE points > 3000
ORDER BY first_name;

#inserting rows
INSERT INTO customers (first_name, last_name, address, city, state)
#() to put values into, so NULL/default isn't needed for the next part 
VALUES ( 'Yo','Sm','address','city','CA');
#values (), (), (),
#customer_id is incremented by 1(auto completed)

#inserting hierachial rows
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1);
SELECT LAST_INSERT_ID();

INSERT INTO order_items 
VALUES (LAST_INSERT_ID(), 1, 1, 2.95),
(LAST_INSERT_ID(), 2, 1, 3.95);

#update rows
UPDATE invoices 
SET payment_total = 10, payment_date = '2019-03-01'
#SET payment_total = 0/DEFAULT, payment_date = NULL, 
WHERE client_id = 3;

UPDATE customers
SET points = points +50
WHERE birth_date <'';

#delete
DELETE FROM invoices
WHERE client_id = (
SELECT * 
FROM clients 
WHERE name = 'Myworks');