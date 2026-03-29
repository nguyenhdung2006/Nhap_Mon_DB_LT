CREATE TABLE Orders (
                        id SERIAL PRIMARY KEY,
                        customer_id INT,
                        order_date DATE,
                        total_amount NUMERIC(15,2) -- Để 15 để thoải mái lưu tiền triệu VNĐ
);

INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
                                                               (1, '2024-01-05', 1200000.00), -- Khách 1 mua 1.2tr
                                                               (2, '2024-01-12', 450000.00),
                                                               (3, '2024-02-15', 5600000.00),  -- Đơn hàng lớn
                                                               (1, '2024-02-20', 800000.00),   -- Khách 1 quay lại
                                                               (4, '2024-03-05', 15000000.00), -- Khách 4 mua sỉ 15tr
                                                               (2, '2024-03-10', 300000.00),
                                                               (5, '2024-03-15', 2100000.00),
                                                               (1, '2024-03-22', 900000.00),   -- Khách 1 mua lần thứ 3
                                                               (6, '2024-03-25', 120000.00),   -- Đơn hàng nhỏ nhất
                                                               (7, '2024-03-28', 3500000.00);

-- 1.
SELECT
    SUM(total_amount) AS total_revenue ,
    COUNT(DISTINCT customer_id) AS total_orders ,
    AVG(total_amount) AS average_order_value
FROM Orders;

-- 2.
SELECT
    EXTRACT(YEAR FROM order_date) AS nam_dat_hang,
    SUM(total_amount) AS doanh_thu_theo_nam
FROM Orders
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY nam_dat_hang;

-- 3.
SELECT
    EXTRACT(YEAR FROM order_date) AS nam_dat_hang ,
    SUM(total_amount) AS tong_doanh_thu
From Orders
GROUP BY EXTRACT(YEAR FROM order_date)
HAVING SUM(total_amount) > 5000000;

-- 4.
SELECT * FROM Orders
ORDER BY total_amount DESC
LIMIT 5;