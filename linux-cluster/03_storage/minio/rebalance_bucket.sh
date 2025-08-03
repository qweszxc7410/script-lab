#!/bin/bash
# rebalance_bucket.sh
# 功能：針對指定 MinIO bucket 進行重平衡（重新寫入以觸發分片再分配）
# 用途：在新增磁碟或重建架構後，觸發現有物件的 Erasure Coding 分佈重排

set -e

# 檢查參數
if [ $# -ne 1 ]; then
  echo "❗ 使用方式：$0 <bucket_name>"
  exit 1
fi

BUCKET="$1"
TMP_BUCKET="${BUCKET}tmp"

echo "🚀 Rebalance bucket: $BUCKET → 暫存 bucket: $TMP_BUCKET"

# 設定 alias（可略過已有的）
mc alias set local http://127.0.0.1:18300 minioadmin minioadmin >/dev/null 2>&1 || true

# 確認原始 bucket 是否存在
if ! mc ls local | grep -q "^.* ${BUCKET}/"; then
  echo "❌ Bucket '${BUCKET}' 不存在於 MinIO"
  exit 2
fi

# 建立暫存 bucket（若已存在就略過）
if ! mc ls local | grep -q "^.* ${TMP_BUCKET}/"; then
  echo "📦 建立暫存 bucket：$TMP_BUCKET"
  mc mb local/$TMP_BUCKET
else
  echo "⚠️  暫存 bucket '$TMP_BUCKET' 已存在，將直接覆寫使用"
fi

# Mirror 到暫存 bucket
echo "📤 複製資料至暫存 bucket..."
mc mirror --overwrite local/$BUCKET local/$TMP_BUCKET

# Mirror 回原 bucket（移除暫存副本）
echo "📥 回寫至原 bucket（並移除暫存）..."
mc mirror --remove --overwrite local/$TMP_BUCKET local/$BUCKET

# 移除暫存 bucket
echo "🧹 移除暫存 bucket..."
mc rb --force --dangerous local/$TMP_BUCKET

echo "✅ Rebalance 完成：$BUCKET 已重新分佈"
