# Clinic Database Project

## Deskripsi
Proyek ini adalah sistem database untuk klinik yang mencakup manajemen pasien, dokter, rekam medis, tagihan, dan laporan keuangan.

## Fitur Utama
- Manajemen pasien & dokter
- Rekam medis & histori pembayaran
- Fitur pencarian data
- Laporan keuangan
- Optimasi database (indexing, stored procedures, triggers, views)

## Cara Menjalankan
1. Import database: Jalankan file `clinic_database.sql` di MySQL.
2. Pastikan server database berjalan (XAMPP, MySQL Server, atau lainnya).
3. Gunakan query SQL untuk mengelola data pasien, dokter, dan transaksi klinik.

## Struktur Database
- patients (id, name, dob, address, phone)
- doctors (id, name, specialization, phone)
- medical_records (id, patient_id, doctor_id, diagnosis, treatment)
- billing (id, patient_id, amount, status)
- payments (id, billing_id, date, method)

## Teknologi yang Digunakan
- MySQL
- SQL Query Optimization (Indexing, Stored Procedures)
- Database Backup & Restore