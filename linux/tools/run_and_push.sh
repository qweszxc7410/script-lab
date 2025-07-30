#!/bin/bash
# run_and_push.sh
# 功能：請補上腳本的功能說明
# 用途：請補上腳本的實際用途

# 設定路徑
SCRIPT_DIR="/opt/AI_Docker/scripts"
LOG_FILE="$SCRIPT_DIR/run_and_push.log"
echo "[$(date '+%F %T')] 開始 run_and_push.sh" >> /var/log/run_and_push.log

# 建立 log 檔（若不存在）
touch "$LOG_FILE"
chmod 664 "$LOG_FILE"
echo "執行dump_crontab"

bash "$SCRIPT_DIR/dump_crontab.sh" >> "$LOG_FILE" 2>&1

echo "=== 🕒 $(date '+%Y-%m-%d %H:%M:%S') 開始執行搬移與上傳 ===" >> "$LOG_FILE"

# 執行搬移檔案（通常需要 root 權限）
echo "🔄 執行 move_files.sh..." >> "$LOG_FILE"
bash "$SCRIPT_DIR/move_files.sh" >> "$LOG_FILE" 2>&1

# 檢查是否成功
if [[ $? -ne 0 ]]; then
    echo "❌ move_files.sh 執行失敗，中止執行。" >> "$LOG_FILE"
    exit 1
fi

echo "=== 🕒 $(date '+%Y-%m-%d %H:%M:%S') 執行自動上傳 ===" >> "$LOG_FILE"

# 用 ubuntu 身份執行 git push（避免 root 身分造成 Git 問題）
echo "🚀 以 ubuntu 身分執行 auto_git_push_market-sentinel.sh..." >> "$LOG_FILE"
sudo -u ubuntu bash "$SCRIPT_DIR/auto_git_push_market-sentinel.sh" >> "$LOG_FILE" 2>&1

echo "✅ 完成所有操作" >> "$LOG_FILE"
echo "=== 🕒 $(date '+%Y-%m-%d %H:%M:%S') 完成所有操作 ===" >> "$LOG_FILE"