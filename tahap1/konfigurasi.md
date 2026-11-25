# Dokumentasi Konfigurasi Nexus OS 1.0

## 1. Pendahuluan

Nexus OS 1.0 merupakan distro Linux hasil modifikasi dari Xubuntu 22.04.5 yang dikembangkan untuk mendukung kebutuhan pengembangan Internet of Things (IoT).

Proses kustomisasi dilakukan menggunakan Cubic dengan bantuan skrip Bash yang disimpan di repository GitHub kelompok. Konfigurasi yang diterapkan meliputi identitas distro, desktop XFCE, branding, bahasa, zona waktu, template pengguna, first-login, boot splash, layar login, dan layanan MQTT.

Dokumentasi ini menjelaskan pengaturan sistem yang diterapkan melalui skrip pada folder `tahap1/scripts/`.

## 2. Identitas Distro

Berikut identitas sistem operasi yang dikembangkan:

| Komponen | Konfigurasi |
|---|---|
| Nama distro | Nexus OS 1.0 |
| Distro induk | Xubuntu 22.04.5 |
| Desktop environment | XFCE |
| Arsitektur | AMD64 (x86_64) |
| Alat kustomisasi | Cubic |

Pengaturan identitas dilakukan menggunakan skrip `07-identitas.sh`.

Beberapa file sistem yang dimodifikasi meliputi:

- `/etc/os-release`
- `/etc/lsb-release`
- `/etc/issue`

Nama distribusi diubah menjadi Nexus, sedangkan nilai `ID` pada `/etc/os-release` tetap menggunakan `ubuntu` untuk mempertahankan kompatibilitas dengan alat dan paket berbasis Ubuntu.

Logo distro juga dipasang pada:

`/usr/share/pixmaps/nexus-logo.png`

Selain itu, identitas logo ditambahkan melalui variabel `LOGO=nexus-logo` pada `/etc/os-release`.

## 3. Konfigurasi Desktop XFCE

Nexus menggunakan desktop environment XFCE bawaan Xubuntu karena memiliki tampilan sederhana dan ringan.

Pengaturan desktop dilakukan menggunakan skrip `06-desktop.sh`.

Konfigurasi yang diterapkan meliputi:

| Pengaturan | Konfigurasi |
|---|---|
| Desktop environment | XFCE |
| Compositing | Dinonaktifkan |
| Pintasan pertama | Terminal Nexus |
| Pintasan kedua | Monitor MQTT |

### 3.1 Pengaturan Compositing

Compositing dinonaktifkan melalui konfigurasi XFWM4 dengan mengatur nilai:

`use_compositing = false`

File konfigurasi ditempatkan pada direktori template pengguna:

`/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml`

Pengaturan ini bertujuan mengurangi penggunaan sumber daya untuk efek visual desktop.

### 3.2 Pintasan Desktop

Nexus menyediakan dua pintasan pada desktop pengguna.

1. **Terminal Nexus**

   Digunakan untuk membuka terminal XFCE dengan menjalankan perintah `xfce4-terminal`.

2. **Monitor MQTT**

   Digunakan untuk memantau pesan MQTT dari broker lokal menggunakan perintah:

   `mosquitto_sub -h localhost -t "#" -v`

Kedua pintasan dibuat dalam format file `.desktop` dan disimpan pada:

`/etc/skel/Desktop/`

Direktori tersebut merupakan template desktop bagi pengguna baru.

## 4. Konfigurasi Branding

Branding diterapkan untuk memberikan identitas visual pada Nexus OS.

### 4.1 Logo Distro

Logo Nexus berasal dari file `logo.png` pada folder `tahap1/assets/`.

File tersebut disalin ke:

`/usr/share/pixmaps/nexus-logo.png`

Proses pemasangan logo dilakukan oleh skrip `07-identitas.sh`.

### 4.2 Wallpaper

Wallpaper Nexus berasal dari file `wallpaper.png` pada folder `tahap1/assets/`.

Wallpaper dipasang pada:

`/usr/share/backgrounds/nexus/wallpaper.png`

Pengaturan ini dilakukan menggunakan skrip `08-wallpaper.sh`.

Skrip tersebut juga membuat program `nexus-wallpaper.sh` pada:

`/usr/local/bin/nexus-wallpaper.sh`

Program dijalankan secara otomatis melalui file autostart:

`/etc/xdg/autostart/nexus-wallpaper.desktop`

Program akan menunggu beberapa detik setelah pengguna masuk ke desktop, kemudian menerapkan wallpaper Nexus menggunakan XFConf. Penanda `.nexus_wallpaper_done` dibuat setelah penerapan wallpaper berhasil.

### 4.3 Layar Login

Layar login menggunakan LightDM GTK Greeter.

Pengaturan dilakukan melalui skrip `12-logo.sh` dengan membuat file:

`/etc/lightdm/lightdm-gtk-greeter.conf.d/99-nexus.conf`

Konfigurasi tersebut mengatur:

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

