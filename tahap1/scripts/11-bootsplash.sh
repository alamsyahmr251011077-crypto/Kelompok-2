export DEBIAN_FRONTEND=noninteractive

LOGO=/tmp/assets/logo.png
TEMA=/usr/share/plymouth/themes/nexus

if [ ! -f "$LOGO" ]; then
  echo "PERINGATAN: logo.png tidak ditemukan, boot splash tidak diubah"
  exit 0
fi

apt install -y plymouth plymouth-theme-ubuntu-logo
mkdir -p "$TEMA"
cp "$LOGO" "$TEMA/logo.png"

cat > "$TEMA/nexus.plymouth" <<'EOF'
[Plymouth Theme]
Name=Nexus
Description=Boot splash Nexus
ModuleName=script

[script]
ImageDir=/usr/share/plymouth/themes/nexus
ScriptFile=/usr/share/plymouth/themes/nexus/nexus.script
EOF

cat > "$TEMA/nexus.script" <<'EOF'
Window.SetBackgroundTopColor(0.08, 0.08, 0.12);
Window.SetBackgroundBottomColor(0.08, 0.08, 0.12);
logo.image = Image("logo.png").Scale(256, 256);
logo.sprite = Sprite(logo.image);
logo.sprite.SetX(Window.GetX() + Window.GetWidth() / 2 - 128);
logo.sprite.SetY(Window.GetY() + Window.GetHeight() / 2 - 128);
EOF

update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth "$TEMA/nexus.plymouth" 200
update-alternatives --set default.plymouth "$TEMA/nexus.plymouth"

update-initramfs -u -k all || echo "PERINGATAN: update-initramfs bermasalah, periksa log"

echo "11-bootsplash selesai."
