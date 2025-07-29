#!/bin/bash

# 建立外部 Docker 網路用的腳本
# 使用前：sudo 權限執行 or 使用者有 docker 權限
# chmod +x create_docker_networks.sh

create_network_if_missing() {
    local network_name="$1"
    if docker network ls --format '{{.Name}}' | grep -q "^${network_name}$"; then
        echo "✅ 網路 '${network_name}' 已存在，跳過建立。"
    else
        echo "🔧 建立網路 '${network_name}'..."
        docker network create "${network_name}"
        if [ $? -eq 0 ]; then
            echo "✅ 網路 '${network_name}' 建立成功。"
        else
            echo "❌ 建立網路 '${network_name}' 失敗，請檢查權限或 Docker 狀態。"
        fi
    fi
}

create_network_if_missing ai_chat
create_network_if_missing ai_report
