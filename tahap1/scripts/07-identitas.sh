sed -i --follow-symlinks 's/^PRETTY_NAME=.*/PRETTY_NAME="Nexus 1.0 (berbasis Xubuntu 24.04)"/' /etc/os-release
sed -i --follow-symlinks 's/^NAME=.*/NAME="Nexus"/' /etc/os-release
sed -i 's/^DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION="Nexus 1.0"/' /etc/lsb-release
echo "Nexus 1.0 \n \l" > /etc/issue

mkdir -p /usr/share/pixmaps
if [ -f /tmp/assets/logo.png ]; then
  cp /tmp/assets/logo.png /usr/share/pixmaps/nexus-logo.png
else
  echo "PERINGATAN: logo.png tidak ditemukan di /tmp/assets"
fi
echo "07-identity selesai."
