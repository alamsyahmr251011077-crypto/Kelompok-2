export DEBIAN_FRONTEND=noninteractive

for pola in hexchat pidgin transmission gnome-mines gnome-sudoku sgt-puzzles parole gnumeric abiword; do
  PKGS=$(dpkg -l "${pola}*" 2>/dev/null | awk '/^ii/ {print $2}')
  if [ -n "$PKGS" ]; then
    echo "Menghapus: $PKGS"
    apt remove --purge -y $PKGS
  else
    echo "Lewati $pola (tidak terpasang)"
  fi
done

dpkg -s xfce4-session >/dev/null 2>&1 || { echo "GAGAL: XFCE ikut terhapus"; exit 1; }
echo "02-remove selesai."
