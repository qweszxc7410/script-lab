#!/bin/bash
# distribute_pubkey.sh
# 功能：將本機的 SSH 公鑰傳送到所有主機（建立免密碼登入）

PUBKEY="$HOME/.ssh/id_rsa.pub"

# 檢查是否存在公鑰
if [ ! -f "$PUBKEY" ]; then
  echo "❌ 找不到 SSH 公鑰，先執行 ssh-keygen 產生："
  echo "    ssh-keygen -t rsa -b 4096 -N \"\" -f ~/.ssh/id_rsa"
  exit 1
fi

# 逐台發送
while read ip; do
  echo "📤 傳送公鑰給 $ip ..."
  
  ssh ubuntu@$ip "mkdir -p ~/.ssh && chmod 700 ~/.ssh"
  
  cat "$PUBKEY" | ssh ubuntu@$ip "cat >> ~/.ssh/authorized_keys"
  
  ssh ubuntu@$ip "chmod 600 ~/.ssh/authorized_keys"
  
  echo "✅ 完成 $ip"
done < "$HOME/hostlist.txt"

echo "🎉 所有主機已設定免密碼登入"
