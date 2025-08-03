#!/bin/bash
# simulate_disk_failure.sh
# 功能：模擬指定 MinIO 磁碟故障，卸載並移除掛載目錄與映像檔
# 用途：測試 MinIO healing 機制與硬碟更換流程

set -e

# 預設參數
DISK_INDEX="${1:-4}"
DISK_PREFIX="minio_disk"
MOUNT_PATH="/mnt/${DISK_PREFIX}${DISK_INDEX}"
IMG_PATH="/home/ubuntu/${DISK_PREFIX}${DISK_INDEX}.img"
BACKUP_PATH="${MOUNT_PATH}_failed"

echo "❌ 模擬磁碟損壞：$MOUNT_PATH"

if mountpoint -q "$MOUNT_PATH"; then
  echo "🔌 卸載 $MOUNT_PATH"
  sudo umount "$MOUNT_PATH"
fi

if [ -d "$MOUNT_PATH" ]; then
  echo "📦 備份掛載點為：$BACKUP_PATH"
  sudo mv "$MOUNT_PATH" "$BACKUP_PATH"
fi

if [ -f "$IMG_PATH" ]; then
  echo "🗑️ 移除映像檔：$IMG_PATH"
  sudo rm -f "$IMG_PATH"
fi

echo "✅ 模擬完成：$DISK_PREFIX$DISK_INDEX 已壞掉"
