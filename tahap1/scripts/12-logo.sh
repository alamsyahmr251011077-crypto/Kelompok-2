LOGO=/usr/share/pixmaps/nexus-logo.png
if [ ! -f "$LOGO" ]; then
  echo "PERINGATAN: $LOGO tidak ada (07-identity.sh harus berjalan lebih dulu)"
  exit 0
fi

CONF=/etc/gdm3/greeter.dconf-defaults
if [ -f "$CONF" ]; then
  if grep -q '^\[org/gnome/login-screen\]' "$CONF"; then
    sed -i "/^\[org\/gnome\/login-screen\]/a logo='$LOGO'" "$CONF"
  else
    printf "\n[org/gnome/login-screen]\nlogo='%s'\n" "$LOGO" >> "$CONF"
  fi
  grep -n "logo=" "$CONF"
else
  echo "INFO: $CONF tidak ditemukan, logo layar login dilewati"
fi
echo "12-logo selesai."
