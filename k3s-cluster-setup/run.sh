#!/bin/bash
# run.sh
# 功能：自動執行完整的 K3s 部署流程
# 用途：整合安裝 Server → 取得 Token → 安裝 Agent，快速建立叢集
echo "🔍 [CHECK] 套用 cgroup 修補..."
pdsh -w ^hostlist.txt 'bash -s' < ./00_patch_cgroup.sh

echo "⚠️ 所有節點修補完成，請重新開機後再執行 run.sh"

set -e
chmod +x 01_*.sh 02_*.sh 03_*.sh

# 更新 hostlist.txt 給 pdsh 使用（主機 + agent）
source ./env.conf
echo "$MASTER_IP" > hostlist.txt
for ip in "${AGENT_IPS[@]}"; do
  echo "$ip" >> hostlist.txt
done

echo "📦 [STEP 1] 安裝主節點 K3s Server..."
./01_install_k3s_server.sh

echo "🔑 [STEP 2] 取得主節點 Token..."
./02_get_token.sh

echo "🚀 [STEP 3] 安裝 Agent 並加入叢集..."
./03_install_k3s_agent.sh

echo "🎉 所有節點安裝完成！你可以在主機執行以下指令查看節點狀態："
echo "    pdsh -w $MASTER_IP 'sudo kubectl get nodes -o wide'"
