/*
1. Retrieve all customers from Mumbai --> Test: SELECT, WHERE
2. List all products with price greater than 2000 --> Test: Filtering numeric values
3. Show total number of orders --> Test: COUNT()
4. Find all orders placed after 1st Jan 2024 --> Test: Date filtering
5. Display unique product categories --> Test: DISTINCT
*/

-- 1. Retrieve all the customers from Mumbai

SELECT 
    customer_id,
    name AS customer_name,
    city
from 
    customers
WHERE 
    city = 'Mumbai'


-- List all products with price grater than 2000

SELECT 
    product_id,
    product_name,
    price
FROM 
    products
WHERE
    price > 2000;


--show total number of orders

SELECT 
    COUNT(DISTINCT order_id)
FROM
    orders;

-- Find all the orders placed after 1st Jan 2024

SELECT
    order_id,
    order_date
FROM
    orders
WHERE
    extract(year from order_date) > 2023
ORDER BY
    EXTRACT(MONTH FROM order_date) ASC;


-- Display unique product categories

SELECT 
    DISTINCT category
FROM   
    products;