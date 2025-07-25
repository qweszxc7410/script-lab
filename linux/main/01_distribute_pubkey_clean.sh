#!/bin/bash
# 01_distribute_pubkey_clean.sh（全新主機強制部署版）
# 功能：將 SSH 公鑰分發至 hostlist.txt 所列主機，允許每台輸入密碼，不會跳過未設免密的主機

# ./01_distribute_pubkey_clean.sh 
# cat ~/.ssh/authorized_keys 可以在不同主機驗證

set -euo pipefail

echo "🔐 [STEP 1] 尋找現有公鑰..."
PUBKEY=$(find ~/.ssh -maxdepth 1 -name "*.pub" | head -n 1)

if [ -z "$PUBKEY" ] || [ ! -f "$PUBKEY" ]; then
  echo "⚠️ 未找到 SSH 公鑰，開始建立 ed25519 金鑰..."
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -C "auto-generated-key"
  PUBKEY="$HOME/.ssh/id_ed25519.pub"
  echo "✅ 金鑰建立完成：$PUBKEY"
fi

echo "🔑 使用公鑰：$PUBKEY"

# === STEP 2: 主機清單檢查 ===
HOSTLIST="$HOME/hostlist.txt"
if [ ! -f "$HOSTLIST" ]; then
  echo "❌ 錯誤：未找到 $HOSTLIST，請建立主機清單。"
  exit 1
fi

# 確保最後一行有換行符號
[ "$(tail -c1 "$HOSTLIST")" != "" ] && echo >> "$HOSTLIST"

# 顯示主機清單（去除空白行）
echo "📦 將處理下列主機："
grep -v '^\s*$' "$HOSTLIST" | sed 's/^/   - /'

# SSH 設定（允許密碼互動！不使用 BatchMode）
SSH_OPTS="-o StrictHostKeyChecking=no -o ConnectTimeout=5"
KEY_CONTENT=$(<"$PUBKEY")

# === STEP 3: 傳送公鑰至每台主機（每台都執行，不跳過）===
mapfile -t HOSTS < <(grep -v '^\s*$' "$HOSTLIST")
for ip in "${HOSTS[@]}"; do
  ip=$(echo "$ip" | xargs)
  [[ -z "$ip" ]] && continue

  echo -e "\n📤 傳送公鑰給 $ip（請輸入密碼）..."

  TEMPFILE="temp_key.pub"
  if ! scp -o StrictHostKeyChecking=no -o ConnectTimeout=5 -o BatchMode=no "$PUBKEY" ubuntu@"$ip":~/"$TEMPFILE"; then
    echo "❌ [$ip] scp 傳送失敗，跳過"
    continue
  fi

  if ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -o BatchMode=no ubuntu@"$ip" "
    mkdir -p ~/.ssh &&
    touch ~/.ssh/authorized_keys &&
    grep -qxF \"$KEY_CONTENT\" ~/.ssh/authorized_keys || cat ~/$TEMPFILE >> ~/.ssh/authorized_keys &&
    rm ~/$TEMPFILE &&
    chmod 700 ~/.ssh &&
    chmod 600 ~/.ssh/authorized_keys
  "; then
    echo "✅ [$ip] 完成公鑰設定"
  else
    echo "❌ [$ip] 公鑰設定失敗"
  fi
done

# === STEP 4: 設定本機公鑰（確保自己也能免密）===
echo -e "\n🖥️ 設定本機 SSH authorized_keys..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh
if grep -qxF "$KEY_CONTENT" ~/.ssh/authorized_keys 2>/dev/null; then
  echo "✅ 本機已存在相同公鑰"
else
  echo "$KEY_CONTENT" >> ~/.ssh/authorized_keys
  echo "✅ 已新增本機公鑰"
fi
chmod 600 ~/.ssh/authorized_keys

echo -e "\n🎉 所有主機（含本機）已完成免密登入設定（此為首次部署版，可輸入密碼）"
