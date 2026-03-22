-- PART 5 DATALAKES WITH DUCKDB
-- Q5.1 -  CROSS FORMAT QUERIES

-- Reset views so that script can run multiple times 
DROP VIEW IF EXISTS customers;
DROP VIEW IF EXISTS orders;
DROP VIEW IF EXISTS products;

-- We will create views for getting cleaner queries for the datalake
CREATE VIEW customers AS
SELECT * FROM read_csv_auto('../datasets/customers.csv') c;

CREATE VIEW orders AS
SELECT * FROM read_json_auto('../datasets/orders.json') o ;

CREATE VIEW products AS
SELECT * FROM read_parquet('../datasets/products.parquet') p ;
-- ------------------------------------------------------------------
-- Q1: List all customers along with the total number of orders they have placed
SELECT c.customer_id,c.name,COUNT(o.order_id) AS total_orders
FROM read_csv_auto('../datasets/customers.csv') c
LEFT JOIN read_json_auto('../datasets/orders.json') o 
ON c.customer_id = o.customer_id
GROUP BY c.customer_id,c.name
ORDER BY total_orders DESC;
-- -------------------------------------------------------------------------------------------

-- Q2: Find the top 3 customers by total order value
SELECT c.customer_id,c.name,SUM(o.total_amount) AS total_spent
FROM read_csv_auto('../datasets/customers.csv') c
JOIN read_json_auto('../datasets/orders.json') o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id,c.name
ORDER BY total_spent DESC 
LIMIT 3;

-- -------------------------------------------------------------------------------------------

-- Q3: List all products purchased by customers from Bangalore
SELECT c.name,o.order_id,o.order_date,o.status,o.total_amount,p.product_name,p.category,p.quantity,p.unit_price,p.total_price
FROM read_csv_auto('../datasets/customers.csv') c
JOIN read_json_auto('../datasets/orders.json') o
   ON c.customer_id = o.customer_id
JOIN read_parquet('../datasets/products.parquet') p 
      ON o.order_id = p.order_id
WHERE LOWER(c.city) = 'bangalore'; 

-- -------------------------------------------------------------------------------------------
-- Q4: Join all three files to show: customer name, order date, product name, and quantity
SELECT c.name AS customer_name,o.order_date,o.status,p.product_name,p.category,p.quantity,p.unit_price,p.total_price
FROM read_csv_auto('../datasets/customers.csv') c
JOIN  read_json_auto('../datasets/orders.json') o 
   ON c.customer_id  = o.customer_id
JOIN read_parquet('../datasets/products.parquet') p 
     ON o.order_id = p.order_id
ORDER BY o.order_date;

 