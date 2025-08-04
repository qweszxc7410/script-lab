#!/bin/bash
# install_gitea.sh
# 功能：使用 Docker 安裝 Gitea 並自動啟動服務
# 用途：部署本地 Git 私有倉庫服務（Web UI + SSH 支援）

set -e

echo "📦 建立 Gitea 資料目錄..."
mkdir -p ~/gitea/{data,config}

echo "🚀 啟動 Gitea Docker 容器..."
docker run -d \
  --name gitea \
  --restart=always \
  -p 3000:3000 \      # Gitea Web UI http://localhost:3000
  -p 222:22 \         # SSH Git 存取 port 22 → 222
  -v ~/gitea/data:/data \
  gitea/gitea:latest

echo "✅ Gitea 安裝完成！"
echo "🌐 請打開瀏覽器並前往：http://localhost:3000 或 http://<你的IP>:3000"
echo "🔑 SSH Git 存取埠為：222（預設帳號在安裝頁面建立）"
