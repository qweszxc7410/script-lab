#!/bin/bash
# 01_distribute_pubkey.sh
# 功能：將本機的 SSH 公鑰傳送到所有主機（建立免密碼登入）
# 用途：用於 cluster 環境（如 pdsh）快速建立 SSH 互信機制

# 嘗試找第一組現有的公鑰
PUBKEY=$(find ~/.ssh -maxdepth 1 -name "*.pub" | head -n 1)

# 如果沒找到就自動建立 ed25519 金鑰
if [ -z "$PUBKEY" ] || [ ! -f "$PUBKEY" ]; then
  echo "⚠️ 未找到 SSH 公鑰，開始建立 ed25519 金鑰..."
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -C "auto-generated-key"
  PUBKEY="$HOME/.ssh/id_ed25519.pub"
  echo "✅ 金鑰建立完成：$PUBKEY"
fi

echo "🔑 使用公鑰：$PUBKEY"

# 檢查 hostlist 是否存在
if [ ! -f "$HOME/hostlist.txt" ]; then
  echo "❌ 找不到 $HOME/hostlist.txt，請建立節點列表"
  exit 1
fi

# 傳送到每台主機
while read ip; do
  echo "📤 傳送公鑰給 $ip ..."
  
  SSH_OPTS="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

  ssh $SSH_OPTS ubuntu@$ip "mkdir -p ~/.ssh && chmod 700 ~/.ssh"
  cat "$PUBKEY" | ssh $SSH_OPTS ubuntu@$ip "cat >> ~/.ssh/authorized_keys"
  ssh $SSH_OPTS ubuntu@$ip "chmod 600 ~/.ssh/authorized_keys"
  
  echo "✅ 完成 $ip"
done < "$HOME/hostlist.txt"

echo "🎉 所有主機已完成免密登入設定"
