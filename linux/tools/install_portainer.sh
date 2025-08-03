#!/usr/bin/env bash
# install_portainer.sh
# 功能：安裝並啟動 Portainer CE 容器管理介面
# 用途：提供圖形化介面以管理 Docker 容器、映像檔、網路、Volume 等資源

set -e

PORTAINER_NAME="portainer"
PORTAINER_PORT=9000

echo "📦 建立 Portainer 資料卷..."
docker volume create portainer_data

echo "🐳 啟動 Portainer 容器..."
docker run -d \
  --name $PORTAINER_NAME \
  --restart=always \
  -p ${PORTAINER_PORT}:9000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce

# ➕ 加入自訂網路（若存在）
for net in ai_chat ai_report; do
  if docker network ls --format '{{.Name}}' | grep -q "^${net}$"; then
    echo "🔗 將 Portainer 加入網路：$net"
    docker network connect "$net" $PORTAINER_NAME
  fi
done

echo "✅ Portainer 已啟動成功！請於瀏覽器開啟以下網址："
echo "👉 http://$(hostname -I | awk '{print $1}'):${PORTAINER_PORT}"

echo "🔐 預設會要求你設定管理者密碼"
