#!/bin/bash
# check_ec_distribution.sh
# 功能：跨主機檢查特定 year prefix 是否已做成 EC（__XLDIR__）
# 用法：./check_ec_distribution.sh year=2010 192.168.1.104 192.168.1.106

if [ $# -lt 2 ]; then
  echo "❗ 用法：$0 <year=XXXX> <host1> [host2] ..."
  exit 1
fi

PREFIX=$1
shift
HOSTS=("$@")

echo "📦 檢查 EC 分佈：$PREFIX__XLDIR__"

for HOST in "${HOSTS[@]}"; do
  echo ""
  echo "🔍 主機：$HOST"

  ssh -o ConnectTimeout=5 ubuntu@$HOST "
    if find /mnt/minio_disk* -type d -name '${PREFIX}__XLDIR__' | grep -q .; then
      echo '✅ 找到 EC 分片：'
      find /mnt/minio_disk* -type d -name '${PREFIX}__XLDIR__'
    else
      echo '❌ 沒有找到 EC 分片'
    fi
  " 2>/dev/null || echo "⚠️ 無法連線到 $HOST"
done
