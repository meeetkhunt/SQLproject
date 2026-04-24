/*
1. Top 10 customers by total spending
2. Most sold product (by quantity)
3. Which city generates highest revenue
4. Monthly sales trend
5. Customers who never placed an order
*/

-- Top 10 customers by total spending

SELECT
    customers.name AS customer_name,
    SUM(products.price * order_items.quantity) AS total_spending
FROM
    products
JOIN order_items
    ON products.product_id = order_items.product_id
 JOIN orders
    ON order_items.order_id = orders.order_id
JOIN customers
    ON orders.customer_id = customers.customer_id
GROUP BY
    customers.name
ORDER BY
    SUM(products.price * order_items.quantity) DESC
LIMIT 10;

-- Most sold product (by quantity)

SELECT
    SUM(order_items.quantity),
    products.product_name
FROM 
    products
JOIN order_items
    ON products.product_id = order_items.product_id
GROUP BY
    products.product_name
ORDER BY
    SUM(order_items.quantity) DESC\
LIMIT 1;

-- Which city generates highest revenue

SELECT
    customers.city,
    SUM(order_items.quantity * products.price) as Revenue
FROM
    customers
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN order_items
    ON orders.order_id = order_items.order_id
JOIN products
    ON order_items.product_id = products.product_id
GROUP BY
    customers.city
ORDER BY
    SUM(order_items.quantity * products.price) DESC;

-- Monthly sales trend

SELECT
    EXTRACT(MONTH FROM order_date),
    SUM(order_items.quantity * products.price) as Sales
FROM
    orders
JOIN order_items
    ON orders.order_id = order_items.order_id
JOIN products
    ON order_items.product_id = products.product_id
GROUP BY
   EXTRACT(MONTH FROM order_date)
ORDER BY
    EXTRACT(MONTH FROM order_date) ASC;
   
-- Customers who never placed an order

SELECT 
    customer_id, 
    name
FROM 
    customers
WHERE  
    customer_id 
    NOT IN 
(
    SELECT customer_id FROM orders
);