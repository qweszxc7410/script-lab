#!/bin/bash
# prepare_disks.sh
# 功能：批次建立指定數量的 img 磁碟檔並掛載，模擬 MinIO 磁碟節點
# 用途：用於在無實體硬碟環境下測試 MinIO 多磁碟啟動與容錯功能

set -e

# ==========================================
# 🧠 MinIO 多機磁碟準備工具
#
# 用法範例：
#   bash prepare_disks.sh \
#     --count 12 \
#     --size 100 \
#     --disk-prefix minio_disk
#   bash prepare_disks.sh --count 12 --size 100 --disk-prefix minio_disk
# ==========================================

# === 預設參數 ===
DISK_COUNT=4
IMG_SIZE_MB=2048
DISK_PREFIX="disk"

# === 解析參數 ===
while [[ $# -gt 0 ]]; do
  case "$1" in
    --count)
      DISK_COUNT="$2"
      shift 2
      ;;
    --size)
      IMG_SIZE_MB="$2"
      shift 2
      ;;
    --disk-prefix)
      DISK_PREFIX="$2"
      shift 2
      ;;
    -h|--help)
      echo "用法: $0 [選項...]"
      echo "  --count         建立幾個磁碟（預設 4）"
      echo "  --size          每個磁碟的大小（MB，預設 2048）"
      echo "  --disk-prefix   磁碟名稱前綴（預設 disk）"
      exit 0
      ;;
    *)
      echo "❌ 不支援的參數: $1"
      exit 1
      ;;
  esac
done

# === 建立磁碟 img 與掛載點 ===
echo "🔧 磁碟數量：$DISK_COUNT，大小：${IMG_SIZE_MB}MB，前綴：$DISK_PREFIX"
for i in $(seq 1 "$DISK_COUNT"); do
  MOUNT_PATH="/mnt/${DISK_PREFIX}${i}"
  IMG_PATH="/home/ubuntu/${DISK_PREFIX}${i}.img"

  echo "📁 建立掛載目錄 $MOUNT_PATH"
  sudo mkdir -p "$MOUNT_PATH"

  if [ ! -f "$IMG_PATH" ]; then
    echo "💾 建立磁碟映像檔 $IMG_PATH"
    sudo dd if=/dev/zero of="$IMG_PATH" bs=1M count="$IMG_SIZE_MB" status=progress
    sudo mkfs.ext4 "$IMG_PATH"
  fi

  if mount | grep -q "$MOUNT_PATH"; then
    echo "⚠️  $MOUNT_PATH 已掛載，略過"
  else
    echo "🔗 掛載 $IMG_PATH 到 $MOUNT_PATH"
    sudo mount -o loop "$IMG_PATH" "$MOUNT_PATH"
  fi

  sudo chown -R ubuntu:ubuntu "$MOUNT_PATH"
  echo "✅ 完成 $MOUNT_PATH"
done
