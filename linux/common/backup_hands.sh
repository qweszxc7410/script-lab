#!/bin/bash

# backup_ai_docker.sh
# 功能：備份 AI_Docker 資料夾至 USB，保留實體檔案，避免符號連結錯誤
# 用途：每日備份，並加上完整時間戳避免資料夾重複

SRC_PATH="/opt/AI_Docker"
DEST_BASE="/mnt/usb"
DATE=$(date '+%Y%m%d_%H%M')  # 加上時間
DEST_DIR="$DEST_BASE/AI_Docker_$DATE"

mkdir -p "$DEST_DIR"

echo "📁 開始備份至：$DEST_DIR"
rsync -avL \
  --exclude='venv' \
  --exclude='node_modules' \
  --exclude='**/__pycache__' \
  --exclude='**/.libs' \
  "$SRC_PATH/" "$DEST_DIR"

echo "✅ 備份完成：$DEST_DIR"
