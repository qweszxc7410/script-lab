#!/bin/bash

echo "🔄 正在重命名備份檔案為正式檔案..."

# .env(backup) → .env
if [ -f ".env(backup)" ]; then
    mv ".env(backup)" .env
    echo "✅ 已重命名：.env"
else
    echo "⚠️ 找不到 .env(backup)"
fi

# .gitignore(backup) → .gitignore
if [ -f ".gitignore(backup)" ]; then
    mv ".gitignore(backup)" .gitignore
    echo "✅ 已重命名：.gitignore"
else
    echo "⚠️ 找不到 .gitignore(backup)"
fi

echo "🎉 備份檔案已轉換完成。可繼續開發與推送。"
