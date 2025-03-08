# Clinic Database Project

Sistem basis data yang dirancang untuk membantu klinik dalam mengelola data pasien, dokter, layanan, janji temu, rekam medis, tagihan, hingga asuransi. Cocok untuk klinik dengan kebutuhan data yang kompleks dan siap diintegrasikan dengan aplikasi web.

---

## 1. Deskripsi

Proyek ini bertujuan untuk menyediakan struktur database yang lengkap dan efisien bagi klinik, mencakup:

- Manajemen Pasien & Dokter  
- Janji Temu & Layanan Klinik  
- Rekam Medis & Hasil Laboratorium  
- Tagihan & Metode Pembayaran  
- Asuransi Pasien  
- User Management (Login & Role)  

Database ini dioptimalkan dengan indexing, relasi one-to-many dan many-to-many, serta penambahan kolom-kolom penting agar mudah dikembangkan lebih lanjut.

---

## 2. Fitur Utama

1. Tabel `patients`, `doctors`, dan `appointments`  
   - Menyimpan data pasien, dokter, dan jadwal janji temu.  
2. Tabel `appointment_services` (Many-to-Many)  
   - Menghubungkan layanan (services) dengan janji temu (appointments) untuk memfasilitasi penambahan banyak layanan dalam satu janji.  
3. Tabel `medical_records` & `lab_results`  
   - Mencatat diagnosis, treatment, gejala, alergi, tekanan darah, dan hasil lab pasien.  
4. Tabel `insurance`  
   - Menyimpan data asuransi pasien seperti nama provider dan nomor polis.  
5. Tabel `billing`  
   - Mencatat total biaya, status tagihan, dan metode pembayaran (Cash, CreditCard, Insurance, Transfer).  
6. Tabel `users`  
   - Mendukung sistem login dengan peran (Admin, Doctor, Receptionist).  

---

## 3. Struktur Tabel

1. patients  
   - Menyimpan data pasien (nama lengkap, tanggal lahir, gender, kontak, dll.)  
2. doctors  
   - Menyimpan data dokter (nama lengkap, spesialisasi, kontak, dll.)  
3. services  
   - Menyimpan data layanan (nama layanan, harga)  
4. appointments  
   - Menyimpan jadwal janji temu antara pasien dan dokter  
5. appointment_services  
   - Tabel penghubung (many-to-many) antara `appointments` dan `services`  
6. medical_records  
   - Menyimpan data rekam medis, gejala, alergi, resep, dll.  
7. lab_results  
   - Menyimpan hasil lab dari rekam medis tertentu  
8. insurance  
   - Menyimpan informasi asuransi pasien  
9. billing  
   - Menyimpan informasi tagihan (jumlah biaya, status, metode pembayaran)  
10. users  
   - Menyimpan data login pengguna dengan peran tertentu  

---

## 4. Cara Menggunakan

1. Import Database  
   - Jalankan file `clinic_database.sql` di MySQL (atau DBMS lain yang kompatibel).  
   - Pastikan server database telah berjalan.  

2. Struktur dan Data Contoh  
   - File `clinic_database.sql` sudah mencakup data contoh untuk pasien, dokter, layanan, dan sebagainya.  
   - Anda dapat mengubah atau menghapus data contoh sesuai kebutuhan.  

3. Kustomisasi  
   - Jika ingin menambahkan kolom atau tabel baru, pastikan menjaga integritas relasi.  
   - Gunakan INDEX tambahan pada kolom yang sering digunakan untuk pencarian (misal `email`, `phone`, `appointment_date`).  

4. Integrasi Aplikasi Web  
   - Gunakan kredensial di tabel `users` untuk otentikasi.  
   - Tabel `appointments`, `medical_records`, dan `billing` dapat diakses dari backend untuk mengelola data klinik secara real-time.  

---

## 5. Rekomendasi Pengembangan Lanjutan

- Stored Procedures & Triggers:  
  - Otomatisasi status tagihan setelah pembayaran.  
  - Pembuatan rekam medis otomatis setelah janji temu selesai.  

- Dashboard Admin:  
  - Laporan pendapatan per hari/bulan/tahun.  
  - Monitoring jumlah pasien, dokter aktif, dan jadwal janji temu.  

- Keamanan Data:  
  - Enkripsi kolom sensitif (misal `phone`, `email`) jika diperlukan.  
  - Penerapan SSL untuk koneksi database.  

- Migrasi & Skalabilitas:  
  - Penggunaan sharding atau replication jika jumlah data sangat besar.  
  - Pindah ke PostgreSQL atau SQL Server jika diperlukan fitur lanjutan.  