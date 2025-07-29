#!/bin/bash

set -e

echo "📦 安裝 ufw（如果尚未安裝）..."
sudo apt update
sudo apt install -y ufw

echo "🔒 設定預設規則：拒絕進入、允許出去"
sudo ufw default deny incoming
sudo ufw default allow outgoing

echo "🛡 開放 SSH 連線 (port 22)"
sudo ufw allow 22/tcp

read -p "是否要開放 Webmin（port 10000）？[y/N] " open_webmin
if [[ "$open_webmin" == "y" || "$open_webmin" == "Y" ]]; then
    echo "🌐 開放 Webmin..."
    sudo ufw allow 10000/tcp
fi

echo "📝 啟用 UFW 紀錄（logging）..."
sudo ufw logging on

echo "🚀 啟用防火牆（ufw）..."
sudo ufw enable

echo "✅ UFW 已設定完成，狀態如下："
sudo ufw status verbose
