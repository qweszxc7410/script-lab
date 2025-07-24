#!/bin/bash
# 01_distribute_pubkey.sh（安全版）
# 功能：自動將 SSH 公鑰分發到 hostlist.txt 裡所有主機，並自動偵測自己

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

SELF_HOST=$(hostname)
SSH_OPTS="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

# 傳送公鑰
while read ip; do
  [ -z "$ip" ] && continue  # 跳過空行

  echo "📤 傳送公鑰給 $ip ..."

  # 嘗試比對主機名稱
  REMOTE_HOST=$(ssh $SSH_OPTS ubuntu@$ip "hostname" 2>/dev/null)

  ssh $SSH_OPTS ubuntu@$ip "mkdir -p ~/.ssh && chmod 700 ~/.ssh"
  cat "$PUBKEY" | ssh $SSH_OPTS ubuntu@$ip "cat >> ~/.ssh/authorized_keys"
  ssh $SSH_OPTS ubuntu@$ip "chmod 600 ~/.ssh/authorized_keys"


  echo "✅ 完成 $ip"
  
done < "$HOME/hostlist.txt"
echo "🔁 強制設定本機 SSH 公鑰登入..."
mkdir -p ~/.ssh
cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys


echo "🎉 所有主機（含本機）已完成免密登入設定"
