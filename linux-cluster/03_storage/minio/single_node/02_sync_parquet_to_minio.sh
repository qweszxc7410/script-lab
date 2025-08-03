#!/bin/bash

# sync_parquet_to_minio.sh
# 功能：將 Parquet 資料備份（mirror）到 MinIO 單節點
# 用途：適用於初始上傳或日常同步，便於管理與後續擴充

# === 設定區 ===
MINIO_HOST="192.168.1.106"
MINIO_PORT="9000"
MINIO_ALIAS="minio106"
MINIO_ACCESS_KEY="minioadmin"
MINIO_SECRET_KEY="minioadmin"
MINIO_BUCKET="parquet-data"
LOCAL_SOURCE="/opt/AI_Docker/market_data_platform/data/parquet"

# === 初始化 mc ===
if ! command -v mc >/dev/null 2>&1; then
    echo "🔽 安裝 mc 工具..."
    wget -q https://dl.min.io/client/mc/release/linux-arm64/mc -O mc
    chmod +x mc
    sudo mv mc /usr/local/bin/
fi

# === 設定別名（重複執行不會報錯）===
echo "🔗 設定 MinIO 連線別名：$MINIO_ALIAS"
mc alias set $MINIO_ALIAS http://$MINIO_HOST:$MINIO_PORT $MINIO_ACCESS_KEY $MINIO_SECRET_KEY

# === 檢查 bucket 是否存在，若不存在就建立 ===
if ! mc ls $MINIO_ALIAS/$MINIO_BUCKET >/dev/null 2>&1; then
    echo "📁 建立 bucket：$MINIO_BUCKET"
    mc mb $MINIO_ALIAS/$MINIO_BUCKET
fi

# === 開始同步 ===
echo "🚀 開始同步 $LOCAL_SOURCE 到 MinIO..."
mc mirror --overwrite "$LOCAL_SOURCE" "$MINIO_ALIAS/$MINIO_BUCKET"

# === 統計 ===
LOCAL_COUNT=$(find "$LOCAL_SOURCE" -type f | wc -l)
REMOTE_COUNT=$(mc ls --recursive "$MINIO_ALIAS/$MINIO_BUCKET" | wc -l)

echo "✅ 本地檔案數：$LOCAL_COUNT"
echo "✅ MinIO 檔案數：$REMOTE_COUNT"

# === 結束 ===
echo "🎉 資料同步完成！"
