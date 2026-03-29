CREATE TABLE OldCustomers (
                              id SERIAL PRIMARY KEY,
                              name VARCHAR(100),
                              city VARCHAR(50)
);

CREATE TABLE NewCustomers (
                              id SERIAL PRIMARY KEY,
                              name VARCHAR(100),
                              city VARCHAR(50)
);

-- Thêm dữ liệu mẫu
INSERT INTO OldCustomers (name, city) VALUES
                                          ('Anh Tuấn', 'Hà Nội'),
                                          ('Bích Phương', 'Đà Nẵng'),
                                          ('Cảnh Trần', 'TP.HCM');

INSERT INTO NewCustomers (name, city) VALUES
                                          ('Diệu Nhi', 'Hà Nội'),
                                          ('Anh Tuấn', 'Hà Nội'), -- Khách hàng cũ quay lại (Trùng lặp)
                                          ('Gia Bảo', 'Cần Thơ');

-- 1.
SELECT name, city FROM OldCustomers
UNION
SELECT name, city FROM NewCustomers;

-- 2.
SELECT name, city FROM OldCustomers
INTERSECT
SELECT name, city FROM NewCustomers;

-- 3.
SELECT city, COUNT(*) AS so_luong_khach
FROM (
         SELECT name, city FROM OldCustomers
         UNION
         SELECT name, city FROM NewCustomers
     ) AS all_customers
GROUP BY city;

-- 4.
SELECT city, COUNT(*) AS so_luong_khach
FROM (
         SELECT name, city FROM OldCustomers
         UNION
         SELECT name, city FROM NewCustomers
     ) AS all_customers
GROUP BY city;