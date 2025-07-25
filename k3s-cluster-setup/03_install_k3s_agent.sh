#!/bin/bash
# 03_install_k3s_agent.sh
# 功能：在所有工作節點安裝 K3s Agent 並加入叢集
# 用途：將其他節點註冊進主節點的 Kubernetes Cluster 中，成為 Worker Node

source ./env.conf

if [ -z "$NODE_TOKEN" ]; then
  echo "❌ 請先執行 02_get_token.sh 取得 NODE_TOKEN"
  exit 1
fi

for ip in "${AGENT_IPS[@]}"; do
  echo "📦 在 $ip 安裝 K3s Agent..."
  pdsh -w "$ip" "K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=$NODE_TOKEN curl -sfL https://get.k3s.io | sh -"
done
