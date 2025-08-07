#!/bin/bash
# 00_install_docker.sh
# 功能：安裝 Docker 並啟動服務
# 用途：提供 Prefect Server 或其他容器應用程式的前置環境

set -e

echo "🔍 檢查是否已安裝 Docker..."
if ! command -v docker &> /dev/null; then
    echo "🚧 未發現 Docker，開始安裝..."
    curl -fsSL https://get.docker.com | sh
    echo "✅ Docker 安裝完成"
else
    echo "✅ 系統已安裝 Docker，略過安裝"
fi

echo "👥 將使用者加入 docker 群組（若尚未加入）..."
if groups $USER | grep -q '\bdocker\b'; then
    echo "✅ 使用者已在 docker 群組中"
else
    sudo usermod -aG docker $USER
    echo "⚠️ 請重新登入或執行 'newgrp docker' 使權限立即生效"
fi

echo "🔄 啟動 Docker 並設為開機自動啟動..."
sudo systemctl start docker
sudo systemctl enable docker
echo "✅ Docker 服務已啟動"
sudo reboot