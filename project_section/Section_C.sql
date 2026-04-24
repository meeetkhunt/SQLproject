/*
1. Total revenue generated --> Formula: price * quantity
2. Revenue by category
3. Total number of orders per customer
4. Top 5 most expensive products
5. Average order value
*/

-- Total revenue generated

SELECT
    SUM (order_items.quantity * products.price)
FROM
    order_items
JOIN products
    ON order_items.product_id = products.product_id;


-- Revenue by categoty

SELECT
    products.category,
    SUM (order_items.quantity * products.price)
FROM
    order_items
JOIN products
    ON order_items.product_id = products.product_id
GROUP BY
    products.category
order by
    SUM (order_items.quantity * products.price);

-- Total number of orders per customer

SELECT
    customers.name AS customer_name,
    COUNT(DISTINCT orders.order_id)
FROM
    customers
JOIN orders
    ON customers.customer_id = orders.customer_id
GROUP BY
    customers.name;

-- Top 5 most expensive products

SELECT
    products.product_name,
    products.price
FROM
    products
ORDER BY
    price DESC
limit 5;

-- Average order value

SELECT
     SUM (order_items.quantity * products.price)/COUNT(DISTINCT orders.order_id)
     AS AVG_Order_value
FROM
    order_items
JOIN products
    ON order_items.product_id = products.product_id
JOIN orders
    ON order_items.order_id = orders.order_id;
    