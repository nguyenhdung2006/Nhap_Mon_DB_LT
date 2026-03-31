CREATE TABLE customer (
                          customer_id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          email VARCHAR(100),
                          phone VARCHAR(15)
);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customer(customer_id),
                        total_amount DECIMAL(10,2),
                        order_date DATE
);

INSERT INTO customer (full_name, email, phone) VALUES
                                                   ('Nguyen Van A', 'nguyenvana@gmail.com', '0901234567'),
                                                   ('Tran Thi B', 'tranthib@gmail.com', '0987654321'),
                                                   ('Le Van C', 'levanc@gmail.com', '0911222333');

INSERT INTO orders (customer_id, total_amount, order_date) VALUES
                                                               (1, 1500000.00, '2023-10-01'),
                                                               (1, 500000.00, '2023-10-15'),
                                                               (2, 2500000.00, '2023-11-05'),
                                                               (3, 800000.00, '2023-11-20'),
                                                               (2, 1200000.00, '2023-12-01');

CREATE VIEW v_order_summary AS
SELECT
    c.full_name,
    o.total_amount,
    o.order_date
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id;

SELECT * FROM v_order_summary;

CREATE VIEW v_high_value_orders AS
SELECT * FROM orders
WHERE total_amount >= 1000000;

UPDATE v_high_value_orders
SET total_amount = 1500000
WHERE order_id = 1;

CREATE VIEW v_monthly_sales AS
SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY TO_CHAR(order_date, 'YYYY-MM');

DROP VIEW v_order_summary;