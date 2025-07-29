#!/bin/bash
# scp_to_all.sh
# 功能：將指定檔案 scp 到 hostlist.txt 中所有機器（自動略過本機 IP）
# 用途：快速同步檔案到 cluster 節點（含免密登入）

# === 自訂變數 ===
FILE_TO_SEND="$1"
DEST_PATH="$2"
HOSTLIST="$HOME/hostlist.txt"
USER="${USER}"  # 可改成固定帳號：例如 ubuntu
# =================

# === 前置檢查 ===
if [ -z "$FILE_TO_SEND" ] || [ -z "$DEST_PATH" ]; then
  echo "❌ 使用方式：$0 <檔案路徑> <目標資料夾路徑>"
  exit 1
fi

if [ ! -f "$FILE_TO_SEND" ]; then
  echo "❌ 找不到檔案：$FILE_TO_SEND"
  exit 1
fi

if [ ! -f "$HOSTLIST" ]; then
  echo "❌ 找不到 hostlist.txt：$HOSTLIST"
  exit 1
fi

# 取得本機 IP（第一個 IPv4）
MY_IP=$(hostname -I | awk '{print $1}')
echo "🧠 本機 IP 為：$MY_IP"

# === 傳送檔案 ===
echo "🚀 開始傳送 $FILE_TO_SEND 到所有主機..."

while IFS= read -r HOST; do
  if [ "$HOST" == "$MY_IP" ]; then
    echo "⏭️  跳過本機 $HOST"
    continue
  fi
  echo "➡️  傳送到 $HOST:$DEST_PATH"
  scp "$FILE_TO_SEND" "$USER@$HOST:$DEST_PATH"
done < "$HOSTLIST"

echo "🎉 所有遠端主機傳送完成"
