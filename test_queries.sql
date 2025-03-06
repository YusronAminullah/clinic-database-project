-- Pengujian Query untuk Clinic Database

-- 1. Pengujian Insert Data Pasien
INSERT INTO patients (name, dob, address, phone) 
VALUES ('John Doe', '1990-05-15', 'Jl. Merdeka No.10', '08123456789');

-- 2. Pengujian Insert Data Dokter
INSERT INTO doctors (name, specialization, phone) 
VALUES ('Dr. Sarah Tan', 'Cardiology', '08129876543');

-- 3. Pengujian Insert Data Rekam Medis
INSERT INTO medical_records (patient_id, doctor_id, diagnosis, treatment, created_at) 
VALUES (1, 1, 'Hypertension', 'Blood Pressure Control', NOW());

-- 4. Pengujian Update Data Pasien
UPDATE patients 
SET phone = '08123400000' 
WHERE id = 1;

-- 5. Pengujian Delete Data Dokter
DELETE FROM doctors WHERE id = 2;

-- 6. Pengujian Pencarian Pasien berdasarkan Nama
SELECT * FROM patients WHERE name LIKE '%John%';

-- 7. Pengujian View Rekam Medis
SELECT * FROM medical_records_view;

-- 8. Pengujian Trigger (Status Tagihan Setelah Pembayaran)
INSERT INTO billing (patient_id, amount, status) 
VALUES (1, 500000, 'pending');

INSERT INTO payments (billing_id, date, method) 
VALUES (1, NOW(), 'Transfer Bank');

SELECT * FROM billing WHERE id = 1; -- Status harus berubah menjadi 'paid'

-- 9. Pengujian Performa Indexing
EXPLAIN SELECT * FROM patients WHERE name = 'John Doe';
