CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name TEXT,
    city TEXT,
    signup_date DATE
);

CREATE TABLE products (
    product_id NUMERIC PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price NUMERIC
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);