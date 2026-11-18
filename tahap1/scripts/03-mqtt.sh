export DEBIAN_FRONTEND=noninteractive
apt update 
apt install -y mosquitto mosquitto-clients nmap net-tools
systemctl enable mosquitto
