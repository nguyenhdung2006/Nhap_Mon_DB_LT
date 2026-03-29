CREATE TABLE Employee (
                          id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          department VARCHAR(50),
                          salary NUMERIC(10,2),
                          hire_date DATE
);

INSERT INTO Employee (full_name, department, salary, hire_date) VALUES
                                                                    ('Alice Nguyen', 'IT', 25000000, '2020-05-15'),   -- 25 triệu
                                                                    ('Bob Tran', 'IT', 45000000, '2019-02-10'),      -- 45 triệu
                                                                    ('Charlie Le', 'HR', 12000000, '2022-11-01'),    -- 12 triệu
                                                                    ('David Pham', 'HR', 8500000, '2023-01-20'),     -- 8.5 triệu
                                                                    ('Eve Hoang', 'Marketing', 18000000, '2021-06-30'),
                                                                    ('Frank Doan', 'Marketing', 7000000, '2024-03-01'), -- Nhân viên mới/Thực tập
                                                                    ('Grace Vu', 'IT', 120000000, '2018-12-12'),     -- 120 triệu (Sếp IT)
                                                                    ('Henry Dang', 'Finance', 35000000, '2020-10-05'),
                                                                    ('Ivy Bui', NULL, 10000000, '2024-03-25'),       -- 10 triệu
                                                                    ('Jack Do', 'Finance', 55000000, '2017-05-01'),   -- 55 triệu
                                                                    ('Alice Nguyen', 'Marketing', 15000000, '2023-05-15');

-- 2.
update Employee
SET salary = salary*1.1
where department = 'IT';

-- 3.
DELETE FROM Employee
WHERE salary < 6000000;

-- 4.
SELECT * FROM Employee
WHERE full_name ilike '%AN%';

-- 5.
SELECT * FROM Employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';
