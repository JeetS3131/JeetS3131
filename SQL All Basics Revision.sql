USE sql_store;

SELECT * 
FROM customers

WHERE customer_id = 1
ORDER by first_name;

SELECT 
first_name, 
last_name, 
points, 
points + 10,
points * 10 + 100 AS 'discount_factor'
FROM customers;

SELECT DISTINCT state
FROM customers;

SELECT name, unit_price, unit_price * 1.1 AS new_price
FROM products;

SELECT *
FROM Customers
WHERE points > 3000;

SELECT * 
FROM Customers
WHERE state != 'VA';

SELECT *
FROM Customers
WHERE state = 'VA';

SELECT *
FROM Customers
WHERE birth_date > '1990-01-01';

SELECT *
FROM orders
WHERE order_date >= '2019-01-01';

SELECT * 
FROM Customers
WHERE birth_date > '1990-01-01' AND points > 1000;

SELECT * 
FROM Customers
WHERE birth_date > '1990-01-01' OR points > 1000;

SELECT * 
FROM Customers
WHERE birth_date > '1990-01-01' OR 
(points > 1000 AND state = 'VA' );

SELECT * 
FROM Customers
WHERE NOT (birth_date > '1990-01-01' OR points > 1000);

SELECT *
FROM order_items
WHERE order_id = 6 AND unit_price * quantity > 30;

SELECT * 
FROM Customers
WHERE state IN ('VA', 'FL', 'GA');

SELECT *
FROM products
WHERE quantity_in_stock IN (49, 38, 72);

SELECT * FROM customers
WHERE points BETWEEN 1000 AND 3000;

SELECT *
FROM Customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT * 
FROM customers
WHERE last_name LIKE '%b%';

SELECT * 
FROM customers
WHERE last_name LIKE '_____y';

SELECT * 
FROM customers
WHERE last_name LIKE 'b___y';

SELECT *
FROM customers
WHERE address LIKE '%trail%' OR 
address LIKE 'avenue%';

SELECT *
FROM customers
WHERE phone NOT LIKE '%9';

SELECT *
FROM customers
WHERE last_name REGEXP 'field';

SELECT *
FROM customers
WHERE last_name REGEXP 'field$';

SELECT * 
FROM customers
WHERE last_name REGEXP 'field|mac|rose';

SELECT * 
FROM customers
WHERE last_name REGEXP 'field$|mac|rose';

SELECT *
FROM customers
WHERE last_name REGEXP '[gim]e';

SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e';

SELECT *
FROM customers
WHERE last_name REGEXP 'e[a-h]';

-- REGEXP
-- ^ beginning
-- | logical OR
-- [abcd]
-- [a-f]

SELECT *
FROM customers
WHERE first_name REGEXP 'ELKA|AMBUR';

SELECT *
FROM customers
WHERE last_name REGEXP '^my|SE';

SELECT *
FROM customers
WHERE first_name REGEXP 'ey$|on$';

SELECT *
FROM customers
WHERE last_name REGEXP 'b[ru]';

SELECT *
FROM customers
WHERE phone IS NULL;

SELECT *
FROM customers 
WHERE phone IS NOT NULL;

SELECT *
FROM orders
WHERE shipped_date IS NULL;

SELECT * 
FROM customers
ORDER BY first_name DESC;

SELECT *
FROM customers
ORDER BY state, first_name;

SELECT first_name, last_name
FROM customers
ORDER BY birth_date;

SELECT first_name, last_name, 10 AS points
FROM customers 
ORDER BY points, first_name;

SELECT * , quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;

SELECT *
FROM customers
LIMIT 3;

SELECT * 
FROM customers
LIMIT 6, 3;

SELECT customer_id, first_name, last_name, points
FROM customers
ORDER BY points DESC
LIMIT 3;

SELECT *
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id;

SELECT order_id, first_name, last_name
FROM orders 
JOIN customers ON orders.customer_id = customers.customer_id;

