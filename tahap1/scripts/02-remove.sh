export DEBIAN_FRONTEND=noninteractive

PAKET="pidgin transmission-gtk transmission-common gnome-mines gnome-sudoku sgt-puzzles parole gnumeric abiword hexchat"

for p in $PAKET; do
  if dpkg -s "$p" >/dev/null 2>&1; then
    echo "Menghapus $p"
    apt remove --purge -y "$p"
  else
    echo "Lewati $p (tidak terpasang)"
  fi
done

dpkg -s xfce4-session >/dev/null 2>&1 || { echo "GAGAL: XFCE ikut terhapus"; exit 1; }
echo "02-remove selesai."
