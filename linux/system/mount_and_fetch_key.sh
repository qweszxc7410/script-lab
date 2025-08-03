#!/usr/bin/env bash
# mount_and_fetch_key.sh
# 功能：掛載 USB 並取得 A10_2.pem 金鑰設定權限
# 用途：供後續遠端 scp 備份使用，確保 key 檔與 USB 正確設置

set -e

sudo mount /dev/sda1 /mnt/usb
cp /mnt/usb/A10_2.pem ~/
chmod 400 ~/A10_2.pem
echo "✅ 金鑰已複製並設為 400 權限"
