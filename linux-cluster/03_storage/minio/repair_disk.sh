#!/bin/bash
# repair_disk.sh
# 功能：重建指定 MinIO 映像磁碟並掛載，啟動 MinIO 並執行 healing 修復流程
# 用途：模擬硬碟更換後的重建與自動修復，驗證 MinIO erasure coding 容錯能力

set -e

# 預設參數
DISK_INDEX="${1:-4}"
DISK_PREFIX="minio_disk"
MOUNT_PATH="/mnt/${DISK_PREFIX}${DISK_INDEX}"
IMG_PATH="/home/ubuntu/${DISK_PREFIX}${DISK_INDEX}.img"
IMG_SIZE_MB=2048

echo "🔁 重建磁碟：$MOUNT_PATH ($IMG_SIZE_MB MB)"

# 建立掛載點
sudo mkdir -p "$MOUNT_PATH"

# 建立映像檔
sudo dd if=/dev/zero of="$IMG_PATH" bs=1M count="$IMG_SIZE_MB" status=progress
sudo mkfs.ext4 "$IMG_PATH"

# 掛載
sudo mount -o loop "$IMG_PATH" "$MOUNT_PATH"
sudo chown -R ubuntu:ubuntu "$MOUNT_PATH"

# 重新啟動 MinIO（請依實際環境調整這行）
echo "🚀 重新啟動 MinIO 節點"
sudo systemctl restart minio || bash start_minio_cluster.sh --self-ip 192.168.1.104 --peer-ips 192.168.1.104,192.168.1.106 --count 12 --disk-prefix minio_disk --minio-port 18300 --console-port 18301

# Heal
echo "🩹 啟動 MinIO Heal"
mc alias set myminio http://192.168.1.104:18300 minioadmin minioadmin
mc admin heal -r myminio

echo "✅ 修復完成"
