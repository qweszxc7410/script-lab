#!/bin/bash
# 03_install_k3s_cluster.sh
# 功能：在主節點安裝 K3s Server，並在工作節點安裝 K3s Agent
# 用途：建立一個最小可用的 K3s 叢集（1 控制器 + 多工作節點）

source ./env.conf

if [ -z "$NODE_TOKEN" ]; then
  echo "❌ 請先執行 02_get_token.sh 取得 NODE_TOKEN"
  exit 1
fi

echo "🖥️ 在主節點 $MASTER_IP 安裝 K3s Server..."
pdsh -w "$MASTER_IP" "curl -sfL https://get.k3s.io | sh -"

for ip in "${AGENT_IPS[@]}"; do
  echo "📦 在 $ip 安裝 K3s Agent..."

  # 🧱 補齊 iptables 套件（如未安裝會自動裝）
  pdsh -w "$ip" "sudo apt update && sudo apt install -y iptables iptables-persistent"

  # 🚀 安裝 K3s Agent 並連接主節點
  pdsh -w "$ip" "K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=$NODE_TOKEN curl -sfL https://get.k3s.io | sh -s - agent"
done


# pdsh -w 192.168.1.105 "sudo kubectl get nodes -o wide" 測試
