/*
1. Show all orders with customer names --> Tables: orders + customers
2. List order details with product names and quantity  --> Tables: order_items + products
3. Get customer name, order date, and product purchased --> Tables: ALL (4-table join )
4. Find all orders where product category is "Electronics" --> Multi-table filtering
5. Show orders made by customers from Ahmedabad --> Join + condition
*/


-- Show all orders with customer names

SELECT
    customers.NAME,
    orders.order_id
FROM 
    customers
JOIN orders
    ON customers.customer_id = orders.customer_id;

-- List order details with product names and quantity

SELECT
    products.product_name,
    order_items.order_id,
    order_items.order_item_id,
    order_items.product_id,
    order_items.quantity
FROM 
    order_items
JOIN products
    ON order_items.product_id = products.product_id;

-- Get customer name, order date, and product purchased

SELECT
    customers.name,
    orders.order_date,
    products.product_name AS product_purchased
FROM
    customers
JOIN orders
    ON customers.customer_id = orders.customer_id
JOIN products
    ON orders.order_id = products.product_id;

-- Find all orders where product category is "Electronics"

SELECT
    orders.order_id,
    products.category
FROM
    orders
JOIN order_items
    ON orders.order_id = order_items.order_id
JOIN products
    ON order_items.product_id = products.product_id
WHERE products.category = 'Electronics';

-- Show orders made by customers from Ahmedabad

SELECT
    orders.order_id,
    customers.name AS customer_name,
    customers.city
FROM
    orders
JOIN customers
    ON orders.customer_id = customers.customer_id
WHERE customers.city = 'Ahmedabad';