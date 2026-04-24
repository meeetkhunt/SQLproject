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