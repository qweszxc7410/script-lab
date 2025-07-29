#!/bin/bash
# 01_setup_ftp_server.sh
# 功能：安裝與設定 vsftpd，支援本機帳號登入、可上傳，並可選擇是否啟用 TLS
# 用途：建立 FTP 檔案伺服器，支援本機帳號登入與資料上傳

set -e

# === 可調參數 ===
FTP_DIR="/srv/ftp"
ENABLE_TLS=true      # 是否啟用 TLS 加密（建議為 true）
FTP_CONF="/etc/vsftpd.conf"
# ==================

echo "🧰 安裝 vsftpd..."
sudo apt update
sudo apt install -y vsftpd

echo "📁 建立 FTP 資料夾：$FTP_DIR"
sudo mkdir -p "$FTP_DIR"
sudo chown ftp:ftp "$FTP_DIR"
sudo chmod 755 "$FTP_DIR"

echo "📝 設定 vsftpd.conf..."
sudo cp "$FTP_CONF" "${FTP_CONF}.bak"

sudo tee "$FTP_CONF" > /dev/null <<EOF
listen=YES
listen_ipv6=NO

anonymous_enable=NO
local_enable=YES
write_enable=YES

anon_upload_enable=NO
anon_mkdir_write_enable=NO

dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
pam_service_name=vsftpd
secure_chroot_dir=/var/run/vsftpd/empty

EOF

# TLS 選項
if [ "$ENABLE_TLS" = true ]; then
  echo "🔐 加入 TLS 設定..."
  sudo tee -a "$FTP_CONF" > /dev/null <<EOF
ssl_enable=YES
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
EOF
else
  echo "🔓 不啟用 TLS"
  echo "ssl_enable=NO" | sudo tee -a "$FTP_CONF" > /dev/null
fi

echo "🔁 重新啟動 vsftpd..."
sudo systemctl restart vsftpd
sudo systemctl enable vsftpd

echo "🎉 FTP Server 已設定完成！登入帳號請使用本機帳號（如 ubuntu）"
if [ "$ENABLE_TLS" = true ]; then
  echo "✅ 支援 FTP over TLS 加密連線"
else
  echo "⚠️ 為明文連線，請僅用於受信區網"
fi

echo "🧪 如尚未設定密碼，請執行：sudo passwd ubuntu"
