mkdir -p /usr/share/backgrounds/nexus
if [ -f /tmp/assets/wallpaper.png ]; then
  cp /tmp/assets/wallpaper.png /usr/share/backgrounds/nexus/wallpaper.png
else
  echo "PERINGATAN: wallpaper.png tidak ditemukan di /tmp/assets"
fi

cat > /usr/local/bin/nexus-wallpaper.sh <<'EOF'
FLAG="$HOME/.nexus_wallpaper_done"
[ -f "$FLAG" ] && exit 0
sleep 5
APPLIED=0
for p in $(xfconf-query -c xfce4-desktop -l | grep last-image); do
  xfconf-query -c xfce4-desktop -p "$p" -s /usr/share/backgrounds/nexus/wallpaper.png && APPLIED=1
done
[ "$APPLIED" = 1 ] && touch "$FLAG"
EOF
chmod +x /usr/local/bin/nexus-wallpaper.sh

mkdir -p /etc/xdg/autostart
cat > /etc/xdg/autostart/nexus-wallpaper.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=Nexus Wallpaper
Exec=/usr/local/bin/nexus-wallpaper.sh
EOF
echo "08-wallpaper selesai."
