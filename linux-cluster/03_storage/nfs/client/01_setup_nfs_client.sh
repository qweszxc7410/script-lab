#!/bin/bash
# 01_setup_nfs_client.sh
# 功能：自動安裝與掛載 NFS 共享資料夾
# 用途：將 NFS Server 的目錄掛載到本機指定目錄，並加入 /etc/fstab 實現開機自動掛載

set -e

# === ✅ 可自訂參數區 ===
SERVER_IP="192.168.1.106"              # ← 替換為你的 NFS Server IP
REMOTE_DIR="/opt/AI_Docker/shared"     # ← Server 上分享的目錄
LOCAL_MOUNT="/mnt/shared_nfs"          # ← 本機要掛載的路徑
# ==========================

echo "📦 安裝 NFS 客戶端工具..."
sudo apt update
sudo apt install -y nfs-common

echo "📁 建立本機掛載點 $LOCAL_MOUNT ..."
sudo mkdir -p "$LOCAL_MOUNT"

echo "🔗 嘗試掛載 $SERVER_IP:$REMOTE_DIR -> $LOCAL_MOUNT ..."
sudo mount "$SERVER_IP:$REMOTE_DIR" "$LOCAL_MOUNT"

echo "📝 設定 /etc/fstab 以實現開機自動掛載..."
FSTAB_LINE="$SERVER_IP:$REMOTE_DIR $LOCAL_MOUNT nfs defaults 0 0"
if ! grep -qF "$FSTAB_LINE" /etc/fstab; then
    echo "$FSTAB_LINE" | sudo tee -a /etc/fstab
else
    echo "✅ /etc/fstab 已含設定，略過"
fi

echo "✅ 驗證掛載結果："
mount | grep "$LOCAL_MOUNT" || echo "⚠️ 尚未掛載成功"

echo "🎉 NFS Client 已完成設定，目錄已掛載到：$LOCAL_MOUNT"
