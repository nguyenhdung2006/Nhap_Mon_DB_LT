CREATE TABLE patients (
                          patient_id SERIAL PRIMARY KEY,
                          full_name VARCHAR(100),
                          phone VARCHAR(20),
                          city VARCHAR(50),
                          symptoms TEXT[]
);

CREATE TABLE doctors (
                         doctor_id SERIAL PRIMARY KEY,
                         full_name VARCHAR(100),
                         department VARCHAR(50)
);

CREATE TABLE appointments (
                              appointment_id SERIAL PRIMARY KEY,
                              patient_id INT REFERENCES patients(patient_id),
                              doctor_id INT REFERENCES doctors(doctor_id),
                              appointment_date DATE,
                              diagnosis VARCHAR(200),
                              fee NUMERIC(10,2)
);

INSERT INTO patients (full_name, phone, city, symptoms) VALUES
                                                            ('Nguyen Van A', '0901234567', 'Hanoi', ARRAY['Fever', 'Cough', 'Sore throat']),
                                                            ('Tran Thi B', '0987654321', 'Ho Chi Minh', ARRAY['Headache', 'Nausea']),
                                                            ('Le Van C', '0912223334', 'Da Nang', ARRAY['Back pain']);

INSERT INTO doctors (full_name, department) VALUES
                                                ('Dr. Tran Van D', 'Cardiology'),
                                                ('Dr. Nguyen Thi E', 'Neurology'),
                                                ('Dr. Pham Van F', 'General Medicine');

INSERT INTO appointments (patient_id, doctor_id, appointment_date, diagnosis, fee) VALUES
                                                                                       (1, 3, '2023-10-15', 'Viral Fever', 150000.00),
                                                                                       (2, 2, '2023-10-16', 'Migraine', 350000.50),
                                                                                       (3, 1, '2023-10-18', 'Muscle Strain', 200000.00);

-- 2. a.
CREATE INDEX idx_patients_phone ON patients(phone);
-- 2. b.
CREATE INDEX idx_hash_patients_city ON patients USING hash (city);
-- 2. c.
CREATE INDEX idx_gin_patients_symtoms ON patients USING gin(symptoms);
-- 2. d.
CREATE EXTENSION btree_gist;
CREATE INDEX idx_gist_appointments_fee ON appointments USING gist(fee);

-- 3.
CREATE index idx_appointments_date ON appointments(appointment_date);
CLUSTER appointments using idx_appointments_date;

-- 4.
CREATE OR REPLACE VIEW vw_doctors_patients AS
SELECT p.patient_id, p.full_name, a.fee,
       d.doctor_id, d.full_name AS ten_bac_si,
       a.appointment_id
FROM appointments a
         JOIN patients p ON p.patient_id = a.patient_id
         JOIN doctors d ON d.doctor_id = a.doctor_id;

-- 4. a.
SELECT vdp.patient_id, Sum(vdp.fee) AS tong_chi_phi
From vw_doctors_patients vdp
GROUP BY vdp.patient_id
ORDER BY tong_chi_phi LIMIT 3;

-- 4. b.
SELECT vdp.doctor_id, vdp.ten_bac_si, vdp.full_name, count(appointment_id) AS tong_luot_kham
From vw_doctors_patients vdp
GROUP BY vdp.doctor_id, vdp.ten_bac_si, vdp.full_name ;

-- 5.
CREATE OR REPLACE VIEW v_patient_city As
SELECT p.patient_id, p.full_name, p.city
FROM patients p
    WHERE city='Hanoi'
WITH CHECK OPTION;

UPDATE v_patient_city v
SET city='Ninh Binh';
