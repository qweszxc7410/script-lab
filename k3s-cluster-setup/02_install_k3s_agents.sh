#!/bin/bash
# 02_install_k3s_agents.sh
# 功能：在所有工作節點安裝 K3s Agent 並加入叢集

# pdsh -w 192.168.1.134,192.168.1.118 "sudo /usr/local/bin/k3s-agent-uninstall.sh || true" # 刪除先前的安裝

source ./env.conf

if [ -z "$NODE_TOKEN" ]; then
  echo "❌ 請先執行 01_install_k3s_server_and_get_token.sh 取得 NODE_TOKEN"
  exit 1
fi

for ip in "${AGENT_IPS[@]}"; do
  echo "📦 [$ip] 安裝 K3s Agent..."

  CMD=$(cat <<EOF
echo '🧹 清除 APT 鎖與殘留進程...'
sudo killall -9 apt apt-get dpkg 2>/dev/null || true
sudo rm -f /var/lib/apt/lists/lock /var/cache/apt/archives/lock \
  /var/lib/dpkg/lock /var/lib/dpkg/lock-frontend
sudo dpkg --configure -a || true

echo '🧼 移除舊有 K3s Agent 安裝...'
sudo /usr/local/bin/k3s-agent-uninstall.sh || true
sudo rm -rf /etc/rancher /etc/systemd/system/k3s-agent.service.d

echo '🔧 安裝必要套件...'
sudo apt-get update -y
sudo apt-get install -y iptables
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent

echo '🚀 安裝 K3s Agent...'
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent" \
  K3S_URL=https://$MASTER_IP:6443 \
  K3S_TOKEN=$NODE_TOKEN \
  sh -
EOF
)

  pdsh -w "$ip" "$CMD"

  echo "✅ [$ip] 安裝完成"
done

echo "🎉 所有工作節點已加入 K3s 叢集"