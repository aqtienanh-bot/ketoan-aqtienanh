#!/bin/bash
# Cập nhật bản dùng thử lên web: https://aqtienanh-bot.github.io/ketoan-aqtienanh/
# Chạy: bash ke-toan-app/deploy.sh
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
TOKEN=$(printf "protocol=https\nhost=github.com\n\n" | git credential fill 2>/dev/null | sed -n 's/^password=//p')
[ -z "$TOKEN" ] && { echo "Khong lay duoc token GitHub"; exit 1; }
WORK=$(mktemp -d)
cd "$WORK"
git clone -q "https://x-access-token:${TOKEN}@github.com/aqtienanh-bot/ketoan-aqtienanh.git" .
cp "$HERE/index.html" ./index.html
if git diff --quiet; then echo "Khong co thay doi."; else
  git -c user.email=aqtienanh@gmail.com -c user.name="AQ Tien Anh" commit -aqm "Cap nhat $(date +%Y-%m-%d)"
  git push -q
  echo "Da cap nhat. Web se moi sau ~1 phut: https://aqtienanh-bot.github.io/ketoan-aqtienanh/"
fi
cd / && rm -rf "$WORK"
