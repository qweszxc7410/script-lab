#!/bin/bash
# start_minio_cluster.sh
# 功能：以指定 IP 與掛載磁碟設定啟動分散式 MinIO 節點
# 用途：在多機環境中快速組建 MinIO Cluster，模擬掛載與埠號可自訂

set -e

# ==========================================
# 🚀 MinIO 多機啟動工具
#
# 用法範例：
#   bash start_minio_cluster.sh \
#     --self-ip 192.168.1.101 \
#     --peer-ips 192.168.1.102,192.168.1.103 \
#     --count 12 \
#     --disk-prefix testdisk \
#     --minio-port 18300 \
#     --console-port 18301

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

# === 建立所有節點磁碟清單 ===
ALL_NODES=("$SELF_IP" ${PEER_IPS//,/ })
MOUNT_ARGS=""

for IP in "${ALL_NODES[@]}"; do
  for i in $(seq 1 "$DISK_COUNT"); do
    MOUNT_ARGS="$MOUNT_ARGS http://$IP/mnt/${DISK_PREFIX}${i}"
  done
done

# === 啟動 MinIO ===
echo "🚀 啟動 MinIO 節點於 $SELF_IP：$MINIO_PORT/$CONSOLE_PORT"
echo "📦 掛載路徑總數：$(echo $MOUNT_ARGS | wc -w)"

export MINIO_ROOT_USER=minioadmin
export MINIO_ROOT_PASSWORD=minioadmin

/home/ubuntu/minio/minio server $MOUNT_ARGS \
  --address ":$MINIO_PORT" \
  --console-address ":$CONSOLE_PORT"
