#!/bin/bash

IDENTITY_FILE=".gitidentity"

if [ ! -f "$IDENTITY_FILE" ]; then
  echo "❌ 找不到 $IDENTITY_FILE"
  exit 1
fi

# 解析欄位
USERNAME=$(grep "^user_name" $IDENTITY_FILE | cut -d '=' -f2- | xargs)
USEREMAIL=$(grep "^user_email" $IDENTITY_FILE | cut -d '=' -f2- | xargs)
SSHKEY=$(grep "^ssh_key" $IDENTITY_FILE | cut -d '=' -f2- | xargs)
REMOTE=$(grep "^remote" $IDENTITY_FILE | cut -d '=' -f2- | xargs)

# 套用 Git 身分
git config user.name "$USERNAME"
git config user.email "$USEREMAIL"
echo "🧾 使用者名稱已設定：$USERNAME <$USEREMAIL>"

# 套用 SSH 金鑰
if [ -n "$SSHKEY" ]; then
  echo "🔐 使用 SSH 金鑰：$SSHKEY"
  export GIT_SSH_COMMAND="ssh -i ~/.ssh/$SSHKEY"
else
  unset GIT_SSH_COMMAND
fi

# 設定 remote
if [ -n "$REMOTE" ]; then
  echo "🌐 設定 remote 為：$REMOTE"
  git remote set-url origin "$REMOTE" 2>/dev/null || git remote add origin "$REMOTE"
else
  echo "⚠️ 未設定 remote"
fi

# 顯示狀態
echo "✅ 當前 Git 設定："
git config --get user.name
git config --get user.email
git remote -v
