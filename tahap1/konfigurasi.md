
# Dokumentasi Konfigurasi Nexus OS 1.0

## 1. Pendahuluan

Nexus OS 1.0 merupakan distro Linux hasil modifikasi dari Xubuntu 22.04.5 yang dikembangkan untuk mendukung kebutuhan pengembangan Internet of Things (IoT).

Konfigurasi dilakukan menggunakan Cubic dengan bantuan skrip Bash yang disimpan di repository GitHub kelompok. Penyesuaian meliputi identitas distro, desktop XFCE, branding, bahasa, zona waktu, template pengguna, first-login, boot splash, dan layar login.

## 2. Identitas Distro

Berikut identitas sistem operasi Nexus:

| Komponen | Konfigurasi |
|---|---|
| Nama distro | Nexus OS 1.0 |
| Distro induk | Xubuntu 22.04.5 |
| Desktop environment | XFCE |
| Arsitektur | AMD64 (x86_64) |
| Alat kustomisasi | Cubic |

Identitas distro diatur menggunakan skrip `07-identitas.sh` melalui perubahan beberapa file sistem:

- `/etc/os-release`
- `/etc/lsb-release`
- `/etc/issue`

Nama distro diubah menjadi Nexus, sedangkan ID sistem tetap menggunakan `ubuntu` untuk menjaga kompatibilitas dengan alat dan paket berbasis Ubuntu.

## 3. Konfigurasi Desktop XFCE

Nexus menggunakan desktop environment XFCE bawaan Xubuntu karena memiliki tampilan sederhana dan ringan.

Pengaturan desktop dilakukan menggunakan skrip `06-desktop.sh`, dengan konfigurasi sebagai berikut:

| Pengaturan | Konfigurasi |
|---|---|
| Desktop environment | XFCE |
| Compositing | Dinonaktifkan |
| Pintasan pertama | Terminal Nexus |
| Pintasan kedua | Monitor MQTT |

Compositing dinonaktifkan melalui file konfigurasi `xfwm4.xml` yang ditempatkan pada template pengguna di:

`/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/`

Selain itu, dibuat dua pintasan desktop:

- **Terminal Nexus:** membuka terminal XFCE untuk menjalankan perintah Linux.
- **Monitor MQTT:** membuka terminal untuk memantau pesan MQTT dari broker lokal menggunakan perintah `mosquitto_sub`.

Kedua pintasan disimpan pada direktori `/etc/skel/Desktop/` agar tersedia bagi pengguna baru.

## 4. Konfigurasi Branding

Branding diterapkan untuk memberikan identitas visual Nexus OS.

### 4.1 Logo Distro

Logo Nexus berasal dari file `logo.png` pada folder `tahap1/assets/`.

Logo dipasang ke lokasi:

`/usr/share/pixmaps/nexus-logo.png`

Proses pemasangan dilakukan oleh skrip `07-identitas.sh`.

### 4.2 Wallpaper

Wallpaper Nexus berasal dari file `wallpaper.png` pada folder `tahap1/assets/`.

Wallpaper dipasang ke:

`/usr/share/backgrounds/nexus/wallpaper.png`

Pengaturan wallpaper dilakukan oleh skrip `08-wallpaper.sh`.

Skrip tersebut juga membuat program `nexus-wallpaper.sh` yang dijalankan secara otomatis ketika pengguna masuk ke desktop melalui konfigurasi autostart XFCE.

### 4.3 Layar Login

Layar login menggunakan LightDM GTK Greeter.

Pengaturan dilakukan oleh skrip `12-logo.sh` melalui file:

`/etc/lightdm/lightdm-gtk-greeter.conf.d/99-nexus.conf`

Konfigurasi tersebut meliputi:

- Wallpaper Nexus sebagai latar belakang layar login.
- Logo Nexus sebagai gambar pengguna default.

## 5. Konfigurasi Bahasa dan Zona Waktu

Pengaturan bahasa dan zona waktu dilakukan melalui skrip `09-locale.sh`.

### 5.1 Bahasa

Bahasa Indonesia disiapkan menggunakan paket `language-pack-id`.

Pengaturan dilakukan melalui beberapa perintah:

- Memasang paket `language-pack-id`.
- Membuat locale `id_ID.UTF-8` menggunakan `locale-gen`.
- Menetapkan `LANG=id_ID.UTF-8` pada `/etc/default/locale`.
- Memperbarui pengaturan locale menggunakan `update-locale`.

### 5.2 Zona Waktu

Zona waktu yang ditetapkan adalah:

`Asia/Makassar` (WITA).

Pengaturan dilakukan dengan menghubungkan `/etc/localtime` ke:

`/usr/share/zoneinfo/Asia/Makassar`

