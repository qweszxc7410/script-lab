#!/bin/bash
# 02_get_token.sh
# 功能：從主節點取得 K3s Token
# 用途：取得 Agent 加入叢集所需的驗證資訊，並寫入 env.conf

source ./env.conf

if [ -z "$NODE_TOKEN" ]; then
  echo "🔑 讀取主節點 $MASTER_IP 的 K3s Token..."
  NODE_TOKEN=$(pdsh -w "$MASTER_IP" "sudo cat /var/lib/rancher/k3s/server/node-token" | grep -v '^.*: ')
  echo "✅ Token 取得成功：$NODE_TOKEN"

  # 寫入 env.conf 暫存
  sed -i "s|^NODE_TOKEN=.*|NODE_TOKEN=\"$NODE_TOKEN\"|" ./env.conf
else
  echo "✅ 已在 env.conf 中指定 NODE_TOKEN，不重新讀取"
fi
