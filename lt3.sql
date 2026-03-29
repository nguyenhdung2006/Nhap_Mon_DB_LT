CREATE TABLE Customer (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          email VARCHAR(100),
                          phone VARCHAR(20),
                          points INT
);

INSERT INTO Customer (name, email, phone, points) VALUES
                                                      ('Nguyen Van A', 'vana@gmail.com', '0901234567', 1500), -- Khách VIP
                                                      ('Tran Thi B', 'thib@yahoo.com', '0912345678', 450),    -- Khách trung bình
                                                      ('Le Van C', 'vanc@outlook.com', NULL, 50),            -- Thiếu số điện thoại
                                                      ('Pham Minh D', 'minhd@gmail.com', '0987654321', 2500), -- Khách siêu VIP
                                                      ('Hoang Thi E', 'thie@gmail.com', '0933445566', 0),    -- Khách mới (0 điểm)
                                                      ('Ngo Van F', 'vanf@gmail.com', '0944556677', 800),
                                                      ('Vu Tuyet G', 'tuyetg@gmail.com', '0955667788', 120),
                                                      ('Dang Van H', 'vanh@gmail.com', '0966778899', 3000),  -- Điểm cao nhất
                                                      ('Bui Minh I', 'minhi@gmail.com', '0977889900', 950),
                                                      ('Do Hoang J', 'vana@gmail.com', '0988990011', 100);   -- Trùng email với ông A để test trùng lặp

-- 2.
SELECT DISTINCT name FROM Customer;

-- 3.
SELECT Customer.email FROM Customer
WHERE email is null;

-- 4.
SELECT name
FROM Customer
ORDER BY points DESC
LIMIT 3 OFFSET 1;

-- 5.
SELECT * FROM Customer
order by name DESC ;

