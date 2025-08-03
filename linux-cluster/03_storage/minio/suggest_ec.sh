#!/bin/bash
# suggest_ec.sh
# 功能：根據總節點數與容錯需求，建議 MinIO 的 erasure coding 設定參數
# 用途：協助決定 --set <資料片數>:<Parity 數>，以達成預期容錯能力與空間效率

# ==========================================
# 🧠 建議 MinIO EC 設定參數工具
#
# 用法範例：
#   ./suggest_ec.sh --nodes 10 --tolerate 2
#   ./suggest_ec.sh --nodes 6  --tolerate 1
#
# 參數說明：
#   --nodes     總節點數（或掛載點數）
#   --tolerate  想容忍的壞機台數（Parity 數）
#
# 顯示建議：
#   --set <資料數>:<Parity 數>
#   ➤ 可用空間百分比也會一併顯示
#
# 查看說明：
#   ./suggest_ec.sh --help
# ==========================================

# === 參數處理邏輯 ===

#!/bin/bash

# === 預設參數 ===
TOTAL_NODES=""
TOLERATE_FAILURES=""

# === 解析參數 ===
while [[ $# -gt 0 ]]; do
  case "$1" in
    --nodes)
      TOTAL_NODES="$2"
      shift 2
      ;;
    --tolerate)
      TOLERATE_FAILURES="$2"
      shift 2
      ;;
    -h|--help)
      echo "用法: $0 --nodes <總節點數> --tolerate <可容忍壞機台數>"
      echo "例如: $0 --nodes 10 --tolerate 2"
      exit 0
      ;;
    *)
      echo "❌ 不支援的參數: $1"
      exit 1
      ;;
  esac
done

# === 檢查輸入 ===
if [[ -z "$TOTAL_NODES" || -z "$TOLERATE_FAILURES" ]]; then
  echo "❗ 請指定 --nodes 和 --tolerate 參數"
  exit 1
fi

if (( TOTAL_NODES <= TOLERATE_FAILURES )); then
  echo "❌ 可容忍損壞數不能 >= 總節點數"
  exit 1
fi

# === 計算資料片數與可用空間 ===
DATA_SHARDS=$((TOTAL_NODES - TOLERATE_FAILURES))
USABLE_PCT=$(awk "BEGIN { printf \"%.1f\", $DATA_SHARDS / $TOTAL_NODES * 100 }")

# === 建議輸出 ===
echo "✅ 建議 MinIO 配置如下："
echo "  --set $DATA_SHARDS:$TOLERATE_FAILURES"
echo "  ➤ 資料片數：$DATA_SHARDS"
echo "  ➤ Parity 數：$TOLERATE_FAILURES"
echo "  ➤ 可用空間：約 ${USABLE_PCT}%"
