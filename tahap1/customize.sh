for f in /tmp/scripts/*.sh; do
	echo ">> Menjalankan $f"
	bash "$f" || { echo "GAGAL: $f"; exit 1; }
done
echo "Semua skrip selesai."
