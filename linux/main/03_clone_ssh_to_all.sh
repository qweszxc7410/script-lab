#!/bin/bash
# sync_ssh_to_all.sh
# 功能：將 main 主機的 SSH 金鑰與 hostlist.txt 同步到所有節點，並建立雙向免密登入

HOSTLIST="$HOME/hostlist.txt"

# ========== 前置檢查 ==========
if [ ! -f "$HOSTLIST" ]; then
  echo "❌ 找不到 $HOSTLIST，請建立節點列表（每行一個 IP）"
  exit 1
fi

if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo "❌ 找不到 SSH 私鑰，請先執行 ssh-keygen 建立金鑰"
  exit 1
fi

# ========== 本機補信任自己 ==========
if ! grep -q "$(cat ~/.ssh/id_ed25519.pub)" ~/.ssh/authorized_keys 2>/dev/null; then
  echo "🔐 本機尚未信任自己的公鑰，補上中..."
  cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
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

  # 設定檔案權限
  ssh -o StrictHostKeyChecking=no ubuntu@$ip "chmod 700 ~/.ssh && chmod 600 ~/.ssh/id_ed25519 ~/.ssh/authorized_keys"

  # 執行 ssh 到所有主機，建立 known_hosts
  echo "🚀 $ip 正在建立互信..."
  ssh -o StrictHostKeyChecking=no ubuntu@$ip '
    KEY=$(find ~/.ssh -maxdepth 1 -name "id_*.pub" | head -n 1 | sed "s/\.pub$//")
    for t in $(cat ~/hostlist.txt); do
      ssh -i $KEY -o StrictHostKeyChecking=no ubuntu@$t "echo ✅ $HOSTNAME ➜ $t"
    done
  '

  echo "✅ $ip 完成設定"
done < "$HOSTLIST"

echo "🎉 所有主機已完成 SSH 金鑰同步與雙向互信設定"
