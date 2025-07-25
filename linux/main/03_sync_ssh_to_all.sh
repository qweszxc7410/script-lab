#!/bin/bash
# 03_sync_ssh_to_all.sh（強化版）
# 功能：將 main 主機的 SSH 金鑰與 hostlist.txt 同步到所有節點，並建立雙向免密登入
# 用途：用於初次部署或重設多台主機的 SSH 信任設定，確保所有節點可互相登入以利 Cluster 或批次管理

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

# 讀入所有主機 IP 為陣列
mapfile -t ip_list < <(grep -v '^\s*$' "$HOSTLIST")

# ========== 同步給所有主機 ==========
for ip in "${ip_list[@]}"; do
  echo "🔁 同步到 $ip ..."

  # 同步 .ssh 資料夾
  rsync -avz ~/.ssh/ ubuntu@"$ip":~/.ssh --rsync-path="mkdir -p ~/.ssh && rsync"

  # 傳送 hostlist.txt
  scp -q "$HOSTLIST" ubuntu@"$ip":~/

  # 設定檔案權限（不假設檔名）
  ssh -o StrictHostKeyChecking=no ubuntu@"$ip" "
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/*.pub ~/.ssh/id_* 2>/dev/null || true
    chmod 600 ~/.ssh/authorized_keys 2>/dev/null || true
  "

  # 建立互信（讓這台 ssh 到其他所有節點）
  echo "🚀 $ip 正在建立互信..."
  ssh -o StrictHostKeyChecking=no ubuntu@"$ip" "
    KEY=\$(find ~/.ssh -maxdepth 1 -name 'id_*' ! -name '*.pub' | head -n 1)
    mapfile -t nodes < ~/hostlist.txt
    for t in \"\${nodes[@]}\"; do
      ssh -i \$KEY -o StrictHostKeyChecking=no ubuntu@\$t 'echo ✅ \$HOSTNAME ➜ '\$t''
    done
  "

  echo "✅ $ip 完成設定"
done

echo "🎉 所有主機已完成 SSH 金鑰同步與雙向互信設定"
