/*
1. Identify customers who haven’t ordered in last 6 months
2. Find products that are never ordered
3. Which category has highest average order value
4. Find peak sales day
5. Customer segmentation:
•	High value (> ₹50,000)
•	Medium
•	Low
*/

-- Identify customers who haven’t ordered in last 6 months

SELECT 
    customers.customer_id,
    customers.name,
    MAX(orders.order_date) AS last_order_date
FROM 
    customers
JOIN orders 
    ON customers.customer_id = orders.customer_id
GROUP BY 
    customers.customer_id, 
    customers.name
HAVING 
    MAX(orders.order_date) IS NULL
    OR MAX(orders.order_date) < CURRENT_DATE - INTERVAL '6 months';


--Find products that are never ordered

SELECT 
    products.product_id,
    products.product_name
FROM 
    products
LEFT JOIN order_items
    ON products.product_id = order_items.product_id
WHERE 
    order_items.product_id IS NULL;

-- Which category has highest average order value

SELECT
    products.category,
    SUM(order_items.quantity * products.price)/COUNT(orders.order_id)
FROM
    products
JOIN order_items
    ON products.product_id = order_items.product_id
JOIN orders
    ON order_items.order_id = orders.order_id
GROUP BY
    products.category
ORDER BY
    SUM(order_items.quantity * products.price)/COUNT(orders.order_id) 
    DESC
LIMIT 1;

-- Find peak sales day

SELECT
    orders.order_date,
    COUNT(order_items.quantity)
FROM
    orders
JOIN order_items
    ON orders.order_id = order_items.order_id
GROUP BY
    orders.order_date
ORDER BY
    COUNT(order_items.quantity) DESC
LIMIT 1;

/* Customer segmentation:
•	High value (> ₹50,000)
•	Medium
•	Low
*/
SELECT 
    customers.customer_id,
    customers.name,
    COALESCE(SUM(products.price * order_items.quantity), 0) AS total_spent,
    CASE 
        WHEN COALESCE(SUM(products.price * order_items.quantity), 0) > 50000 THEN 'High Value'
        WHEN COALESCE(SUM(products.price * order_items.quantity), 0) BETWEEN 20000 AND 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM 
    customers
LEFT JOIN orders  
    ON customers.customer_id = orders.customer_id
LEFT JOIN order_items 
    ON orders.order_id = order_items.order_id
LEFT JOIN products
    ON order_items.product_id = products.product_id
GROUP BY 
    customers.customer_id, 
    customers.name;


/* SELECT
    customers.customer_id,
    customers.name,
    SUM(order_items.quantity * products.price)/COUNT(orders.order_id),
    CASE
        WHEN SUM(order_items.quantity * products.price)/COUNT(orders.order_id) < 20000
            THEN "Low"
        WHEN SUM(order_items.quantity * products.price)/COUNT(orders.order_id) BETWEEN 20000 AND 50000
            THEN "Medium" 
        ELSE "High"
    END AS customer_segment
FROM 
    customers
LEFT JOIN orders
    ON customers.customer_id = orders.customer_id
LEFT JOIN order_items
    ON orders.order_id = order_items.order_id
LEFT JOIN products
    ON order_items.product_id = products.product_id
GROUP BY
    customers.customer_id
    customers.name
ORDER BY
    SUM(order_items.quantity * products.price)/COUNT(orders.order_id);
*/