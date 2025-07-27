#!/bin/bash
# add_swap.sh
# 功能：加開額外 2GB 的 swap 空間
# 用途：用於記憶體不足時，減緩系統壓力，特別是在 K3s 等重載環境

SWAP_FILE="/swapfile2"
SWAP_SIZE="2G"

echo "📦 準備建立額外 swap：$SWAP_FILE (${SWAP_SIZE})"

# 如果已存在，就跳過
if [ -f "$SWAP_FILE" ]; then
  echo "✅ Swap 檔案已存在：$SWAP_FILE"
else
  sudo fallocate -l "$SWAP_SIZE" "$SWAP_FILE" && \
  sudo chmod 600 "$SWAP_FILE" && \
  sudo mkswap "$SWAP_FILE"
fi

# 啟用 swap
sudo swapon "$SWAP_FILE"

# 確保開機自動掛載（若尚未加入 fstab）
if ! grep -q "$SWAP_FILE" /etc/fstab; then
  echo "$SWAP_FILE none swap sw 0 0" | sudo tee -a /etc/fstab > /dev/null
  echo "🔧 已寫入 /etc/fstab，重啟後將自動掛載"
fi

# 顯示目前 swap 使用狀況
echo "📊 目前 Swap 狀態："
free -h
