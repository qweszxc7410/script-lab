#!/bin/bash
# install_minio.sh
# 功能：下載並安裝 MinIO ARM 版本執行檔至指定目錄
# 用途：用於自動化安裝 MinIO 伺服器，適用於樹莓派等 ARM 環境
set -e

# 預設安裝位置
INSTALL_DIR="/home/ubuntu/minio"
BIN_PATH="$INSTALL_DIR/minio"
DOWNLOAD_URL="https://dl.min.io/server/minio/release/linux-arm/minio"

echo "🌐 下載 MinIO 可執行檔（適用 ARM）"
echo "📦 URL: $DOWNLOAD_URL"
echo "📁 安裝路徑: $BIN_PATH"

# 建立安裝目錄
mkdir -p "$INSTALL_DIR"

# 下載
wget -O "$BIN_PATH" "$DOWNLOAD_URL"

# 設定權限
chmod +x "$BIN_PATH"

# 顯示版本確認
echo "✅ MinIO 已安裝於 $BIN_PATH"
"$BIN_PATH" --version
