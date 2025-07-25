#!/bin/bash
# 01_install_k3s_server.sh
# 功能：在主節點安裝 K3s Server
# 用途：啟動 Kubernetes 叢集的主節點，並準備好接收其他節點加入

source ./env.conf

echo "🚀 在主節點 $MASTER_IP 安裝 K3s Server..."
pdsh -w "$MASTER_IP" 'curl -sfL https://get.k3s.io | sh -'