Nilai zona waktu juga disimpan pada file `/etc/timezone`.

## 6. Konfigurasi Template Pengguna

Nexus menyediakan template pengguna melalui direktori `/etc/skel`.

Skrip `09-locale.sh` membuat folder:

`/etc/skel/iot-projects/`

Folder tersebut dilengkapi file `README.txt` yang berisi informasi singkat mengenai lingkungan pengembangan IoT dan contoh pengujian komunikasi MQTT menggunakan perintah `mosquitto_sub` dan `mosquitto_pub`.

Template ini akan disalin ke direktori home ketika pengguna baru dibuat melalui proses instalasi.

## 7. Konfigurasi First-Login

Nexus menyediakan skrip khusus yang berjalan saat pengguna pertama kali masuk ke desktop.

Pengaturan dilakukan oleh skrip `10-firstlogin.sh`.

Skrip tersebut membuat program:

`/usr/local/bin/nexus-firstlogin.sh`

Program dijalankan secara otomatis melalui file autostart:

`/etc/xdg/autostart/nexus-firstlogin.desktop`

Fungsi first-login meliputi:

1. Memeriksa apakah pengguna sudah pernah melakukan login pertama.
2. Membuat folder `iot-projects` pada direktori home pengguna.
3. Mencatat waktu login pertama ke file `iot-projects/firstlogin.log`.
4. Menampilkan notifikasi selamat datang.
5. Membuat penanda `.nexus_firstlogin_done` agar proses tidak dijalankan berulang kali.

## 8. Konfigurasi Boot Splash

Nexus menggunakan Plymouth untuk menampilkan logo saat proses booting pada sistem yang sudah diinstal.

Pengaturan dilakukan oleh skrip `11-bootsplash.sh`.

Tema Plymouth disimpan pada direktori:

`/usr/share/plymouth/themes/nexus/`

Berkas yang digunakan meliputi:

- `nexus.plymouth`
- `nexus.script`
- `logo.png`

Logo Nexus ditampilkan di tengah layar sebagai identitas visual saat proses booting.

Tema diaktifkan menggunakan `update-alternatives`, kemudian konfigurasi initramfs diperbarui menggunakan `update-initramfs`.

**Catatan:** Boot splash Nexus berlaku pada sistem yang sudah diinstal. Saat menjalankan ISO sebagai Live Session, tampilan boot masih menggunakan tampilan bawaan Xubuntu karena berasal dari initrd ISO induk.

## 9. Konfigurasi Layanan IoT

Nexus dilengkapi layanan dan alat pendukung untuk kebutuhan pengembangan IoT.

Broker MQTT yang digunakan adalah Mosquitto.

Pengaturan dilakukan melalui skrip `03-mqtt.sh`, yang meliputi:

- Memasang Mosquitto sebagai broker MQTT.
- Memasang Mosquitto Clients untuk pengujian komunikasi.
- Mengaktifkan layanan Mosquitto menggunakan `systemctl enable mosquitto`.

Selain itu, Nexus menyediakan lingkungan pemrograman, komunikasi serial, dan pengolahan data menggunakan paket-paket yang dipasang melalui skrip `04-dev.sh` dan `05-serial.sh`.

## 10. Daftar Skrip Konfigurasi

Konfigurasi Nexus diterapkan menggunakan skrip yang tersimpan pada folder `tahap1/scripts/`.

| Nama Skrip | Fungsi |
|---|---|
| `06-desktop.sh` | Mengatur desktop XFCE dan pintasan desktop |
| `07-identitas.sh` | Mengatur identitas dan logo distro |
| `08-wallpaper.sh` | Memasang wallpaper dan mengatur autostart |
| `09-locale.sh` | Mengatur bahasa, zona waktu, dan template pengguna |
| `10-firstlogin.sh` | Mengatur proses login pertama |
| `11-bootsplash.sh` | Membuat dan mengaktifkan tema Plymouth |
| `12-logo.sh` | Mengatur logo dan wallpaper layar login |

Seluruh skrip kustomisasi dijalankan secara berurutan melalui file `customize.sh` yang berada di dalam folder `tahap1/`.

## 11. Penutup

Konfigurasi Nexus OS 1.0 dirancang untuk menghasilkan sistem operasi dengan desktop XFCE yang ringan serta menyediakan lingkungan kerja yang mendukung pengembangan IoT.

Penyesuaian sistem mencakup identitas distro, desktop, branding, bahasa, zona waktu, template pengguna, first-login, boot splash, layar login, dan layanan MQTT.

Seluruh konfigurasi dan proses kustomisasi didokumentasikan melalui repository GitHub kelompok agar proses pengerjaan dan pembangunan ulang ISO dapat dipahami serta ditelusuri.
