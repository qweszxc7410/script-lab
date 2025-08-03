#!/bin/bash
# setup_minio_distributed.sh
# 功能：啟動支援自動去重複 IP 的 MinIO 分散式叢集節點，依指定磁碟數與節點組合出啟動參數
# 用途：在多機架構下快速部署 MinIO，避免重複節點造成啟動錯誤或掛載重複

set -e

# ==========================================
# 🚀 MinIO 多機啟動工具（支援去重複 IP）
#
# 用法範例：
#   bash setup_minio_distributed.sh \
#     --self-ip 192.168.1.101 \
#     --peer-ips 192.168.1.102,192.168.1.103 \
#     --count 12 \
#     --disk-prefix testdisk \
#     --minio-port 18300 \
#     --console-port 18301

#  bash setup_minio_distributed.sh --self-ip 192.168.1.104 --peer-ips 192.168.1.106 --count 12 --disk-prefix minio_disk --minio-port 18300 --console-port 18301
# bash setup_minio_distributed.sh --self-ip 192.168.1.106 --peer-ips 192.168.1.104 --count 12 --disk-prefix minio_disk --minio-port 18300 --console-port 18301
# ==========================================

# === 預設參數 ===
DISK_COUNT=4
DISK_PREFIX="disk"
SELF_IP=""
PEER_IPS=""
MINIO_PORT=9000
CONSOLE_PORT=9001

# === 解析參數 ===
while [[ $# -gt 0 ]]; do
  case "$1" in
    --count)
      DISK_COUNT="$2"
      shift 2
      ;;
    --disk-prefix)
      DISK_PREFIX="$2"
      shift 2
      ;;
    --self-ip)
      SELF_IP="$2"
      shift 2
      ;;
    --peer-ips)
      PEER_IPS="$2"
      shift 2
      ;;
    --minio-port)
      MINIO_PORT="$2"
      shift 2
      ;;
    --console-port)
      CONSOLE_PORT="$2"
      shift 2
      ;;
    -h|--help)
      echo "用法: $0 [選項...]"
      echo "  --self-ip        本機 IP（必填）"
      echo "  --peer-ips       其他節點 IP，逗號分隔（必填）"
      echo "  --count          每台磁碟數（預設 4）"
      echo "  --disk-prefix    掛載磁碟前綴（預設 disk）"
      echo "  --minio-port     MinIO API port（預設 9000）"
      echo "  --console-port   MinIO Console port（預設 9001）"
      exit 0
      ;;
    *)
      echo "❌ 不支援的參數: $1"
      exit 1
      ;;
  esac
done

if [[ -z "$SELF_IP" || -z "$PEER_IPS" ]]; then
  echo "❌ 請使用 --self-ip 與 --peer-ips 指定本機與其他節點"
  exit 1
fi

# === 去除重複 IP ===
ALL_NODES_RAW="$SELF_IP ${PEER_IPS//,/ }"
ALL_NODES=($(echo "$ALL_NODES_RAW" | tr ' ' '\n' | sort -u))

# === 建立掛載清單 ===
MOUNT_ARGS=""
for IP in "${ALL_NODES[@]}"; do
  for i in $(seq 1 "$DISK_COUNT"); do
    MOUNT_ARGS="$MOUNT_ARGS http://$IP/mnt/${DISK_PREFIX}${i}"
  done
done

# === 顯示資訊 ===
TOTAL_PATHS=$(echo $MOUNT_ARGS | wc -w)
echo "🚀 啟動 MinIO 節點於 $SELF_IP：$MINIO_PORT/$CONSOLE_PORT"
echo "🌐 節點總數：${#ALL_NODES[@]}"
echo "📦 掛載路徑總數：$TOTAL_PATHS"

# === 啟動 MinIO ===
export MINIO_ROOT_USER=minioadmin
export MINIO_ROOT_PASSWORD=minioadmin

/home/ubuntu/minio/minio server $MOUNT_ARGS \
  --address ":$MINIO_PORT" \
  --console-address ":$CONSOLE_PORT"
