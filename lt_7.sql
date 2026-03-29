CREATE TABLE Department (
                            id SERIAL PRIMARY KEY,
                            name VARCHAR(50)
);

CREATE TABLE Employee (
                          id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          department_id INT REFERENCES Department(id),
                          salary NUMERIC(15,2) -- Đã chỉnh lên 15 để chứa tiền triệu VNĐ
);

-- Thêm phòng ban
INSERT INTO Department (name) VALUES
                                  ('Kỹ thuật'),
                                  ('Nhân sự'),
                                  ('Kinh doanh'),
                                  ('Marketing');

-- Thêm nhân viên
INSERT INTO Employee (full_name, department_id, salary) VALUES
                                                            ('Nguyễn Văn A', 1, 25000000), -- Kỹ thuật
                                                            ('Trần Thị B', 1, 35000000),   -- Kỹ thuật
                                                            ('Lê Văn C', 2, 15000000),    -- Nhân sự
                                                            ('Phạm Minh D', 3, 45000000),  -- Kinh doanh
                                                            ('Hoàng Thị E', 3, 12000000),  -- Kinh doanh
                                                            ('Ngô Văn F', NULL, 10000000); -- Nhân viên tự do (test LEFT JOIN)

-- 1.
SELECT
    e.full_name ,
    d.name
FROM Employee e
JOIN Department d on d.id = e.department_id;

-- 2.
SELECT
    d.name ,
    AVG(e.salary)::DECIMAL(10, 2) AS luong_trung_binh
FROM Employee e
         JOIN Department d on d.id = e.department_id
GROUP BY d.name;

-- 3.
SELECT
    d.name ,
    AVG(e.salary)::DECIMAL(10, 2) AS luong_trung_binh
FROM Employee e
         JOIN Department d on d.id = e.department_id
GROUP BY d.name
HAVING AVG(e.salary) > 10000000;

-- 4.
SELECT
    d.name AS ten_phong_trong
FROM Department d
         LEFT JOIN Employee e ON d.id = e.department_id
WHERE e.id IS NULL;