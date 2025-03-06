-- Membuat database
CREATE DATABASE clinic_db;
USE clinic_db;

-- Tabel pasien
CREATE TABLE patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    address TEXT NOT NULL,
    phone VARCHAR(15) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel dokter
CREATE TABLE doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel rekam medis
CREATE TABLE medical_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis TEXT NOT NULL,
    treatment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE
);

-- Tabel tagihan
CREATE TABLE billing (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'paid') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
);

-- Tabel pembayaran
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    billing_id INT,
    payment_date DATE NOT NULL,
    method ENUM('cash', 'credit_card', 'insurance') NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (billing_id) REFERENCES billing(id) ON DELETE CASCADE
);

-- Menambahkan data contoh untuk tabel patients
INSERT INTO patients (name, dob, address, phone) VALUES
('Ahmad Rahman', '1990-05-21', 'Jl. Merdeka No. 10, Jakarta', '081234567890'),
('Siti Aisyah', '1985-07-15', 'Jl. Kemerdekaan No. 22, Bandung', '081298765432');

-- Menambahkan data contoh untuk tabel doctors
INSERT INTO doctors (name, specialization, phone) VALUES
('Dr. Budi Santoso', 'Umum', '081212345678'),
('Dr. Lilis Wahyuni', 'Spesialis Bedah', '081223456789');

-- Menambahkan data contoh untuk tabel medical_records
INSERT INTO medical_records (patient_id, doctor_id, diagnosis, treatment) VALUES
(1, 1, 'Demam dan flu', 'Istirahat cukup dan minum obat paracetamol'),
(2, 2, 'Fraktur lengan kiri', 'Operasi ringan dan pemasangan gips');

-- Menambahkan data contoh untuk tabel billing
INSERT INTO billing (patient_id, amount, status) VALUES
(1, 150000, 'pending'),
(2, 200000, 'paid');

-- Menambahkan data contoh untuk tabel payments
INSERT INTO payments (billing_id, payment_date, method, amount) VALUES
(2, '2025-03-07', 'cash', 200000);
