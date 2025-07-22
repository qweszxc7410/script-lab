#!/bin/bash
# reset_and_force_push.sh
# 功能：將專案重設為指定 commit 並強制推送至 GitHub（清除歷史）
# 用途：回復特定狀態並同步 GitHub 倉庫

PROJECT_DIR="."   # 🔁 你的專案資料夾路徑
COMMIT_HASH="0-----d"                  # ✅ 想回復的 commit hash
BRANCH_NAME="main"                     # 🧭 分支名稱

echo "🚀 開始進行 Git 重設與強制推送..."

# Step 1: 切換到目標資料夾
if [ ! -d "$PROJECT_DIR/.git" ]; then
    echo "❌ 資料夾 $PROJECT_DIR 並非 Git 倉庫，請確認路徑正確"
    exit 1
fi

cd "$PROJECT_DIR"
echo "📁 已切換至 $(pwd)"

# Step 2: 執行 reset
echo "🧭 執行 git reset --hard $COMMIT_HASH ..."
git reset --hard "$COMMIT_HASH"

# Step 3: 強制推送至遠端
echo "🚀 強制推送至 origin/$BRANCH_NAME ..."
git push origin "$BRANCH_NAME" --force

echo "✅ 操作完成！目前 HEAD 為：$(git rev-parse HEAD)"
