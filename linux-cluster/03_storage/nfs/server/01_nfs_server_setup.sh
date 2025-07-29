#!/bin/bash
# 01_setup_nfs_server.sh
# 功能：自動安裝與設定 NFS Server
# 用途：快速佈署 Ubuntu 上的 NFS 分享目錄給區網使用

set -e

# === ✅ 可自訂參數區 ===
SHARE_DIR="/opt/AI_Docker/shared"
SUBNET="192.168.1.0/24"
EXPORT_OPTION="rw,sync,no_subtree_check,no_root_squash"
# ========================

echo "🧰 安裝 NFS Server..."
sudo apt update
sudo apt install -y nfs-kernel-server

echo "📁 建立共享資料夾 $SHARE_DIR ..."
sudo mkdir -p "$SHARE_DIR"
sudo chown nobody:nogroup "$SHARE_DIR"
sudo chmod 777 "$SHARE_DIR"

echo "📝 設定 /etc/exports ..."
LINE="$SHARE_DIR $SUBNET($EXPORT_OPTION)"
if ! grep -qF "$LINE" /etc/exports; then
    echo "$LINE" | sudo tee -a /etc/exports
else
    echo "✅ /etc/exports 已含設定，略過"
fi

echo "🔁 匯出 NFS 分享..."
sudo exportfs -ra

echo "🚀 重新啟動 NFS Server ..."
sudo systemctl restart nfs-kernel-server
sudo systemctl enable nfs-kernel-server

echo "🎉 NFS Server 已完成設定，共享資料夾為：$SHARE_DIR"
