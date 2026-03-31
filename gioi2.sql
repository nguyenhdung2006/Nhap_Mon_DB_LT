CREATE TABLE customer (
                          customer_id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          region VARCHAR(50)
);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customer(customer_id),
                        total_amount DECIMAL(10,2),
                        order_date DATE,
                        status VARCHAR(20)
);

CREATE TABLE product (
                         product_id SERIAL PRIMARY KEY,
                         name VARCHAR(100),
                         price DECIMAL(10,2),
                         category VARCHAR(50)
);

CREATE TABLE order_detail (
                              order_id INT REFERENCES orders(order_id),
                              product_id INT REFERENCES product(product_id),
                              quantity INT
);

INSERT INTO customer (full_name, region) VALUES
                                             ('Nguyen Van A', 'Miền Bắc'),
                                             ('Tran Thi B', 'Miền Nam'),
                                             ('Le Van C', 'Miền Trung'),
                                             ('Pham Thi D', 'Miền Bắc'),
                                             ('Hoang Van E', 'Miền Nam'),
                                             ('Vu Thi F', 'Miền Tây');

INSERT INTO orders (customer_id, total_amount, order_date, status) VALUES
                                                                       (1, 5000000.00, '2023-01-10', 'Completed'),
                                                                       (2, 8000000.00, '2023-02-15', 'Completed'),
                                                                       (3, 3000000.00, '2023-03-20', 'Completed'),
                                                                       (4, 7000000.00, '2023-04-25', 'Completed'),
                                                                       (5, 4000000.00, '2023-05-30', 'Completed'),
                                                                       (1, 2000000.00, '2023-06-05', 'Completed'),
                                                                       (6, 1500000.00, '2023-07-10', 'Completed');

INSERT INTO product (name, price, category) VALUES
                                                ('Laptop', 15000000.00, 'Electronics'),
                                                ('Áo thun', 250000.00, 'Clothing'),
                                                ('Bàn làm việc', 1200000.00, 'Furniture');

INSERT INTO order_detail (order_id, product_id, quantity) VALUES
                                                              (1, 1, 1), (1, 2, 4),
                                                              (2, 1, 1),
                                                              (3, 3, 2),
                                                              (4, 1, 1), (4, 3, 1),
                                                              (5, 3, 3),
                                                              (6, 2, 8),
                                                              (7, 2, 6);


CREATE VIEW v_revenue_by_region AS
SELECT c.region, SUM(o.total_amount) AS total_revenue
FROM customer c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region;

SELECT * FROM v_revenue_by_region
ORDER BY total_revenue DESC
LIMIT 3;


CREATE VIEW v_revenue_above_avg AS
SELECT * FROM v_revenue_by_region
WHERE total_revenue > (SELECT AVG(total_revenue) FROM v_revenue_by_region);