SELECT order_id, orders.customer_id, first_name, last_name
FROM orders 
JOIN customers ON orders.customer_id = customers.customer_id;

SELECT order_id, o.customer_id, first_name, last_name
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;

SELECT order_id, o.product_id, name, quantity, o.unit_price, o.unit_price * quantity AS total_price
FROM order_items o
JOIN products p
ON o.product_id = p.product_id
ORDER BY total_price DESC;

SELECT * 
FROM order_items oi
JOIN sql_inventory.products p
ON oi.product_id = p.product_id;

USE sql_inventory;

SELECT *
FROM sql_store.order_items oi
JOIN products p
ON oi.product_id = p.product_id;

USE sql_hr;

SELECT *
FROM employees e
JOIN employees m
ON e.reports_to = m.employee_id;

SELECT e.employee_id, e.first_name, m.first_name AS manager
FROM employees e
JOIN employees m
ON e.reports_to = m.employee_id;

USE sql_store;

SELECT * 
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_statuses os
ON  o.status = os.order_status_id;

SELECT o.order_id, o.order_date, c.first_name, c.last_name, os.name AS status
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_statuses os
ON  o.status = os.order_status_id;

use sql_invoicing;

SELECT p.payment_id, c.name, c.address, c.city, p.date, p.amount, p.payment_method, pm.name AS payment_mode
FROM payments p
JOIN payment_methods pm
ON p.payment_method = pm.payment_method_id
JOIN clients c
ON p.client_id = c.client_id;

USE sql_store;

SELECT *
from order_items oi
JOIN order_item_notes oin
ON oi.order_id = oin.order_id 
AND oi.product_id = oin.product_id;

SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id;

SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT p.product_id, p.name, oi.order_id
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id;

SELECT c.customer_id, c.first_name, o.order_id, s.name AS shipper
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
LEFT JOIN shippers s
ON o.shipper_id = s.shipper_id
ORDER BY c.customer_id;

SELECT o.order_date, o.order_id, c.first_name, s.name AS shipper, os.name AS status
FROM orders o
JOIN order_statuses os
ON o.status = os.order_status_id
JOIN customers c
ON c.customer_id = o.customer_id
LEFT JOIN shippers s
ON o.shipper_id = s.shipper_id
ORDER BY status ;

USE sql_hr;

SELECT e.employee_id, e.first_name, m.first_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.reports_to = m.employee_id;

USE sql_store;
SELECT o.order_id, c.first_name
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;


SELECT o.order_id, c.first_name
FROM orders o
JOIN customers c
USING (customer_id);

SELECT o.order_id, c.first_name, s.name AS shipper
FROM orders o
JOIN customers c
USING (customer_id)
LEFT JOIN shippers s
USING (shipper_id);

SELECT *
FROM order_items oi
JOIN order_item_notes oin
ON oi.order_id = oin.order_id
AND oi.product_id = oin.product_id;

SELECT *
FROM order_items oi
JOIN order_item_notes oin
USING (order_id, product_id);

USE sql_invoicing;

SELECT p.date, c.name AS client, p.amount, pm.name AS payment_mode
FROM payments p
JOIN clients c
USING (client_id)
JOIN payment_methods pm
ON p.payment_method = pm.payment_method_id;

USE sql_store;

SELECT o.order_id, c.first_name
FROM orders o
NATURAL JOIN customers c;

SELECT c.first_name AS customer, p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name;

SELECT s.name AS shipper, p.name AS product
FROM shippers s
CROSS JOIN products p
ORDER BY shipper;

SELECT o.order_id, o.order_date, 'Active' AS status
FROM orders o
WHERE o.order_date >= '2019-01-01';

SELECT o.order_id, o.order_date, 'Archive' AS status
FROM orders o
WHERE o.order_date < '2019-01-01';


SELECT o.order_id, o.order_date, 'Active' AS status
FROM orders o
WHERE o.order_date >= '2019-01-01'
UNION
SELECT o.order_id, o.order_date, 'Archive' AS status
FROM orders o
WHERE o.order_date < '2019-01-01';

