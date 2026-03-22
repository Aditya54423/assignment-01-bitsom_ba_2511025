
--  PART 3 - DATA WAREHOUSE SCHEMA FOR RETAIL
-- 3.1 - STAR SCHEMA DESIGN
-- -----------------------------------------------

CREATE DATABASE retail_dw;
USE retail_dw;

-- NOW CREATING DIMENSIONS TABLES

CREATE TABLE dim_date(
    date_id INT PRIMARY KEY,
    full_date DATE,
    month INT,
    year INT,
    month_name VARCHAR(20)
);

CREATE TABLE dim_store(
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(100),
    store_city VARCHAR(100)
);

CREATE TABLE dim_product(
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

-- ------------------------------
-- FACT TABLE
-- ---------------------------------

CREATE TABLE fact_sales(
    sales_id INT AUTO_INCREMENT PRIMARY KEY,
    date_id INT,
    store_id INT,
    product_id INT,

    units_sold INT,
    unit_price DECIMAL(10,2),

    total_sales DECIMAL(12,2),

    FOREIGN KEY (date_id)  REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- --------------------------
-- INSERTING CLEANED DIMENSIONAL DATA
-- -------------------------------

INSERT INTO dim_date VALUES
(1,'2023-01-15',1,2023,'January'),
(2,'2023-02-05',2,2023,'February'),
(3,'2023-02-20',2,2023,'February'),
(4,'2023-08-29',8,2023,'August'),
(5,'2023-12-12',12,2023,'December');

INSERT INTO dim_store (store_name,store_city) VALUES
('Chennai Anna Store','Chennai'),
('Delhi South Store','Delhi'),
('Mumbai Central Store','Mumbai');

INSERT INTO dim_product (product_name,category) VALUES
('Laptop','Electronics'),
('Smartphone','Electronics'),
('Headphones','Electronics'),
('Coffee Maker','Home Appliances');

-- -------------------------
-- FACT TABLE DATA 
-- -------------------------

INSERT INTO fact_sales(date_id,store_id,product_id,units_sold,unit_price,total_sales) VALUES
(4,1,1,3,49262.78,147788.34),
(5,1,2,11,23226.12,255487.32),
(2,1,3,20,48703.39,974067.80),
(3,2,2,14,23226.12,325165.68),
(1,1,4,10,58851.01,588510.10),
(1,2,1,7,49262.78,344839.46),
(2,3,3,12,48703.39,584440.68),
(3,2,4,5,58851.01,294255.05),
(4,3,1,9,49262.78,44365.02),
(5,1,3,6,48703.39,292220.34);

