
#!/bin/bash

FLAG="$HOME/.nexus_firstlogin_done"

[ -f "$FLAG" ] && exit 0

sleep 5

mkdir -p "$HOME/iot-projects"

echo "Login pertama: $(date)" >> "$HOME/iot-projects/firstlogin.log"

notify-send "Nexus" "Lingkungan pengembang IoT siap digunakan." || true

touch "$FLAG"
