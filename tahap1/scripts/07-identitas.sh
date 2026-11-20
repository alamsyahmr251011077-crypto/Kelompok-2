sed -i --follow-symlinks 's/^PRETTY_NAME=.*/PRETTY_NAME="Nexus 1.0 (berbasis Xubuntu 22.04)"/' /etc/os-release
sed -i --follow-symlinks 's/^NAME=.*/NAME="Nexus"/' /etc/os-release
sed -i 's/^DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION="Nexus 1.0"/' /etc/lsb-release
echo "Nexus 1.0 \n \l" > /etc/issue

echo "07-identity selesai."
