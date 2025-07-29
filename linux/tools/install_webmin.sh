#!/bin/bash
# install_webmin.sh
# 功能：自動安裝 Webmin 並新增對應套件源與 GPG 金鑰
# 用途：快速部署 Webmin 管理介面並自動開啟 port 10000（若啟用 UFW）
set -e

echo "📦 正在更新套件列表..."
sudo apt update

echo "🔧 安裝必要套件..."
sudo apt install -y wget apt-transport-https software-properties-common gnupg

echo "🔑 匯入 Webmin GPG 金鑰..."
wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo gpg --dearmor -o /usr/share/keyrings/webmin.gpg

echo "➕ 新增 Webmin 軟體源..."
echo "deb [signed-by=/usr/share/keyrings/webmin.gpg] http://download.webmin.com/download/repository sarge contrib" | sudo tee /etc/apt/sources.list.d/webmin.list

echo "📦 重新更新套件列表..."
sudo apt update

echo "🚀 安裝 Webmin..."
sudo apt install -y webmin

echo "✅ Webmin 安裝完成！"

# 檢查 ufw 是否啟用，若啟用就開放 port 10000
if command -v ufw &> /dev/null && sudo ufw status | grep -q "Status: active"; then
    echo "🔓 開放 Webmin 預設通訊埠 10000..."
    sudo ufw allow 10000/tcp
else
    echo "⚠️  沒有啟用 ufw 或找不到 ufw，不做防火牆設定。"
fi

echo "🌐 Webmin 網頁介面位於： https://$(hostname -I | awk '{print $1}'):10000"
