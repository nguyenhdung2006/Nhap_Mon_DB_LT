CREATE TABLE OrderInfo (
                           id SERIAL PRIMARY KEY,
                           customer_id INT, -- Liên kết với bảng Customer bạn vừa tạo
                           order_date DATE,
                           total NUMERIC(15,2), -- Nới rộng để chứa được tiền triệu VNĐ
                           status VARCHAR(20)
);

INSERT INTO OrderInfo (customer_id, order_date, total, status) VALUES
                                                                   (1, '2024-01-10', 1500000.00, 'Completed'), -- Khách 1 mua 1.5tr
                                                                   (2, '2024-01-15', 500000.00, 'Completed'),
                                                                   (1, '2024-02-05', 2300000.00, 'Completed'), -- Khách 1 quay lại mua tiếp
                                                                   (3, '2024-02-10', 0.00, 'Cancelled'),       -- Đơn bị hủy
                                                                   (4, '2024-03-01', 12000000.00, 'Completed'), -- Đơn hàng lớn 12tr
                                                                   (5, '2024-03-12', 350000.00, 'Pending'),     -- Đang chờ xử lý
                                                                   (2, '2024-03-15', 800000.00, 'Completed'),
                                                                   (6, '2024-03-20', 4500000.00, 'Shipped'),    -- Đang giao hàng
                                                                   (1, '2024-03-22', 1000000.00, 'Completed'),  -- Khách 1 mua lần 3
                                                                   (8, '2024-03-25', 950000.00, 'Completed');

-- 2.
SELECT * FROM OrderInfo
WHERE total > 500000;

-- 3.
SELECT * FROM OrderInfo
WHERE order_date BETWEEN '2024-10-01' AND '2024-10-31';

-- 4.
SELECT * FROM OrderInfo
WHERE status != 'Completed';

-- 5.
SELECT * FROM OrderInfo
ORDER BY order_date DESC
LIMIT 2;