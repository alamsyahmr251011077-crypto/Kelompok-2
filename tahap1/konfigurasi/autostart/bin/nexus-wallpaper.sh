
#!/bin/bash

FLAG="$HOME/.nexus_wallpaper_done"
[ -f "$FLAG" ] && exit 0

sleep 5

APPLIED=0

for p in $(xfconf-query -c xfce4-desktop -l | grep last-image); do
    xfconf-query -c xfce4-desktop -p "$p" -s /usr/share/backgrounds/nexus/wallpaper.png && APPLIED=1
done

[ "$APPLIED" = 1 ] && touch "$FLAG"
