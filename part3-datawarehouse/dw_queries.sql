-- ----------------------------------
-- PART 3.2 - DATA WAREHOUSE ANALYTICAL QUERIES
-- Q1: Total sales revenue by product category for each month
SELECT d.month,d.month_name,p.category,SUM(f.total_sales) AS total_revenue
FROM fact_sales AS f
JOIN dim_date AS d
    ON f.date_id = d.date_id
JOIN dim_product p
     ON f.product_id = p.product_id
GROUP BY d.month,d.month_name,p.category
ORDER BY d.month;         

-- Q2: Top 2 performing stores by total revenue
SELECT s.store_name,SUM(f.total_sales)AS total_revenue
FROM fact_sales AS f 
JOIN dim_store AS s
    ON f.store_id = s.store_id
GROUP BY s.store_name
ORDER BY total_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
SELECT d.year,d.month,SUM(f.total_sales) AS monthly_revenue
FROM fact_sales AS f
JOIN dim_date  AS d
   ON f.date_id = d.date_id
GROUP BY d.year,d.month
ORDER BY d.year,d.month;   

