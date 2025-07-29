#!/bin/bash
cd "$(dirname "$0")"
JSON_FILE="./file_map.json"

SCRIPT_DIR="/opt/AI_Docker/scripts"
LOG_FILE="$SCRIPT_DIR/move_files.log"

echo "=== 🕒 $(date '+%Y-%m-%d %H:%M:%S') 開始複製檔案（JSON） ===" >> "$LOG_FILE"

# 檢查檔案與 jq 是否存在
if [[ ! -f "$JSON_FILE" ]]; then
    echo "❌ 找不到 $JSON_FILE" >> "$LOG_FILE"
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo "❌ 缺少 jq，請先安裝（sudo apt install jq）" >> "$LOG_FILE"
    exit 1
fi

# 使用 jq 讀取 JSON 內容
jq -c '.[]' "$JSON_FILE" | while read -r item; do
    SRC=$(echo "$item" | jq -r '.source' | xargs)
    DST=$(echo "$item" | jq -r '.destination' | xargs)

    if [[ -e "$SRC" ]]; then
        mkdir -p "$(dirname "$DST")"
        cp -f "$SRC" "$DST"
        echo "✅ 複製 $SRC → $DST" >> "$LOG_FILE"
    else
        echo "🚫 找不到來源：$SRC" >> "$LOG_FILE"
    fi
done
