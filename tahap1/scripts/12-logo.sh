LOGO=/usr/share/pixmaps/nexus-logo.png
WALL=/usr/share/backgrounds/nexus/wallpaper.png

if [ ! -d /etc/lightdm ]; then
  echo "INFO: LightDM tidak ditemukan, logo layar login dilewati"
  exit 0
fi

mkdir -p /etc/lightdm/lightdm-gtk-greeter.conf.d
cat > /etc/lightdm/lightdm-gtk-greeter.conf.d/99-nexus.conf <<EOF
[greeter]
background=$WALL
default-user-image=$LOGO
EOF

ls /etc/lightdm /etc/lightdm/lightdm-gtk-greeter.conf.d
echo "12-logo selesai."
