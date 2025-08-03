#!/usr/bin/env bash
# setup_prefect_container.sh
# 功能：自動建立 Prefect Server + Worker 的容器架構與執行環境
# 用途：用於快速部署 Prefect 2.x 流程管理伺服器與本地處理池，支援網路整合

set -e

BASE_DIR="/opt/AI_Docker/prefect"
APP_DIR="$BASE_DIR/app"

echo "📁 建立 Prefect 專案目錄..."
mkdir -p "$APP_DIR"
mkdir -p "$BASE_DIR/prefect_data"

echo "📝 建立 Dockerfile..."
cat > "$BASE_DIR/Dockerfile" << 'EOF'
FROM python:3.11-slim

RUN apt-get update && \
    apt-get install -y git curl tzdata  docker.io && \
    ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
    echo "Asia/Taipei" > /etc/timezone && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir prefect

WORKDIR /app
COPY app/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
EOF

echo "📝 建立 entrypoint.sh..."
echo "IP" - $(ip route | awk '/default/ {print $3}')
cat > "$APP_DIR/entrypoint.sh" << 'EOF'
#!/bin/bash


# ✅ 放在最開頭，設定 IP 與 config

# HOST_IP=$(ip route | awk '/default/ {print $3}')
HOST_IP=192.168.1.135
export PREFECT_API_URL=http://$HOST_IP:4200/api
export PREFECT_UI_API_URL=$PREFECT_API_URL

prefect config set PREFECT_API_URL=$PREFECT_API_URL
prefect config set PREFECT_UI_API_URL=$PREFECT_UI_API_URL
prefect config set PREFECT_PROFILE=server


echo "🚀 啟動 Prefect Orion..."
prefect server start --host 0.0.0.0 --port 4200 &

echo "⏳ 等待 Orion API 啟動中..."
until curl -s http://localhost:4200/api/health | grep "\"status\":\"healthy\"" > /dev/null; do
  sleep 2
done
echo "✅ Orion API 已啟動！"

# 建立 work pool（若不存在）
prefect work-pool inspect default-agent-pool || \
prefect work-pool create default-agent-pool --type process

# 啟動 worker
prefect worker start --pool default-agent-pool
EOF

echo "📝 建立 docker-compose.yml..."
cat > "$BASE_DIR/docker-compose.yml" << EOF
version: '3.8'

services:
  prefect:
    build: .
    container_name: prefect
    ports:
      - "4200:4200"
    volumes:
      - ./app:/app
      - ./prefect_data:/root/.prefect
      - /etc/localtime:/etc/localtime:ro
    environment:
      - TZ=Asia/Taipei
    working_dir: /app
    stdin_open: true
    tty: true

EOF

echo "🔧 啟動 Prefect 容器..."
cd "$BASE_DIR"
docker compose -p prefect_project up -d --build

echo "✅ 安裝完成！請開啟瀏覽器前往：http://<你的IP>:4200"
docker network connect ai_report prefect
docker network connect ai_chat prefect