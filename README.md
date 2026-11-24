# Proyek SO - Kelompok 2 (Topik 3: Distro Pengembang IoT)

Token kelompok: 002

## Anggota
| No | Nama | Peran |
|---|---|---|
| 1 | Sayyid As'ad | Ketua |
| 2 | Muhammad Raihan Alamsyah | Hapus paket |
| 3 | Firmansyah | Paket MQTT dan jaringan |
| 4 | Muhammad Reihan | Paket Pemrograman |
| 5 | Klara Airelin Kele | Paket Serial dan Data |
| 6 | Yuninda Pabaru' | Tambah Skrip Desktop Ringan XCFE |
| 7 | Akram Muis | Tambah skrip nama distro nexus, dan logo |
| 8 | Muhammad Aisar Idhan Nur | Tambah Skrip Wallpaper, Nexus OS, Gambar dan alasan |
| 9 | Charistheo Rehaliel Cahyono | Tambah Skrip Bahasa, Zona Waktu, Template pengguna, dan alasan |
| 10 | Muhammad Saeed | Tambah Skrip First-login dan alasan |
| 11 | Vincensius Chandra Pratama | Tambah catatan alasan boot splash |

## Versi
- ISO induk: xubuntu-22.04.5-desktop-amd64.iso
  SHA256: b61e083d8a5ab003bad6ef7ea31ec21d7bfdf19b99d75987ab3fa3bbe85ec1bf
- Nama distro hasil: Nexus 1.0
- Alat Tahap 1: Cubic
- Buildroot: LTS 2026.02

## Struktur
- tahap1/ : skrip dan konfigurasi distro (scripts/, alasan/, assets/)
- tahap2/ : Buildroot (defconfig, overlay, patch kernel, program uji)
- laporan/ : bahan laporan


## Langkah build Tahap 1

### 1. Persiapan repositori dan lingkungan build

1. Clone repositori GitHub:
   ```bash
   git clone https://github.com/alamsyahmr251011077-crypto/Kelompok-2.git
   cd Kelompok-2
   ```
2. Siapkan VM Linux sebagai mesin build.
3. Pastikan Cubic versi 2026.09.110 sudah terpasang melalui PPA resmi.
4. Siapkan ISO induk **Xubuntu 22.04.5** dan periksa checksum SHA256 untuk memastikan file ISO tidak rusak.

### 2. Membuat project di Cubic

1. Jalankan Cubic dan buat project baru pada direktori kerja yang masih kosong.
2. Pilih ISO induk Xubuntu 22.04.5.
3. Atur informasi ISO sebagai berikut:
   - Nama file: `nexus-os-1.0.iso`
   - Volume ID: `Nexus`
   - Release: `1.0`
   - Disk Name: `Nexus 1.0`
4. Lanjutkan proses hingga masuk ke terminal kustomisasi Cubic.

### 3. Menyalin skrip dan aset

Salin file dari repositori ke lingkungan terminal Cubic dengan susunan berikut:

- Seluruh skrip dari `tahap1/scripts/` ke `/root/scripts/`.
- Seluruh aset dari `tahap1/assets/` ke `/root/assets/`.
- File `customize.sh` ke `/root/customize.sh`.

Pastikan seluruh skrip dan aset sudah tersedia sebelum menjalankan proses kustomisasi.

### 4. Menjalankan kustomisasi distro

Jalankan perintah berikut pada terminal Cubic:

```bash
bash /root/customize.sh
```

File `customize.sh` akan menjalankan seluruh skrip kustomisasi secara berurutan, mulai dari penghapusan paket yang tidak diperlukan, pemasangan paket IoT, konfigurasi desktop XFCE, pengaturan identitas Nexus, hingga konfigurasi boot splash dan layar login.

Pastikan proses berakhir dengan tulisan:

```text
Semua skrip selesai.
```

Tidak boleh ada pesan `GAGAL` selama proses kustomisasi berlangsung.

### 5. Menghasilkan ISO Nexus

1. Bersihkan file sementara dan cache APT setelah proses kustomisasi selesai.
2. Lanjutkan ke tahap pembuatan ISO pada Cubic.
3. Pilih metode kompresi **gzip**.
4. Klik **Generate** untuk memulai proses pembuatan ISO.
5. Setelah selesai, pastikan file `nexus-os-1.0.iso` berhasil dibuat.

### 6. Pengujian ISO

Lakukan pengujian menggunakan VirtualBox dengan langkah berikut:

1. **Pengujian Live Session:** Boot VM menggunakan ISO Nexus dan periksa apakah sistem berhasil masuk ke desktop.
2. Periksa identitas distro dan konfigurasi desktop, kemudian uji pengiriman pesan MQTT menggunakan Mosquitto.
3. **Pengujian instalasi:** Instal Nexus ke disk virtual berkapasitas 25 GB sampai proses instalasi selesai.
4. **Pengujian setelah instalasi:** Boot VM dari disk virtual dan periksa kembali nama distro, wallpaper, folder `iot-projects`, serta fitur first-login.

### 7. Pengukuran hasil

Setelah pengujian selesai, catat ukuran ISO, penggunaan RAM saat idle, waktu boot, jumlah paket, dan port yang terbuka sebagai data untuk analisis perbandingan pada Tahap 3.
