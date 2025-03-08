USE clinic_db;

-- ===========================================
-- 1. INDEXING
-- ===========================================
-- Index tambahan (sebagian sudah dibuat di file utama)
-- Hanya contoh jika ingin menambah index lain

CREATE INDEX idx_service_name ON services(service_name);
CREATE INDEX idx_test_type ON lab_results(test_type);
CREATE INDEX idx_policy_number ON insurance(policy_number);

-- ===========================================
-- 2. STORED PROCEDURES
-- ===========================================

DELIMITER //

-- Contoh SP: Menjadwalkan Janji Temu
CREATE PROCEDURE ScheduleAppointment (
    IN p_patient_id INT,
    IN p_doctor_id INT,
    IN p_appointment_datetime DATETIME,
    IN p_notes TEXT
)
BEGIN
    INSERT INTO appointments (patient_id, doctor_id, appointment_date, status, notes)
    VALUES (p_patient_id, p_doctor_id, p_appointment_datetime, 'Scheduled', p_notes);
END //

-- Contoh SP: Menambah Layanan ke Janji Temu
CREATE PROCEDURE AddServiceToAppointment (
    IN p_appointment_id INT,
    IN p_service_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_price DECIMAL(10,2);

    -- Ambil harga layanan
    SELECT price INTO v_price
    FROM services
    WHERE service_id = p_service_id;

    -- Masukkan ke tabel appointment_services
    INSERT INTO appointment_services (appointment_id, service_id, quantity, service_cost)
    VALUES (p_appointment_id, p_service_id, p_quantity, v_price * p_quantity);
END //

-- Contoh SP: Melakukan Pembayaran Tagihan
CREATE PROCEDURE PayBilling (
    IN p_bill_id INT,
    IN p_method ENUM('Cash','CreditCard','Insurance','Transfer')
)
BEGIN
    UPDATE billing
    SET status = 'Paid',
        payment_method = p_method,
        payment_date = NOW()
    WHERE bill_id = p_bill_id;
END //

DELIMITER ;

-- ===========================================
-- 3. TRIGGERS
-- ===========================================

DELIMITER //

-- Trigger: Saat menambahkan layanan baru ke janji temu, perbarui total_amount di billing (jika sudah ada billing)
CREATE TRIGGER trg_after_insert_appointment_services
AFTER INSERT ON appointment_services
FOR EACH ROW
BEGIN
    DECLARE v_current_total DECIMAL(10,2) DEFAULT 0;

    -- Ambil total_amount saat ini dari billing
    SELECT total_amount INTO v_current_total
    FROM billing
    WHERE appointment_id = NEW.appointment_id
    LIMIT 1;

    -- Jika billing untuk appointment ini ada, update total_amount
    IF v_current_total IS NOT NULL THEN
        UPDATE billing
        SET total_amount = v_current_total + NEW.service_cost
        WHERE appointment_id = NEW.appointment_id;
    END IF;
END //

-- Trigger: Saat menghapus layanan dari janji temu, turunkan total_amount di billing
CREATE TRIGGER trg_after_delete_appointment_services
AFTER DELETE ON appointment_services
FOR EACH ROW
BEGIN
    DECLARE v_current_total DECIMAL(10,2) DEFAULT 0;

    SELECT total_amount INTO v_current_total
    FROM billing
    WHERE appointment_id = OLD.appointment_id
    LIMIT 1;

    IF v_current_total IS NOT NULL THEN
        UPDATE billing
        SET total_amount = v_current_total - OLD.service_cost
        WHERE appointment_id = OLD.appointment_id;
    END IF;
END //

DELIMITER ;

-- ===========================================
-- Catatan:
-- 1. Pastikan kolom/tipe data di billing, appointments, dsb. sesuai dengan yang ada di database.
-- 2. Stored Procedures & Triggers di atas hanya contoh. Silakan sesuaikan dengan kebutuhan aplikasi.
-- 3. Gunakan EXPLAIN untuk mengecek penggunaan index pada query.
-- ===========================================
