USE clinic_db;

-- ==============================================
-- 1. PENGUJIAN INSERT DATA PASIEN
-- ==============================================
INSERT INTO patients (full_name, date_of_birth, gender, phone, email, address)
VALUES
('Test Patient', '1995-01-01', 'Male', '081234567900', 'test@patient.com', 'Jl. Testing No.1');

-- ==============================================
-- 2. PENGUJIAN UPDATE DATA DOKTER
-- ==============================================
UPDATE doctors
SET phone = '081233344455'
WHERE doctor_id = 1;

-- ==============================================
-- 3. PENGUJIAN DELETE LAYANAN
-- ==============================================
-- Pastikan service_id=3 benar-benar ada (misal 'X-Ray').
DELETE FROM services
WHERE service_id = 3;

-- ==============================================
-- 4. PENGUJIAN STORED PROCEDURE: ScheduleAppointment
-- ==============================================
-- Menjadwalkan janji temu baru untuk pasien_id=1, doctor_id=1
DELIMITER //
CALL ScheduleAppointment(
    1,                   -- p_patient_id
    1,                   -- p_doctor_id
    '2025-04-05 08:00:00', -- p_appointment_datetime
    'Check up for Testing' -- p_notes
);
DELIMITER ;

-- ==============================================
-- 5. PENGUJIAN STORED PROCEDURE: AddServiceToAppointment
-- ==============================================
-- Asumsikan appointment_id=3 adalah hasil dari schedule baru di atas
DELIMITER //
CALL AddServiceToAppointment(
    3,   -- p_appointment_id
    1,   -- p_service_id (General Checkup)
    1    -- p_quantity
);
DELIMITER ;

-- ==============================================
-- 6. PENGUJIAN STORED PROCEDURE: PayBilling
-- ==============================================
-- Asumsikan bill_id=1 adalah tagihan yang ingin dibayar
DELIMITER //
CALL PayBilling(
    1,          -- p_bill_id
    'Cash'      -- p_method
);
DELIMITER ;

-- ==============================================
-- 7. PENGUJIAN TRIGGER: Insert ke appointment_services
-- ==============================================
-- Tambah layanan baru untuk janji temu #1
INSERT INTO appointment_services (appointment_id, service_id, quantity, service_cost)
VALUES (1, 2, 1, 50000.00);

-- Periksa billing terkait appointment_id=1 untuk memastikan total_amount berubah

-- ==============================================
-- 8. PENGUJIAN TRIGGER: Delete di appointment_services
-- ==============================================
-- Hapus layanan dengan appt_service_id=1 (sesuaikan ID)
DELETE FROM appointment_services
WHERE appt_service_id = 1;

-- ==============================================
-- 9. PENGUJIAN QUERY DENGAN INDEX
-- ==============================================
EXPLAIN SELECT * FROM patients
WHERE phone = '08123456789';

-- ==============================================
-- 10. PENGUJIAN SELECT JOIN REKAM MEDIS
-- ==============================================
SELECT 
    p.full_name AS patient_name, 
    d.full_name AS doctor_name, 
    m.diagnosis, 
    m.treatment
FROM medical_records m
JOIN patients p ON m.patient_id = p.patient_id
JOIN doctors d ON m.doctor_id = d.doctor_id
WHERE m.record_id = 1;

-- ==============================================
-- Note:
-- - Sesuaikan ID (doctor_id, appointment_id, service_id, dsb.) dengan data di database Anda.
-- - DELIMITER hanya diperlukan jika stored procedure tidak disimpan di database, 
--   atau jika Anda mengeksekusi statement yang mengandung tanda ; di MySQL console.
-- ==============================================
