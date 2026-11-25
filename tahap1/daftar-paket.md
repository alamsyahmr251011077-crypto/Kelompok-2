
# Daftar Paket Distro Nexus

## 1. Paket yang Ditambahkan

Paket berikut ditambahkan untuk mendukung kebutuhan pengembangan IoT pada distro Nexus.

### A. MQTT dan Jaringan

| No | Nama Paket | Fungsi |
|---|---|---|
| 1 | mosquitto | Broker MQTT untuk komunikasi perangkat IoT |
| 2 | mosquitto-clients | Menguji komunikasi MQTT menggunakan publish dan subscribe |
| 3 | nmap | Memindai perangkat dan port pada jaringan |
| 4 | net-tools | Menyediakan perintah diagnosis jaringan seperti ifconfig dan netstat |

### B. Pemrograman

| No | Nama Paket | Fungsi |
|---|---|---|
| 5 | python3 | Bahasa pemrograman untuk skrip dan prototipe IoT |
| 6 | python3-pip | Memasang pustaka Python |
| 7 | python3-venv | Membuat lingkungan virtual Python |
| 8 | build-essential | Menyediakan compiler dan alat kompilasi C/C++ |
| 9 | git | Mengelola versi kode proyek |

### C. Serial dan Pengolahan Data

| No | Nama Paket | Fungsi |
|---|---|---|
| 10 | minicom | Terminal komunikasi serial |
| 11 | picocom | Alternatif terminal serial yang ringan |
| 12 | jq | Mengolah data JSON |
| 13 | sqlite3 | Menyimpan data sensor secara lokal |
| 14 | curl | Menguji API HTTP dan mengambil data |

**Total paket tambahan: 14 paket.**

## 2. Paket yang Dihapus

Paket dihapus karena tidak menjadi kebutuhan utama pengembang IoT atau tidak sesuai dengan target pengguna Nexus.

| No | Paket | Alasan Penghapusan |
|---|---|---|
| 1 | libreoffice* | Aplikasi perkantoran yang tidak dibutuhkan untuk pengembangan IoT |
| 2 | gimp* | Editor gambar yang tidak menjadi kebutuhan utama |
| 3 | rhythmbox* | Pemutar musik yang tidak relevan dengan target penggunaan |
| 4 | simple-scan | Aplikasi pemindai dokumen yang tidak diperlukan |
| 5 | xfburn | Pembakar CD/DVD yang tidak menjadi kebutuhan utama |
| 6 | hexchat* | Klien IRC yang tidak relevan dengan pengembangan IoT |
| 7 | fonts-noto-cjk | Font tambahan untuk bahasa Tiongkok, Jepang, dan Korea yang bukan target bahasa utama |
| 8 | xubuntu-docs | Dokumentasi bantuan Xubuntu yang dapat diakses secara daring |
| 9 | pidgin | Aplikasi pesan instan yang tidak dibutuhkan |
| 10 | transmission | Klien unduhan torrent yang tidak dibutuhkan |
| 11 | gnome-mines | Permainan yang tidak relevan dengan target pengguna |
| 12 | gnome-sudoku | Permainan yang tidak relevan dengan target pengguna |
| 13 | sgt-puzzles | Kumpulan permainan yang tidak relevan dengan target pengguna |
| 14 | parole | Pemutar multimedia yang tidak menjadi kebutuhan utama |
| 15 | gnumeric | Aplikasi spreadsheet yang tidak dibutuhkan |
| 16 | abiword | Aplikasi pengolah kata yang tidak dibutuhkan |

**Catatan:** Daftar ini merangkum nama paket dalam skrip penghapusan. Pastikan seluruh nama dan alasan dikonfirmasi oleh anggota yang mengerjakan skrip tersebut.

## 3. Paket yang Dipertahankan

Beberapa paket bawaan sengaja dipertahankan karena masih dibutuhkan sistem dan pengembangan IoT, seperti:

- linux-firmware: mendukung perangkat keras dan Wi-Fi.
- xfce4-session, xfwm4, lightdm, thunar: mendukung desktop XFCE.
- gcc/g++: mendukung kompilasi program.

## 4. Kesimpulan

Paket-paket Nexus dipilih berdasarkan kebutuhan pengembangan IoT, meliputi komunikasi MQTT, pemrograman, jaringan, komunikasi serial, dan pengolahan data.

Penghapusan paket yang tidak relevan bertujuan mengurangi aplikasi yang tidak diperlukan serta mengoptimalkan penggunaan ruang penyimpanan.
