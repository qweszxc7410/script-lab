#!/bin/bash
# 01_install_k3s_server.sh
# 功能：請補上腳本的功能說明
# 用途：請補上腳本的實際用途
# 01_install_k3s_server_and_get_token.sh
# 功能：安裝主節點 K3s Server 並取得 Token

source ./env.conf

echo "🚀 在主節點 $MASTER_IP 安裝 K3s Server..."
pdsh -w "$MASTER_IP" 'curl -sfL https://get.k3s.io | sh -'

echo "⏳ 等待 K3s 啟動中（10 秒）..."
sleep 10

echo "🔑 讀取主節點 $MASTER_IP 的 K3s Token..."
NODE_TOKEN=$(ssh -o StrictHostKeyChecking=no ubuntu@"$MASTER_IP" "sudo cat /var/lib/rancher/k3s/server/node-token" 2>/dev/null)

if [ -n "$NODE_TOKEN" ]; then
  if grep -q '^NODE_TOKEN=' ./env.conf; then
    sed -i "s|^NODE_TOKEN=.*|NODE_TOKEN=\"$NODE_TOKEN\"|" ./env.conf
    echo "✅ 已更新 NODE_TOKEN 至 env.conf"
  else
    echo "NODE_TOKEN=\"$NODE_TOKEN\"" >> ./env.conf
    echo "✅ 已寫入 NODE_TOKEN 至 env.conf（新增）"
  fi
else
  echo "❌ 取得 token 失敗，請確認主節點 K3s 是否正確安裝並可執行 sudo"
  exit 1
fi