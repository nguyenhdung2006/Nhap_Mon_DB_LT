CREATE TABLE Customer (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100)
);

-- Dùng lại bảng Orders từ bài trước nhưng liên kết với bảng Customer này
CREATE TABLE Orders (
                        id SERIAL PRIMARY KEY,
                        customer_id INT REFERENCES Customer(id),
                        order_date DATE,
                        total_amount NUMERIC(15,2)
);

-- Thêm khách hàng
INSERT INTO Customer (name) VALUES
                                ('Anh Tuấn'),
                                ('Bích Phương'),
                                ('Cảnh Trần'),
                                ('Diệu Nhi'),
                                ('Ewan McGregor');

-- Thêm đơn hàng (Chỉ khách 1, 2, 3 mua đồ)
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
                                                               (1, '2024-03-01', 500000),
                                                               (1, '2024-03-05', 1200000),
                                                               (2, '2024-03-10', 350000),
                                                               (3, '2024-03-15', 2500000),
                                                               (2, '2024-03-20', 450000);
-- Khách 4 (Diệu Nhi) và 5 (Ewan) chưa mua gì.

-- 1.
SELECT
    c.name AS ten,
    o.total_amount AS tong_chi_tieu
From orders o
JOIN Customer c on c.id = o.customer_id;

-- 2.
SELECT
    c.name,
    SUM(o.total_amount) AS tong_chi_tieu
FROM Customer c
         JOIN Orders o ON c.id = o.customer_id
GROUP BY c.name
ORDER BY tong_chi_tieu DESC
LIMIT 1;

-- 3.
SELECT
    c.name AS khach_hang_chua_mua
FROM Customer c
         LEFT JOIN Orders o ON c.id = o.customer_id
WHERE o.id IS NULL;

-- 4.
SELECT
    c.name,
    SUM(o.total_amount) AS tong_chi_tieu
FROM Customer c
         JOIN Orders o ON c.id = o.customer_id
GROUP BY c.name
HAVING SUM(o.total_amount) > (
    SELECT AVG(sub.tong_ca_nhan)
    FROM (
             SELECT SUM(total_amount) AS tong_ca_nhan
             FROM Orders
             GROUP BY customer_id
         ) AS sub
);