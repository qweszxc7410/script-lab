#!/bin/bash
# setup_ntp_taipei.sh
# 功能：設定系統時區為台北並啟用 NTP 自動校時
# 用途：讓系統維持準確時間，適用於伺服器或樹莓派等設備

set -e  # 遇錯即停

echo "🕒 設定時區為 Asia/Taipei..."
sudo timedatectl set-timezone Asia/Taipei

echo "🔄 檢查是否有 systemd-timesyncd 或 chrony..."
if command -v timedatectl >/dev/null; then
    echo "✅ 使用 systemd-timesyncd 啟用 NTP..."
    sudo timedatectl set-ntp true
    echo "✅ NTP 功能已啟用！"
elif command -v chronyd >/dev/null; then
    echo "✅ 使用 chrony 啟用 NTP..."
    sudo systemctl enable chronyd
    sudo systemctl start chronyd
    echo "✅ chrony 已啟動！"
else
    echo "⚠️ 無法找到 systemd-timesyncd 或 chrony，請手動安裝其中之一。"
    exit 1
fi

echo "📋 目前時間狀態："
timedatectl

echo "✅ 設定完成！"
