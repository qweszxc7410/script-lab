#!/bin/bash
# git_help.sh
# 功能：顯示常用 Git 指令與用途
# 用途：當作 Git 離線速查工具使用

cat << 'EOF'
📘 Git 常用指令速查表（離線可用）

🔧 帳號設定
  git config --global user.name "你的名字"
  git config --global user.email "你的信箱"
  git config user.name       ← 查詢當前名稱
  git config --list          ← 查詢所有設定

📂 初始化 / 複製專案
  git init
  git clone <repo-url>

📄 狀態查詢
  git status
  git log

📌 提交與暫存
  git add .                  ← 加入所有檔案
  git commit -m "訊息"

🔀 分支操作
  git branch                 ← 顯示分支
  git checkout -b <新分支>
  git switch <分支名>
  git merge <分支名>

🔁 遠端操作
  git remote -v
  git push origin main
  git pull origin main

🧹 還原與取消
  git restore <檔案>
  git reset HEAD <檔案>
  git revert <commit>

📄 幫助與說明
  git help                  ← 查看 Git 全體幫助
  git help config           ← 查 config 用法
  git help <指令>           ← 查某個指令用法

EOF