Catatan hasil pemeriksaan: pada sesi pengguna yang diperiksa, nilai `LANG` masih menunjukkan `en_US.UTF-8`, sedangkan beberapa kategori regional seperti `LC_TIME`, `LC_NUMERIC`, dan `LC_MONETARY` sudah menunjukkan `id_ID.UTF-8`. Oleh karena itu, penerapan bahasa aktif masih perlu diverifikasi lebih lanjut.

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

Folder tersebut dilengkapi file `README.txt` yang berisi informasi singkat mengenai lingkungan pengembangan IoT dan contoh pengujian komunikasi MQTT menggunakan perintah:

- `mosquitto_sub`
- `mosquitto_pub`

Template tersebut akan disalin ke direktori home ketika pengguna baru dibuat melalui proses instalasi.

## 7. Konfigurasi First-Login

Nexus menyediakan skrip khusus yang dijalankan ketika pengguna pertama kali masuk ke desktop.

Pengaturan dilakukan menggunakan skrip `10-firstlogin.sh`.

Skrip tersebut membuat program:

`/usr/local/bin/nexus-firstlogin.sh`

Program dijalankan secara otomatis melalui file:

`/etc/xdg/autostart/nexus-firstlogin.desktop`

Fungsi first-login meliputi:

1. Memeriksa apakah pengguna sudah pernah melakukan login pertama.
2. Membuat folder `iot-projects` pada direktori home pengguna.
3. Mencatat waktu login pertama pada file `iot-projects/firstlogin.log`.
4. Menampilkan notifikasi selamat datang.
5. Membuat penanda `.nexus_firstlogin_done` agar proses tidak dijalankan berulang kali.

## 8. Konfigurasi Boot Splash

Nexus menggunakan Plymouth untuk menampilkan logo ketika sistem melakukan proses booting.

Pengaturan dilakukan menggunakan skrip `11-bootsplash.sh`.

Tema Plymouth disimpan pada direktori:

`/usr/share/plymouth/themes/nexus/`

File yang digunakan meliputi:

- `nexus.plymouth`
- `nexus.script`
- `logo.png`

Konfigurasi tema meliputi:

- Mengatur latar belakang berwarna gelap.
- Memuat logo Nexus dengan ukuran 256 × 256 piksel.
- Menempatkan logo di tengah layar.

Tema diaktifkan menggunakan `update-alternatives`, kemudian konfigurasi initramfs diperbarui menggunakan `update-initramfs`.

Catatan: boot splash Nexus berlaku pada sistem yang sudah diinstal. Tampilan boot saat menjalankan ISO sebagai Live Session masih menggunakan tampilan bawaan Xubuntu karena berasal dari initrd ISO induk.

## 9. Konfigurasi Layanan IoT

Nexus dilengkapi layanan dan alat pendukung untuk kebutuhan pengembangan IoT.

Broker MQTT yang digunakan adalah Mosquitto.

Pengaturan dilakukan melalui skrip `03-mqtt.sh`, yang meliputi:

- Memasang Mosquitto sebagai broker MQTT.
- Memasang Mosquitto Clients untuk pengujian komunikasi.
- Mengaktifkan layanan Mosquitto menggunakan `systemctl enable mosquitto`.

Selain itu, Nexus menyediakan lingkungan pemrograman, komunikasi serial, dan pengolahan data melalui paket-paket yang dipasang menggunakan:

- `04-dev.sh` untuk lingkungan pemrograman.
- `05-serial.sh` untuk komunikasi serial dan pengolahan data.

## 10. Daftar Skrip yang Mengatur Konfigurasi

Konfigurasi Nexus diterapkan melalui skrip yang tersimpan pada folder `tahap1/scripts/`.

| Nama Skrip | Fungsi |
|---|---|
| `06-desktop.sh` | Mengatur desktop XFCE dan pintasan desktop |
| `07-identitas.sh` | Mengatur identitas dan logo distro |
| `08-wallpaper.sh` | Memasang wallpaper dan mengatur autostart |
| `09-locale.sh` | Mengatur bahasa, zona waktu, dan template pengguna |
| `10-firstlogin.sh` | Mengatur proses login pertama |
| `11-bootsplash.sh` | Membuat dan mengaktifkan tema Plymouth |
| `12-logo.sh` | Mengatur logo dan wallpaper layar login |

Skrip `customize.sh` bertugas menjalankan seluruh skrip kustomisasi secara berurutan di dalam lingkungan Cubic.

## 11. Penutup

Konfigurasi Nexus OS 1.0 dirancang untuk menghasilkan sistem operasi dengan desktop XFCE yang ringan serta menyediakan lingkungan kerja yang mendukung kebutuhan pengembangan IoT.

Penyesuaian sistem mencakup identitas distro, desktop, branding, bahasa, zona waktu, template pengguna, first-login, boot splash, layar login, dan layanan MQTT.

Seluruh proses konfigurasi dikelola melalui skrip Bash yang tersimpan di repository GitHub kelompok agar proses kustomisasi dapat didokumentasikan dan ditelusuri.
