#!/bin/bash
# 01_samba_server_setup.sh
# 功能：自動安裝與設定 Samba Server，將共享資料夾開放給 Windows 存取
# 用途：快速設定 /opt/AI_Docker/shared 為匿名可寫的 Windows 分享路徑

set -e

# === 可自訂參數 ===
SHARE_NAME="shared"
SHARE_DIR="/opt/AI_Docker/shared"
# ==================

echo "🧰 安裝 Samba..."
sudo apt update
sudo apt install -y samba

echo "📁 建立共享資料夾 $SHARE_DIR ..."
sudo mkdir -p "$SHARE_DIR"
sudo chown nobody:nogroup "$SHARE_DIR"
sudo chmod 777 "$SHARE_DIR"

echo "📝 設定 /etc/samba/smb.conf..."
SMB_CONF="/etc/samba/smb.conf"

# 備份原始設定檔（只備份一次）
if [ ! -f "${SMB_CONF}.bak" ]; then
  sudo cp "$SMB_CONF" "${SMB_CONF}.bak"
fi

# 移除舊設定（避免重複）
sudo sed -i "/^\[$SHARE_NAME\]/,/^$/d" "$SMB_CONF"

# 新增設定到底部
cat <<EOF | sudo tee -a "$SMB_CONF"

[$SHARE_NAME]
   comment = AI Docker Shared Folder
   path = $SHARE_DIR
   browseable = yes
   writable = yes
   guest ok = yes
   force user = nobody
   create mask = 0777
   directory mask = 0777

EOF

echo "🚀 重新啟動 Samba..."
sudo systemctl restart smbd
sudo systemctl enable smbd

echo "🎉 Samba 已完成設定，共享資料夾：\\\\$(hostname -I | awk '{print $1}')\\$SHARE_NAME"
