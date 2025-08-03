#!/bin/bash
# enable_minio_versioning.sh
# 功能：檢查指定 MinIO bucket 是否存在，若無則建立，並啟用版本控管功能
# 用途：快速啟用資料版本追蹤，支援 Rewind、還原與歷史版本查詢
set -e

# ✅ 用法範例：
# bash enable_minio_versioning.sh myminio marketdata

# === 參數 ===
ALIAS="$1"
BUCKET="$2"

if [[ -z "$ALIAS" || -z "$BUCKET" ]]; then
  echo "❌ 用法: $0 <mc-alias> <bucket-name>"
  exit 1
fi

# === 檢查 mc 是否存在 ===
if ! command -v mc &> /dev/null; then
  echo "❌ 請先安裝 mc CLI 工具"
  exit 1
fi

echo "🔍 檢查 bucket [$BUCKET] 是否已存在..."
if ! mc ls "$ALIAS/$BUCKET" &> /dev/null; then
  echo "🪣 bucket [$BUCKET] 不存在，正在建立..."
  mc mb "$ALIAS/$BUCKET"
fi

echo "⚙️ 啟用版本控制功能..."
mc version enable "$ALIAS/$BUCKET"

echo "✅ 完成：[$BUCKET] 已啟用版本控管"
