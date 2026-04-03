CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           full_name VARCHAR(100),
                           email VARCHAR(100) UNIQUE,
                           city VARCHAR(50)
);

CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          product_name VARCHAR(100),
                          category TEXT[],
                          price NUMERIC(10,2)
);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES customers(customer_id),
                        product_id INT REFERENCES products(product_id),
                        order_date DATE,
                        quantity INT
);

INSERT INTO customers (full_name, email, city) VALUES
                                                   ('Nguyen Van A', 'a.nguyen@email.com', 'Hanoi'),
                                                   ('Tran Thi B', 'b.tran@email.com', 'Ho Chi Minh'),
                                                   ('Le Van C', 'c.le@email.com', 'Da Nang'),
                                                   ('Pham Thi D', 'd.pham@email.com', 'Hanoi'),
                                                   ('Hoang Van E', 'e.hoang@email.com', 'Can Tho'),
                                                   ('Vo Thi F', 'f.vo@email.com', 'Hai Phong');

INSERT INTO products (product_name, category, price) VALUES
                                                         ('Laptop Dell XPS', ARRAY['Electronics', 'Computers'], 1500.00),
                                                         ('iPhone 15 Pro', ARRAY['Electronics', 'Smartphones'], 1200.50),
                                                         ('Mechanical Keyboard', ARRAY['Accessories', 'Computers'], 150.00),
                                                         ('Samsung 4K TV', ARRAY['Electronics', 'Home Appliances'], 800.00),
                                                         ('Wireless Mouse', ARRAY['Accessories', 'Computers'], 50.00),
                                                         ('Bluetooth Speaker', ARRAY['Electronics', 'Audio'], 120.00),
                                                         ('Gaming Chair', ARRAY['Furniture', 'Gaming'], 250.00);

INSERT INTO orders (customer_id, product_id, order_date, quantity) VALUES
                                                                       (1, 1, '2023-11-01', 1),
                                                                       (1, 5, '2023-11-01', 2),
                                                                       (2, 2, '2023-11-02', 1),
                                                                       (3, 4, '2023-11-03', 1),
                                                                       (4, 3, '2023-11-04', 1),
                                                                       (4, 5, '2023-11-04', 1),
                                                                       (5, 7, '2023-11-05', 2),
                                                                       (6, 6, '2023-11-06', 3),
                                                                       (1, 2, '2023-11-10', 1),
                                                                       (2, 6, '2023-11-12', 1),
                                                                       (3, 1, '2023-11-15', 1),
                                                                       (5, 3, '2023-11-18', 1),
                                                                       (6, 4, '2023-11-20', 1);

-- 2. a.
CREATE INDEX idx_customers_email ON customers(email);
-- 2. b.
CREATE INDEX idx_hash_customers_city ON customers USING hash (city);
-- 2. c.
CREATE INDEX idx_gin_products_category ON products USING gin (category);
-- 2. d.
CREATE INDEX idx_gist_product_price ON products USING gist (price);

-- 3. a.
explain analyse SELECT c.full_name , c.email
FROM customers c;

-- 3. b.
explain analyse SELECT p.category
FROM products p
WHERE 'Electonics' = ANY(p.category); -- Electronics có nằm trong mảng category không?

explain analyse SELECT p.category
FROM products p
WHERE p.category @> ARRAY['Electronics']; -- category chứa Electronics

-- 3. c.
explain analyse SELECT p.product_name
FROM products p
WHERE price BETWEEN 500 AND 1000;

-- 3. d.

-- 4.
CREATE INDEX idx_orders_order_date ON orders(order_date);
CLUSTER orders USING idx_orders_order_date;

-- 5.
CREATE OR REPLACE VIEW vw AS
    SELECT c.full_name, c.customer_id, p.product_id, p.product_name, p.price
    FROM orders o
    JOIN customers c on c.customer_id = o.customer_id
    JOIN products p on p.product_id = o.product_id;

SELECT vw.customer_id, vw.full_name, SUM(vw.price) AS total_price
FROM vw
GROUP BY vw.customer_id, vw.full_name
ORDER BY total_price DESC LIMIT 3;

SELECT vw.product_name, vw.product_id, SUM(vw.price) AS total_price
FROM vw
GROUP BY vw.product_id, vw.product_name;

-- 6.
CREATE OR REPLACE VIEW v_customer_city As
SELECT c.customer_id, c.full_name, c.city
FROM customers c
WHERE city='Hanoi'
WITH CHECK OPTION;

UPDATE v_customer_city
SET city='Ninh Binh';