CREATE TABLE Product (
                         id SERIAL PRIMARY KEY,
                         name VARCHAR(100),
                         category VARCHAR(50),
                         price NUMERIC(15,2) -- Đã nới rộng để chứa tiền triệu
);

CREATE TABLE OrderDetail (
                             id SERIAL PRIMARY KEY,
                             order_id INT,
                             product_id INT REFERENCES Product(id),
                             quantity INT
);

-- Thêm sản phẩm
INSERT INTO Product (name, category, price) VALUES
                                                ('Chuột Gaming', 'Phụ kiện', 800000),
                                                ('Bàn phím cơ', 'Phụ kiện', 1500000),
                                                ('Màn hình 24 inch', 'Thiết bị', 3500000),
                                                ('Tai nghe chống ồn', 'Phụ kiện', 2200000),
                                                ('Laptop Văn Phòng', 'Thiết bị', 15000000);

-- Thêm chi tiết đơn hàng
INSERT INTO OrderDetail (order_id, product_id, quantity) VALUES
                                                             (1, 1, 2), -- Đơn 1 mua 2 chuột
                                                             (1, 2, 1), -- Đơn 1 mua thêm 1 bàn phím
                                                             (2, 3, 1), -- Đơn 2 mua 1 màn hình
                                                             (3, 1, 5), -- Đơn 3 mua sỉ 5 chuột
                                                             (3, 5, 1), -- Đơn 3 mua thêm 1 laptop
                                                             (4, 4, 2); -- Đơn 4 mua 2 tai nghe

-- 1.
SELECT
    p.name AS product_name,
    SUM(p.price * od.quantity) AS total_sales
FROM Product p
         JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.name;

-- 2.
SELECT
    p.category,
    AVG(p.price * od.quantity)::DECIMAL(15,0) AS avg_revenue_category
FROM Product p
         JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.category;

-- 3.
SELECT
    p.category,
    AVG(p.price * od.quantity) AS avg_revenue
FROM Product p
         JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.category
HAVING AVG(p.price * od.quantity) > 20000000;

-- 4.
SELECT
    p.name,
    SUM(p.price * od.quantity) AS total_product_sales
FROM Product p
         JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.name
HAVING SUM(p.price * od.quantity) > (
    SELECT AVG(sub.total)
    FROM (
             SELECT SUM(p2.price * od2.quantity) AS total
             FROM Product p2
                      JOIN OrderDetail od2 ON p2.id = od2.product_id
             GROUP BY p2.id
         ) AS sub
);
-- 5.
SELECT
    p.name,
    COALESCE(SUM(od.quantity), 0) AS total_quantity_sold
FROM Product p
         LEFT JOIN OrderDetail od ON p.id = od.product_id
GROUP BY p.name
ORDER BY total_quantity_sold DESC;