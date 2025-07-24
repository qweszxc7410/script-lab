#!/bin/bash
# 03_install_cockpit.sh
# 功能：安裝 Cockpit 系統管理介面並啟用服務
# 用途：提供 Web UI 介面，用於遠端瀏覽與管理本機資源（CPU、記憶體、磁碟、服務等），可做為 Cluster 主控節點或被控節點使用
sudo apt install -y cockpit
sudo systemctl enable --now cockpit.socket

# 開放 9090 port（若有啟用防火牆）
if command -v ufw &>/dev/null && sudo ufw status | grep -q "Status: active"; then
  echo "🔓 偵測到 UFW 防火牆，開放 9090/tcp..."
  sudo ufw allow 9090/tcp
elif command -v firewall-cmd &>/dev/null && systemctl is-active firewalld &>/dev/null; then
  echo "🔓 偵測到 Firewalld，開放 9090/tcp..."
  sudo firewall-cmd --add-port=9090/tcp --permanent
  sudo firewall-cmd --reload
else
  echo "🟢 未啟用防火牆或無法識別，跳過防火牆設定"
fi