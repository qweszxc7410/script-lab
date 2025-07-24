#!/bin/bash
# sync_ssh_to_all.sh（強化版）
# 功能：將 main 主機的 SSH 金鑰與 hostlist.txt 同步到所有節點，並建立雙向免密登入

HOSTLIST="$HOME/hostlist.txt"

# ========== 前置檢查 ==========
if [ ! -f "$HOSTLIST" ]; then
  echo "❌ 找不到 $HOSTLIST，請建立節點列表（每行一個 IP）"
  exit 1
fi

# 找第一把可用公鑰（不寫死）
PUBKEY=$(find ~/.ssh -maxdepth 1 -name "*.pub" | head -n 1)
PRIVATE_KEY="${PUBKEY%.pub}"

if [ ! -f "$PRIVATE_KEY" ]; then
  echo "❌ 找不到對應的私鑰（$PRIVATE_KEY）"
  exit 1
fi

# ========== 本機補信任自己 ==========
KEY_CONTENT=$(cat "$PUBKEY")
if ! grep -qxF "$KEY_CONTENT" ~/.ssh/authorized_keys 2>/dev/null; then
  echo "🔐 本機尚未信任自己的公鑰，補上中..."
  echo "$KEY_CONTENT" >> ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/authorized_keys
fi

echo "📦 開始將 ~/.ssh 和 hostlist.txt 同步到所有節點..."

# ========== 同步給所有主機 ==========
while read ip; do
  [ -z "$ip" ] && continue

  echo "🔁 同步到 $ip ..."

  # 同步 .ssh 資料夾
  rsync -avz ~/.ssh/ ubuntu@$ip:~/.ssh --rsync-path="mkdir -p ~/.ssh && rsync"

  # 傳送 hostlist.txt
  scp -q ~/hostlist.txt ubuntu@$ip:~/

  # 設定檔案權限（不假設檔名）
  ssh -o StrictHostKeyChecking=no ubuntu@$ip "
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/*.pub ~/.ssh/id_* 2>/dev/null || true
    chmod 600 ~/.ssh/authorized_keys 2>/dev/null || true
  "

  # 執行 ssh 到所有主機，建立 known_hosts
  echo "🚀 $ip 正在建立互信..."
  ssh -o StrictHostKeyChecking=no ubuntu@$ip "
    KEY=\$(find ~/.ssh -maxdepth 1 -name 'id_*' ! -name '*.pub' | head -n 1)
    for t in \$(cat ~/hostlist.txt); do
      ssh -i \$KEY -o StrictHostKeyChecking=no ubuntu@\$t 'echo ✅ \$HOSTNAME ➜ '\$t''
    done
  "

  echo "✅ $ip 完成設定"
done < "$HOSTLIST"

echo "🎉 所有主機已完成 SSH 金鑰同步與雙向互信設定"
