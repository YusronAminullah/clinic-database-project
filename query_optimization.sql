-- Optimasi Query untuk Clinic Database

-- 1. Menambahkan Index untuk Mempercepat Pencarian
CREATE INDEX idx_patient_name ON patients(name);
CREATE INDEX idx_doctor_specialization ON doctors(specialization);
CREATE INDEX idx_billing_status ON billing(status);

-- 2. Membuat Stored Procedure untuk Menambah Data Pasien
DELIMITER //
CREATE PROCEDURE AddPatient(
    IN p_name VARCHAR(100), 
    IN p_dob DATE, 
    IN p_address TEXT, 
    IN p_phone VARCHAR(15)
)
BEGIN
    INSERT INTO patients (name, dob, address, phone) VALUES (p_name, p_dob, p_address, p_phone);
END //
DELIMITER ;

-- 3. Membuat View untuk Melihat Rekam Medis dengan Informasi Lengkap
CREATE VIEW medical_records_view AS
SELECT 
    mr.id AS record_id,
    p.name AS patient_name,
    d.name AS doctor_name,
    d.specialization,
    mr.diagnosis,
    mr.treatment,
    mr.created_at
FROM medical_records mr
JOIN patients p ON mr.patient_id = p.id
JOIN doctors d ON mr.doctor_id = d.id;

-- 4. Membuat Trigger untuk Mengubah Status Tagihan Otomatis Setelah Pembayaran
DELIMITER //
CREATE TRIGGER update_billing_status 
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    UPDATE billing
    SET status = 'paid'
    WHERE id = NEW.billing_id;
END //
DELIMITER ;