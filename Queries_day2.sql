CREATE SCHEMA SQL_JOINS_PRACTICE;
USE SQL_JOINS_PRACTICE;
CREATE TABLE CUSTOMER (CUSTOMER_ID INT PRIMARY KEY, CUSTOMER_NAME VARCHAR(50));
CREATE TABLE ODERS(ORDER_ID INT PRIMARY KEY,CUSTOMER_ID INT, AMOUNT DECIMAL(10,2));
INSERT INTO CUSTOMER VALUES (1,'ROHAN'),(2,'RAHUL'),(3,'PRIYA'),(4,'POORVI');
INSERT INTO ODERS VALUES(101,1,500),
(102,2,300),
(103,3,800),
(104,4,900);

-- =====================================
-- WEEK 1 DAY 2: SQL JOINS
-- Intern: Rohan
-- Project: Cynaris Internship
-- =====================================

USE sql_joins_practice;

-- 1. INNER JOIN
SELECT c.customer_name, o.order_id, o.amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-- 2. LEFT JOIN
SELECT c.customer_name, o.order_id, o.amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- 3. RIGHT JOIN
SELECT c.customer_name, o.order_id, o.amount
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- 4. FULL OUTER JOIN (MySQL using UNION)
SELECT c.customer_id, c.customer_name,
       o.order_id, o.amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id

UNION

SELECT c.customer_id, c.customer_name,
       o.order_id, o.amount
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- 5. DUPLICATE CHECK
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 6. SELF JOIN
SELECT e.employee_name AS employee,
       m.employee_name AS manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id = m.employee_id;

-- 7. TABLE ALIASES
SELECT c.customer_name, o.amount
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;