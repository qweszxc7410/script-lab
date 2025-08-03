#!/usr/bin/env bash
# trigger_git_push_as_user.sh
# 功能：以 ubuntu 身分執行 Git 自動上傳腳本並記錄過程
# 用途：避免 root 權限造成 Git 權限錯誤，適用於排程或容器內部觸發操作

# 設定路徑
SCRIPT_DIR="/opt/AI_Docker/scripts"
LOG_FILE="$SCRIPT_DIR/push.log"

# 建立 log 檔（若不存在）
touch "$LOG_FILE"
chmod 664 "$LOG_FILE"

echo "=== 🕒 $(date '+%Y-%m-%d %H:%M:%S') 開始執行搬移與上傳 ===" >> "$LOG_FILE"



echo "=== 🕒 $(date '+%Y-%m-%d %H:%M:%S') 執行自動上傳 ===" >> "$LOG_FILE"

# 用 ubuntu 身份執行 git push（避免 root 身分造成 Git 問題）
echo "🚀 以 ubuntu 身分執行 auto_git_push_market-sentinel.sh..." >> "$LOG_FILE"
sudo -u ubuntu bash "$SCRIPT_DIR/auto_git_push_market-sentinel.sh" >> "$LOG_FILE" 2>&1

echo "✅ 完成所有操作" >> "$LOG_FILE"
echo "=== 🕒 $(date '+%Y-%m-%d %H:%M:%S') 完成所有操作 ===" >> "$LOG_FILE"