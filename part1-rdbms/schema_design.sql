-- ASSIGNMENT PART 1: RDBMS (3NF)
-- DATASET: orders_flat.csv
-- Here I have imported the raw csv file given as a staging table named 'orders_flat'
CREATE DATABASE order_data;
USE order_data;

-- ---------------------------------------------------------
-- TABLE 1 :- Sales Representatives
-- This table will store unique sales staff information

CREATE TABLE sales_reps (
 sales_rep_id VARCHAR(10) NOT NULL,
 sales_rep_name VARCHAR(100) NOT NULL,
 sales_rep_email VARCHAR(120),
 office_address VARCHAR(200),
        
 CONSTRAINT pk_sales_reps
 PRIMARY KEY (sales_rep_id)
 );       
  
  --  ---------------------------------------------------    
  -- TABLE 2: Customers
  -- This table show each customer appears only once to avoid redundancy
  
  CREATE TABLE customers (
  customer_id VARCHAR(10) NOT NULL,
  customer_name VARCHAR(100) NOT NULL,
  customer_email VARCHAR(120) NOT NULL,
  customer_city VARCHAR (60),
          
   CONSTRAINT pk_customers
   PRIMARY KEY (customer_id)
   );
   
   -- -----------------------------------------
   -- TABLE 3 : PRODUCTS
   -- This table stores product attrbutes independent of orders

   CREATE TABLE products (
   product_id VARCHAR(10) NOT NULL,
   product_name VARCHAR(120) NOT NULL,
   category VARCHAR(80),
   unit_price DECIMAL(10,2)NOT NULL,
   
   CONSTRAINT pk_products
   PRIMARY KEY (product_id)
   );
          
-- =====================================
-- TABLE 4:ORDERS
-- This table represents each order placed by a customer

CREATE TABLE orders(
order_id VARCHAR(12) NOT NULL,
customer_id VARCHAR(10) NOT NULL,
sales_rep_id VARCHAR (10),
order_date DATE,

CONSTRAINT pk_orders
PRIMARY KEY (order_id),

CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id),

CONSTRAINT fk_orders_sales_rep
FOREIGN KEY (sales_rep_id)
REFERENCES sales_reps(sales_rep_id)
);
-- -----------------------------------
-- TABLE 5:ORDER_ITEMS
-- This resolves the many-to-many relationship between orders and products
-- As we can see that each order can contain multiple products.
CREATE TABLE order_items (
  order_id VARCHAR(12) NOT NULL,
  product_id VARCHAR(10) NOT NULL,
  quantity INT NOT NULL,
  
  CONSTRAINT pk_order_items
  PRIMARY KEY (order_id,product_id),
  
  CONSTRAINT fk_orderitems_order
  FOREIGN KEY (order_id)
  REFERENCES orders(order_id),
  
  CONSTRAINT fk_orderitems_product
  FOREIGN KEY (product_id)
  REFERENCES products(product_id)
  );
 
 -- -----------------------------------------------------
  -- Now to populate normalized tables form staging table
  -- the orders_flat was imported form csv file earlier
-- --------------------------------------------
  -- Inserting unique sales representatives
  INSERT INTO sales_reps 
  SELECT sales_rep_id,MAX(sales_rep_name),MAX(sales_rep_email),MAX(office_address)
  FROM orders_flat
  GROUP BY sales_rep_id;
  
  -- Inserting unique customers
  INSERT INTO customers
  SELECT customer_id,MAX(customer_name),MAX(customer_email),MAX(customer_city)
  FROM orders_flat
  GROUP BY customer_id;
  
  -- Inserting unique products
  INSERT INTO products
  SELECT product_id,MAX(product_name),MAX(category),MAX(unit_price)
  FROM orders_flat
  GROUP BY product_id;
  
  -- Inserting orders
  INSERT INTO orders
  SELECT order_id,MAX(customer_id),MAX(sales_rep_id),MAX(order_date)
  FROM orders_flat
  GROUP BY order_id;
  
  -- Inserting order-product relationships
  INSERT INTO order_items (order_id,product_id,quantity)
  SELECT DISTINCT order_id,product_id,quantity
  FROM orders_flat;
  
  


 SELECT * FROM customers;
  SELECT * FROM products;
  SELECT * FROM orders;
  SELECT * FROM order_items
 