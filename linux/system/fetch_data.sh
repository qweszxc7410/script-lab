#!/usr/bin/env bash
# fetch_data.sh
# 功能：透過 SSH 金鑰連線並下載遠端 A10 資料至本地 USB，並安全卸載
# 用途：每日或手動備份遠端模型資料至本地儲存裝置

set -e

TARGET_DIR="/media/ubuntu/USB_Drive/Xtal_v6"
mkdir -p "$TARGET_DIR"

scp -i ~/A10_2.pem -r ubuntu@132.145.137.151:/home/ubuntu/A10 "$TARGET_DIR"
echo "✅ A10 資料已成功下載到 $TARGET_DIR"

sudo umount /media/ubuntu/USB_Drive/
echo "🧹 USB 已安全卸載"
