#!/bin/bash
# 02_get_token.sh
# 功能：從主節點取得 K3s Token 並寫入 env.conf

source ./env.conf

echo "🔑 讀取主節點 $MASTER_IP 的 K3s Token..."
NODE_TOKEN=$(ssh -o StrictHostKeyChecking=no ubuntu@"$MASTER_IP" "sudo cat /var/lib/rancher/k3s/server/node-token" 2>/dev/null)

if [ -n "$NODE_TOKEN" ]; then
  # 如果 env.conf 裡面已經有 NODE_TOKEN 這行，就取代它，否則新增一行
  if grep -q '^NODE_TOKEN=' ./env.conf; then
    sed -i "s|^NODE_TOKEN=.*|NODE_TOKEN=\"$NODE_TOKEN\"|" ./env.conf
    echo "✅ 已更新 NODE_TOKEN 至 env.conf"
  else
    echo "NODE_TOKEN=\"$NODE_TOKEN\"" >> ./env.conf
    echo "✅ 已寫入 NODE_TOKEN 至 env.conf（新增）"
  fi
else
  echo "❌ 取得 token 失敗，請確認主節點 K3s 是否正確安裝並可執行 sudo"
  return 1 2>/dev/null || exit 1
fi
