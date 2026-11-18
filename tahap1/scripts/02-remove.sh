export DEBIAN_FRONTEND=noninteractive

for pola in hexchat pidgin transmission gnome-mines gnome-sudoku sgt-puzzles parole gnumeric abiword libreoffice gimp rythmbox simple-scan xfburn; do
  PKGS=$(dpkg -l "${pola}*" 2>/dev/null | awk '/^ii/ {print $2}')
  if [ -n "$PKGS" ]; then
    echo "Menghapus: $PKGS"
    apt remove --purge -y $PKGS
  else
    echo "Lewati $pola (tidak terpasang)"
  fi
done

for wajib in xcfe-session xfwm4 lightdm thunar; do
  dpkg -s "$wajib" >/dev/null 2>&1 || { echo "GAGAL: $wajib ikut terhapus"; exit 1; }
done
echo "02-remove selesai."
