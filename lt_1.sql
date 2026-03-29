CREATE TABLE Product (
                         id SERIAL PRIMARY KEY,
                         name VARCHAR(100),
                         category VARCHAR(50),
                         price NUMERIC(10,2),
                         stock INT
);

INSERT INTO Product (name, category, price, stock) VALUES
                                                       ('iPhone 15 Pro', 'Electronics', 1200.00, 10),
                                                       ('Samsung Galaxy S23', 'Electronics', 900.00, 5),
                                                       ('MacBook Air M2', 'Electronics', 1100.00, 0), -- Hết hàng để test stock = 0
                                                       ('Dell XPS 13', 'Electronics', 1300.00, 3),
                                                       ('T-Shirt Cotton', 'Clothing', 25.50, 50),
                                                       ('Jeans Slim Fit', 'Clothing', 45.00, 0),     -- Hết hàng
                                                       ('Nike Air Max', 'Shoes', 120.00, 15),
                                                       ('Adidas Ultraboost', 'Shoes', 150.00, 8),
                                                       ('Running Socks', 'Shoes', 10.00, 100),      -- Giá cực thấp
                                                       ('Office Chair', 'Furniture', 200.00, 12),
                                                       ('Gaming Desk', 'Furniture', 350.00, 4),
                                                       ('Bread', NULL, 2.00, 20);             -- Danh mục NULL để test xử lý lỗi

-- 2.
SELECT * FROM Product;

-- 3.
SELECT price FROM Product
order by price DESC
LIMIT 3;

-- 4.
SELECT DISTINCT category FROM Product
WHERE price < 10000000;

-- 5.
SELECT * FROM Product
order by stock;
