#!/bin/bash
# check_cluster.sh
# 功能：列出所有節點狀態、IP、OS 等，並自動等待叢集就緒
# 用途：快速檢查整個 K3s Cluster 是否運作正常

source ./env.conf

MAX_RETRY=10
RETRY_INTERVAL=5

echo "🔍 正在檢查 K3s Cluster（主節點 $MASTER_IP）狀態..."

for i in $(seq 1 $MAX_RETRY); do
  OUTPUT=$(pdsh -w "$MASTER_IP" "sudo kubectl get nodes -o wide" 2>&1)

  if echo "$OUTPUT" | grep -q "NAME.*STATUS"; then
    echo ""
    echo "$OUTPUT" | grep -v "^.*: " | sed "s/^/🔹 /"

    # 顯示警告：是否有 NotReady
    if echo "$OUTPUT" | grep -q "NotReady"; then
      echo -e "\n⚠️  \e[31m警告：有節點處於 NotReady 狀態！請執行以下指令查看 log：\e[0m"
      echo "    pdsh -w ^hostlist.txt \"sudo journalctl -u k3s -n 50\""
    else
      echo -e "\n✅ 所有節點皆為 Ready！"
    fi
    exit 0
  else
    echo "⏳ [$i/$MAX_RETRY] K3s 尚未就緒，等待 $RETRY_INTERVAL 秒再重試..."
    sleep $RETRY_INTERVAL
  fi
done

echo -e "\n❌ \e[31mK3s 叢集仍未就緒，請確認 k3s.service 是否啟動成功！\e[0m"
exit 1
