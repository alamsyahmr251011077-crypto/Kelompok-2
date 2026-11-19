cat > /usr/local/bin/nexus-firstlogin.sh <<'EOF'
FLAG="$HOME/.nexus_firstlogin_done"
[ -f "$FLAG" ] && exit 0
sleep 5
mkdir -p "$HOME/iot-projects"
echo "Login pertama: $(date)" >> "$HOME/iot-projects/firstlogin.log"
notify-send "Nexus" "Lingkungan pengembang IoT siap digunakan." || true
touch "$FLAG"
EOF
chmod +x /usr/local/bin/nexus-firstlogin.sh

mkdir -p /etc/xdg/autostart
cat > /etc/xdg/autostart/nexus-firstlogin.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=Nexus First Login
Exec=/usr/local/bin/nexus-firstlogin.sh
EOF
echo "10-firstlogin selesai."
