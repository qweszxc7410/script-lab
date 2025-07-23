#!/bin/bash

# === 設定區 ===
LOG_PATH="/backup/backup.log"
SRC_PATH="/opt/AI_Docker"
SSD_TARGET="/backup/opt/AI_Docker"
USB_TARGET="/mnt/usb/opt/AI_Docker"
EXCLUDE_PATH="finlab_course2019_latest/history"

TIMESTAMP=$(date '+%Y%m%d_%H%M%S')

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_PATH"
}
# === USB 掛載自動化 ===
if ! mount | grep -q "/mnt/usb"; then
  if [ -b /dev/sda1 ]; then
    log "🔌 偵測到 /dev/sda1，準備掛載至 /mnt/usb..."
    sudo mount /dev/sda1 /mnt/usb
    sleep 1
    if mount | grep -q "/mnt/usb"; then
      log "✅ USB 裝置掛載成功"
    else
      log "❌ 嘗試掛載 USB 失敗，備份中止"
      exit 1
    fi
  else
    log "❌ 找不到 /dev/sda1 裝置，無法掛載 USB，備份中止"
    exit 1
  fi
fi

# === SSD 備份（rsync）===
log "🔁 開始備份至 SSD..."
sudo rsync -av --delete \
  --exclude="$EXCLUDE_PATH" \
  --no-perms --no-owner --no-group \
  --log-file="$LOG_PATH" \
  "$SRC_PATH/" "$SSD_TARGET/"
log "✅ SSD 備份完成"

# === USB 掛載檢查 ===
if ! mount | grep -q "/mnt/usb"; then
  log "❌ USB 裝置未掛載，備份中止"
  exit 1
fi

# === USB 備份（rsync）===
log "🔁 開始備份至 USB..."
sudo rsync -av --delete \
  --exclude="$EXCLUDE_PATH" \
  --no-perms --no-owner --no-group \
  --log-file="$LOG_PATH" \
  "$SRC_PATH/" "$USB_TARGET/"
log "✅ USB 備份完成"

# === 截斷 log，只保留最近 N 行 ===
MAX_LINES=1000
log "🧹 截斷 log，只保留最近 ${MAX_LINES} 行"
sudo tail -n "$MAX_LINES" "$LOG_PATH" > "${LOG_PATH}.tmp" && sudo mv "${LOG_PATH}.tmp" "$LOG_PATH"

log "🎉 所有備份任務完成"
