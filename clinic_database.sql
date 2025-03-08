-- STRUKTUR DATABASE KLINIK

CREATE DATABASE clinic_db;
USE clinic_db;

-- Tabel Pasien
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX (email),
    INDEX (phone)
);

-- Tabel Dokter
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX (email),
    INDEX (phone)
);

-- Tabel Layanan Klinik
CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Tabel Janji Temu
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE,
    INDEX (appointment_date)
);

-- Tabel Penghubung Janji Temu & Layanan (Many-to-many)
CREATE TABLE appointment_services (
    appt_service_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity INT DEFAULT 1,
    service_cost DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE
);

-- Tabel Rekam Medis
CREATE TABLE medical_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    diagnosis TEXT NOT NULL,
    treatment TEXT NOT NULL,
    prescription TEXT,
    symptoms TEXT,
    allergies TEXT,
    blood_pressure VARCHAR(20),
    record_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE
);

-- Tabel Hasil Lab
CREATE TABLE lab_results (
    lab_id INT AUTO_INCREMENT PRIMARY KEY,
    record_id INT NOT NULL,
    test_type VARCHAR(100) NOT NULL,
    test_date DATE NOT NULL,
    results TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (record_id) REFERENCES medical_records(record_id) ON DELETE CASCADE
);

-- Tabel Asuransi
CREATE TABLE insurance (
    insurance_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    provider_name VARCHAR(100) NOT NULL,
    policy_number VARCHAR(50) NOT NULL,
    valid_until DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE
);

-- Tabel Tagihan
CREATE TABLE billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    appointment_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('Unpaid', 'Paid', 'Cancelled') DEFAULT 'Unpaid',
    payment_method ENUM('Cash','CreditCard','Insurance','Transfer') DEFAULT 'Cash',
    payment_date TIMESTAMP NULL DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE CASCADE
);

-- Tabel Pengguna (Login)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin','Doctor','Receptionist') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Data Contoh Tabel Patients
INSERT INTO patients (full_name, date_of_birth, gender, phone, email, address)
VALUES
('Budi Santoso','1985-06-15','Male','08123456789','budi@example.com','Jl. Merdeka No.10'),
('Siti Aminah','1992-09-22','Female','08234567890','siti@example.com','Jl. Mawar No.5');

-- Data Contoh Tabel Doctors
INSERT INTO doctors (full_name, specialization, phone, email)
VALUES
('Dr. Andi Wijaya','General Practitioner','0811111111','andi@example.com'),
('Dr. Lina Kusuma','Pediatrician','0812222222','lina@example.com');

-- Data Contoh Tabel Services
INSERT INTO services (service_name, price)
VALUES
('General Checkup',100000.00),
('Blood Test',50000.00),
('X-Ray',150000.00);

-- Data Contoh Tabel Users
INSERT INTO users (username, password_hash, role)
VALUES
('admin','hash123','Admin'),
('drandi','hash456','Doctor'),
('reception','hash789','Receptionist');

-- Data Contoh Tabel Appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, status, notes)
VALUES
(1,1,'2025-04-01 10:00:00','Scheduled','Checkup'),
(2,2,'2025-04-02 09:30:00','Scheduled','Vaccination');

-- Data Contoh Tabel Appointment Services
INSERT INTO appointment_services (appointment_id, service_id, quantity, service_cost)
VALUES
(1,1,1,100000.00),
(2,2,1,50000.00);

-- Data Contoh Tabel Rekam Medis
INSERT INTO medical_records (patient_id, doctor_id, diagnosis, treatment, prescription, symptoms, allergies, blood_pressure)
VALUES
(1,1,'Flu','Rest and paracetamol','Paracetamol 500mg','Cough, Fever','Dust','120/80');

-- Data Contoh Tabel Hasil Lab
INSERT INTO lab_results (record_id, test_type, test_date, results, notes)
VALUES
(1,'Blood Test','2025-03-01','Hemoglobin Normal','No issues found');

-- Data Contoh Tabel Asuransi
INSERT INTO insurance (patient_id, provider_name, policy_number, valid_until)
VALUES
(1,'BPJS','BPJS-12345','2025-12-31');

-- Data Contoh Tabel Billing
INSERT INTO billing (patient_id, appointment_id, total_amount, status, payment_method)
VALUES
(1,1,100000,'Unpaid','Cash'),
(2,2,50000,'Unpaid','Insurance');
