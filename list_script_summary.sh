#!/usr/bin/env bash
# list_script_summary.sh
# 功能：讀取指定資料夾內所有 .sh 檔案開頭三行，輸出名稱與說明
# 用途：快速總覽 shell 工具用途，方便管理與查找
# 範例 $ ./list_script_summary.sh ./tools

DIR="${1:-.}"  # 預設為當前目錄

echo ""
for file in "$DIR"/*.sh; do
    if [ -f "$file" ]; then
        name=$(basename "$file")
        line1=$(sed -n '2p' "$file" | sed 's/^# *//')
        line2=$(sed -n '3p' "$file" | sed 's/^# *//')

        echo "📄 $name"
        echo "  ➤ $line1"
        echo "  ➤ $line2"
        echo ""
    fi
done
