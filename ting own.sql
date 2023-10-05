USE store;
#increasing the price the more there is of stock
SELECT name, 
quantity_in_stock,
unit_price, 
(unit_price * 1.1) AS 'new_price'
FROM products
WHERE quantity_in_stock BETWEEN 40 AND 49
UNION
SELECT name, 
quantity_in_stock,
unit_price, 
(unit_price * 1.3) AS 'new_price'
FROM products
WHERE quantity_in_stock BETWEEN 60 AND 69
UNION
SELECT name, 
quantity_in_stock,
unit_price, 
(unit_price * 1.5) AS 'new_price'
FROM products
WHERE quantity_in_stock >= 70
ORDER BY quantity_in_stock DESC; 

#a table about customers and their orders
SELECT c.last_name,
c.city, 
p.name AS items,
p.unit_price
FROM customers c
CROSS JOIN products p
ORDER BY p.name DESC;

#brackets first like bidmas
SELECT * 
FROM customers, shippers
WHERE last_name NOT LIKE '%b%' OR
(points > 2000);

#all orders for 2 specific items
SELECT c.first_name, c.last_name, p.name, oi.quantity
FROM customers c, products p, order_items oi
WHERE name = 'Foam Dinner Plate' OR name = 'broom - push'
ORDER BY first_name;

#discount on customers depending on points
SELECT first_name, last_name, points, '0%' AS sunny_days_discount
FROM customers 
WHERE points <500
UNION
SELECT first_name, last_name, points, '5%' AS sunny_days_discount
FROM customers 
WHERE points BETWEEN 500 AND 1000
UNION
SELECT first_name, last_name, points, '10%' AS sunny_days_discount
FROM customers 
WHERE points BETWEEN 1100 AND 1900
UNION
SELECT first_name, last_name, points, '15%' AS sunny_days_discount
FROM customers 
WHERE points BETWEEN 2000 AND 2900
UNION
SELECT first_name, last_name, points, '20%' AS sunny_days_discount
FROM customers 
WHERE points >3000
ORDER BY points DESC;

#the products, price and status 
SELECT c.first_name, 
	   c.last_name, 
       p.name AS products, 
       oi.quantity, 
       oi.unit_price, 
       (oi.quantity * oi.unit_price) AS total_price, 
       os.name AS status
FROM customers c, products p, order_statuses os, order_items oi
ORDER BY last_name, status;

SELECT DISTINCT c.first_name, c.last_name, p.name AS products, sh.name, os.name AS status, o.comments
FROM customers c, products p, shippers sh, order_statuses os, orders o
WHERE os.name in ('processed', 'shipped')
ORDER BY last_name, status;

USE classicmodels;
SELECT customerName, contactFirstname, contactLastname, creditLimit
FROM customers;