SELECT first_name
FROM customers
UNION
SELECT name
FROM shippers;

SELECT customer_id, first_name, points, 'Bronze' AS type
FROM customers
WHERE points < 2000
UNION 
SELECT customer_id, first_name, points, 'SILVER' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION 
SELECT customer_id, first_name, points, 'GOLD' AS type
FROM customers
WHERE points >3000
ORDER BY first_name;

INSERT INTO customers
VALUES (
DEFAULT,
 'John', 
 'Smith', 
 '1990-01-01', 
 NULL, 
 'address', 
 'city', 
 'CA', 
 DEFAULT);
 
 INSERT INTO customers (first_name, 
 last_name,
 birth_date,
 address,
 city,
 state)
VALUES (
 'John', 
 'Smith', 
 '1990-01-01', 
 'address', 
 'city', 
 'CA');
 
 INSERT INTO shippers(name)
 VALUES( 'Shipper1'),
 ('Shipper2'),
 ('Shipper3');
 
 INSERT INTO products(name, quantity_in_stock, unit_price)
 VALUES('Yamaha', 10, 5),
 ('Honda', 8, 1),
 ('Kawasaki', 6, 9.5);
 
 INSERT INTO orders (customer_id, order_date, status)
 VALUES (1, '2019-01-02', 1);
 
  SELECT LAST_INSERT_ID();
  
 INSERT INTO order_items
 VALUES ( LAST_INSERT_ID(), 1, 1, 2.95),
 ( LAST_INSERT_ID(), 2, 1, 3.95);
 
 CREATE TABLE orders_archived AS
 SELECT * FROM orders;
 
 SELECT *
 FROM orders
 WHERE order_date <= '2019-01-01';
 
 INSERT INTO orders_archived()
 SELECT *
 FROM orders
 WHERE order_date <= '2019-01-01';
 
 USE sql_invoicing;
 
 SELECT i.invoice_id,
 i.number,
 c.name AS client,
 i.invoice_date,
 i.invoice_total,
 i.payment_date,
 i.payment_total,
 i.due_date
 FROM invoices i
 JOIN clients c
 USING (client_id)
 WHERE payment_date IS NOT NULL;
 
 CREATE TABLE invoices_archived AS
  SELECT i.invoice_id,
 i.number,
 c.name AS client,
 i.invoice_date,
 i.invoice_total,
 i.payment_date,
 i.payment_total,
 i.due_date
 FROM invoices i
 JOIN clients c
 USING (client_id)
 WHERE payment_date IS NOT NULL;
 
 UPDATE invoices
 SET payment_total = invoice_total * 0.5, payment_date = due_date
 WHERE invoice_id = 3;
 
  UPDATE invoices
 SET payment_total = invoice_total * 0.5, payment_date = due_date
 WHERE client_id IN (3, 4);
 
 USE sql_store;
 
 UPDATE customers
 SET points = points + 50
 WHERE birth_date < '1990-01-01';
 
use sql_invoicing;

SELECT client_id
FROM clients
WHERE name = 'Myworks';

  UPDATE invoices
 SET payment_total = invoice_total * 0.5, payment_date = due_date
 WHERE invoice_id = (SELECT client_id
FROM clients
WHERE name = 'Myworks');
 
   UPDATE invoices
 SET payment_total = invoice_total * 0.5, payment_date = due_date
 WHERE invoice_id IN 
 (SELECT client_id
FROM clients
WHERE state IN ('CA', 'NY'));

USE sql_store;

UPDATE orders
SET comments = 'GOLD'
WHERE customer_id IN
(  SELECT customer_id
FROM customers
WHERE points > 3000 );

USE sql_invoicing;

DELETE FROM invoices
WHERE invoice_id =1;

DELETE FROM invoices
WHERE client_id = (
SELECT client_id
FROM clients
WHERE name = 'Myworks');







 
 