#!/usr/bin/env bash
# backup_container.sh
# 功能：將指定的 Docker container 打包成 image 並匯出為 .tar 檔
# 用途：用於備份容器狀態與映像，方便搬移或日後還原

# === 備份 Docker Container 成 Image 並導出為 .tar 檔案 ===
# 使用方式：
#   ./backup_container.sh <container_id或container_name> <備份image名稱>
# 範例：
#   /opt/AI_Docker/scripts/backup_container.sh 77417e4f03a1 market_data
#   /opt/AI_Docker/scripts/backup_container.sh d59123eb3c11 news_sentiment

# --- 檢查參數 ---
if [ $# -ne 2 ]; then
  echo "❌ 使用方式錯誤！請輸入："
  echo "./backup_container.sh <container_id或container_name> <image_name>"
  exit 1
fi

# --- 參數變數定義 ---
CONTAINER_ID="$1"        # 傳入的 container ID 或名稱
IMAGE_NAME="$2"          # 傳入要儲存的新 image 名稱
DATE_STR=$(date +%Y%m%d) # 產生今天的日期字串
TAR_NAME="${IMAGE_NAME}_${DATE_STR}.tar"  # 最後輸出的 tar 檔案名稱

# --- Commit 成為新 image ---
echo "📦 正在將 container「$CONTAINER_ID」打包成 image「$IMAGE_NAME」..."
docker commit "$CONTAINER_ID" "$IMAGE_NAME"

# --- 導出成 .tar 檔案（包含 base image）---
echo "💾 將 image「$IMAGE_NAME」導出為 tar 檔：$TAR_NAME"
docker save -o "$TAR_NAME" "$IMAGE_NAME"

echo "✅ 備份完成！檔案名稱：$TAR_NAME"
