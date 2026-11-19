export DEBIAN_FRONTEND=noninteractive
dpkg -s xfce4-session >/dev/null 2>&1 || apt install -y xfce4 xfce4-terminal

mkdir -p /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml
cat > /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfwm4" version="1.0">
  <property name="general" type="empty">
    <property name="use_compositing" type="bool" value="false"/>
  </property>
</channel>
EOF

mkdir -p /etc/skel/Desktop
cat > /etc/skel/Desktop/nexus-terminal.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=Terminal Nexus
Exec=xfce4-terminal
Icon=utilities-terminal
Terminal=false
EOF
cat > /etc/skel/Desktop/nexus-mqtt-monitor.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=Monitor MQTT
Exec=xfce4-terminal --hold -x mosquitto_sub -h localhost -t "#" -v
Icon=network-wired
Terminal=false
EOF
chmod +x /etc/skel/Desktop/*.desktop

echo "06-desktop selesai."
