DIR="$(cd "$(dirname "$0")" && pwd)"
sed -i 's/\r$//' "$DIR"/scripts/*.sh
mkdir -p /tmp/assets
cp -r "$DIR"/assets/* /tmp/assets/ 2>/dev/null
for f in "$DIR"/scripts/*.sh; do
  echo ">> Menjalankan $f"
  bash "$f" || { echo "GAGAL: $f"; exit 1; }
done
echo "Semua skrip selesai."
