CREATE TABLE Course (
                        id SERIAL PRIMARY KEY,
                        title VARCHAR(100),
                        instructor VARCHAR(50),
                        price NUMERIC(15,2),
                        duration INT -- số giờ học
);

INSERT INTO Course (title, instructor, price, duration) VALUES
                                                            ('SQL cho người mới bắt đầu', 'Sơn Đặng', 500000.00, 20),
                                                            ('Lập trình Python cơ bản', 'Sơn Đặng', 0.00, 15),       -- Khóa học miễn phí
                                                            ('Thiết kế đồ họa Pro', 'Trần Trung', 2500000.00, 45),
                                                            ('Data Science Masterclass', 'Lê Nam', 8000000.00, 120),
                                                            ('Excel dành cho kế toán', 'Hoàng Minh', 350000.00, 10),
                                                            ('Lập trình Web ReactJS', 'Sơn Đặng', 1200000.00, 30),
                                                            ('Tiếng Anh giao tiếp cấp tốc', 'Ms. Hoa', 1500000.00, 24),
                                                            ('Tư duy giải thuật', 'Lê Nam', 750000.00, 18),
                                                            ('Digital Marketing cơ bản', 'Trần Trung', 0.00, 8),     -- Khóa học miễn phí
                                                            ('Học máy nâng cao', 'Lê Nam', 5500000.00, 60);

-- 2.
UPDATE course
SET price = price * 1.15
WHERE duration > 30;

-- 3.
DELETE FROM course
WHERE title = 'Demo';

-- 4.
SELECT * FROM course
WHERE title ilike '%SQL%';

-- 5.
SELECT * FROM course
WHERE price BETWEEN 500000 AND 2000000
ORDER BY price DESC ;