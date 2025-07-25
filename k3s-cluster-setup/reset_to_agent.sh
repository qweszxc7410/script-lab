#!/bin/bash
# reset_to_agent.sh
# 功能：卸載現有 K3s 並重新安裝為 Agent

source ./env.conf

for ip in "${AGENT_IPS[@]}"; do
  echo "🧹 清除 $ip 的舊安裝..."
  pdsh -w "$ip" "sudo /usr/local/bin/k3s-uninstall.sh || true"

  echo "📦 重新安裝 K3s Agent 到 $ip ..."
  pdsh -w "$ip" "K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=$NODE_TOKEN curl -sfL https://get.k3s.io | sh -s - agent"
done
