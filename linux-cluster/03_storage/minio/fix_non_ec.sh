#!/bin/bash
# fix_non_ec.sh
# 功能：自動尋找非 EC 的年份 prefix，並強制改名回寫以觸發 Erasure Coding
# 用途：確保所有指定 bucket 下的年份資料都以 EC 格式儲存

set -e

BUCKET="$1"
if [ -z "$BUCKET" ]; then
  echo "❗ 用法：$0 <bucket_name>"
  exit 1
fi

echo "🚀 開始修復 bucket '$BUCKET' 中未做 EC 的年份 prefix..."

# 先找出所有年分 prefix（如 year=2009）
YEAR_PREFIXES=$(mc ls --recursive "local/$BUCKET" | grep 'year=' | awk '{print $NF}' | cut -d/ -f1 | sort -u | grep -E '^year=[0-9]{4}$')

if [ -z "$YEAR_PREFIXES" ]; then
  echo "❌ 找不到任何 year=xxxx 的 prefix"
  exit 2
fi

EC_FIXED=()
for prefix in $YEAR_PREFIXES; do
  EC_PATH="${prefix}__XLDIR__"
  
  if find /mnt/minio_disk* -type d -name "$EC_PATH" | grep -q .; then
    echo "✅ [$prefix] 已經是 EC 格式，略過"
  else
    echo "🔧 [$prefix] 尚未做 EC，開始修復..."

    # 找出其中一個檔案
    FILE=$(mc ls "local/$BUCKET/benchmark_twse/is_warrant=False/$prefix/" | awk '{print $NF}' | head -n1)

    if [ -z "$FILE" ]; then
      echo "⚠️  [$prefix] 無檔案可處理，略過"
      continue
    fi

    SRC="local/$BUCKET/benchmark_twse/is_warrant=False/$prefix/$FILE"
    TMP="local/$BUCKET/benchmark_twse/is_warrant=False/$prefix/${FILE%.parquet}-temp.parquet"

    # 複製 + 回寫 → 觸發 EC
    mc cp "$SRC" "$TMP"
    mc rm "$SRC"
    mc mv "$TMP" "$SRC"

    # 驗證是否出現 __XLDIR__
    if find /mnt/minio_disk* -type d -name "${prefix}__XLDIR__" | grep -q .; then
      echo "✅ [$prefix] 已成功轉為 EC 格式"
      EC_FIXED+=("$prefix")
    else
      echo "❌ [$prefix] 嘗試轉換失敗"
    fi
  fi
done

echo ""
echo "🎉 修復完成！以下年份已成功轉為 EC："
for p in "${EC_FIXED[@]}"; do
  echo "- $p"
done
