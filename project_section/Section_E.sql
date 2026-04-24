/*
1. Rank customers based on spending --> Use: RANK() or DENSE_RANK()
2. Find the second highest priced product --> Use: Subquery / LIMIT OFFSET
3. Find repeat customers (placed more than 1 order)
4. Running total of revenue by date --> Use: Window function
5. Find top-selling product in each category -->Use: PARTITION BY
*/

-- Rank customers based on spending

SELECT
    customers.name,
    SUM(order_items.quantity * products.price),
    RANK() OVER (ORDER BY SUM(order_items.quantity * products.price) DESC)
    AS customer_rank
FROM
    customers
JOIN orders
    ON customers.customer_id = orders.order_id
JOIN order_items
    ON orders.order_id = order_items.order_id
JOIN products
    ON order_items.product_id = products.product_id
GROUP BY
    customers.name;

-- Find the second highest priced product

SELECT
    products.product_name,
    products.price
FROM
    products
ORDER BY
    products.price DESC
LIMIT 1 OFFSET 2;

--  Find repeat customers (placed more than 1 order)

SELECT
    customers.name,
    COUNT(DISTINCT orders.order_id) AS Times_Repeated
FROM
    customers
JOIN orders
    ON customers.customer_id = orders.customer_id

GROUP BY
    customers.name
HAVING
    COUNT(DISTINCT orders.order_id) > 1
ORDER BY
    COUNT(DISTINCT orders.order_id) DESC;


--Running total of revenue by date --> Use: Window function

SELECT 
    order_date,
    daily_revenue,
    SUM(daily_revenue) OVER (ORDER BY order_date) AS running_total
FROM (
    SELECT 
        orders.order_date,
        SUM(products.price * order_items.quantity) AS daily_revenue
    FROM 
        orders
    JOIN order_items 
        ON orders.order_id = order_items.order_id
    JOIN products 
        ON order_items.product_id = products.product_id
    GROUP BY order_date
)
ORDER BY order_date;

-- Find top-selling product in each category -->Use: PARTITION BY

SELECT 
    category,
    product_id,
    product_name,
    total_quantity
FROM (
    SELECT 
        products.category,
        products.product_id,
        products.product_name,
        SUM(order_items.quantity) AS total_quantity,
        RANK() OVER (
            PARTITION BY products.category 
            ORDER BY SUM(order_items.quantity) DESC
        ) AS rnk
    FROM 
        products 
    JOIN order_items  
        ON products.product_id = order_items.product_id
    GROUP BY 
        products.category, 
        products.product_id, 
        products.product_name
)
WHERE rnk = 1;