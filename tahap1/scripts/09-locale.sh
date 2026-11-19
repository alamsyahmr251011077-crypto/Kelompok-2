export DEBIAN_FRONTEND=noninteractive

apt update
apt install -y language-pack-id
locale-gen id_ID.UTF-8
echo 'LANG=id_ID.UTF-8' > /etc/default/locale
update-locale LANG=id_ID.UTF-8 2>/dev/null || true

ln -sf /usr/share/zoneinfo/Asia/Makassar /etc/localtime
echo "Asia/Makassar" > /etc/timezone

mkdir -p /etc/skel/iot-projects
cat > /etc/skel/iot-projects/README.txt <<'EOF'
Selamat datang di Nexus, distro pengembang IoT.

Uji broker MQTT:
  mosquitto_sub -t test &
  mosquitto_pub -t test -m halo

Folder ini untuk proyek IoT-mu.
EOF

echo "09-locale selesai."
