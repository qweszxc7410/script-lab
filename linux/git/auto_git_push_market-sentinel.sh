#!/usr/bin/env bash
# auto_git_push.sh
# 功能：自動偵測 Git 專案是否有變更並執行 add / commit / push 操作
# 用途：用於自動備份專案、記錄更新、結合排程定時同步 Git 儲存庫

# 設定變數
PROJECT_DIR="/opt/AI_Docker/market-sentinel"
SCRIPT_DIR="/opt/AI_Docker/scripts"
LOG_FILE="$SCRIPT_DIR/auto_git_push.log"

echo "=== 🕒 $(date '+%Y-%m-%d %H:%M:%S') 開始自動上傳 ===" >> "$LOG_FILE"

# 確保 Git 信任該資料夾（重要）
git config --global --add safe.directory "$PROJECT_DIR"

# 切換到專案資料夾
cd "$PROJECT_DIR" || {
    echo "❌ 找不到目錄 $PROJECT_DIR，結束。" >> "$LOG_FILE"
    exit 1
}

# 顯示目前狀態
git status >> "$LOG_FILE"

# 如果有任何變更（包括新檔案），才進行後續
if [[ -n $(git status --porcelain) ]]; then
    echo "🔄 有變更，執行上傳流程..." >> "$LOG_FILE"

    git add . >> "$LOG_FILE" 2>&1
    git commit -m "auto update $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE" 2>&1
    git push --force origin main >> "$LOG_FILE" 2>&1

    echo "✅ 完成 push。" >> "$LOG_FILE"
else
    echo "🚫 沒有變更，跳過。" >> "$LOG_FILE"
fi