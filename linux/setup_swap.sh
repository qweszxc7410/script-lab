#!/bin/bash
SWAPFILE="/swapfile"
SWAP_SIZE_GB=16

echo "🧹 移除舊 swap..."
sudo swapoff $SWAPFILE
sudo rm -f $SWAPFILE

echo "🛠 建立新的 $SWAP_SIZE_GB GB swap 檔案..."
sudo fallocate -l ${SWAP_SIZE_GB}G $SWAPFILE || sudo dd if=/dev/zero of=$SWAPFILE bs=1G count=$SWAP_SIZE_GB
sudo chmod 600 $SWAPFILE
sudo mkswap $SWAPFILE
sudo swapon $SWAPFILE

echo "📦 新的 swap 啟用完成！"
swapon --show
free -h

# 開機自動掛載（如尚未設定）
if ! grep -q "$SWAPFILE" /etc/fstab; then
  echo "$SWAPFILE none swap sw 0 0" | sudo tee -a /etc/fstab
fi
