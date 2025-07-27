#!/bin/bash
# 00_start_prefect_server.sh
# 功能：啟動 Prefect Server（會自動中斷並重新登入）

set -e


echo "📦 檢查資料資料夾..."
mkdir -p "$HOME/prefect-server-data"

echo "🚀 啟動 Prefect Server 容器..."
docker run -d \
  --name prefect-server \
  -p 4200:4200 \
  -e PREFECT_API_URL=http://192.168.1.106:4200/api \
  -e PREFECT_UI_URL=http://192.168.1.106:4200 \
  prefecthq/prefect:2.10-python3.10 \
  prefect server start --host 0.0.0.0 --port 4200

echo "🎉 Prefect Server 啟動完成！你可以瀏覽：http://192.168.1.106:4200"
