#!/bin/bash

echo "🚀 [init_project.sh] 專案初始化開始..."
# 🛑 安全檢查：若 remote 是預設值，則中止執行
if [ -f ".gitidentity" ]; then
    CURRENT_REMOTE=$(grep -E '^remote\s*=' .gitidentity | cut -d '=' -f2 | xargs)
    if [ "$CURRENT_REMOTE" = "git@github.com:noneresearchlab/org-project-template.git" ]; then
        echo "🛑 偵測到 remote 未變更（仍為預設 .gitidentity 值）"
        echo "➡️ 請先修改 .gitidentity，再重新執行初始化"
        exit 1
    fi
fi

echo "⚠️ 準備建立乾淨分支並清除 Git 歷史紀錄..."

# Step X: 建立乾淨分支
git checkout --orphan temp-init-branch
echo "✅ 建立乾淨分支 temp-init-branch"

# Step X: 暫存所有目前檔案（忽略已忽略的）
git add .
git commit -m "🎉 初始化：保留當前狀態，清除歷史紀錄"

# Step X: 刪除舊的 main 分支（如果存在）
if git show-ref --verify --quiet refs/heads/main; then
    git branch -D main
    echo "🗑️ 已刪除原本的 main 分支"
fi

# Step 1: 檢查 Git 是否已初始化
if [ ! -d ".git" ]; then
    echo "📁 未檢測到 .git，執行 git init..."
    git init
    echo "✅ 已初始化 Git 倉庫"
else
    echo "✅ Git 倉庫已存在，略過 init"
fi

# Step 2: 套用 Git 身份與 remote
if [ -f "./git_scripts/apply_git_identity.sh" ]; then
    bash ./git_scripts/apply_git_identity.sh
else
    echo "⚠️ 無法找到 git_scripts/apply_git_identity.sh，跳過 Git 身份設定"
fi

# Step 3: 將 .env(backup) → .env、.gitignore(backup) → .gitignore
if [ -f ".env(backup)" ] && [ ! -f ".env" ]; then
    mv ".env(backup)" .env
    echo "✅ 已建立 .env"
else
    echo "ℹ️ 已存在 .env 或缺少 .env(backup)"
fi

if [ -f ".gitignore(backup)" ] && [ ! -f ".gitignore" ]; then
    mv ".gitignore(backup)" .gitignore
    echo "✅ 已建立 .gitignore"
else
    echo "ℹ️ 已存在 .gitignore 或缺少 .gitignore(backup)"
fi

# Step 4: 將 .gitidentity 加進 .gitignore（防止後續 push）
if [ -f ".gitignore" ]; then
    grep -qxF ".gitidentity" .gitignore || echo ".gitidentity" >> .gitignore
    echo "📛 已將 .gitidentity 加入 .gitignore"
fi

# Step 5: 讓 .gitignore 規則真正生效
echo "🧹 清除 Git 追蹤中應該被忽略的檔案..."
git rm --cached -r . > /dev/null 2>&1

# Step 6: 建立新的空白 README.md（會覆蓋原有）
echo "📄 建立新的空白 README.md..."
echo "# $(basename "$PWD")" > README.md
echo "✅ 已建立 README.md（內容為專案資料夾名稱）"

git add .
git commit -m "chore: apply .gitignore" > /dev/null 2>&1 || echo "⚠️ 無需 commit"
# 將新分支改名為 main
git branch -m main
echo "🚀 正在強制推送到 GitHub（origin/main）..."
git push -f origin main # 要push 才會刪除舊的

echo "🎉 初始化完成。你現在可以開始開發或 git add/commit/push！"
